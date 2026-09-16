/*
 Issue Description:CDM-37847 Dash board Cleanup Request
 Category/ Module: Case Timeline
 Root cause: Delete Intake #I241011872204 as per the user request
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- No records found
select activeflag,*from routing where objectid ='I241011872204';

select activeflag,* from intakedastatus where intakenumber ='I241011872204';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-37847'where intakenumber='I241011872204';

select activeflag,* from intakedastaging where intakenumber ='I241011872204';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-37847'where intakenumber='I241011872204';

--  No records found
select activeflag,* from intakesnapshot i where intakenumber ='I241011872204';
