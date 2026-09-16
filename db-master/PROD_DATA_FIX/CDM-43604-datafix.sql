/*
  Issue Description:  CDM-43604
   Category/ Module  :  Persons
   Root cause: User request to update the Previous Adoption Date in Persons tab as 8/3/2006
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

update person set preadoptiondate = '2006-08-03 00:00:00.000',
updatedby = 'CDM-43604', updatedon = now()
where personid = 'dba0e633-1650-472d-b00b-a128d2d266a1' and activeflag = 1;