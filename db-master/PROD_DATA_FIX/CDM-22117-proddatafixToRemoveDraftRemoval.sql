
/*
   Issue Description: CDM-22117
   Category/ Module  : Prod data fix To remove Draft Removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-22117', updatedon = now() 
where intakeservreqchildremovalid in ('f8296f2d-5296-4e4a-8917-80eba9703df7','794a6d59-fe1e-47b7-be49-95135adcd180') and activeflag = 1;
