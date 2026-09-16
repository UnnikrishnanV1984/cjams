UPDATE caseassignment 
SET enddate = null,
updatedby = 'CDM-8930',
updatedon = now() 
WHERE objectid = '5cacf8e4-bc98-4f4c-bc76-987d958647a2' AND toworkeridno = '83b6ff74-57cb-44e7-bd74-935e33053171';

UPDATE intakeservicerequest 
SET exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
updatedby = 'CDM-8930',
updatedon = now()
WHERE intakeserviceid = '5cacf8e4-bc98-4f4c-bc76-987d958647a2';

UPDATE routing 
SET activeflag = 0,
updatedby = 'CDM-8930',
updatedon = now()
WHERE objectid = '1de6c620-b9aa-4079-b368-f3bee50c05e5';

UPDATE intakeservicerequestdispositioncode 
SET reviewcomments = 'Reverting on user request',
updatedby = 'CDM-8930',
updatedon = now()
WHERE intakeservicerequestdispositioncodeid = '1de6c620-b9aa-4079-b368-f3bee50c05e5';