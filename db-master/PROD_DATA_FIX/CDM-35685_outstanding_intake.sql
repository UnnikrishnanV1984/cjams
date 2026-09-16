
/*
   Issue Description: CDM-35685
   Category/ Module  : delete a draft record
   Root cause: User requested to remove old intake that was started in error in the wrong system. 
   Intake was completed in adult services but this has been unable to be removed from the system
   Fix Provided: 
*/

select * from intakedastaging where intakenumber ='I211010188493';

select * from intakedastatus where intakenumber ='I211010188493';

update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-35685', updatedon = now() 
where intakenumber in ('I211010188493') and activeflag=1;

update cjams.intakedastatus  
set activeflag = 0, updatedby = 'CDM-35685', updatedon = now() 
where intakenumber in ('I211010188493') and activeflag=1;