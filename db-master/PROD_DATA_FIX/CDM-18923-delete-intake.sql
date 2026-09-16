/*
 Issue Description:CDM-18923
 Category/ Module:delete intake
 Root cause: delete
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedon=now(),updatedby='CDM-18923'where objectid='I211010208350';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-18923'where intakenumber='I211010208350';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-18923'where intakenumber='I211010208350';
update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CDM-18923'where intakenumber='I211010208350';