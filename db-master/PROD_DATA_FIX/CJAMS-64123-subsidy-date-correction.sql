/*
Issue: CJAMS-64123 need assistance with an error in dates on the payment.
Category/Module: GAP/Subsidy rate
Root cause: Data entry error and following changes needs to be done as the part of data fix
            1. Client ID: 3348954 (CORNELL PARKS) - There are duplicate Subsidy rates dated "01/19/2025 - 01/18/2026". 
               Need to delete the duplicate rate and the date needs to be corrected as "01/18/2025 - 01/17/2026" for the other record because the prior rate ended with "01/17/2025".
            2. Client ID: 3255183 (CAMILLE PARKS) - There is a Subsidy rate dated "01/19/2025 - 01/18/2026". 
               Date needs to be corrected as "01/18/2025 - 01/17/2026"  because the prior rate ended with "01/17/2025".  

Fix provided:  Data fix has been done to delete the duplicate subsidy rate and correct the subsidy agreement rate as requested.
Data/Code fix ticket#: CJAMS-64123
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a data entry error and we need a data fix to resolve it.
*/

--Client Name CAMILLE PARKS -- CJAMS PID #3255183

update gapagreementrate
set startdate = '2025-01-18 01:00:00',
    enddate = '2026-01-17 01:00:00',
    updatedby = 'CJAMS-64123',
    updatedon = now()
where  gapagreementrateid in ('282ddf45-5c3a-4de6-a2bc-9462dc146d98')
and activeflag=1;

update gapagreementrate
set startdate = '2026-01-18 01:00:00',
    enddate = '2027-01-17 01:00:00',
    updatedby = 'CJAMS-64123',
    updatedon = now()
where  gapagreementrateid in ('c573e160-2cb3-4ebd-8a3c-5298708840d8')
and activeflag=1;


---Client Name CORNELL PARKS   CJAMS PID #3348954

update gapagreementrate
set startdate = '2025-01-18 01:00:00',
    enddate = '2026-01-17 01:00:00',
    updatedby = 'CJAMS-64123',
    updatedon = now()
where  gapagreementrateid in ('e438567b-f9c8-42f4-9a15-8d2ec444b065')
and activeflag=1;

update gapagreementrate
set startdate = '2026-01-18 01:00:00',
    enddate = '2027-01-17 01:00:00',
    updatedby = 'CJAMS-64123',
    updatedon = now()
where  gapagreementrateid in ('537c248f-fba0-4a66-bf43-06cc41966128')
and activeflag=1;


--Deleting duplicate subsidy rate

update gapagreementrate
set activeflag = 0,
    updatedby = 'CJAMS-64123',
    updatedon = now()
where  gapagreementrateid in ('2aa724bb-fd6c-489b-84c6-973e2b5e7e17')
and activeflag =1;

update gapratesrevision
set activeflag = 0,
    updatedby = 'CJAMS-64123',
    updatedon = now()
where  gaprateid in ('2aa724bb-fd6c-489b-84c6-973e2b5e7e17')
and activeflag =1;


--To Trigger overpayment batch for all the gap rate records
update gapratesrevision
set approvaldate = now(),
    updatedby = 'CJAMS-62877',
    updatedon = now()
where  gaprateid  in ('282ddf45-5c3a-4de6-a2bc-9462dc146d98','c573e160-2cb3-4ebd-8a3c-5298708840d8','e438567b-f9c8-42f4-9a15-8d2ec444b065','537c248f-fba0-4a66-bf43-06cc41966128')
and activeflag =1;