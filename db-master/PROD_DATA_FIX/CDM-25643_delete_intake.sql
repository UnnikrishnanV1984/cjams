
/*
   Issue Description: CDM-21311
   Category/ Module  :  Intake
   Root cause: user asked to delete the incorrect intake
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-25643'
where objectid = 'I221010322490';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-25643'
where intakenumber = 'I221010322490';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-25643'
where intakenumber = 'I221010322490';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-25643'
where intakenumber = 'I221010322490';