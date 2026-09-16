/*
Issue Description: CJAMS-59396  AGREEMENT NEEDS TO BE UPDATED
Category/Module: GAP 
Root cause: User is unable to change the GAP agreement end date as it is overlapping with the subsidy rate end date.
Fix provided: Data fix to update the GAP agreement end date and subsidy end date.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update gapagreement
set enddate = '2026-02-03 00:00:00.000',
    updatedby = 'CJAMS-59396',
    updatedon = now()
where  gapagreementid = '0f6a09a4-a4cb-438e-b680-66ddc0f711fa'
and activeflag = 1;

update gapagreementrevision
set enddate = '2026-02-03 00:00:00.000',
    approvaldate = now(),
	updatedby = 'CJAMS-59396',
	updatedon = now()
where gapagreementid = '0f6a09a4-a4cb-438e-b680-66ddc0f711fa' ;