/*
Issue Description: CJAMS-63612: Name Change
Category/Module: User profile
Root cause: User name changed in the sailpoint and data fix needed to reassign the cases in the pending dashboard.
            Emily.Miller@maryland.gov has been updated to Emily.Kenney@maryland.gov can you please assist with transfering any cases or tasks to her new email.
Fix provided: Data fix has been done to reassign the cases from pending dashboard of Emily.Miller@maryland.gov to the new user Emily.Kenney@maryland.gov
Data/Code fix ticket#: CJAMS-63612
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: It is a sailpoint issue and we need to do data fix for case assignments
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:

*/
--routing id's fbd42bc5-3b84-45a1-b6cc-5f504d625ce7 and dbdc04ae-a637-4b01-86c3-aa175476cdcb
--to update tosecurityuserids to c8cd187f-0fa0-45d3-a27d-d19b48395321 from e82ede0e-15a7-43d9-b628-a06054c5eca3

update routing
set tosecurityusersid = 'c8cd187f-0fa0-45d3-a27d-d19b48395321',
    updatedon = now(),
    updatedby = 'CJAMS-63612'
where routingid in ('fbd42bc5-3b84-45a1-b6cc-5f504d625ce7','dbdc04ae-a637-4b01-86c3-aa175476cdcb')
and activeflag =1;    
