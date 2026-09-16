/*
   Issue Description: CDM-18878
   Category/ Module  : User asked to remove intake
   Root cause: user wants to intake
   Pull request# for code fix: 
   Explanantion: user wants to delete the approval record which is already approved
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-18878'
where objectid in ('I211010218366','I211010201320');

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-18878'
where intakenumber in ('I211010218366','I211010201320');

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-18878'
where intakenumber in ('I211010218366','I211010201320');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-18878'
where intakenumber in ('I211010218366','I211010201320');


