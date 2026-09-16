
/*
Issue Description: Change subsidy rate
Category/Module: Bug
Root cause: Not a defect ,User entered incorrect subsidy rate date   and requested for data fix.
Fix provided:Data fix is done to update the subsidy date  as requested
Data/Code fix ticket#:CJAMS-67457
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate set startdate ='2025-02-24 05:00:00',
updatedby='CJAMS-67457',updatedon=now() where gapagreementrateid='223fb881-0a91-4bd9-87eb-e72fd2b281ec' and activeflag =1;

update gapratesrevision  set ratestartdate='2025-02-24 05:00:00',approvaldate = now(),
updatedby='CJAMS-67457',updatedon=now() where gaprateid='223fb881-0a91-4bd9-87eb-e72fd2b281ec' and activeflag =1;

update gapratesrevision set approvaldate = now(),updatedon = now(),updatedby  = 'CJAMS-67457' 
where gaprateid = '4467a22f-f166-4ce7-afa4-fbd3354cc2c1' and activeflag =1;