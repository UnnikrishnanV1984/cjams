# Local Postgres bootstrap for CJAMS (api-master + db-master)

Generated 2026-09-16. `api-master/server/config.json`'s `dbhosturls.DB_URL`/`SECONDARY_DB_URL` ship
in this repo as placeholders (`postgres://dbuser:dbpwd@localhost:5555/cjams`) — real credentials
are never committed. Fill in your actual local Postgres user/password there (and set
`"environment": "local"`) before starting `api-master`; see `ARCHITECTURE.md` §6.2 for the rest of
the local dev setup.

Load these three files, in order, into an empty database on your local Postgres instance:

```
psql -h localhost -p 5555 -U <user> -d <db> -f 01_schema.sql
psql -h localhost -p 5555 -U <user> -d <db> -f 02_schema_patch.sql
psql -h localhost -p 5555 -U <user> -d <db> -f 03_seed_data.sql
```

All three were test-loaded end-to-end into a throwaway Postgres 18 database (`cjams_ddl_verify`,
since dropped) with **zero errors**: 717 tables created, all 7,924 day-zero seed INSERT statements
executed successfully (~6,930 net rows after `ON CONFLICT DO NOTHING` skipped duplicate keys — see
below).

## What each file is

- **`01_schema.sql`** — `CREATE TABLE` for all 717 tables api-master's LoopBack models declare
  (schemas `cjams`, `prov`, `defecttracking`), generated straight from every `postgresql` block in
  `api-master/common/models/*.json` + `server/models/**/*.json` (plus LoopBack's own built-in
  `AccessToken`/`ACL`/`Role`/etc. models). Column names, types, lengths, precision/scale come
  directly from that metadata. Also includes 6 small supplemental tables
  (`tb_batch_master/log/sp_master/sp_log`, `routingconfig`, `routingstatustype`) that dbsp-master's
  batch jobs and routing logic read/write directly — no LoopBack model exposes them, and no
  surviving db-master DDL file creates them either, so their columns are reverse-engineered from
  db-master's own seed-script INSERT column lists (flagged inline in the file).

- **`02_schema_patch.sql`** — 27 `ALTER TABLE ADD COLUMN` / `ALTER COLUMN TYPE` statements for
  columns/lengths that the day-zero seed data needs but no model declares. Almost all are legacy
  columns named `old_id` or `timestamp` (classic remnants of the historical Oracle→Postgres
  migration alluded to in `ARCHITECTURE.md`) that the API never reads/writes but the physical table
  still carries. Every entry was found by actually attempting the seed load and reading the
  resulting Postgres errors — not guessed.

- **`03_seed_data.sql`** — day-zero / reference data extracted from `db-master/MASTER`,
  `db-master/MASTER/PROVIDER/DML`, `db-master/RBAC`, and `db-master/RBAC_06JUNE20`: country/state/
  county reference values, marital status, religion, alien status, picklists, routing config,
  RBAC roles/resources/permission groups/team types, provider reference data, batch job
  definitions, etc. Only `INSERT` statements targeting a table in `01_schema.sql` were kept (7,924
  of the ~8,443 INSERTs across those folders). Every kept statement is wrapped in
  `ON CONFLICT DO NOTHING` (named-constraint variants like `ON CONFLICT ON CONSTRAINT pk_team DO
  NOTHING` normalized to the untargeted form) because the source scripts were historically paired
  with `DELETE`s we deliberately don't replay, so the same logical row is re-inserted by more than
  one dated file.

## What's deliberately NOT here

- **dbsp-master's ~3,150 PL/pgSQL functions and `views.sql`** (169 views) — business logic that
  lives in the DB layer, per `ARCHITECTURE.md` §2/§5. Not requested; load separately if you need
  features that depend on them (most CRUD/API paths don't).
- **Foreign keys, indexes (beyond the primary key), sequences, triggers** — LoopBack's model JSON
  doesn't carry this information; only db-master's DDL/dbsp-master would.
- **NOT NULL constraints** — intentionally not enforced (see "Why NOT NULL is dropped" below).
- **RBAC's `Grants/*` role/permission SQL** — assumes existing DB roles (`cjams_app_user`, etc.)
  per `ARCHITECTURE.md` §6.1 step 3; not needed to run api-master against your own superuser role.

## Notable data-quality findings surfaced while building this

Building this required actually loading the output into Postgres and iterating on real errors
(not just generating plausible-looking SQL), which surfaced a few genuine issues in the source
repos worth knowing about:

1. **Ten tables are declared by more than one unrelated LoopBack model** (`cjams.role`,
   `cjams.user`, `cjams.accesstoken`, `cjams.tb_picklist_values`, `cjams.providercontract`,
   `defecttracking.supportlog`, and others — see `gen_report.json`'s `collisions` list). Most
   strikingly, the `Environmentconfig` model's `postgresql.table` is set to `"role"` — almost
   certainly a copy-paste bug in `api-master/common/models/environmentconfig.json` — which would
   have silently merged an unrelated `env_variable_id NOT NULL` column onto the real RBAC role
   table. All ten are listed in `gen_report.json`; worth a real look if you touch any of them.
2. **~115 tables have more than one property marked `"id": true`** in their model JSON, which read
   as if they declare composite primary keys (e.g. `referencevalues` implied PK
   `(ref_key, referencetypeid, parentkey, parenttypeid)`). Real data disproves this — thousands of
   `referencevalues` rows have `parentkey IS NULL`, which a real PK column can never be. This
   generator only trusts a single-column `"id": true` as an actual PRIMARY KEY; multi-column cases
   are left with no PK constraint.
3. **LoopBack's `"required": true`** on a model property is API-payload validation, not a DB
   constraint — several properties marked required are routinely NULL in real seed/production
   data. Combined with (2), this generator doesn't emit `NOT NULL` anywhere; use `01_schema.sql` as
   a column/type reference, not a source of truth for what's actually mandatory.
4. Several model-declared column lengths are shorter than real data
   (`provprogramtypename.programtype` was `varchar(5)`, can't even hold `"Kinship"`;
   `medicalconditiontype.medicalconditiontypekey` was `varchar(50)`, real values run to 55+ chars)
   — widened in `02_schema_patch.sql`.

## Regenerating

The generator scripts are included for provenance/reproducibility, but they have relative paths
assuming they sit inside `api-master/` and `db-master/` respectively (they read
`server/model-config.json`, `server/datasources.json`, `common/models/*.json` next to themselves,
and `../api-master/_generated_ddl.sql` as a cross-reference). To rerun: copy `gen_01_schema.js`
into `api-master/`, run it there to produce `_generated_ddl.sql`; then copy `gen_03_seed_data.js`
into `db-master/` and run it (it reads `../api-master/_generated_ddl.sql`); then `heal_schema.js`
alongside it, which reads a psql error log (`../_seed_load_log.txt`) from an attempted load and
emits/merges `_generated_schema_patch.sql`. `gen_report.json` is `gen_01_schema.js`'s last report
(table counts, skipped models, the model-name collisions from point 1 above).
