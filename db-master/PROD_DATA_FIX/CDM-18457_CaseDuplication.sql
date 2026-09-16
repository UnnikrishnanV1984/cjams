/*
   Issue Description: CDM-18457, CDM-18459
   Category/ Module  :  Case Duplication (Intake) 
   Root cause: user wants to remove 2 times
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.intakedastatus
set activeflag = 0, updatedby = 'CDM-18457', updatedon = now()  
where intakenumber = 'I211010201725' and intakedastatusid 
in ('e15dc275-9fee-47e8-ae8c-c6fd68a38646');
 