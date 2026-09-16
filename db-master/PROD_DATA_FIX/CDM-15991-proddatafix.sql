/*  Issue Description: CDM-15991 - Dual role not working in CJAMS
   Category/ Module  :  Staff management
   Root cause: it seems it is sailpoint issue
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: teammemberid=480d3530-2591-4490-b178-9b0fa6d56a21
*/

update teammemberassignment set teammemberid='2bc2493e-1c01-481f-b482-71229d7fd21d', updatedby='CDM-15991', updatedon = now()  
where securityusersid='8bc34261-90d5-47fa-baae-6fdd9cc259d8' and teammemberassignmentid='9d4cf210-7e5d-4453-ae86-d4b722199ec9';
