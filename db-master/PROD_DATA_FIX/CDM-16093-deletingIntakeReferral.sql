/*
   Issue Description: CDM-16093
   Category/ Module  :  
   Root cause: User requested to remove the intake referral
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update intakedastaging set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-16093'
where intakenumber = 'I211010181656';

update intakedastatus set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-16093'
where intakenumber = 'I211010181656';

update intakesnapshot set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-162093'
where intakenumber = 'I211010181656';