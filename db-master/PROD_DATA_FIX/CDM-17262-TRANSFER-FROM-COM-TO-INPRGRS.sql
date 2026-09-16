/*
   Issue Description: CDM-17262
      Category/ Module  :  transform from complete to in progress
   Root cause: multiple permanency plans
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakeservicerequest 
	SET intakeserreqstatustypeid ='c8dbf10f-843d-4b40-97ca-288d750463da', 
		updatedby = 'CDM-17262',
		updatedon = now() 
	WHERE intakeserviceid = 'ed29773e-32b9-4206-a1d6-2b25849b23d2';

	UPDATE IntakeServiceRequestDispositionCode 
	SET activeflag = 0, 
		updatedby = 'CDM-17262',
		updatedon = now() 
	WHERE intakeservicerequestdispositioncodeid = '6e570d80-8102-46e4-8bc0-afbab5a5dd34';

	UPDATE caseassignment 
	SET enddate = null, 
		updatedby = 'CDM-17262',
		updatedon = now() 
	WHERE caseassignmentid = '06be35a0-04ec-4081-97cd-2716be561724';