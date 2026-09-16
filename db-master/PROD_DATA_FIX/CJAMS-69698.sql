/*
Issue Description: CJAMS-69698 - Re-open investigation
Category/Module: Case Reopen
Root cause: The CPS AR 261023845500 was closed on 08/03/2026 and the user needs it re-opened to add to the
   investigation. The closure disposition was recommended and approved, which end dated the case assignment
   and the program areas, so the worker can no longer edit the case.
Fix provided: Data fix to reopen the CPS AR 261023845500 as requested by the user and approved by SSA on
   08/10/2026 - deactivated the closure disposition record, cleared the exit date and set the status back to
   Approved, and removed the end date on the case assignment and the person program areas.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: User requested a data fix
*/

--Updating intakeservicerequest
update intakeservicerequest
set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
	updatedby = 'CJAMS-69698', updatedon = now()
where intakeserviceid = 'fd2ca674-f4cb-4286-9ace-798921ce00ca' and activeflag = 1;

--Updating intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CJAMS-69698', updatedon = now()
where intakeservicerequestdispositioncodeid = '8a2d459b-80ab-46f1-b22b-aaade82e8c3b' and activeflag = 1;

--Updating caseassignment
update caseassignment
set enddate = null, updatedby = 'CJAMS-69698', updatedon = now()
where caseassignmentid = '2d12db8f-3ca4-4135-9a4d-4515ba80e94a'
	and objectid = 'fd2ca674-f4cb-4286-9ace-798921ce00ca' and activeflag = 1;

--personprogramarea
update personprogramarea
set enddate = null, updatedby = 'CJAMS-69698', updatedon = now()
where entityid = '261023845500'
	and objectid = 'fd2ca674-f4cb-4286-9ace-798921ce00ca'
	and activeflag = 1;