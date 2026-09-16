--Issue CDM-27424-intake-needs-deleted
/*
-- Issue Description: 
	1. User requested to delete Intake #I221010343670 from the system

-- Category/ Module: Intake
-- Root cause: User request. Intake needs to be deleted as subsequent intake was created and approved. This intake is stuck and unable to be approved/disapproved

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedon=now(),updatedby='CDM-27424'where objectid='I221010343670';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-27424'where intakenumber='I221010343670';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-27424'where intakenumber='I221010343670';
update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CDM-27424'where intakenumber='I221010343670';