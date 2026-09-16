UPDATE intakeservicerequest 
SET intakeserreqstatustypeid ='c8dbf10f-843d-4b40-97ca-288d750463da', 
    updatedby = 'CDM-13783',
    updatedon = now() 
WHERE intakeserviceid = '12455fd1-6688-4180-8a6e-01694a0884b1';

update IntakeServiceRequestDispositionCode 
SET activeflag = 0, 
    updatedby = 'CDM-13783',
    updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = 'db4bc76e-7733-46e2-a32e-efdf947c041d';