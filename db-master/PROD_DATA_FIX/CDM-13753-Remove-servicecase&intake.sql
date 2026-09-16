UPDATE intakesnapshot 
SET updatedby = 'CDM-13753', 
    updatedon = now(), 
    activeflag = 0
WHERE intakenumber = 'I202000363032';

update intakeservicerequest 
set activeflag = 0, 
    updatedby = 'CDM-13753', 
    updatedon = now() 
where intakenumber = 'I202000363032';

update intakedastaging 
set activeflag = 0, 
    updatedby = 'CDM-13753', 
    updatedon = now()
where intakenumber = 'I202000363032';

update intakedastatus 
set 
    activeflag = 0,
    updatedby = 'CDM-13753',
    updatedon = now()
where intakenumber = 'I202000363032';

update routing 
set 
    activeflag = 0,
    updatedby = 'CDM-13753',
    updatedon = now()
where objectid = 'I202000363032';


update intakeservicerequestactor 
set activeflag = 0, 
    updatedby = 'CDM-13753', 
    updatedon = now() 
where intakenumber = 'I202000363032';

update servicecase 
set activeflag = 0, 
    updatedby = 'CDM-13753', 
    updatedon = now() 
where servicecaseid = '8ff3fb58-cff6-4778-b420-936eeebf7646';

update routing 
set 
    activeflag = 0,
    updatedby = 'CDM-13753',
    updatedon = now()
where objectid = '8ff3fb58-cff6-4778-b420-936eeebf7646';