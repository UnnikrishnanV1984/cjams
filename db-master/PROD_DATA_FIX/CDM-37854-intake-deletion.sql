/*
 Issue Description:CDM-37854 Dash board Cleanup Request
 Category/ Module: Case Timeline
 Root cause: Delete Intake #I231011262854 as per the user request
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- Active flag is zero
select activeflag,*from routing where objectid ='I231011262854';

select activeflag,* from intakedastatus where intakenumber ='I231011262854';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-37854'where intakenumber='I231011262854';

select activeflag,* from intakedastaging where intakenumber ='I231011262854';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-37854'where intakenumber='I231011262854';

--  No records found
select activeflag,* from intakesnapshot i where intakenumber ='I231011262854';
