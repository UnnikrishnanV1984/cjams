
ALTER TABLE cjams.legislative ADD islateinitialcontact bool NULL;
COMMENT ON COLUMN cjams.legislative.islateinitialcontact IS 'to store the islateinitialcontact value';