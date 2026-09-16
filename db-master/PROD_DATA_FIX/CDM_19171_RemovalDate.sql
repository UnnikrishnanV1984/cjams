/*
   Issue Description: CDM-19171
   Category/ Module  : Child Removal End Date/
   Root cause: user wants to delete end date removal and placement 
   Pull request# for code fix: 4433
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/ 
UPDATE intakeservreqchildremoval 
SET exitdate=null,  
    updatedby='CDM-19171',
    updatedon=now() 
WHERE intakeservreqchildremovalid = '6c2db70e-ba5a-48cf-9e6c-0071a2a8ace1';

UPDATE personprogramarea 
SET enddate = null, 
    updatedby = 'CDM-14116', 
    updatedon = now() 
WHERE personprogramid = '9a828afb-a59d-46d4-b853-356ee90861d3';