const fs = require('fs');
const path = require('path');

const root = __dirname;
const modelDirs = [
  path.join(root, 'common', 'models'),
  path.join(root, 'server', 'models'),
  path.join(root, 'server', 'models', 'nytd'),
  path.join(root, 'server', 'models', 'external'),
  path.join(root, 'node_modules', 'loopback', 'common', 'models'),
  path.join(root, 'node_modules', 'loopback', 'server', 'models'),
];

const modelConfig = JSON.parse(fs.readFileSync(path.join(root, 'server', 'model-config.json'), 'utf8'));
delete modelConfig._meta;

const datasources = JSON.parse(fs.readFileSync(path.join(root, 'server', 'datasources.json'), 'utf8'));
const dsSchema = {};
for (const [name, ds] of Object.entries(datasources)) {
  if (ds.schema) dsSchema[name] = ds.schema;
}

// Index all model json files by their "name" property (case-insensitive key too)
const byName = {};
const allFiles = [];
for (const dir of modelDirs) {
  if (!fs.existsSync(dir)) continue;
  for (const f of fs.readdirSync(dir)) {
    if (!f.endsWith('.json')) continue;
    const full = path.join(dir, f);
    allFiles.push(full);
    let j;
    try {
      j = JSON.parse(fs.readFileSync(full, 'utf8'));
    } catch (e) {
      console.error('PARSE ERROR', full, e.message);
      continue;
    }
    if (j.name) {
      byName[j.name] = { file: full, def: j };
      byName[j.name.toLowerCase()] = { file: full, def: j };
    }
  }
}

const pgTypeMap = {
  'character varying': (l) => `varchar(${l > 0 ? l : 255})`,
  'character': (l) => `char(${l > 0 ? l : 1})`,
  'text': () => 'text',
  'uuid': () => 'uuid',
  'bigint': () => 'bigint',
  'integer': () => 'integer',
  'smallint': () => 'smallint',
  'numeric': (l, p, s) => (p != null && p > 0 ? `numeric(${p}${s != null ? ',' + s : ''})` : 'numeric'),
  'double precision': () => 'double precision',
  'real': () => 'real',
  'boolean': () => 'boolean',
  'json': () => 'json',
  'jsonb': () => 'jsonb',
  'timestamp without time zone': () => 'timestamp',
  'timestamp with time zone': () => 'timestamptz',
  'date': () => 'date',
  'time without time zone': () => 'time',
  'bytea': () => 'bytea',
  'bool': () => 'boolean',
  'bigserial': () => 'bigserial',
  'serial': () => 'serial',
  'byte': () => 'bytea',
};

function mapType(prop, propName) {
  const pg = prop.postgresql || {};
  let dt = (pg.dataType || '').toLowerCase().trim();
  if (dt && pgTypeMap[dt]) {
    return pgTypeMap[dt](pg.dataLength, pg.dataPrecision, pg.dataScale);
  }
  // fallback based on loopback "type"
  const t = (prop.type || '').toString().toLowerCase();
  if (t === 'string') return `varchar(${prop.length || 255})`;
  if (t === 'number') return 'numeric';
  if (t === 'boolean') return 'boolean';
  if (t === 'date') return 'timestamp';
  if (t === 'object' || t === 'json' || t === 'geopoint' || t === 'any') return 'jsonb';
  return `text /* unmapped type: ${dt || t} for ${propName} */`;
}

const results = []; // {modelName, schema, table, columns:[], pk:[], sourceFile, dataSource}
const skipped = [];
const notFound = [];

