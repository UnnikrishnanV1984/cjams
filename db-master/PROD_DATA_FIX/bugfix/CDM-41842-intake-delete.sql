/*
 * CDM-41842 - deleted the intake as requested by user
 * Customer Email ID: gina.provenzano@maryland.gov
 * Description - Intake -   Case assignment was never assigned, and referral will need to be re-written. 
 * Need to delete the Intake# I241013145862.
 */

-- select activeflag,* from intakedastaging where intakenumber='I241013145862';

update intakedastaging
set activeflag=0, updatedby='CDM-41842', updatedon=now()
where intakenumber='I241013145862' and activeflag=1;

-- select activeflag,* from intakedastatus where intakenumber='I241013145862';

update intakedastatus
set activeflag=0, updatedby='CDM-41842', updatedon=now()
where intakenumber='I241013145862' and activeflag=1;

-- select activeflag,* from intakesnapshot where intakenumber='I241013145862';

update intakesnapshot
set activeflag=0, updatedby='CDM-41842', updatedon=now()
where intakenumber='I241013145862' and activeflag=1;

--  select activeflag,* from intakeservicerequest where intakenumber='I241013145862';

update intakeservicerequest 
set activeflag=0, updatedby='CDM-41842', updatedon=now()
where intakenumber='I241013145862' and activeflag=1;