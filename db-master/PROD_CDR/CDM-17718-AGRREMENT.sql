/*
   Issue Description: CDM-17718
      Category/ Module  :  Agrrement 
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate 
	set activeflag = 0, updatedby = 'CDM-17718', updatedon = now() 
	where gapagreementrateid = '7fd1b922-1545-4280-a477-9a8328cbb1ab';
