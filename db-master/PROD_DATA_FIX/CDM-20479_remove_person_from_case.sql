/*
   Issue Description: CDM-20479
   Category/ Module  : Person removal from service case  
   Root cause: 
   Pull request# for code fix: 4274
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update actor set activeflag = 0, updatedby = 'CDM-20479', updatedon = now() 
where personid in ('b7ce7c13-d264-43c7-a8c4-403dc3de4f59', '92f0134c-c2b5-4e2f-95cb-d2480021f79b', 'dcaa3f4c-fe3e-461f-a756-4acd28b40259') and servicecaseid = '6f88f2a2-6d70-4274-8ed1-9f2c4e0915c4';

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-20479', updatedon = now() 
where personid in ('b7ce7c13-d264-43c7-a8c4-403dc3de4f59', '92f0134c-c2b5-4e2f-95cb-d2480021f79b', 'dcaa3f4c-fe3e-461f-a756-4acd28b40259') and servicecaseid = '6f88f2a2-6d70-4274-8ed1-9f2c4e0915c4';

update personrole set activeflag = 0, updatedby = 'CDM-20479', updatedon = now() 
where personid in ('b7ce7c13-d264-43c7-a8c4-403dc3de4f59', '92f0134c-c2b5-4e2f-95cb-d2480021f79b', 'dcaa3f4c-fe3e-461f-a756-4acd28b40259') and servicecaseid = '6f88f2a2-6d70-4274-8ed1-9f2c4e0915c4';

update personprogramarea set activeflag = 0, updatedby = 'CDM-20479', updatedon = now() 
where personid in ('b7ce7c13-d264-43c7-a8c4-403dc3de4f59', '92f0134c-c2b5-4e2f-95cb-d2480021f79b', 'dcaa3f4c-fe3e-461f-a756-4acd28b40259') and objectid = '6f88f2a2-6d70-4274-8ed1-9f2c4e0915c4';
