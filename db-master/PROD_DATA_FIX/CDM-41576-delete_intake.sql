/*
 Issue Description:CDM-41576
 Category/ Module: I231011822737 Old/incorrect intake needs to be deleted from user Michelle Roque
 Root cause: delete intake I231011822737
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedon=now(),updatedby='CDM-41576'where objectid='I231011822737';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-41576'where intakenumber='I231011822737';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-41576'where intakenumber='I231011822737';
update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CDM-41576'where intakenumber='I231011822737';