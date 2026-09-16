/*
   Issue Description: CDM-23186
   1. Remove wrong case/glitch case: 221030016708 from the system
   2. Connect correct service case(221030016709) to the intake(I221010287346)
   Note- 221030016709 is closed now, please do not open it. User just need connection with intake correctly.
   Category/ Module  : Duplicate service case 
   Root cause: user wants to Remove wrong case/glitch case: 221030016708 from the system
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update
    servicecase
set
    activeflag = 0,
    updatedby = 'CDM-23186',
    updatedon = now()
where
    servicecaseid = 'cb5ef789-c82c-4e0f-8d06-bfe5e12b1d8f';

update
    servicecasedisposition
set
    activeflag = 0,
    updatedby = 'CDM-23186',
    updatedon = now()
where
    servicecaseid = 'cb5ef789-c82c-4e0f-8d06-bfe5e12b1d8f';

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-23186',
    updatedon = now()
where
    routingid = '8d9d588c-8e00-40b6-bba9-85e8889af8e2' and objectid = 'cb5ef789-c82c-4e0f-8d06-bfe5e12b1d8f';