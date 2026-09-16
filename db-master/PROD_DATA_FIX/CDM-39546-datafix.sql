/* 
    Issue Description: CDM-39546
  Category/ Module  : Persons
  Root cause: User request do a data fix for the Enrollment Date should be "08/23/2023" for the client OLIVIA ELIZABETH GRACE KERILL
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update personeducation set enrollmentdate='2023-08-23 00:00:00',
updatedby='CDM-39546',updatedon=now()
where personeducationid='4bca4a92-96d1-4292-954e-466b96f2c1a7'
and personid='8a6e4e4c-15ab-4fa2-8361-3fe8e476467c' and activeflag=1;
