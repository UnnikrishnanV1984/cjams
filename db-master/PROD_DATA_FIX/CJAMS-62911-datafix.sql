/*
Issue:The CPS IR case was closed in error 
Root Cause:The case was  marked “Completed” and “Approved” in the Decision tab, and the assignment was ended, preventing the worker from reopening or editing the case.
Fix Provided (Data Fix Only):
									Decision Record: Deactivated the incorrect closure disposition (activeflag = 0)
									Assignment: Cleared the assignment end date to reactivate worker access
									
Data/Code fix ticket#: CJAMS-62911
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This was a data-specific issue, so no code fix is required as the case is closed accidentally.
*/

--Updating intakeservicerequest
update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CJAMS-62911', updatedon = now()
where intakeserviceid = '5e10ece4-d9e4-4860-a6df-04bcd30e05f2' and activeflag = 1;

--Updating intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CJAMS-62911', updatedon = now()
where intakeservicerequestdispositioncodeid = 'dd421c58-cf5c-4f68-ba4f-72efd3ee6855' and activeflag = 1;

--Updating caseassignment
update caseassignment
set enddate = null, updatedby = 'CJAMS-62911', updatedon = now()
where caseassignmentid = 'a2ecf86f-1843-46bb-88f8-3628db8b8b6c' and activeflag = 1;

--personprogramarea
 update
	personprogramarea
set
	enddate = null,updatedby = 'CJAMS-62911',updatedon = now()
where entityid = '251023121135'
and activeflag = 1;