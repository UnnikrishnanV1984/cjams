/*
   Issue Description: CJAMS-59424
   Category/ Module  : Prod data fix To remove Safe-C assessments
   Root cause: Sub query was failing as duplicate records was there in rolemapping table.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update rolemapping
set activeflag = 0,
	updatedby = 'CJAMS-59424',
	updatedon = now()
where id = 152059643
and activeflag = 1;