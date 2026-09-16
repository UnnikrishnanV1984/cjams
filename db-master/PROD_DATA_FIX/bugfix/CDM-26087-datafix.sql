-- CDM-26087 - Wrong person indicated
/*
-- Issue Description: 
	1.User requested to reopen the CPS case
	
-- Category/ Module: CPS Case
-- Root cause: Duplicate note
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update 	intakeservicerequest 
set 	exitdate = null, 
		intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 
		updatedon= now(), 
		updatedby='CDM-26087'
where 	intakeserviceid = '42530b17-dcdc-45ac-95b2-39f7c74a4978';


UPDATE 	IntakeServiceRequestDispositionCode 
SET 	activeflag =0, 
		updatedby = 'CDM-26087',
		updatedon = now() 
WHERE 	intakeservicerequestdispositioncodeid = '0052e520-cefa-412f-ba1d-4972e3fc7498';