/*
 Issue Description:CDM-16037
 Category/ Module:Broken intake from 6/9
 Root cause: delete
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedon=now(),updatedby='CDM-16037'where objectid='I211010165265';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-16037'where intakenumber='I211010165265';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-16037'where intakenumber='I211010165265';
update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CDM-16037'where intakenumber='I211010165265';