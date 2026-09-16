/*
   Issue Description: CDM-35469
   Category/ Module  : Intake Referral Delete
   Root cause: User requested to remove the accidentally created intake
   Fix Privided: 
*/

update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-35469', updatedon = now() 
where intakenumber in ('I231011478427') and activeflag=1;


update cjams.intakedastatus  
set activeflag = 0, updatedby = 'CDM-35469', updatedon = now() 
where intakenumber in ('I231011478427') and activeflag=1;