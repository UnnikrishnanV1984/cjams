/*
   Issue Description: CDM-18708
   Category/ Module  : Person removal from service case  
   Root cause: 
   Pull request# for code fix: 4274
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--select * from actor where servicecaseid = '9a336f2d-97ad-4509-808f-408c267c0a27' and personid = '1e8c0afc-1c8b-47be-b5de-0f98c96d8476'
-- 1 row affected
update actor set activeflag = 0, updatedby = 'CDM-18708', updatedon = now() where actorid = 'b589a7a2-b959-46da-97c4-fced58825249' and servicecaseid = '9a336f2d-97ad-4509-808f-408c267c0a27' and personid = '1e8c0afc-1c8b-47be-b5de-0f98c96d8476' and activeflag = 1;

--select * from intakeservicerequestactor where servicecaseid = '9a336f2d-97ad-4509-808f-408c267c0a27' and personid = '1e8c0afc-1c8b-47be-b5de-0f98c96d8476' and activeflag = 1;
--1 row affected
update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-18708', updatedon = now() 
where intakeservicerequestactorid = '6db991a5-28d0-4c44-a088-7a9f21494a6b' and servicecaseid = '9a336f2d-97ad-4509-808f-408c267c0a27' and personid = '1e8c0afc-1c8b-47be-b5de-0f98c96d8476' and activeflag = 1;

--select * from personrole where servicecaseid = '9a336f2d-97ad-4509-808f-408c267c0a27' and personid = '1e8c0afc-1c8b-47be-b5de-0f98c96d8476' and activeflag = 1;
--1 row affected
update personrole set activeflag = 0, updatedby = 'CDM-18708', updatedon = now() 
where personroleid  = '7e840b70-01b3-4d59-aa3c-401c6766bec1' and servicecaseid = '9a336f2d-97ad-4509-808f-408c267c0a27' and personid = '1e8c0afc-1c8b-47be-b5de-0f98c96d8476' and activeflag = 1;