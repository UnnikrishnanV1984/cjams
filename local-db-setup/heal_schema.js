const fs = require('fs');
const path = require('path');

const root = __dirname;
const apiMaster = path.join(root, '..', 'api-master');
const seedFile = path.join(root, '_generated_seed_data.sql');
const logFile = path.join(root, '..', '_seed_load_log.txt');
const patchFile = path.join(root, '_generated_schema_patch.sql');

const seedText = fs.readFileSync(seedFile, 'utf8');
const logText = fs.readFileSync(logFile, 'utf8');

// --- Split seed file into statements, each tagged with its 1-based start line number ---
function splitStatementsWithLines(sql) {
  const stmts = [];
  let cur = '';
  let curStartLine = 1;
  let line = 1;
  let inSingle = false;
  let inDollar = false;
  let dollarTag = '';
  let i = 0;
  let atStmtStart = true;
  while (i < sql.length) {
    const ch = sql[i];
    if (atStmtStart && /\s/.test(ch)) {
      if (ch === '\n') line++;
      i++;
      continue;
    }
    if (atStmtStart) { curStartLine = line; atStmtStart = false; }
    const two = sql.slice(i, i + 2);
    if (!inSingle && !inDollar && two === '--') {
      const nl = sql.indexOf('\n', i);
      if (nl === -1) break;
      cur += sql.slice(i, nl + 1);
      line++;
      i = nl + 1;
      continue;
    }
    if (!inSingle && !inDollar && ch === '$') {
      const m = sql.slice(i).match(/^\$([a-zA-Z_]*)\$/);
      if (m) { inDollar = true; dollarTag = m[0]; cur += dollarTag; i += dollarTag.length; continue; }
    }
    if (inDollar) {
      if (sql.slice(i, i + dollarTag.length) === dollarTag) { inDollar = false; cur += dollarTag; i += dollarTag.length; continue; }
      if (ch === '\n') line++;
      cur += ch; i++; continue;
    }
    if (ch === "'" ) { inSingle = !inSingle; cur += ch; i++; continue; }
    if (ch === '\n') line++;
    if (ch === ';' && !inSingle) {
      cur += ch;
      stmts.push({ text: cur.trim(), startLine: curStartLine, endLine: line });
      cur = '';
      atStmtStart = true;
      i++;
      continue;
    }
    cur += ch;
    i++;
  }
  if (cur.trim()) stmts.push({ text: cur.trim(), startLine: curStartLine, endLine: line });
  return stmts;
}

const statements = splitStatementsWithLines(seedText);
// Build a line->statement lookup (sorted by startLine, binary-searchable via linear scan since count is small)
function findStatementForLine(ln) {
  for (const s of statements) {
    if (ln >= s.startLine && ln <= s.endLine) return s;
  }
  return null;
}

// Quote-aware top-level comma splitter (for column lists / value tuples)
function splitTopLevel(s) {
  const parts = [];
  let depth = 0, inSingle = false, cur = '';
  for (let i = 0; i < s.length; i++) {
    const ch = s[i];
    if (ch === "'" ) inSingle = !inSingle;
    if (!inSingle) {
      if (ch === '(') depth++;
      if (ch === ')') depth--;
    }
    if (ch === ',' && depth === 0 && !inSingle) {
      parts.push(cur.trim());
      cur = '';
      continue;
    }
    cur += ch;
  }
  if (cur.trim()) parts.push(cur.trim());
  return parts;
}

function parseInsert(stmtText) {
  const cleaned = stmtText.replace(/\bON\s+CONFLICT\s+(?:ON\s+CONSTRAINT\s+[a-zA-Z0-9_]+\s+)?DO\s+NOTHING\s*;?\s*$/i, ';').trim();
  const m = cleaned.match(/^INSERT\s+INTO\s+"?([a-zA-Z0-9_]+)"?\.?"?([a-zA-Z0-9_]*)"?\s*\(([\s\S]*?)\)\s*VALUES\s*\(([\s\S]*)\)\s*;?\s*$/i);
  if (!m) return null;
  let schema, table;
  if (m[2]) { schema = m[1].toLowerCase(); table = m[2].toLowerCase(); } else { schema = 'cjams'; table = m[1].toLowerCase(); }
  const cols = splitTopLevel(m[3]).map(c => c.replace(/^"|"$/g, '').trim().toLowerCase());
  const vals = splitTopLevel(m[4]);
  return { schema, table, cols, vals };
}

function inferType(valueToken) {
  const v = valueToken.trim();
  if (/^null$/i.test(v)) return null;
  if (/^-?\d+$/.test(v)) return 'integer';
  if (/^-?\d+\.\d+$/.test(v)) return 'numeric';
  if (/^(true|false)$/i.test(v)) return 'boolean';
  if (/^now\(\)$/i.test(v)) return 'timestamp';
  if (/^gen_random_uuid\(\)$/i.test(v)) return 'uuid';
  if (v.startsWith("'") && v.endsWith("'")) {
    const inner = v.slice(1, -1);
    if (/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(inner)) return 'uuid';
    if (/^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}/.test(inner)) return 'timestamp';
    if (/^\d{4}-\d{2}-\d{2}$/.test(inner)) return 'date';
    return { type: 'varchar', len: Math.max(inner.length, 1) };
  }
  return null; // unquoted, unrecognized -- probably an expression; fall back to text
}

