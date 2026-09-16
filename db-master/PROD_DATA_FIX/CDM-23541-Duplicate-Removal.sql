/*
   Issue Description: CDM-23541
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to remove duplicate record
   Pull request# for code fix: 6989
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update     intakeservreqchildremoval
set     activeflag = 0,
        updatedby = 'CDM-23541',
        updatedon = now()         
where     intakeservreqchildremovalid  = '00437efd-daa8-464d-a9f4-e38ade0bb694';


update     intakeservreqchildremoval
set     activeflag = 1,
        updatedby = 'CDM-23541',
        updatedon = now()         
where     intakeservreqchildremovalid  = '4cf27f0c-db70-4195-a1b3-466ed67382e9';