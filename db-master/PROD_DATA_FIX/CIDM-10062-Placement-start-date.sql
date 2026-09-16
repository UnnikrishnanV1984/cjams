/*
Issue Description: CIDM-10062 231030147416:Hello, I am attempting to change the start date of this placement under the placement tab. It gives me an error regarding a hospitalization and this youth has not been hospitalized. Please provide support as I need the start date to read 5/19/25.
Category/Module: Placement
Root cause: Living Arrangement - Relative Fictive Kin Home - Throwing a Hospitalization validation message when the user click on edit for the approved record.
            Code fix needed to resolve it. We are doing a data fix as the part of this ticket to update the placement start date.
Fix provided: Data fix has been done to update the placement start date
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:CDM-44450
Reason why no related code fix:N/A
*/


update placement
set startdatetime = '2025-05-19 00:00:00.000',
    updatedby = 'CIDM-10062',
    updatedon = now()
where placementid = 'a0e6e75f-0a49-4c21-ba8e-f062aa66790c'
and activeflag=1;

update placementrevision
set entrydate = '2025-05-19 00:00:00.000',
    updatedby = 'CIDM-10062',
    updatedon = now()
where placementid = 'a0e6e75f-0a49-4c21-ba8e-f062aa66790c'
and activeflag=1;
