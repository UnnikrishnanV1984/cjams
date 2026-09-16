/*
   Issue Description: CDM-34501
   Category/ Module  : Delete Referrals  
   Root cause: user wants to remove this draft intakes
   Fix Provided: Did data fix to remove all intakes 
*/


update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-34501', updatedon = now() 
where intakenumber in ('I231011244409') and activeflag=1;

update cjams.intakedastatus 
set activeflag =0, updatedby = 'CDM-34501', updatedon = now() 
where intakenumber in ('I231011244409') and activeflag=1;

update cjams.intakesnapshot 
set activeflag =0, updatedby = 'CDM-34501', updatedon = now() 
where intakenumber in ('I231011244409') and activeflag=1;

update cjams.routing 
set activeflag =0, updatedby = 'CDM-34501', updatedon = now() 
where objectid in ('I231011244409') and activeflag=1;

