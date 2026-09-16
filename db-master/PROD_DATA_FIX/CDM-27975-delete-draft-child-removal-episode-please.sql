
/*
   Issue Description: CDM-27975
   Category/ Module  : Prod data fix To remove draft Removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    intakeservreqchildremoval
set
    activeflag = 0,
    updatedby = 'CDM-27975',
    updatedon = now()
where
    intakeservreqchildremovalid = 'a2fa01bc-4ab9-4233-b521-fce4ba905f13';
