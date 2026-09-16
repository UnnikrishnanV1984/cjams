/*
 Issue Description:CDM-19055
 Category/ Module: Data fix needed
 Root cause: delete intake
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedon=now(),updatedby='CDM-19055'where objectid='I211010219503 ';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-19055'where intakenumber='I211010219503';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-19055'where intakenumber='I211010219503';
update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CDM-19055'where intakenumber='I211010219503';