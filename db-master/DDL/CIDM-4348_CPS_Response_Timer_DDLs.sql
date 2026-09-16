-- B-124723/B-124724 - Enhancement to CPS Response Timer (CIDM-4348)

-- Add Column responsetimerdetails in cjams.intakeservicerequest 
-- To capture the details of all 3 Contacts used for the Response Timer

Alter table cjams.intakeservicerequest add column if not exists responsetimerdetails character varying;
