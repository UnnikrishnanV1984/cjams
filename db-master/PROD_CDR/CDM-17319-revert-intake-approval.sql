update intakeservicerequest set activeflag = 0, updatedby = 'CDM-17319', updatedon = now() where intakenumber = 'I211010196450';

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-17319'
where objectid = 'I211010196450';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-17319'
where intakenumber = 'I211010196450' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-17319'
where intakenumber = 'I211010196450' and activeflag = 1;