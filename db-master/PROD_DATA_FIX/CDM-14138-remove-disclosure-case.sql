UPDATE intakeservicerequest 
SET intakeserreqstatustypeid ='c8dbf10f-843d-4b40-97ca-288d750463da', 
    updatedby = 'CDM-14138',
    updatedon = now() 
WHERE intakeserviceid = '27087e73-67cf-4b5a-a88d-458fa8adb9e3';

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag = 0, 
    updatedby = 'CDM-14138',
    updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = '0aa9084e-1e81-445a-a2d9-ba1327d0ab82';
