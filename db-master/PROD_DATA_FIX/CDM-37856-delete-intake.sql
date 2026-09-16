/*
 Issue Description:CDM-37856 Dash Board clean out
 Category/ Module: Case Timeline
 Root cause: Delete Intake #I241012071177 as per the user request
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- No records found
select activeflag,*from routing where objectid ='I241012071177';

select activeflag,* from intakedastatus where intakenumber ='I241012071177';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-37856'where intakenumber='I241012071177';

select activeflag,* from intakedastatus where intakenumber ='I241012071177';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-37856'where intakenumber='I241012071177';

-- No records found
select activeflag,* from intakesnapshot i where intakenumber ='I241012071177';
