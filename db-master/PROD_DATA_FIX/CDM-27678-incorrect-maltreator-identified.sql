/*
   Issue Description: CDM-27678
   Category/ Module  : Incorrect Maltreator Identified
   Root cause: user requested to change the maltreator role from shayanika to shriyananda
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update
    intakeservicerequestactor
set
    personid = 'f231ca95-a033-43a8-be72-272a4ab35e64',
    actorid = 'd4dc5e16-2234-4917-a190-6118353798b1',
    updatedby = 'CDM-27678',
    updatedon = now()
where
    actorid = 'ca72d75c-320e-4bd9-b30f-e71425e044eb'
    and intakeservicerequestpersontypekey = 'AM'
    and activeflag = 1
    and intakeservicerequestactorid = '29d9fef9-69bb-41ac-8943-3a852bc820bd';