// --- Parse error log ---
const errRe = /^psql:.*?:(\d+): ERROR:  (?:column "([^"]+)" of relation "([^"]+)" does not exist|relation "([^"]+)" does not exist)/gm;
const missingColumns = {}; // schema.table -> { col -> [valueTokens] }
const missingTables = {};  // schema.table -> { col -> [valueTokens] } (all cols, since table doesn't exist)
let m;
let matched = 0, unmatchedStmt = 0;
while ((m = errRe.exec(logText))) {
  matched++;
  const line = parseInt(m[1], 10);
  const stmt = findStatementForLine(line);
  if (!stmt) { unmatchedStmt++; continue; }
  const parsed = parseInsert(stmt.text);
  if (!parsed) { unmatchedStmt++; continue; }
  const key = `${parsed.schema}.${parsed.table}`;
  if (m[2]) {
    // column "X" of relation "Y" does not exist -> table exists, one column missing
    const missingCol = m[2].toLowerCase();
    missingColumns[key] = missingColumns[key] || {};
    const idx = parsed.cols.indexOf(missingCol);
    if (idx >= 0) {
      missingColumns[key][missingCol] = missingColumns[key][missingCol] || [];
      missingColumns[key][missingCol].push(parsed.vals[idx]);
    }
  } else if (m[4]) {
    // relation "Y" does not exist -> whole table missing, capture every column
    missingTables[key] = missingTables[key] || {};
    parsed.cols.forEach((c, idx) => {
      missingTables[key][c] = missingTables[key][c] || [];
      missingTables[key][c].push(parsed.vals[idx]);
    });
  }
}

function resolveColumnType(valueTokens) {
  let best = null;
  let maxLen = 0;
  for (const tok of valueTokens) {
    const t = inferType(tok);
    if (t === null) continue;
    if (typeof t === 'object') {
      maxLen = Math.max(maxLen, t.len);
      if (!best || best === 'varchar') best = 'varchar';
    } else if (!best) {
      best = t;
    } else if (best !== t) {
      // conflicting inferred types across samples -- fall back to text (always safe)
      best = 'text';
    }
  }
  if (best === 'varchar') return `varchar(${Math.max(Math.ceil(maxLen * 1.5), maxLen + 10, 50)})`;
  if (!best) return 'text';
  return best;
}

// Each run only sees errors that survived whatever patch was already applied, so merge onto any
// prior patch rather than overwrite it -- otherwise a later, smaller run would erase earlier fixes.
const priorAlters = new Set();
const priorCreates = [];
if (fs.existsSync(patchFile)) {
  const prior = fs.readFileSync(patchFile, 'utf8');
  for (const line of prior.split('\n')) {
    if (/^ALTER TABLE/.test(line)) priorAlters.add(line.trim());
  }
}

let patch = '';
patch += `-- Auto-generated schema patch: columns/tables referenced by db-master seed data but absent from\n`;
patch += `-- api-master's model-derived DDL (legacy/internal columns the API layer never exposes). Types are\n`;
patch += `-- inferred from the literal values in the seed INSERTs that failed against the base schema --\n`;
patch += `-- verify before treating as authoritative. Apply AFTER _generated_ddl.sql and BEFORE seed data.\n\n`;

// Missing tables: also need a schema present; assume cjams unless key says otherwise
const missingTableList = Object.keys(missingTables).sort();
for (const key of missingTableList) {
  const [schema, table] = key.split('.');
  const cols = missingTables[key];
  patch += `-- Table referenced by seed data, absent from generated DDL (all columns inferred from seed values)\n`;
  patch += `CREATE TABLE IF NOT EXISTS "${schema}"."${table}" (\n`;
  const colNames = Object.keys(cols);
  patch += colNames.map(c => `    "${c}" ${resolveColumnType(cols[c])}`).join(',\n');
  patch += '\n);\n\n';
}

const newAlters = new Set();
const missingColList = Object.keys(missingColumns).sort();
for (const key of missingColList) {
  if (missingTables[key]) continue; // already created fresh above with all columns
  const [schema, table] = key.split('.');
  const cols = missingColumns[key];
  for (const c of Object.keys(cols)) {
    newAlters.add(`ALTER TABLE "${schema}"."${table}" ADD COLUMN IF NOT EXISTS "${c}" ${resolveColumnType(cols[c])};`);
  }
}

const allAlters = [...new Set([...priorAlters, ...newAlters])].sort();
patch += allAlters.join('\n') + (allAlters.length ? '\n' : '');

fs.writeFileSync(patchFile, patch);

console.log('Error lines matched:', matched, '(unmatched to a statement:', unmatchedStmt, ')');
console.log('Missing tables:', missingTableList.length, missingTableList.join(', '));
console.log('Tables with missing columns:', missingColList.filter(k => !missingTables[k]).length);
console.log('Patch written to', patchFile);
