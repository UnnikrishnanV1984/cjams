update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-1652'
where intakesnapshotid::character varying = '4171d6a1-c90b-4781-a25d-f269edc22cfd';

update intakeservicerequest
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-1652'				
where intakenumber = 'I202000465817';

update routing
set routingstatustypeid  = 1,
updatedon = now(),
updatedby = 'CDM-1652'
where objectid = 'I202000465817';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-1652'
where intakenumber = 'I202000465817' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-1652'
where intakenumber = 'I202000465817' and activeflag = 1;