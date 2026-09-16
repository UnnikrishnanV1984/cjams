/*
   Issue Description:CJAMS-60901
   Category/ Module  : Not Provider maltreatment
   Root cause: data fix to change the Provider involved maltreatment from 'Yes' to 'No'  in the SDM and maltreatment allegations screens.
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestsdm
set isfclivingarrangement = false,
    ismaltreatment = false,
    updatedby = 'CJAMS-60901',
    updatedon = now()
where intakeserviceid = '7edd358e-fc2f-4c97-be59-b7cf281b37f1'
and intakeservicerequestsdmid = 'edeac65b-ab99-4389-8aa3-02e52a457c8b';

UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CJAMS-60901',
updatedon=now()
WHERE investigationid='742f2a08-28bd-4e78-8b45-5b54ad0026db';

