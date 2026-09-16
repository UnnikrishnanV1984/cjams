alter table person add column if not exists ispostmdmflag boolean;
alter table person add column if not exists postmdmreturnstatus character varying;

COMMENT ON COLUMN cjams.person.ispostmdmflag IS 'Flag to Capture MDM call was successful or not';
COMMENT ON COLUMN cjams.person.postmdmreturnstatus IS 'To Capture MDM API call return status code';