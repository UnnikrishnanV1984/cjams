
/*
   Issue Description: CDM-32122
   Category/ Module  : Delete Referrals  
   Root cause: user wants to remove this duplicate intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-32122', updatedon = now() 
where intakenumber in ('I231010630471') and activeflag=1;

update cjams.intakedastatus 
set activeflag =0, updatedby = 'CDM-32122', updatedon = now() 
where intakenumber in ('I231010630471') and activeflag=1;

--No Records found becuase it's a draft Intake 
--select objectid, * from routing  where  objectid='I231010630471';
