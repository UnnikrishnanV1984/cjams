update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'S20200253015895'
where intakesnapshotid::character varying = 'dcd86e8d-3d68-4265-bfa0-980b2474a589';

update intakeservicerequest
set activeflag = 0,
updatedon = now(),
updatedby = 'S20200253015895'				
where intakenumber = 'I202000379191';

update routing
set routingstatustypeid  = 1,
updatedon = now(),
updatedby = 'S20200253015895'
where objectid = 'I202000379191';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'S20200253015895'
where intakenumber = 'I202000379191' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'S20200253015895'
where intakenumber = 'I202000379191' and activeflag = 1;
