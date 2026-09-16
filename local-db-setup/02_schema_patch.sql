-- Auto-generated schema patch: columns/tables referenced by db-master seed data but absent from
-- api-master's model-derived DDL (legacy/internal columns the API layer never exposes). Types are
-- inferred from the literal values in the seed INSERTs that failed against the base schema --
-- verify before treating as authoritative. Apply AFTER _generated_ddl.sql and BEFORE seed data.

ALTER TABLE "cjams"."agencytype" ADD COLUMN IF NOT EXISTS "timestamp" text;
ALTER TABLE "cjams"."medicalconditiontype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."medicationtype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."permissiongroup" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."personimmunizationconfig" ADD COLUMN IF NOT EXISTS "activeflag" integer;
ALTER TABLE "cjams"."personimmunizationconfig" ADD COLUMN IF NOT EXISTS "agetype" varchar(50);
ALTER TABLE "cjams"."personimmunizationconfig" ADD COLUMN IF NOT EXISTS "effectivedate" timestamp;
ALTER TABLE "cjams"."personimmunizationconfig" ADD COLUMN IF NOT EXISTS "expirationdate" text;
ALTER TABLE "cjams"."personimmunizationconfig" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."personphonetype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."personphonetype" ADD COLUMN IF NOT EXISTS "timestamp" text;
ALTER TABLE "cjams"."personservicetype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."pgresource" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."physicalattributetype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."physicalattributetype" ADD COLUMN IF NOT EXISTS "sequencenumber" text;
ALTER TABLE "cjams"."physicianspecialtytype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."progressnotesubtype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."progressnotesubtype" ADD COLUMN IF NOT EXISTS "progressnotetypeid" text;
ALTER TABLE "cjams"."progressnotesubtype" ADD COLUMN IF NOT EXISTS "timestamp" text;
ALTER TABLE "cjams"."provideragreementtype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."provideragreementtype" ADD COLUMN IF NOT EXISTS "timestamp" text;
ALTER TABLE "cjams"."referencetype" ADD COLUMN IF NOT EXISTS "flag" text;
ALTER TABLE "cjams"."resource" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."role" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."role" ADD COLUMN IF NOT EXISTS "updatedby" varchar(50);
ALTER TABLE "cjams"."role" ADD COLUMN IF NOT EXISTS "updatedon" timestamp;
ALTER TABLE "cjams"."role_resource" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."rolemapping" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."roletype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."routingconfig" ADD COLUMN IF NOT EXISTS "principaltype" text;
ALTER TABLE "cjams"."team" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."team" ADD COLUMN IF NOT EXISTS "timestamp" text;
ALTER TABLE "cjams"."teammemberroletype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."teammemberroletype" ADD COLUMN IF NOT EXISTS "timestamp" text;
ALTER TABLE "cjams"."auditlogtype" ADD COLUMN IF NOT EXISTS "old_id" text;
ALTER TABLE "cjams"."assessmentstatustype" ADD COLUMN IF NOT EXISTS "typedescription" varchar(250);
ALTER TABLE "cjams"."assessmentstatustype" ADD COLUMN IF NOT EXISTS "insertedby" varchar(50);

-- Model-declared lengths too short for real seed data (model metadata is stale relative to the live schema)
ALTER TABLE "cjams"."provprogramtypename" ALTER COLUMN "programtype" TYPE varchar(50);
ALTER TABLE "cjams"."medicalconditiontype" ALTER COLUMN "medicalconditiontypekey" TYPE varchar(500);
ALTER TABLE "cjams"."teamtype" ADD COLUMN IF NOT EXISTS "old_id" text;
