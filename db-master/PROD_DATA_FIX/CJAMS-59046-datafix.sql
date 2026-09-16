/*
Issue:The CPS IR case was closed in error 
Root Cause:The case was prematurely marked “Completed” and “Approved” in the Decision tab, and the assignment was ended, preventing the worker from reopening or editing the case.
Fix Provided (Data Fix Only):
									Decision Record: Deactivated the incorrect closure disposition (activeflag = 0)
									Assignment: Cleared the assignment end date to reactivate worker access
									
Data/Code fix ticket#: CJAMS-59046
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This was a data-specific issue, not a systemic or recurring logic problem. The underlying code was working as designed, and no functional changes were required.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

--Updating intakeservicerequest
update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CJAMS-59046', updatedon = now()
where intakeserviceid = '925b7290-8628-4ca6-8229-38b40f937325' and activeflag = 1;

--Updating intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CJAMS-59046', updatedon = now()
where intakeservicerequestdispositioncodeid = '3adff389-a7aa-432d-902a-b9853f3f857c' and activeflag = 1;

--Updating caseassignment
update caseassignment
set enddate = null, updatedby = 'CJAMS-59046', updatedon = now()
where caseassignmentid = 'd19b2d69-4186-40bb-b865-7962724e1521' and activeflag = 1;

--personprogramarea
 update
	personprogramarea
set
	enddate = null,updatedby = 'CJAMS-59197',updatedon = now()
where entityid = '251023018983'
and activeflag = 1;
