/*
   Issue Description: CDM-17662
      Category/ Module  :  gap agreement approvals removal
   Root cause: gap agrrement approvals for the saul paraz
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate 
	set activeflag = 0, updatedby = 'CDM-17662', updatedon = now() 
	where gapagreementrateid = '4e69aed6-b82e-4ae1-b81d-d8f7a7f8a6ca';