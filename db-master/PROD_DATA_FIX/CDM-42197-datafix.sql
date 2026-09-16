/*
  Issue Description:  CDM-42197
   Category/ Module  : Assignments
   Root cause: User request to deaactivate the 5987 role in userresource table for the user rebecca.glotfelty@maryland.gov
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update userresource set activeflag = 0,updatedby = 'CDM-42197', updatedon = now() 
where userid = 27921 and permissiongroupid = '90ed1d47-e282-48df-a54a-a2151bde847f' and activeflag = 1;
