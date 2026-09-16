/*
   Issue Description: CJAMS-66367 - Remove the client ID # 204824844 from the CPS AR case # 261023681982,
   Category/ Module  : Delete Person from case
   Root cause: User wants to remove the person from the case
   Fix Provided :Data fix has been promoted to delete person from case
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update actor
set activeflag =0, updatedby='CJAMS-66367', updatedon=now()
where actorid ='163fdcec-30ed-44b1-ab05-b3e9cbc391bc' and personid ='e8ef57b9-1757-4c8d-96dc-dbabb6ea3b47';

update intakeservicerequestactor 
set activeflag =0, updatedby='CJAMS-66367', updatedon=now()
where intakeservicerequestactorid ='d87db994-d448-4f7c-a5df-6289f410b247' and actorid ='163fdcec-30ed-44b1-ab05-b3e9cbc391bc';

update personrole 
set activeflag =0, updatedby='CJAMS-66367', updatedon=now()
where personroleid ='6b62c222-f88b-4e24-b20b-9d19910edbbd' and personid='e8ef57b9-1757-4c8d-96dc-dbabb6ea3b47';

update personroletype 
set activeflag =0, updatedby='CJAMS-66367', updatedon=now()
where personroleid ='6b62c222-f88b-4e24-b20b-9d19910edbbd' and personroletypeid ='3696df1e-c935-44a6-b5ea-c9eabe633ebe';

update actorrelationship 
set activeflag =0, updatedby='CJAMS-66367', updatedon=now()
where intakeservicerequestactorid ='d87db994-d448-4f7c-a5df-6289f410b247';

update personprogramarea 
set activeflag =0, updatedby='CJAMS-66367', updatedon=now()
where personid ='e8ef57b9-1757-4c8d-96dc-dbabb6ea3b47' and personprogramid ='0086acff-1aec-4b9d-9498-657a643b8861';