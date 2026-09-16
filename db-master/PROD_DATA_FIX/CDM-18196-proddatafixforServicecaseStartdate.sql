
/*
   Issue Description: CDM-18196
   Category/ Module  : Updating service case start date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- 2021-10-19 10:44:40
update servicecase set startdate = '2021-10-15 10:44:40', insertedon = '2021-10-15 10:44:40', effectivedate = '2021-10-15 10:44:40', updatedby = 'CDM-1819', updatedon = now() where servicecaseid = '740b8de7-3aae-42c9-9e7b-6189ca1c60e9';
update servicecasedisposition set statusdate = '2021-10-15 10:44:40', effectivedate = '2021-10-15 10:44:40', updatedby = 'CDM-18196', updatedon = now() where servicecasedispositionid = '0cf4604d-5cdc-4734-831c-18aaf5cfbe47';
