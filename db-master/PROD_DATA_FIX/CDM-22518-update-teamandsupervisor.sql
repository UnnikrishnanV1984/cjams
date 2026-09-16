
/*
  Issue Description: CDM-22518 Workload update needed for K Jones
   Category/ Module  :  user management
   Root cause: User is assigned to Family Preservation #14 but is still listed under Family Preservation #1 in Workload
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: supervisor id :c454f4b3-1a2e-4562-9e5d-9de86a057efa , teamid : 98d369d5-c38d-4fc2-865b-87b2f5df4343
*/
-- securityuserid:6fe9b11b-2112-41ab-8116-89d4af099eff


UPDATE userprofile 
SET supervisorid = '1d4436d9-cf29-4ffe-b792-8d9f2433d3dc',updatedon = now(), updatedby = 'CDM-22518'
WHERE securityusersid = '6fe9b11b-2112-41ab-8116-89d4af099eff' and activeflag=1;

update teammember 
set teamid='09ce26f0-d0d2-4a57-8f93-1fb31aa3b2fe',updatedby ='CDM-22518',updatedon =now()
where teammemberid = 'cdb2feb9-1f2e-4916-88c8-497439dbc9b4';