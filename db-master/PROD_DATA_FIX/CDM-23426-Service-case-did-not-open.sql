/*
   Issue Description: CDM-23426
   Category/ Module  :  
   Root cause: User requested to remove the intake referral
   Pull request# for code fix: 5820
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastaging set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-23426'
where activeflag = 1 and intakenumber = 'I221010291284';

update intakedastatus set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-23426'
where activeflag = 1 and intakenumber = 'I221010291284';

update intakesnapshot set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-23426'
where activeflag = 1 and intakenumber = 'I221010291284';

update intakeservicerequest set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-23426'
where activeflag = 1 and intakenumber = 'I221010291284';