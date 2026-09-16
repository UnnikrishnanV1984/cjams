/*
   Issue Description: CDM-43114
   Category/ Module  : remove person
   Root cause: uremove person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-43114', updatedon = now() 
where personid = 'f3d7be65-9ba2-491a-b71a-bd93729c9797' and activeflag = 1;

update actor set activeflag = 0, updatedby = 'CDM-43114', updatedon = now() 
where  personid = 'f3d7be65-9ba2-491a-b71a-bd93729c9797' and activeflag = 1;

update personrole set activeflag = 0, updatedby = 'CDM-43114', updatedon = now() 
where  personid = 'f3d7be65-9ba2-491a-b71a-bd93729c9797' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-43114', updatedon = now() 
where   personid = 'f3d7be65-9ba2-491a-b71a-bd93729c9797' and activeflag = 1;