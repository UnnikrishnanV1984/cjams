const fs = require('fs');
const path = require('path');

const root = __dirname;
const apiMaster = path.join(root, '..', 'api-master');

// Load the set of tables our generated DDL declared (schema.table, lowercase)
const ddl = fs.readFileSync(path.join(apiMaster, '_generated_ddl.sql'), 'utf8');
const knownTables = new Set();
for (const m of ddl.matchAll(/CREATE TABLE IF NOT EXISTS "([a-z_]+)"\."([a-z_0-9]+)"/g)) {
  knownTables.add(`${m[1]}.${m[2]}`);
}

const seedDirs = [
  path.join(root, 'MASTER'),
  path.join(root, 'MASTER', 'PROVIDER', 'DML'),
  path.join(root, 'RBAC'),
  path.join(root, 'RBAC_06JUNE20'),
];

function listSqlFiles(dir) {
  if (!fs.existsSync(dir)) return [];
  return fs.readdirSync(dir)
    .filter(f => f.toLowerCase().endsWith('.sql'))
    .map(f => path.join(dir, f))
    .sort();
}

let files = [];
for (const d of seedDirs) files = files.concat(listSqlFiles(d));

// Quote-aware statement splitter: splits on ';' not inside '...' or $$...$$ blocks. Strips -- line comments.
function splitStatements(sql) {
  const stmts = [];
  let cur = '';
  let inSingle = false;
  let inDollar = false;
  let dollarTag = '';
  let i = 0;
  while (i < sql.length) {
    const ch = sql[i];
    const two = sql.slice(i, i + 2);
    if (!inSingle && !inDollar && two === '--') {
      const nl = sql.indexOf('\n', i);
      if (nl === -1) break;
      i = nl + 1;
      cur += '\n';
      continue;
    }
    if (!inSingle && !inDollar && ch === '$') {
      const m = sql.slice(i).match(/^\$([a-zA-Z_]*)\$/);
      if (m) {
        inDollar = true;
        dollarTag = m[0];
        cur += dollarTag;
        i += dollarTag.length;
        continue;
      }
    }
    if (inDollar) {
      if (sql.slice(i, i + dollarTag.length) === dollarTag) {
        inDollar = false;
        cur += dollarTag;
        i += dollarTag.length;
        continue;
      }
      cur += ch;
      i++;
      continue;
    }
    if (ch === "'" && !inDollar) {
      inSingle = !inSingle;
      cur += ch;
      i++;
      continue;
    }
    if (ch === ';' && !inSingle) {
      stmts.push(cur.trim());
      cur = '';
      i++;
      continue;
    }
    cur += ch;
    i++;
  }
  if (cur.trim()) stmts.push(cur.trim());
  return stmts.filter(s => s.length > 0);
}

const includedByFile = {}; // file -> [statements]
const unknownTables = new Set();
let totalIncluded = 0;
let totalInsertStmts = 0;

for (const file of files) {
  const rel = path.relative(root, file);
  const content = fs.readFileSync(file, 'utf8');
  const stmts = splitStatements(content);
  const keep = [];
  for (const stmt of stmts) {
    const m = stmt.match(/^\s*INSERT\s+INTO\s+"?([a-zA-Z0-9_]+)"?\.?"?([a-zA-Z0-9_]*)"?/i);
    if (!m) continue;
    totalInsertStmts++;
    let schema, table;
    if (m[2]) {
      schema = m[1].toLowerCase();
      table = m[2].toLowerCase();
    } else {
      schema = 'cjams'; // default search_path in these scripts
      table = m[1].toLowerCase();
    }
    const key = `${schema}.${table}`;
    if (knownTables.has(key)) {
      // Source scripts often accumulate re-inserts of the same key across dated files (originally
      // paired with a DELETE we deliberately don't replay -- see extraction note above), so the same
      // day-zero row can appear more than once here. ON CONFLICT DO NOTHING makes that idempotent
      // instead of aborting the load on a duplicate-key error.
      // Source scripts sometimes target a named constraint ("ON CONFLICT ON CONSTRAINT pk_team DO
      // NOTHING"), but that name is whatever the real DB happened to call it -- not something this
      // generator's auto-named PRIMARY KEY constraints reproduce. Normalize to the untargeted form,
      // which matches any unique/exclusion violation on the table regardless of constraint name.
      let cleanedStmt = stmt.replace(/\bON\s+CONFLICT\s+ON\s+CONSTRAINT\s+[a-zA-Z0-9_]+\s+DO\s+NOTHING\b/i, 'ON CONFLICT DO NOTHING');
      const hasConflictClause = /\bON\s+CONFLICT\b/i.test(cleanedStmt);
      keep.push(cleanedStmt + (hasConflictClause ? '' : ' ON CONFLICT DO NOTHING') + ';');
      totalIncluded++;
    } else {
      unknownTables.add(key);
    }
  }
  if (keep.length) includedByFile[rel] = keep;
}

let out = '';
out += `-- Day-zero / reference seed data, extracted from db-master MASTER + RBAC + RBAC_06JUNE20 + MASTER/PROVIDER/DML.\n`;
out += `-- Only INSERT statements targeting tables present in _generated_ddl.sql (api-master's own model-declared tables) are included.\n`;
out += `-- Generated: ${new Date().toISOString()}\n`;
out += `-- Load AFTER _generated_ddl.sql.\n\n`;
out += `-- Many source scripts reference tables unqualified (e.g. "insert into resource" instead of "cjams.resource"),\n`;
out += `-- matching how the real cjams_app_user role's search_path is configured. Set it for this session too.\n`;
out += `SET search_path TO cjams, prov, defecttracking, public;\n\n`;

for (const [rel, stmts] of Object.entries(includedByFile)) {
  out += `-- ===== Source: ${rel.replace(/\\/g, '/')} (${stmts.length} insert statement(s)) =====\n`;
  out += stmts.join('\n\n') + '\n\n';
}

fs.writeFileSync(path.join(root, '_generated_seed_data.sql'), out);
fs.writeFileSync(path.join(root, '_gen_seed_report.json'), JSON.stringify({
  filesScanned: files.length,
  filesWithIncludedInserts: Object.keys(includedByFile).length,
  totalInsertStatementsSeen: totalInsertStmts,
  totalIncluded,
  totalSkippedUnknownTable: totalInsertStmts - totalIncluded,
  unknownTables: [...unknownTables].sort(),
}, null, 2));

console.log('Files scanned:', files.length);
console.log('Insert statements seen:', totalInsertStmts);
console.log('Included (table known):', totalIncluded);
console.log('Skipped (table not in generated DDL):', totalInsertStmts - totalIncluded);
console.log('Distinct unknown tables:', unknownTables.size);
