-- CDM-14563

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-14563'
where objectid = 'I211010162864';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-14563'
where intakenumber = 'I211010162864';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-14563'
where intakenumber = 'I211010162864';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-14563'
where intakenumber = 'I211010162864';