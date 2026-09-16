
ALTER TABLE provider_uir 
ADD COLUMN IF NOT EXISTS incident_time timestamp without time zone;
ALTER TABLE provider_uir 
ADD COLUMN IF NOT EXISTS incident_date timestamp without time zone;
ALTER TABLE provider_uir 
ADD COLUMN IF NOT EXISTS is_classthreeincident integer;
ALTER TABLE provider_uir 
ADD COLUMN IF NOT EXISTS additional_youth_info character varying;
ALTER TABLE provider_uir 
ADD COLUMN IF NOT EXISTS class3_brief_desc character varying;
ALTER TABLE  provider_uir
ADD COLUMN   IF NOT EXISTS  program_nm varchar(40) ;
