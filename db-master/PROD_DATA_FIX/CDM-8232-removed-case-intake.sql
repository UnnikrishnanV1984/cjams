update cjams.intakedastaging
set activeflag = 0
where intakenumber = 'I202000110294';
update cjams.intakedastatus
set activeflag = 0
where intakenumber = 'I202000110294';
update cjams.intakeservicerequest 
set activeflag = 0
where intakenumber = 'I202000110294';