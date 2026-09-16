
/*
   Issue Description: CDM-23761
   Category/ Module  : Delete Referrals  
   Root cause: user wants to remove this duplicate intake and duplicate person 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-23761', updatedon = now() 
where intakenumber in ('I221010262013') and activeflag=1;

update cjams.intakedastatus 
set activeflag =0, updatedby = 'CDM-23761', updatedon = now() 
where intakenumber in ('I221010262013') and activeflag=1;

update cjams.intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-23761', updatedon = now()
where intakeservicerequestactorid in('07b7cdad-8314-437d-b1b7-2df0c7c3f2be') and personid = '085bdd18-55b5-4d41-b1c9-361850020906';

update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28519'
where actorid = '65d3c47a-a1cf-4646-8597-bca261a1603c';