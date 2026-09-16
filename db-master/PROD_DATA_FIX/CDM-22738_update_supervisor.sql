/*
  Issue Description: CDM-22738 Not under appropriate Supervisor 
   Category/ Module  :  user management
   Root cause: Not under appropriate Supervisor 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 1d4436d9-cf29-4ffe-b792-8d9f2433d3dc
   Backup before update/ delete: 
*/

--old supervisor : 1d4436d9-cf29-4ffe-b792-8d9f2433d3dc,aislinnm.taylor@maryland.gov
update userprofile
set supervisorid = '3e07111f-f5f9-4e72-92a7-9cd2d0c1791f',updatedon = now(), updatedby = 'CDM-22738'
where email ilike 'Kenneith.Jones@maryland.gov';