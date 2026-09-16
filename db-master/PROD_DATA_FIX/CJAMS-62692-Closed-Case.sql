/*
Issue Description: 3054306:Case is closed by assignment is still active. Cannot end assignment at this time.
Root cause: It seems that in August 2023, supervisors could still assign cases to workers despite the case being closed. I checked now and this is no longer the case. So the issue is no longer present, except for this case. Datafix adding an end date to the caseassignment seems sufficient.
Fix provided: update into caseassignment table
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User Error.
*/

update caseassignment
set enddate = '2023-08-21 15:47:04',updatedby  ='CJAMS-62692', updatedon =now()
where caseassignmentid = '633c8a6a-2d1b-4029-8915-cd0cea102b20' AND activeflag =1;