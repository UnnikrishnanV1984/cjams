update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-1515'
where intakesnapshotid::character varying = '779b13ec-b26c-4bfb-afda-4bd2a6a9bdb6';

update intakeservicerequest
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-1515'				
where intakenumber = 'I202000464905';

update routing
set routingstatustypeid  = 1,
updatedon = now(),
updatedby = 'CDM-1515'
where objectid = 'I202000464905';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-1515'
where intakenumber = 'I202000464905' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-1515'
where intakenumber = 'I202000464905' and activeflag = 1;