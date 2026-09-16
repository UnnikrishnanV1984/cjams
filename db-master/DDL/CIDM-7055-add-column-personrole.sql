alter table personrole ADD COLUMN IF NOT EXISTS initialresponse int;
COMMENT ON COLUMN cjams.personrole.initialresponse IS 'IS CHILD PART OF INITIAL RESPONSE';

alter table personrole ADD COLUMN IF NOT EXISTS initialresponseupdatedby character varying;
COMMENT ON COLUMN cjams.personrole.initialresponseupdatedby IS 'INITIAL RESPONSE UPDATED BY ';

alter table personrole ADD COLUMN IF NOT EXISTS initialresponseupdatedon timestamp;
COMMENT ON COLUMN cjams.personrole.initialresponseupdatedON IS 'INITIAL RESPONSE UPDATED ON ';