/*
   Issue Description: CDM-38042
   Category/ Module  : Dashboard
   Root cause: User created a duplicate intake referral.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

select activeflag,* from intakedastaging where intakenumber='I241012092180' and activeflag=1;

update intakedastaging 
set activeflag=0, updatedby='CDM-38042', updatedon=now()
where intakenumber='I241012092180' and activeflag=1;

select activeflag,* from intakedastatus where intakenumber='I241012092180' and activeflag=1;

update intakedastatus 
set activeflag=0, updatedby='CDM-38042', updatedon=now()
where intakenumber='I241012092180' and activeflag=1;

select activeflag,* from intakesnapshot where intakenumber='I241012092180' and activeflag=1;

update intakesnapshot 
set activeflag=0, updatedby='CDM-38042', updatedon=now()
where intakenumber='I241012092180' and activeflag=1;

select activeflag,* from intakeservicerequest where intakenumber='I241012092180' and activeflag=1;

select activeflag,* from routing where objectid='I241012092180' and activeflag=1;

update routing 
set activeflag=0, updatedby='CDM-38042', updatedon=now()
where objectid='I241012092180' and activeflag=1;