-- CDM-14353
-- Intake has been removed as per the user request

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-14353'
where objectid = 'I211010168048';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-14353'
where intakenumber = 'I211010168048';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-14353'
where intakenumber = 'I211010168048';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-14353'
where intakenumber = 'I211010168048';