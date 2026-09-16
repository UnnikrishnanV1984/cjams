/*
* CDM-42366 - Intake was deleted as requested by the user
* Customer Email ID: trene.williams@maryland.gov
* Description - Intake- Intake has no person added into referral #I241012076063.
* 
*/

-- select activeflag ,* from intakedastaging i where intakenumber ='I241012076063';

update intakedastaging
set activeflag=0, updatedby='CDM-42366', updatedon=now()
where intakenumber='I241012076063' and activeflag=1;

-- select activeflag ,* from intakedastatus i2 where intakenumber ='I241012076063';

update intakedastatus
set activeflag=0, updatedby='CDM-42366', updatedon=now()
where intakenumber='I241012076063' and activeflag=1;

update intakesnapshot 
set activeflag=0, updatedby='CDM-42366', updatedon=now()
where intakenumber='I241012076063' and activeflag=1;

update intakeservicerequest
set activeflag=0, updatedby='CDM-42366', updatedon=now()
where intakenumber='I241012076063' and activeflag=1;