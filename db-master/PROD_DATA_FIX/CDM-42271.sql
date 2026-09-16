/*
Issue:The CPS IR case was closed in error 
Root Cause:The case was  marked “Completed” and “Approved” in the Decision tab, and the assignment was ended, preventing the worker from reopening or editing the case.
Fix Provided (Data Fix Only):
									Decision Record: Deactivated the incorrect closure disposition (activeflag = 0)
									Assignment: Cleared the assignment end date to reactivate worker access
									
Data/Code fix ticket#: CDM-42271
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This was a data-specific issue, so no code fix is required as the case is closed accidentally.
*/

--Updating intakeservicerequest
update intakeservicerequest 
set
intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CDM-42271', updatedon = now()
where intakeserviceid = '58a5eb0a-556d-43a3-9302-c1152f5fdbf9' and activeflag = 1;

--Updating intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CDM-42271', updatedon = now()
where intakeservicerequestdispositioncodeid = '665f768e-da78-44bf-b8a5-647f4e532825' and activeflag = 1;


--Updating caseassignment
update caseassignment
set enddate = null, updatedby = 'CDM-42271', updatedon = now()
where caseassignmentid = '8b497a51-3961-423b-b1d2-69f70975ab82' and activeflag = 1;

--personprogramarea
 update
	personprogramarea
set
	enddate = null,updatedby = 'CDM-42271',updatedon = now()
where entityid = '241022914295'
and activeflag = 1;