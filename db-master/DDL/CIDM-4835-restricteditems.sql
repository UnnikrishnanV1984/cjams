ALTER TABLE restricteditems ADD COLUMN IF NOT EXISTS roletypekey character varying(10);
COMMENT ON COLUMN restricteditems.roletypekey IS 'Role of the access user';