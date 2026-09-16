/*
 Issue Description:CDM-37852 Dash Board clean out
 Category/ Module: Case Timeline
 Root cause: Delete Intake #I231011593219 as per the user request
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- No records found
select activeflag,*from routing where objectid ='I231011593219';

select activeflag,* from intakedastatus where intakenumber ='I231011593219';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-37852'where intakenumber='I231011593219';

select activeflag,* from intakedastaging where intakenumber ='I231011593219';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-37852'where intakenumber='I231011593219';

-- No records found
select activeflag,* from intakesnapshot i where intakenumber ='I231011593219';
