/*
   Issue Description: CDM-25205 - Case stuck
   Category/ Module  : Approved inbox - Case pending
   Root cause:
   Pull request# for code fix: 4190
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


 
update ROUTING set activeflag = 0 , updatedby = 'CDM-18644', updatedon = now() where objectid = '91e4c8af-5ac1-4724-bfc3-bc2e18ca707e';

update ROUTING set activeflag = 0 , updatedby = 'CDM-18644', updatedon = now() where objectid = '5c6efb03-bc51-428b-b5f0-0e7264819ca7'; 
