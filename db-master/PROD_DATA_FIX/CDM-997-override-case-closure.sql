UPDATE caseassignment 
SET enddate = null 
WHERE objectid = 'f0804888-cb29-4de9-bfd1-5f336baaad83' AND toworkeridno = 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26';

UPDATE intakeservicerequest 
SET exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690'
WHERE intakeserviceid = 'f0804888-cb29-4de9-bfd1-5f336baaad83';

UPDATE routing 
SET activeflag = 0
WHERE objectid = 'c64b53f8-2171-4cf8-922f-dcc4fcede325';

UPDATE intakeservicerequestdispositioncode 
SET reviewcomments = 'Reverting on user request'
WHERE intakeservicerequestdispositioncodeid = 'c64b53f8-2171-4cf8-922f-dcc4fcede325';
