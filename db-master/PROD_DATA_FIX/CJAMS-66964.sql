/*
Issue Description: CJAMS-66964-Case is closed showing on workload
Root cause: case is closed, but the assignment didn't get ended that is the reason we are getting the case on workload dashboard
Fix provided: Datafix to end assignment date as per the case closure Date
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Code fix ticket#: N/A
Reason why no related code fix: User Error.
*/

update caseassignment set enddate= '2021-09-23 10:45:02',
updatedby ='CJAMS-66964',updatedon = now() where caseassignmentid = 'a01e467a-3538-4811-a7b4-e4abd9679fba';