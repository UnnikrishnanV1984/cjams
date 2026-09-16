/*
  Issue Description:  CDM-42466
   Category/ Module  : Intake
   Root cause: Intake to delete as supervisor was clicking outside the case connected window pop-up page. 
   The Intake got approved and screened in but it is not connected to any service case.
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

-- select activeflag,* from intakedastaging where intakenumber='I241013166928';

update intakedastaging
set activeflag=0, updatedby='CDM-42524', updatedon=now()
where intakenumber='I241013166928' and activeflag=1;

-- select activeflag,* from intakedastatus where intakenumber='I241013166928';

update intakedastatus
set activeflag=0, updatedby='CDM-42524', updatedon=now()
where intakenumber='I241013166928' and activeflag=1;

-- select activeflag,* from routing where objectid='I241013166928';

update routing
set activeflag=0, updatedby='CDM-42524', updatedon=now()
where objectid='I241013166928' and activeflag=1;

-- select activeflag ,* from intakesnapshot i where intakenumber='I241013166928';

update intakesnapshot
set activeflag=0, updatedby='CDM-42524', updatedon=now()
where intakenumber='I241013166928' and activeflag=1;

-- select * from intakeservicerequest i where intakenumber ='I241013166928';

update intakeservicerequest
set activeflag=0, updatedby='CDM-42524', updatedon=now()
where intakenumber='I241013166928' and activeflag=1;