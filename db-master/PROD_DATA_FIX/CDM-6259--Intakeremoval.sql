--   Issue Description: CDM-6259 - Entered into Child Welfare Production in Error
--   Category/ Module  :  Intake
--   Root cause: User wrongly created and requested to delete the intake
--   Pull request# for code fix: NA
--   Reason why no related code fix: NA
--   Status of the code fix if already submitted and expected prod fix date: NA
update intakedastaging set activeflag=0, updatedby='CDM-6259',updatedon=now() where intakenumber='I202000185687' and activeflag=1;
update intakesnapshot set activeflag=0, updatedby='CDM-6259',updatedon=now() where intakenumber='I202000185687' and activeflag=1;
update intakedastatus set activeflag=0, updatedby='CDM-6259',updatedon=now() where intakenumber='I202000185687' and activeflag=1;
update intakeservicerequestactor set activeflag=0, updatedby='CDM-6259',updatedon=now() where intakenumber='I202000185687';