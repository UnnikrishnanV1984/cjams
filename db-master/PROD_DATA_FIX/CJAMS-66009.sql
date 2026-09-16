/*
Issue Description: Change subsidy rate
Category/Module: Bug
Root cause: Not a defect ,User entered incorrect subsidy rate date  and request for data fix.
Fix provided:Data fix is done to update the subsidy dates as requested
Data/Code fix ticket#: CJAMS-66009
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update gapagreementrate set startdate ='2025-12-08 00:00:00.000', enddate ='2026-02-08 00:00:00.000',
updatedby='CJAMS-66009',updatedon=now() where gapagreementrateid='99a988c6-3e78-4116-9d97-aefb4ba89248' and activeflag =1;

update gapratesrevision  set ratestartdate='2025-12-08 00:00:00.000', rateenddate  ='2026-02-08 00:00:00.000',approvaldate = now(),
updatedby='CJAMS-66009',updatedon=now() where gaprateid='99a988c6-3e78-4116-9d97-aefb4ba89248' and activeflag =1;