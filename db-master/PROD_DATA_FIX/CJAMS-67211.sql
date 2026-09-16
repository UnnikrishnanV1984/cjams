/*
Issue Description: Change subsidy rate
Category/Module: Bug
Root cause: Not a defect ,User entered incorrect subsidy rate date  and request for data fix.
Fix provided:Data fix is done to update the subsidy dates as requested
Data/Code fix ticket#: CJAMS-67211
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update gapagreementrate set startdate ='2025-04-02 00:00:00.000',
updatedby='CJAMS-67211',updatedon=now() where gapagreementrateid='9ffbfe05-5aa6-46df-9454-6e2bd6d972ca' and activeflag =1;

update gapratesrevision  set ratestartdate='2025-04-02 00:00:00.000',approvaldate = now(),
updatedby='CJAMS-67211',updatedon=now() where gaprateid='9ffbfe05-5aa6-46df-9454-6e2bd6d972ca' and activeflag =1;

update gapratesrevision set approvaldate = now(),updatedon = now(),updatedby  = 'CJAMS-67211' 
where gaprateid = '7a676c46-6e11-4e73-8776-a12ab4e4523c';