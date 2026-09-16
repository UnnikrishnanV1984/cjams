/*
   Issue Description: CDM-28359
   Category/ Module  :Incorrect Screening
   Root cause: 3011907::A SEN referral was received on 1/25. This morning a new case for the same family but entered and screened as a new investigation.IR neglect. When screened inCJAMS automatically moved to assign as a new service case instead of an investigation. 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/
update intakedastatus set activeflag = 0, updatedby = 'CDM-28359', updatedon = now() 
where intakenumber = 'I231010388854' and activeflag = 1;

update intakedastaging set activeflag = 0, updatedby = 'CDM-28359', updatedon = now() 
where intakenumber = 'I231010388854' and activeflag = 1;

update intakeservicerequest set servicecaseid = null, updatedby = 'CDM-28359', updatedon = now() 
where intakenumber = 'I231010388854';

update routing set activeflag = 0, updatedby = 'CDM-28359', updatedon = now() 
where objectid = 'I231010388854' and activeflag = 1;