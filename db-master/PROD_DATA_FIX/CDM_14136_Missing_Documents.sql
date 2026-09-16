/* Issue Description:CDM-14136 - Missing documents for the user and showing flag 0 records 
   Category/ Module  : Documents session
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/



update documentproperties dp set activeflag  =1, updatedby='CDM-14136', updatedon=now() where
	dp.documentpropertiesid in ('7102d7e9-5f56-4bfe-8f89-ef62eded1e0f','c54d215a-ff75-483d-8c91-51a111cfe631');