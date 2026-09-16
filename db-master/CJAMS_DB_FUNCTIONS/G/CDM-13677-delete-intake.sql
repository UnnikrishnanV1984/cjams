UPDATE intakesnapshot 
SET 
updatedby = 'CDM-13677', updatedon = now(), activeflag = 0
WHERE intakenumber = 'I202100256026';

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-13677', updatedon = now() where intakenumber = 'I202100256026';

update intakedastaging set activeflag = 0, updatedby = 'CDM-13677', updatedon = now()
	where intakenumber = 'I202100256026';

update intakedastatus 
set 
activeflag = 0,
updatedby = 'CDM-13677',
updatedon = now()
where intakenumber = 'I202100256026';