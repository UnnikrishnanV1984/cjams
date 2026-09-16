
/*
   Issue Description: CDM-24362
   Category/ Module  : Duplicate Placement
   Root cause: user wants to remove duplicate placement 
   Pull request# for code fix: 6046
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
UPDATE intakeservreqchildremoval 
SET updatedby = 'CDM-24362', 
    updatedon = now(), 
    activeflag = 0
WHERE intakeservreqchildremovalid = 'f5e9c276-ae2e-4033-a2c8-91a8cd5fcbcb' AND activeflag=1;

UPDATE placement 
SET updatedby = 'CDM-24362', 
    updatedon = now(), 
    intakeservreqchildremovalid = 'ef2f1404-51da-44cd-9a87-b43ea767e207'
WHERE intakeservreqchildremovalid = 'f5e9c276-ae2e-4033-a2c8-91a8cd5fcbcb' AND activeflag=1;