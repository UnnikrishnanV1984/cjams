/*
   Issue Description: CDM-29540
   Category/ Module  : Investigation Maltreatment 
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update Investigationmaltreatment 
set activeflag = 0, updatedby ='CDM-29540', updatedon = now()
where maltreatmentid = '2434b0fb-db31-48d7-8036-0e0ef776dc4e';

update Investigationallegation
set activeflag = 0, updatedby ='CDM-29540', updatedon = now()
where maltreatmentid = '2434b0fb-db31-48d7-8036-0e0ef776dc4e';