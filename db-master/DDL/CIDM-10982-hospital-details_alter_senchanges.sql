-- 01-06-2026 - Veera Nadimpalli -- CIDM-10982 - To save Sen Criteria Identification

ALTER TABLE cjams.hospitaldetails ADD COLUMN IF NOT EXISTS objecttype  varchar(20) NULL;
comment on column cjams.hospitaldetails.objecttype is 'To Identify object type relation';


alter table cjams.person add column if not exists sencriteria  varchar(10) NULL;
alter table cjams.person add column if not exists birthinghospital varchar(500) NULL;
 
COMMENT ON COLUMN cjams.person.sencriteria IS 'To Identify the sen criteria';
COMMENT ON COLUMN cjams.person.birthinghospital IS 'Details of birthing Hospital';



alter table cjams.senselectiondetails add column if not exists sencriteria  varchar(10) NULL;
alter table cjams.senselectiondetails add column if not exists birthinghospital varchar(500) NULL;
 
COMMENT ON COLUMN cjams.senselectiondetails.sencriteria IS 'To Identify the sen criteria';
COMMENT ON COLUMN cjams.senselectiondetails.birthinghospital IS 'Details of birthing Hospital';

alter table cjams.senselectiondetails_history add column if not exists sencriteria  varchar(10) NULL;
alter table cjams.senselectiondetails_history add column if not exists birthinghospital varchar(500) NULL;
 
COMMENT ON COLUMN cjams.senselectiondetails_history.sencriteria IS 'To Identify the sen criteria';
COMMENT ON COLUMN cjams.senselectiondetails_history.birthinghospital IS 'Details of birthing Hospital';