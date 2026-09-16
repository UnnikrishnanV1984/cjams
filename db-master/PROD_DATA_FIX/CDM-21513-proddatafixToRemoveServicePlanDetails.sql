
/*
   Issue Description: CDM-21513
   Category/ Module  : Unable to end date adoption reunification
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update serviceplan set activeflag = 0, updatedby = 'CDM-21513',updatedon = now() where serviceplanid in ('674c48dc-1ec3-4dd6-8d01-212bc8387b4b','779af44c-ff00-451f-9849-41145fe6ab35','52ddcd05-b8b3-4f8b-8564-dedd26543f83');
