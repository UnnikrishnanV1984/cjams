/*
   Issue Description: CDM-15867
   Category/ Module  : Case removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing r 
	set activeflag = 0, updatedby = 'CDM-15867', updatedon = now()
	where objectid = 'e5c5076e-e222-4056-97b7-df40e4b46556';

    