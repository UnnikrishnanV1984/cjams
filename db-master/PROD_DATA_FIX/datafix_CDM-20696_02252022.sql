-- CDM-20696 - Child is missing from the case
/*
-- Issue Description: 
	Something has happened to this case; the child/alleged victim is no longer in the case. 
	The maltreatment allegation and investigative findings are now gone.
	This child has been removed and placed in foster care there is an active court case concerning this investigation.

-- CPS-IR ID: 211020117881 - 555bb34e-359e-4153-9935-1677ca414bdd
-- Alleged Victim
-- Client ID: 200770739 (Tat Burch) - e3435cf9-59fd-4eae-89b4-e40dcf39a544

-- Category/ Module: Maltreatment/Finding (Investigation Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To bring back the Alleged Victim person in the CPS case 
-- Update intakeserviceid, isprimary, activeflag
select personid, intakeserviceid, servicecaseid, isprimary,
	intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
from intakeservicerequestactor 
where intakeservicerequestactorid = '8ab5116b-0ad1-45d9-b86e-a7363d25d73a'
	and activeflag = 0 ;

update intakeservicerequestactor
set intakeserviceid = '555bb34e-359e-4153-9935-1677ca414bdd',
	isprimary = True,
	activeflag = 1, 
	updatedon = now(), 
	updatedby = 'CDM-20696'
where intakeservicerequestactorid = '8ab5116b-0ad1-45d9-b86e-a7363d25d73a'
	and activeflag = 0 ;

select maltreatmentid, intakeservicerequestactorid, updatedby, updatedon
	from investigationmaltreatmentactor
where investigationmaltreatmentactorid = '82323f8a-cd53-413f-8f97-6fab0a306aa1'
	and activeflag = 1 ;

-- New 
update investigationmaltreatmentactor
set intakeservicerequestactorid = '8ab5116b-0ad1-45d9-b86e-a7363d25d73a', 
	updatedon = now(), 
	updatedby = 'CDM-20696'
where investigationmaltreatmentactorid = '82323f8a-cd53-413f-8f97-6fab0a306aa1'
	and activeflag = 1 ;

