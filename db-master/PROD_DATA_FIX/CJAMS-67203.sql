/*
Issue Description: Change subsidy rate
Category/Module: Bug
Root cause: Not a defect ,User entered incorrect subsidy rate date   and requested for data fix.
Fix provided:Data fix is done to update the subsidy date  as requested
Data/Code fix ticket#:CJAMS-67203
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate set startdate ='2025-09-02 00:00:00.000',
updatedby='CJAMS-67203',updatedon=now() where gapagreementrateid='0706672c-ce4d-488a-9946-56ff6e0ba78f' and activeflag =1;

update gapratesrevision  set ratestartdate='2025-09-02 00:00:00.000',approvaldate = now(),
updatedby='CJAMS-67203',updatedon=now() where gaprateid='0706672c-ce4d-488a-9946-56ff6e0ba78f' and activeflag =1;