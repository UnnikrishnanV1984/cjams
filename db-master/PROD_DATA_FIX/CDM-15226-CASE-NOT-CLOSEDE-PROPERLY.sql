/*
   Issue Description: CDM-15226
      Category/ Module  :case not closed properly
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to reopen  AR case

  */

  UPDATE intakeservicerequest 
	SET intakeserreqstatustypeid ='c8dbf10f-843d-4b40-97ca-288d750463da', 
		updatedby = 'CDM-15226',
		updatedon = now() 
	WHERE intakeserviceid = '55eeacec-09ac-4a6c-9c50-df9f66c3667f';

	UPDATE IntakeServiceRequestDispositionCode 
	SET activeflag = 0, 
		updatedby = 'CDM-15226',
		updatedon = now() 
	WHERE intakeservicerequestdispositioncodeid = '74d9f0f6-2189-4cd1-ab1a-21bdaa66e9b7';

	UPDATE caseassignment 
	SET enddate = null, 
		updatedby = 'CDM-15226',
		updatedon = now() 
	WHERE caseassignmentid = '2a0fca12-2245-4fe1-89ac-9db78b6216c2';