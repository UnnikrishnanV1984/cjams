-- CDM-9412 - Revert intake approval


update routing
set routingstatustypeid  = 1,
activeflag = 1,
updatedon = now(),
updatedby = 'CDM-9412'
where objectid = 'I202100220630';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-9412'
where objectid = 'I202100220630';

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-9412'
where objectid = 'I202100220630';

update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-9412'
where intakesnapshotid::character varying = '1616feba-55b0-42ad-8c02-0633a36b5e34';
