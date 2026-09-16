/*
Issue Description: CJAMS-57855:Unable to approve GAP subsidy.Abel, Isaiah and Brandon - These three kids subsidy rates to be approved as they are struck as the previous supervisor has changed
Category/Module: GAP subsidy
Root cause:3301207:Gap Subsidy Review Approvals Are Stuck in the Review Status as the supervisor who has to approve is inactive.  
Fix provided: Data fix has been done redirect the pending GAP subsidy approvals to the supervisor amber.webster1@maryland.gov
Regression Impacts: N/A
Data/Code fix ticket#: CJAMS-57855
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a known issue where supervisor is deactivated and data fix should resolve it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update routing 
set tosecurityusersid='aabfe50d-3996-444c-a2fb-4640f0ff257b', 
    toroleid='CWSP', 
    updatedby='CJAMS-57855', 
    updatedon=now() 
where objectid='34fb7099-ab39-475b-b9fb-5860df09f002' and tosecurityusersid='5a0ef493-bd37-4046-8b0e-773bd97b8612' and activeflag=1;

update routing 
set tosecurityusersid='aabfe50d-3996-444c-a2fb-4640f0ff257b', 
    toroleid='CWSP', 
    updatedby='CJAMS-57855', 
    updatedon=now() 
where objectid='5bec4035-a430-4315-a554-2d73b889548e' and tosecurityusersid='5a0ef493-bd37-4046-8b0e-773bd97b8612' and activeflag=1;

update routing 
set tosecurityusersid='aabfe50d-3996-444c-a2fb-4640f0ff257b', 
    toroleid='CWSP', 
    updatedby='CJAMS-57855', 
    updatedon=now() 
where objectid='c6520dad-64b8-41bd-b0df-ddecdba6f31d' and tosecurityusersid='5a0ef493-bd37-4046-8b0e-773bd97b8612' and activeflag=1;

