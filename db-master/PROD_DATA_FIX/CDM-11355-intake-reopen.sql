update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-11083'
where intakesnapshotid::character varying = '0a504d16-186c-4609-8818-1110bf64fedf';

UPDATE intakeservicerequest 
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-11083'
where intakeserviceid = '6ac7dc6d-eb79-4acd-bfbb-2f509899ba6f';

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-11083'
where objectid = 'I202100220630';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-11083'
where intakenumber = 'I202100220630' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-11083'
where intakenumber = 'I202100220630' and activeflag = 1;