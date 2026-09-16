/*
   Issue Description: CDM-16211
   Category/ Module  :  
   Root cause: user requested to remove the duplicate removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakedastaging set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-16211'
where intakenumber = 'I211010161544';

update intakedastatus set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-16211'
where intakenumber = 'I211010161544';

update intakesnapshot set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-16211'
where intakenumber = 'I211010161544';