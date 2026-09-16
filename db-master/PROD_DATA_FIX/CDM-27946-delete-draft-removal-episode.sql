
/*
   Issue Description: CDM-27946
   Category/ Module  : Prod data fix To remove draft Removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    intakeservreqchildremoval
set
    activeflag = 0,
    updatedby = 'CDM-27946',
    updatedon = now()
where
    intakeservreqchildremovalid = '43ac69ba-433c-41d2-8629-54c0983ef707';