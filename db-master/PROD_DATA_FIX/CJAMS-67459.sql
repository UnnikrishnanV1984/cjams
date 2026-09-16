/*
Issue Description: Change subsidy rate
Category/Module: Bug
Root cause: Not a defect ,User entered incorrect subsidy rate date and agreement start date  and requested for data fix.
Fix provided:Data fix is done to update the subsidy date and agreement start date as requested
Data/Code fix ticket#: CJAMS-67459
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update gapagreement set startdate = '2025-07-18 11:00:00',
 updatedon = now(), updatedby = 'CJAMS-67459'
 where gapagreementid = 'c771619b-09a8-4834-846d-37d7125dae06';


update gapagreementrevision set startdate = '2025-07-18 11:00:00',
updatedon = now(), updatedby = 'CJAMS-67459'
where gapagreementid = 'c771619b-09a8-4834-846d-37d7125dae06';

update gapagreementrate set startdate ='2025-07-18 11:00:00',
updatedby='CJAMS-67459',updatedon=now() where gapagreementrateid='e2c0c3df-48a5-4f0a-bb6a-427367ddaa47' and activeflag =1;

update gapratesrevision  set ratestartdate='2025-07-18 11:00:00',approvaldate = now(),
updatedby='CJAMS-67459',updatedon=now() where gaprateid='e2c0c3df-48a5-4f0a-bb6a-427367ddaa47' and activeflag =1;