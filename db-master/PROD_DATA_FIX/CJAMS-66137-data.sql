/*
Issue:The CPS IR case was closed in error 
Root Cause:The case was  marked “Completed” and “Approved” in the Decision tab, and the assignment was ended, preventing the worker from reopening or editing the case.
Fix Provided (Data Fix Only):
									Decision Record: Deactivated the incorrect closure disposition (activeflag = 0)
									Assignment: Cleared the assignment end date to reactivate worker access
									
Data/Code fix ticket#: CJAMS-66137'
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This was a data-specific issue, so no code fix is required as the case is closed accidentally.
*/



--Updating intakeservicerequest
update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CJAMS-66137', updatedon = now()
where intakeserviceid = 'aeae00de-2810-4dfe-b386-3c428df29f53' and activeflag = 1;

--Updating intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CJAMS-66137', updatedon = now()
where intakeservicerequestdispositioncodeid = '2eacfae2-c845-4308-a6c0-69120d3cb84b' and activeflag = 1;

--Updating caseassignment
update caseassignment
set enddate = null, updatedby = 'CJAMS-66137', updatedon = now()
where caseassignmentid = 'caeb81e2-4637-47d3-97e2-e5cd30a560eb' and activeflag = 1;

--personprogramarea
 update
	personprogramarea
set
	enddate = null,updatedby = 'CJAMS-66137',updatedon = now()
where entityid = '261023557863'
and activeflag = 1;