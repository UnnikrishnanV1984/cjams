/*
  Issue Description:  CDM-44244
   Category/ Module  :  Intake
   Root cause: User requested to remove draft Inaktes
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-44244'
where objectid in ('I221010244904','I211010214759','I211010208435','I211010207817','I211010190611') and activeflag = 1;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-44244'
where intakenumber in ('I221010244904','I211010214759','I211010208435','I211010207817','I211010190611') and activeflag = 1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-44244'
where intakenumber in ('I221010244904','I211010214759','I211010208435','I211010207817','I211010190611')and activeflag = 1;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-44244'
where intakenumber in ('I221010244904','I211010214759','I211010208435','I211010207817','I211010190611') and activeflag = 1;
