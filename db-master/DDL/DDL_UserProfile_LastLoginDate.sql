alter table cjams.userprofile 
add column if not exists cwlastlogindatetime timestamp;

alter table cjams.userprofile 
add column if not exists aslastlogindatetime timestamp;

alter table cjams.userprofile 
add column if not exists provlastlogindatetime timestamp;

COMMENT ON COLUMN cjams.userprofile.cwlastlogindatetime IS 'Child Welfare User Last Login Date & Time'; 
COMMENT ON COLUMN cjams.userprofile.aslastlogindatetime IS 'Adult Services User Last Login Date & Time'; 
COMMENT ON COLUMN cjams.userprofile.provlastlogindatetime IS 'Provider User Last Login Date & Time'; 
