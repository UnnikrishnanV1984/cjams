update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-11336'
where intakenumber = 'I202100137299';

UPDATE intakeservicerequest 
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-11336'
where intakenumber = 'I202100137299';


update intakedastatus
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-11336'
where intakenumber = 'I202100137299';

update intakedastaging
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-11336'
where intakenumber = 'I202100137299';