update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-3373'
where intakesnapshotid::character varying = '0db08073-0b70-44ba-9787-35c0edeaccb4';

update intakeservicerequest
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-3642'				
where intakenumber = 'I202000065124';

update routing
set routingstatustypeid  = 1,
updatedon = now(),
updatedby = 'CDM-3642'
where objectid = 'I202000065124';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-3642'
where intakenumber = 'I202000065124' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-3642'
where intakenumber = 'I202000065124' and activeflag = 1;