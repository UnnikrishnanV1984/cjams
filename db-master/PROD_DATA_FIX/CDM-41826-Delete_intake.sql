/*
 Issue Description:CDM-41826
 Category/ Module: I241013146354 intake needs to be deleted from user lisa.nasoff@montgomerycountymd.gov as it was created on error Screen
 Root cause: delete intake I241013146354
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/


update routing set activeflag=0,updatedon=now(),updatedby='CDM-41826'where objectid='I241013146354';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-41826'where intakenumber='I241013146354';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-41826'where intakenumber='I241013146354';
update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CDM-41826'where intakenumber='I241013146354';