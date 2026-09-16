/*
 * CDM-42215 - deleted the intake as requested by user
 * Customer Email ID:lamon.anderson@maryland.gov
 * Description - Intake -  Intake should be deleted as the user created another intake for the same
 * 
 */

-- select activeflag,* from intakedastaging where intakenumber='I241013159251';

update intakedastaging
set activeflag=0, updatedby='CDM-42215', updatedon=now()
where intakenumber='I241013159251' and activeflag=1;

-- select activeflag,* from intakedastatus where intakenumber='I241013159251';

update intakedastatus
set activeflag=0, updatedby='CDM-42215', updatedon=now()
where intakenumber='I241013159251' and activeflag=1;


-- select activeflag,* from intakesnapshot where intakenumber='I241013159251';

update intakesnapshot
set activeflag=0, updatedby='CDM-42215', updatedon=now()
where intakenumber='I241013159251' and activeflag=1;

-- select * from intakeservicerequest where intakenumber = 'I241013159251' and activeflag = 1 ;

update intakeservicerequest
set activeflag=0, updatedby='CDM-42215', updatedon=now() 
where intakenumber = 'I241013159251' and activeflag=1;