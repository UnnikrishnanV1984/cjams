/*
   Issue Description: CDM-17891
      Category/ Module  : Gap agreement approval
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate 
	set activeflag = 0, updatedby = 'CDM-17891', updatedon = now() 
	where gapagreementrateid = 'cbceac74-dff4-4dcc-a897-ea89d1900711';