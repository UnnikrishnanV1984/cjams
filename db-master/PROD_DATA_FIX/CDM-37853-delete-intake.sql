/*
 Issue Description:CDM-37853 Dashboard Cleanup Request
 Category/ Module: Case Timeline
 Root cause: Delete Intake #I241011872572 as per the user request
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- Active flag is zero
select activeflag,*from routing where objectid ='I241011872572';

select activeflag,* from intakedastatus where intakenumber ='I241011872572';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-37853'where intakenumber='I241011872572';

select activeflag,* from intakedastaging where intakenumber ='I241011872572';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-37853'where intakenumber='I241011872572';

-- Active flag is zero
select activeflag,* from intakesnapshot i where intakenumber ='I241011872572';
