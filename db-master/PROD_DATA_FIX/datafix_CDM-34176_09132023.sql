-- CDM-34176 - ROA CPS
/*
-- Issue Description: 
	This intake appears to be entered in error and needs to be removed. It is blank case 231020292645.
	
-- Blank Case # 231020292645 - intakeserviceid: c6db6b9e-00ba-4add-8174-572d096f58ad

-- Category/ Module: Person (Investigation Management)
-- Root cause: Blank case was created for in-state ROA-CPS Intake 
-- Fix Provided: Datafix has been promoted to remove the Blank Case # 231020292645
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To remove the Blank Case (CDM-34176)
select servicerequestnumber, actiontype, intakenumber, activeflag, updatedby, updatedon
	from intakeservicerequest 
where servicerequestnumber = '231020292645'
	and activeflag = 1;
	
update intakeservicerequest
set activeflag = 0,
	updatedby = 'CDM-34176',
	updatedon = now()
where servicerequestnumber = '231020292645'
	and activeflag = 1;
