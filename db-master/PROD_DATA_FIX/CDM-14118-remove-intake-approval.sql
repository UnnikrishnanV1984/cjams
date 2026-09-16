update routing
set routingstatustypeid  = 1,
    activeflag = 1,
    updatedon = now(),
    updatedby = 'CDM-14118'
where objectid = 'I211010163842';

update intakedastatus
set status = 1,
    updatedon = now(),
    updatedby = 'CDM-14118'
where intakenumber = 'I211010163842' and activeflag=1;

update intakedastaging
set status = 'pending',
    ispreintake = FALSE,
    updatedon = now(),
    updatedby = 'CDM-14118'
where intakenumber = 'I211010163842' and activeflag=1;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-14118'
where intakenumber = 'I211010163842' and activeflag=1;

update servicecase 
set activeflag = 0, 
    updatedon = now(), 
    updatedby = 'CDM-14118' 
where servicecaseid = 'c98b96c8-78f6-4476-a42a-5baa526cbd5f';