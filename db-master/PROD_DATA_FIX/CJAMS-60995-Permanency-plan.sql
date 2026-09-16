/*
Issue Description:CJAMS-60995 Permanency Plans
Category/Module: Permanency Plan 
Root cause: Due to input error, Permanency Plan dates need to be corrected. Primary plan of reunification end date needs to be updated as 10/22/24. The primary plan of guardianship start date is 10/22/24 with the end date of 4/22/25
Fix provided: Data fix has been done to update the dates for the permanency plans.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix needed to update the permanency plan details.
*/

update permanencyplan
set establisheddate = '2024-10-22 00:00:00.000',
    enddate = '2025-04-22 00:00:00.000',
    updatedby = 'CJAMS-60995',
    updatedon = now()
where permanencyplanid  in ('945e75b9-dc0b-4bc5-9273-35c7b8f8c5e5','ac95f6b6-9bfd-4440-b526-ab8d2ca510ba')
and activeflag = 1; 

update permanencyplan
set enddate = '2024-10-22 00:00:00.000',
    updatedby = 'CJAMS-60995',
    updatedon = now()
where permanencyplanid  in ('c1c0134f-338c-4d6c-96a1-0c09057d8b09','f0fd7b82-8e17-4e6a-9982-20b873b98ba1')
and activeflag = 1;