/*
   Issue Description: CDM-15088
   Category/ Module  :  child welfare 
   Root cause: wrong person removed as usr request
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error wrong data issue. 
*/
update person
set 
activeflag = 0,
updatedby = 'CDM-15088',
updatedon = now()
where
personid in ('5bbdc6c3-491b-4512-b81a-5361dbc5884a', 'e0f1a461-b098-41f2-85f7-4ecb64899d0c');

update intakeservicerequestactor
set 
activeflag = 0,
updatedby = 'CDM-15088',
updatedon = now()
where
personid in ('5bbdc6c3-491b-4512-b81a-5361dbc5884a', 'e0f1a461-b098-41f2-85f7-4ecb64899d0c');


update actor
set 
activeflag = 0,
updatedby = 'CDM-15088',
updatedon = now()
where
personid in ('5bbdc6c3-491b-4512-b81a-5361dbc5884a', 'e0f1a461-b098-41f2-85f7-4ecb64899d0c');