for (const [modelName, cfgEntry] of Object.entries(modelConfig)) {
  const ds = cfgEntry.dataSource;
  if (!ds || !dsSchema[ds]) {
    skipped.push({ modelName, reason: ds ? `datasource '${ds}' has no schema (not postgres-backed)` : 'dataSource: null (not persisted)' });
    continue;
  }
  const entry = byName[modelName] || byName[modelName.toLowerCase()];
  if (!entry) {
    notFound.push(modelName);
    continue;
  }
  const def = entry.def;
  const schema = (def.postgresql && def.postgresql.schema) || dsSchema[ds];
  const table = (def.postgresql && def.postgresql.table) || modelName.toLowerCase();
  const columns = [];
  const pk = [];
  for (const [propName, prop] of Object.entries(def.properties || {})) {
    if (typeof prop !== 'object' || prop === null) continue;
    const pg = prop.postgresql || {};
    const colName = pg.columnName || propName;
    const type = mapType(prop, propName);
    // NOT NULL is intentionally never enforced here: LoopBack's "required" is API-payload validation,
    // not a DB constraint, and even postgresql.nullable:"NO" columns are routinely left out of real
    // INSERTs because the live DB fills them via DEFAULT expressions or dbsp-master BEFORE-INSERT
    // triggers -- neither of which this generator has visibility into. Enforcing NOT NULL here rejects
    // otherwise-valid seed/production data. PRIMARY KEY is still enforced below.
    const notNull = false;
    columns.push({ colName, type, notNull });
    if (prop.id === true) pk.push(colName);
  }
  results.push({ modelName, schema, table, columns, pk, sourceFile: entry.file, dataSource: ds });
}

// Dedupe by schema.table (multiple models can map to same physical table - merge columns by name)
const byTable = {};
for (const r of results) {
  const key = `${r.schema}.${r.table}`;
  if (!byTable[key]) {
    byTable[key] = { schema: r.schema, table: r.table, columns: [], colSet: new Set(), pk: new Set(), models: [] };
  }
  const t = byTable[key];
  t.models.push(r.modelName);
  for (const c of r.columns) {
    if (!t.colSet.has(c.colName)) {
      t.colSet.add(c.colName);
      t.columns.push(c);
    }
  }
  for (const p of r.pk) t.pk.add(p);
}

const tableKeys = Object.keys(byTable).sort();

// Several tables in this codebase are declared by more than one distinct model (e.g. "Environmentconfig"'s
// postgresql.table is set to "role", colliding with the real RBAC Role model). Merging blindly would let one
// model's NOT NULL requirement break inserts written against the other model's shape, so for any table with
// more than one contributing model we relax NOT NULL entirely and flag it for manual review.
const collisions = [];
for (const key of tableKeys) {
  const t = byTable[key];
  const distinctModels = [...new Set(t.models)];
  if (distinctModels.length > 1) {
    collisions.push({ table: key, models: distinctModels });
    for (const c of t.columns) c.notNull = false;
  }
}

let out = '';
out += `-- Auto-generated from api-master LoopBack model definitions (common/models/*.json, server/models/**/*.json)\n`;
out += `-- Generated: ${new Date().toISOString()}\n`;
out += `-- Source of truth: each model's "postgresql" blocks declare exact column name/type/length/precision/scale/nullable.\n`;
out += `-- This captures every table api-master's model layer is configured to read/write. It does NOT include\n`;
out += `-- FK constraints (LoopBack relations are app-level, not enforced DB FKs in these model files) or\n`;
out += `-- indexes/sequences/triggers that live only in db-master/dbsp-master.\n\n`;

const schemas = [...new Set(tableKeys.map(k => byTable[k].schema))].sort();
const q = (id) => `"${id}"`;

for (const s of schemas) {
  out += `CREATE SCHEMA IF NOT EXISTS ${q(s)};\n`;
}
out += '\n';

for (const key of tableKeys) {
  const t = byTable[key];
  out += `-- Model(s): ${t.models.join(', ')}\n`;
  out += `CREATE TABLE IF NOT EXISTS ${q(t.schema)}.${q(t.table)} (\n`;
  // Many model files mark more than one property "id": true for reasons unrelated to the real physical
  // key (verified against live data: e.g. referencevalues' "id" columns include parentkey, which real rows
  // routinely leave NULL -- an actual PK column can never be NULL). A multi-column "id" set here is not
  // trustworthy as a composite PRIMARY KEY, so only single-column id markings are enforced as PK.
  const pkCol = t.pk.size === 1 ? [...t.pk][0] : null;
  const lines = t.columns.map(c => {
    let line = `    ${q(c.colName)} ${c.type}`;
    // A uuid PK column that real seed/production INSERTs omit relies on the DB filling it via a
    // DEFAULT -- verified against live data (RBAC's `resource.id` insert omits `id` entirely and
    // expects the DB to generate it). gen_random_uuid() is the idiomatic default already used
    // throughout db-master's own DDL for uuid PKs.
    if (pkCol === c.colName && c.type === 'uuid') line += ' DEFAULT gen_random_uuid()';
    if (c.notNull) line += ' NOT NULL';
    return line;
  });
  if (pkCol) {
    lines.push(`    PRIMARY KEY (${q(pkCol)})`);
  }
  out += lines.join(',\n');
  out += '\n);\n\n';
}

