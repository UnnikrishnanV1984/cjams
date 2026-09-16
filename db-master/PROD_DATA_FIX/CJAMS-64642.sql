/*
Issue:The CPS IR case was closed in error 
Root Cause:The case was  marked “Completed” and “Approved” in the Decision tab, and the assignment was ended, preventing the worker from reopening or editing the case.
Fix Provided (Data Fix Only):
									Decision Record: Deactivated the incorrect closure disposition (activeflag = 0)
									Assignment: Cleared the assignment end date to reactivate worker access
									
Data/Code fix ticket#: CJAMS-64642
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This was a data-specific issue, so no code fix is required as the case is closed accidentally.
*/

--Updating intakeservicerequest
update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CJAMS-64642', updatedon = now()
where intakeserviceid = '828f2a5b-6d3d-4f6a-a113-22ead928ce84' and activeflag = 1;

--Updating intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CJAMS-64642', updatedon = now()
where intakeservicerequestdispositioncodeid = '1d93c408-60fd-4261-8dde-4f8371cebd1e' and activeflag = 1;

--Updating caseassignment
update caseassignment
set enddate = null, updatedby = 'CJAMS-64642', updatedon = now()
where caseassignmentid = 'ffb0db0f-8575-443e-bc2c-975c9c1d3614' and activeflag = 1;

--personprogramarea
 update
	personprogramarea
set
	enddate = null,updatedby = 'CJAMS-64642',updatedon = now()
where entityid = '251023236440'
and activeflag = 1;