update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-3197'
where intakesnapshotid::character varying = '15815070-249e-482c-9451-74fd4bef5cae';

UPDATE intakeservicerequest 
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-3197'
where intakeserviceid = 'a694a6e1-6766-4821-906d-a01dcd5a1838';

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-3197'
where objectid = 'I202000497805';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-3197'
where intakenumber = 'I202000497805' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-3197'
where intakenumber = 'I202000497805' and activeflag = 1;