

ALTER TABLE cjams.person ADD COLUMN IF NOT EXISTS othergendertypekey int4 NULL;
COMMENT ON COLUMN person.othergendertypekey IS 'To Store othergendertypekey value';
