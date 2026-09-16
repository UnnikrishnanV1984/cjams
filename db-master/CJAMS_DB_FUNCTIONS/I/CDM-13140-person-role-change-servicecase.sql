update intakeservicerequestactor set
activeflag = 1,
servicecaseid = null,
updatedon = now(),
updatedby = 'CDM-13140, CDM-13026'
where 
intakeservicerequestactorid = 'a21abc08-8dea-4de0-8b23-07d3f511ff87';