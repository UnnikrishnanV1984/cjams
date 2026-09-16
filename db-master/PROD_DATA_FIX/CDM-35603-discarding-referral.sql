/*
   Issue Description: CDM-35603
   Category/ Module  : Intake Referral Delete
   Root cause: User requested to remove the old referral
   Fix Privided: 
*/

select * from intakedastatus where intakenumber ='I221010303745';

select * from intakedastaging where intakenumber ='I221010303745';

update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-35603', updatedon = now() 
where intakenumber in ('I221010303745') and activeflag=1;


update cjams.intakedastatus  
set activeflag = 0, updatedby = 'CDM-35603', updatedon = now() 
where intakenumber in ('I221010303745') and activeflag=1;