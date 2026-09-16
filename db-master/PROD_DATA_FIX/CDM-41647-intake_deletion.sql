/*
 Issue Description: CDM-41647
-- Category/ Module: Delete Intake
-- Root cause: User wants to remove the intake which was opened in error.
-- Fix Provided: Datafix has been promoted to update the active flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag=0,updatedon=now(),updatedby='CDM-41647'where objectid='I241013104544';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-41647'where intakenumber='I241013104544';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-41647'where intakenumber='I241013104544';
update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CDM-41647'where intakenumber='I241013104544';