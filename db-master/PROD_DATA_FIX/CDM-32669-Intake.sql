/*
   Issue Description: CDM-32669
   Category/ Module  : Delete Referrals  
   Root cause: user wants to remove this draft intakes
   Fix Provided: Did data fix to remove all intakes 
*/


update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-32669', updatedon = now() 
where intakenumber in ('I221010309702','I221010235099','I211010202365') and activeflag=1;

update cjams.intakedastatus 
set activeflag =0, updatedby = 'CDM-32669', updatedon = now() 
where intakenumber in ('I221010309702','I221010235099','I211010202365') and activeflag=1;

--No Records found becuase it's a draft Intake 
--select objectid, * from routing  where  objectid='I221010309702','I221010235099','I211010202365';