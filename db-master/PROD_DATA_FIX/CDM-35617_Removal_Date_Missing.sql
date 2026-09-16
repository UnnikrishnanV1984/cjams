/*
 Issue Description: CDM-35617 Removal date missing after placement was completed
 Category/ Module  : caseworker>childremoval
 Root cause: Draft child removal needed to be removed
 -- Fix Provided: Datafix has been added by deleting the draft record.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */
update
    intakeservreqchildremoval
set
    activeflag = 0,
    updatedby = 'CDM-35617',
    updatedon = now()
where
    intakeservreqchildremovalid = '39d0ba86-2dfe-48f5-bbd4-45bbe209491d'
    and activeflag = 1;

/* Updating intakeservchildremoval_history */
update
    intakeservreqchildremoval_history
set
    activeflag = 0,
    updatedby = 'CDM-35617',
    updatedon = now()
where
    intakeservreqchildremovalid = '39d0ba86-2dfe-48f5-bbd4-45bbe209491d'
    and activeflag = 1;