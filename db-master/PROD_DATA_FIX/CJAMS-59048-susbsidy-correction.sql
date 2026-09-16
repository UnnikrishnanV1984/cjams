/*
Issue Description:CJAMS-59048 3166056:SUBSIDY END DATE END AGREEMENT END DATE IS INCORRECT
Category/Module: GAP Subsidy 
Root cause: Adoption Subsidy and agreement date needs to be corrected to match child's 21st B'day
Fix provided: Data fix has been done to update subsidy and agreement end date.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update gapagreementrate
set enddate = '2026-01-20 20:00:00.000',
    updatedon = now(),
    updatedby = 'CJAMS-59048'
where gapagreementrateid='4567e044-2c49-40b5-ac17-9c6b0e6254e4'
and activeflag = 1;

update gapratesrevision
set rateenddate = '2026-01-20 20:00:00.000',
    updatedon = now(),
    updatedby = 'CJAMS-59048'
where gaprateid='4567e044-2c49-40b5-ac17-9c6b0e6254e4'
and activeflag = 1;

update gapagreement
set enddate = '2026-01-20 20:00:00.000',
    updatedon = now(),
    updatedby = 'CJAMS-59048'
where gapagreementid = 'cea905dd-f581-4fcd-9e4b-0b3df5371311'
and activeflag = 1;

update gapagreementrevision
set enddate = '2026-01-20 20:00:00.000',
    updatedon = now(),
    updatedby = 'CJAMS-59048'
where gapagreementid = 'cea905dd-f581-4fcd-9e4b-0b3df5371311'
and activeflag = 1;