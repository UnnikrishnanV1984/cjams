/*
Issue: CJAMS-65003 Incorrect Date of Death
Category/Module: Person profile 
Root cause: 241022931927:The date of death for Alicia Cinto Ramirez (204000955) is incorrect. The DOD is listed as 10/8/2025 and the child's actual DOD is 10/8/2024.
Fix provided:  Data fix has been provided to correct the Date of Death as requested.
Data/Code fix ticket#: CJAMS-65003
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update person
set dateofdeath = '2024-10-08 00:00:00',
    updatedon = now(),
    updatedby = 'CJAMS-65003'
where personid = '8eb3e870-9b2f-4d82-9c41-b605aa185a0e'
and activeflag =1;  