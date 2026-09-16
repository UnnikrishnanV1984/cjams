
/*
Issue: CJAMS-67224 Overdue Response Timer
Category/Module: Response Timer
Root cause: Overdue reason button appeared eventhough user met response timer condiiton.
Fix provided:  Data fix has been done to remove the Overdue Reason Button
Data/Code fix ticket#: CJAMS-67224
Regression Impacts: N/A
Is Code fix Required?: 
Code fix ticket#: N/A
Reason why no related code fix:
*/




update cjams.cpsresponsetimeractions
	set activeflag = 0, 
		updatedby = 'CJAMS-67224',
		updatedon = now()
where intakeserviceid  = '98923f8c-3000-4a5d-b565-2382e827f69f'
	and activeflag = 1;

update caseassignment c
set enddate = NULL, 
		updatedby = 'CJAMS-67224',
		updatedon = now()
where caseassignmentid ='083838c2-36cb-441a-9861-e82ea1ec5b6c' and activeflag = 1;

update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
		updatedby = 'CJAMS-67224',
		updatedon = now()
where servicerequestnumber ='261023454383' and activeflag=1;






	update cjams.intakeservicerequestdispositioncode
	set activeflag = 0, 
		updatedby = 'CJAMS-67224',
		updatedon = now()
where intakeserviceid  = '98923f8c-3000-4a5d-b565-2382e827f69f' and intakeservicerequestdispositioncodeid ='2c1a8038-eca8-4483-919b-dac97ce0f48d'
	and activeflag = 1;

	update cjams.intakeservicerequestdispositioncode
	set activeflag = 0, 
		updatedby = 'CJAMS-67224',
		updatedon = now()
where intakeserviceid  = '98923f8c-3000-4a5d-b565-2382e827f69f' and intakeservicerequestdispositioncodeid ='c69f6cd7-268d-4b9d-a557-286f2c127432'
	and activeflag = 1;
