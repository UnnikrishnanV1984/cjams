UPDATE intakesnapshot 
SET updatedby = 'CDM-13723', 
    updatedon = now(), 
    activeflag = 0
WHERE intakenumber = 'I211010162067';

update intakeservicerequest 
set activeflag = 0, 
    updatedby = 'CDM-13723', 
    updatedon = now() 
where intakenumber = 'I211010162067';

update intakedastaging 
set activeflag = 0, 
    updatedby = 'CDM-13723', 
    updatedon = now()
where intakenumber = 'I211010162067';

update intakedastatus 
set 
    activeflag = 0,
    updatedby = 'CDM-13723',
    updatedon = now()
where intakenumber = 'I211010162067';

update routing 
set 
    activeflag = 0,
    updatedby = 'CDM-13723',
    updatedon = now()
where objectid = 'I211010162067';


update intakeservicerequestactor 
set activeflag = 0, 
    updatedby = 'CDM-13723', 
    updatedon = now() 
where intakenumber = 'I211010162067';