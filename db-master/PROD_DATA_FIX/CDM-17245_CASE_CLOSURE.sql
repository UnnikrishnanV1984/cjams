/*
   Issue Description: CDM-17245
   Category/ Module  : case closure
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to reopen  AR case

  */


  UPDATE intakeservicerequest 
	SET intakeserreqstatustypeid ='c8dbf10f-843d-4b40-97ca-288d750463da', 
		updatedby = 'CDM-17245',
		updatedon = now() 
	WHERE intakeserviceid = 'df5b70f0-30c4-4c39-90eb-b1e80d5123a5';

	UPDATE IntakeServiceRequestDispositionCode 
	SET activeflag = 0, 
		updatedby = 'CDM-17245',
		updatedon = now() 
	WHERE intakeservicerequestdispositioncodeid in ('f40e80cb-1c8a-4f62-9246-3c0beade92ac', 'a6b029c6-eab8-4bc7-81d9-77f45d18aa8c');