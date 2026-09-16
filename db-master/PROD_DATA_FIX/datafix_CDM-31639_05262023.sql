-- CDM-31639 - AR summary
/*
-- Issue Description: 
   CPS-AR closure Issue
   Not able to complete the case closure as the Victim perpetrator relationship checkbox is checked.

-- CPS-AR: 231020479806 - 9c8c3322-a173-4176-81c7-a374b1db73ce

-- Category/ Module: Placement (Case Management) 
-- Root cause: Perosn Role Data issue (intakeservicerequestactor table -- Column servicecaseid is having CPS-AR case uuid)
-- Fix Provided: Datafix has been promoted to remove the worng intakeservicerequestactor table record.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 1848305 (BETTIE WALKER )- 37f678ad-317d-4c05-a86e-bc501d355a2a	
select personid, activeflag, updatedby, updatedon, servicecaseid, intakenumber, intakeserviceid
from intakeservicerequestactor 
where intakeservicerequestactorid = '88754bcc-757f-4de8-b76c-88ca5aa3158b'
	and activeflag = 1 ;
	
update intakeservicerequestactor
set activeflag = 0, 
	updatedby = 'CDM-31639', 
	updatedon = now()
where intakeservicerequestactorid = '88754bcc-757f-4de8-b76c-88ca5aa3158b'
	and activeflag = 1 ;
