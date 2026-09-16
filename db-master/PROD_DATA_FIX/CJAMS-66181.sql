/*
   Issue Description: CJAMS-66181 - Remove the client ID # 1648162 from the CPS AR case # 2020027403321,
   Category/ Module  : Delete Person from case
   Root cause: User wants to remove the person from the case
   Fix Provided :Data fix has been promoted to delete person from person tab
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update actor 
set activeflag =0, updatedby ='CJAMS-66181', updatedon =now()
where personid ='cc8540ca-9e21-4a92-9d85-9b4653a30688' and actorid ='d883f76f-7e5b-4a21-886e-f869101774d6';

update intakeservicerequestactor  
set activeflag =0, updatedby ='CJAMS-66181', updatedon =now()
where actorid ='d883f76f-7e5b-4a21-886e-f869101774d6' and intakeservicerequestactorid ='c6085461-3f49-4eb8-be25-ffbf0fee6a59';

update personrole 
set activeflag =0, updatedby ='CJAMS-66181', updatedon =now()
where personid ='cc8540ca-9e21-4a92-9d85-9b4653a30688' and personroleid ='c23b49a8-fa04-4a2e-b7ad-a9eca7f1cb6f';

update personroletype 
set activeflag =0, updatedby ='CJAMS-66181', updatedon =now()
where  personroleid ='c23b49a8-fa04-4a2e-b7ad-a9eca7f1cb6f' and personroletypeid ='1550f35c-6d9e-4f4d-8322-23599f1eabd1';

update actorrelationship 
set activeflag =0, updatedby ='CJAMS-66181', updatedon =now()
where intakeservicerequestactorid ='c6085461-3f49-4eb8-be25-ffbf0fee6a59';
