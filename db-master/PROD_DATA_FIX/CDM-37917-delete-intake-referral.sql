/*
   Issue Description: CDM-37917
   Category/ Module  : Delete Referrals  
   Root cause: user wants to remove this intake (#I241012074838)
   Fix Provided: Data fix has been promoted to delete the intake (#I241012074838) which still in-progress status as requested.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- Active flag is zero
select *from cjams.routing where objectid='I241012074838';

select *from cjams.intakedastatus where intakenumber='I241012074838';
update cjams.intakedastatus 
set activeflag = 0, updatedby = 'CDM-37917', updatedon = now() 
where intakenumber in ('I241012074838') and activeflag=1;


select *from cjams.intakedastaging where intakenumber='I241012074838';
update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-37917', updatedon = now() 
where intakenumber in ('I241012074838') and activeflag=1;

-- No Records found
select *from intakesnapshot where intakenumber='I241012074838';