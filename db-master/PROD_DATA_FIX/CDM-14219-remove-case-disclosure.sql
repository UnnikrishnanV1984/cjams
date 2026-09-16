UPDATE intakeservicerequest 
SET intakeserreqstatustypeid ='c8dbf10f-843d-4b40-97ca-288d750463da', 
    updatedby = 'CDM-14219',
    updatedon = now() 
WHERE intakeserviceid = 'dbc00126-9730-43e7-87c1-7c54ac84bb32';

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag = 0, 
    updatedby = 'CDM-14219',
    updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = '3a18cf57-2daa-4da3-9dcc-53d945d9b9b0';

UPDATE caseassignment 
SET enddate = null, 
    updatedby = 'CDM-14219',
    updatedon = now() 
WHERE caseassignmentid = 'bcb61cca-9979-4425-87e8-4460e2c48b8a';