/*
Issue Description:CJAMS-58544 GAP case 3115100:The subsidy rate end date needs to be changed. Unable to change the dated
Category/Module: GAP 
Root cause: User is unable to change the GAP agreement end date as it is overlapping with the subsidy rate end date.
Fix provided: Data fix to update the GAP agreement end date and subsidy end date.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update gapagreement
set enddate = '2026-01-23 00:00:00.000',
    updatedby = 'CJAMS-58544',
    updatedon = now()
where gapagreementid='cf6b77c1-8604-474b-a46c-c359842a48ea'
and activeflag = 1;

update gapagreementrate
set enddate='2026-01-23 00:00:00.000',
updatedby = 'CJAMS-58544',
updatedon = now()
where gapagreementrateid ='a97d243e-8dbd-484c-a875-a1d66fb6cc44'
and activeflag = 1;

update gapratesrevision
set rateenddate = '2026-01-23 00:00:00.000',
updatedby = 'CJAMS-58544',
updatedon = now()
where gaprateid  ='a97d243e-8dbd-484c-a875-a1d66fb6cc44'
and activeflag = 1;


update gapratesrevision
set approvaldate = now(),
updatedby = 'CJAMS-58544',
updatedon = now()
where gaprateid in ('a97d243e-8dbd-484c-a875-a1d66fb6cc44','018b4c36-bb4a-4f55-809f-c1b0de82edd4')
and activeflag = 1;