// A handful of tables are read/written only by dbsp-master functions and batch jobs, never
// through a LoopBack model, so they don't appear in common/models/*.json at all. Their DDL is
// also absent from every db-master DDL/MASTER file that survived to this checkout (pre-existing,
// manually-created infra tables per ARCHITECTURE.md 5). Column lists below are reverse-engineered
// from the actual INSERT column lists in db-master/MASTER + DML seed scripts, not from a source DDL.
out += `-- ===== Supplemental tables (not declared by any api-master model; needed for db-master's day-zero\n`;
out += `-- seed data to load). Columns inferred from db-master seed-script INSERT column lists, not from\n`;
out += `-- an authoritative CREATE TABLE source -- double check types/constraints before relying on these. =====\n\n`;
out += `CREATE TABLE IF NOT EXISTS "cjams"."tb_batch_master" (
    "batch_master_id" integer NOT NULL,
    "batch_nm" varchar(255),
    "dependent_master_id" integer,
    "batch_desc_tx" text,
    "active_sw" varchar(1),
    "frequency" varchar(10),
    "scheduled_tm" varchar(20),
    "threshold_tm" integer,
    "threshold_cutoff_tm" integer,
    "alert_cd" varchar(20),
    "email_sw" varchar(1),
    "comments_tx" text,
    "batch_detail_desc_tx" text,
    "help_failure_tx" text,
    "dependencies_desc_tx" text,
    "module_cd" varchar(50),
    PRIMARY KEY ("batch_master_id")
);

CREATE TABLE IF NOT EXISTS "cjams"."tb_batch_log" (
    "batch_log_id" integer NOT NULL,
    "batch_master_id" integer,
    "success_sw" varchar(1),
    "run_dt" date,
    "comments_tx" text,
    "start_ts" timestamptz,
    "end_ts" timestamptz,
    PRIMARY KEY ("batch_log_id")
);

CREATE TABLE IF NOT EXISTS "cjams"."tb_batch_sp_master" (
    "batch_sp_master_id" integer NOT NULL,
    "batch_master_id" integer,
    "sp_nm" varchar(255),
    "sp_desc_tx" text,
    "sp_call_level_cd" varchar(20),
    "comments_tx" text,
    PRIMARY KEY ("batch_sp_master_id")
);

CREATE TABLE IF NOT EXISTS "cjams"."tb_batch_sp_log" (
    "batch_sp_log_id" integer NOT NULL,
    "batch_log_id" integer,
    "batch_sp_master_id" integer,
    "success_sw" varchar(1),
    "sp_args" text,
    "comments_tx" text,
    "start_ts" timestamptz,
    "end_ts" timestamptz,
    PRIMARY KEY ("batch_sp_log_id")
);

CREATE TABLE IF NOT EXISTS "cjams"."routingstatustype" (
    "sequencenumber" integer NOT NULL,
    "routingstatustypekey" varchar(50),
    "activeflag" integer,
    "typedescription" varchar(255),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("sequencenumber")
);

CREATE TABLE IF NOT EXISTS "cjams"."routingconfig" (
    "routingconfigid" uuid NOT NULL,
    "eventcode" varchar(50),
    "targetrolekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "targetteamtypekey" varchar(50),
    "sourcerolekey" varchar(50),
    "old_id" varchar(50),
    "routingstatustypekey" varchar(50),
    PRIMARY KEY ("routingconfigid")
);

`;

fs.writeFileSync(path.join(root, '_generated_ddl.sql'), out);
fs.writeFileSync(path.join(root, '_gen_report.json'), JSON.stringify({
  totalModelConfigEntries: Object.keys(modelConfig).length,
  totalTablesGenerated: tableKeys.length,
  skipped,
  notFound,
  collisions,
}, null, 2));

console.log('Tables generated:', tableKeys.length);
console.log('Skipped (not postgres-backed):', skipped.length);
console.log('Not found (model-config entry with no matching json file):', notFound.length);
console.log('Not found list:', notFound.join(', '));
console.log('Table-name collisions (>1 distinct model -> same table):', collisions.length);
for (const c of collisions) console.log('  ', c.table, '<-', c.models.join(', '));
