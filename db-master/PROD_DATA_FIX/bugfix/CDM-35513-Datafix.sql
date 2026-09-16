/*
   Issue Description: CDM-35513
   Category/ Module  : Child Welfare
   Root cause:Old Intake needs to be removed
   Pull request# for data fix: Deleted the particular case from the system
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/
update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-35513', updatedon = now() 
where intakenumber in ('I202000201867') and activeflag=1;

update cjams.intakedastatus 
set activeflag =0, updatedby = 'CDM-35513', updatedon = now() 
where intakenumber in ('I202000201867') and activeflag=1;


--Deleted the particular case I202000201867 from the system