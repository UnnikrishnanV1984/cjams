/* 
    Issue Description: CDM-39545
  Category/ Module  : Persons
  Root cause: User request do a data fix for the Enrollment Date should be "03/04/2024" for the client ISAIAH Makey BAKER.  
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update personeducation set 
enrollmentdate='2024-03-04 00:00:00',updatedby='CDM-39545',updatedon=now()
where personeducationid='c861189b-a313-40db-a866-544887abaec6'
and personid='f71d2879-6951-45bb-9e79-6c01df452140' and activeflag=1;