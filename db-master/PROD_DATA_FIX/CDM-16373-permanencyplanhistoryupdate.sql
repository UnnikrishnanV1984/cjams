/*
   Issue Description: CDM-16373
   Category/ Module  :  permenancy history record
   Root cause: user requeseted to update permanency plan Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- Review  
update permanencyplanhistory set status = 'Approved', updatedon = now(), updatedby = 'CDM-16373' where permanencyplanhistoryid = '5cf36a0d-2503-46b5-89d1-081a69c74010';