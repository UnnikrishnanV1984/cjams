/*
Issue:The CPS AR case was closed in error before a new service case could be opened for a pending referral to Family Preservation Services.
Root Cause:The case was prematurely marked “Completed” and “Approved” in the Decision tab, and the assignment was ended, preventing the worker from reopening or editing the case.
Fix Provided (Data Fix Only):
									Decision Record: Deactivated the incorrect closure disposition (activeflag = 0)
									AR Summary: Reset status from Approved to Draft to allow resubmission
									Assignment: Cleared the assignment end date to reactivate worker access
									Routing: Reactivated routing to resume workflow
Data/Code fix ticket#: CJAMS-59197
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This was a data-specific issue, not a systemic or recurring logic problem. The underlying code was working as designed, and no functional changes were required.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
--Intakeservicerequestdispositioncode
 update
	Intakeservicerequestdispositioncode
set
	activeflag = 0,
	updatedby = 'CJAMS-59197',
	updatedon = now()
where
	intakeservicerequestdispositioncodeid = '25779176-b871-4ab7-a46c-c2d853c350f8'
	and activeflag = 1;
--caseassignment
 update
	caseassignment
set
	enddate = null,
	updatedby = 'CJAMS-59197',
	updatedon = now()
where
	caseassignmentid = 'fb0d7cf3-59d8-4758-a405-f8ccd4166a6d'
	and activeflag = 1;
--routing
 update
	routing
set
	activeflag = 1,
	updatedby = 'CJAMS-59197',
	updatedon = now()
where
	routingid = 'a9ce9673-9613-4466-a484-09faed48e26e';

update
	intakeservicerequest
set
	intakeserreqstatustypeid  = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
	updatedby = 'CJAMS-59197',
	updatedon = now()
where
	intakeserviceid = '9dff7ab6-e6b7-451b-b9c4-a171dbc58a04'
	and activeflag = 1;

update
	Intakeservicerequestdispositioncode
set
	intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
	updatedby = 'CJAMS-59197',
	updatedon = now()
where
	intakeservicerequestdispositioncodeid = '3c125194-25fe-4555-840f-1dba76d766cf'
	and activeflag = 1;
    
--personprogramarea
 update
	personprogramarea
set
	enddate = null,
	updatedby = 'CJAMS-59197',
	updatedon = now()
where
	personprogramid in('00d95751-76d6-4477-b013-4d3d406dc543',
	'48847718-352e-4275-a16c-f6306d44b08d',
	'fdde084e-749d-4322-855b-84cee50b2c7b',
	'85d966e8-8b49-43bd-b970-a0da1b9482e5',
	'56147afa-43ab-4a74-8720-5c64e3af8af1',
	'2f18c132-a4c7-4e91-9406-6f231c0f22ee')
	and activeflag = 1 ;
