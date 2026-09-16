/*
   Issue Description: CDM-27927
   Category/ Module  : delete case 221020272316
   Root cause: user wants to delete case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update
    intakeservicerequest
set
    activeflag = 0,
    updatedby = 'CDM-27927',
    updatedon = now()
where
    intakeserviceid = '1b79cac1-8b2b-46c0-8f22-c0e534a7992d'
    and activeflag = 1;

update
    investigation
set
    activeflag = 0,
    updatedby = 'CDM-27927',
    updatedon = now()
where
    intakeserviceid = '1b79cac1-8b2b-46c0-8f22-c0e534a7992d'
    and activeflag = 1;

update
    caseassignment
set
    activeflag = 0,
    updatedby = 'CDM-27927',
    updatedon = now()
where
    objectid = '1b79cac1-8b2b-46c0-8f22-c0e534a7992d'
    and activeflag = 1;

update
    personprogramarea
set
    activeflag = 0,
    updatedby = 'CDM-27927',
    updatedon = now()
where
    objectid = '1b79cac1-8b2b-46c0-8f22-c0e534a7992d'
    and activeflag = 1;