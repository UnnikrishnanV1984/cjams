/*
Issue Description: Change subsidy rate
Category/Module: Bug
Root cause: Not a defect ,User entered incorrect subsidy rate date  and request for data fix.
Fix provided:Data fix is done to update the subsidy dates as requested
Data/Code fix ticket#: CJAMS-65909
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate set startdate ='2026-01-01 00:00:00.000', enddate ='2026-12-31 00:00:00.000',
updatedby='CJAMS-65909',updatedon=now() where gapagreementrateid='c5b80837-cfb0-4b69-a267-4a897873bb1d' and activeflag =1;

update gapratesrevision  set ratestartdate='2026-01-01 00:00:00.000', rateenddate  ='2026-12-31 00:00:00.000',approvaldate = now(),
updatedby='CJAMS-65909',updatedon=now() where gaprateid='c5b80837-cfb0-4b69-a267-4a897873bb1d' and activeflag =1;

update gapagreementrate set  enddate ='2025-12-31 00:00:00.000',
updatedby='CJAMS-65909',updatedon=now() where gapagreementrateid='9dfa5444-1627-4181-9acf-df3d944b0423' and activeflag =1;

update gapratesrevision  set rateenddate ='2025-12-31 00:00:00.000',approvaldate = now(),
updatedby='CJAMS-65909',updatedon=now() where gaprateid='9dfa5444-1627-4181-9acf-df3d944b0423' and activeflag =1;