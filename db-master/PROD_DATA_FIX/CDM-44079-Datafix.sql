/*
  Issue Description:  CDM-44079
   Category/ Module  :  Persons
   Root cause: User request to update the Previous Adoption Date in Persons tab
   Pull request# for code fix: NA
   Reason why no related code fix: NA
*/

update person set preadoptiondate='2018-10-31 00:00:00', updatedby='CDM-44079',updatedon=now()
where personid='13df3c30-e5d2-4507-becd-f277c8af0d2f' and activeflag=1;