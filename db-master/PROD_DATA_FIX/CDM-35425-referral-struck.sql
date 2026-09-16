/*
   Issue Description: CDM-35425
   Category/ Module  : Intake Referral Struck
   Root cause: User requested to remove the old intake
   Fix Privided: 
*/

update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-35425', updatedon = now() 
where intakenumber in ('I202100352158') and activeflag=1;


update cjams.intakedastatus  
set activeflag = 0, updatedby = 'CDM-35425', updatedon = now() 
where intakenumber in ('I202100352158') and activeflag=1;