update servicecase set activeflag = 0, updatedby = 'CDM-7686', updatedon = now() where servicecaseid = 'd4532456-78c8-4a2e-8cbf-4eb8b2e355e1';

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-7686'
where objectid = 'I202000105351';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-7686'
where intakenumber = 'I202000105351' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-7686'
where intakenumber = 'I202000105351' and activeflag = 1;


update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-7686'
where intakesnapshotid::character varying = 'fad30f95-86d7-4f34-9f3c-a7c90adf688a';
