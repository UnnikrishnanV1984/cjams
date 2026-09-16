/*
  Issue Description:  CDM-43582
   Category/ Module  :  Persons
   Root cause: User request to update the Previous Adoption Date in Persons tab
   Pull request# for code fix: NA
   Reason why no related code fix: NA
*/


update person set preadoptiondate = '2000-10-01 00:00:00.000',
updatedby = 'CDM-43582', updatedon = now()
where personid = '1f797854-a1cc-419a-942e-a4730589dc2e' and activeflag = 1;