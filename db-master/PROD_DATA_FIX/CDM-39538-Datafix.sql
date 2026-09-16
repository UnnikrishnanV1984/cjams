/*
   Issue Description: CDM-39538
   Category/ Module  : delete pending Intakes
   Root cause: delete five draft intakes under Dasia Arthuy Pending dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/


update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39538'
where intakenumber in ('I241012101047','I231011331146','I231011640940','I241011968032','I231011641139');

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39538'
where intakenumber in ('I241012101047','I231011331146','I231011640940','I241011968032','I231011641139');

