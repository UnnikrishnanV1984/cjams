/*
   Issue Description: CJAMS_59925
   Category/ Module  : intake removal 
   Root cause: Referral #: I251013279477 Created in error, needs to be removed from dashboard 
   Fix Provided: Fix provided by deleting the intake #I251013279477
   Reason why no related code fix: User error
*/

-- select activeflag,* from intakedastaging where intakenumber='I251013279477' and activeflag=1;

update intakedastaging
set activeflag=0, updatedby='CJAMS-59925', updatedon=now()
where intakenumber='I251013279477' and activeflag=1;

-- select * from intakedastatus where intakenumber='I251013279477' and activeflag=1;

update intakedastatus
set activeflag=0, updatedby='CJAMS-59925', updatedon=now()
where intakenumber='I251013279477' and activeflag=1;