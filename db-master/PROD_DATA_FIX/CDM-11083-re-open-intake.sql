update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-11083'
where intakesnapshotid::character varying = '52f9a021-b3a1-446e-80fc-051bd1eb7643';

UPDATE intakeservicerequest 
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-11083'
where intakeserviceid = '1d1b9f6b-fc48-4cb2-b463-4ed608ff27a6';

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-11083'
where objectid = 'I202100235228';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-11083'
where intakenumber = 'I202100235228' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-11083'
where intakenumber = 'I202100235228' and activeflag = 1;