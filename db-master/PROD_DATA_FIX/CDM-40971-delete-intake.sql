/* 
   Issue Description: CDM-40971 Delete intake
   Category/ Module  : Case Timeline
   Root cause:User requested to delete the intake I202100513070 from Dashboard as it was created by mistake
   Fix Provided : Data fix has been provided to delete the intake from all intake related tables.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

-- Intake data not created in routing and intakesnapshot table
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-40971'  where intakenumber='I202100513070' and activeflag=1;
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-40971' where intakenumber='I202100513070' and activeflag=1;