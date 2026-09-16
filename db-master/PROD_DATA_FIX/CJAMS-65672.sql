/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on 07/09/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for the alleged maltreator from  06/17/2025 to 04/30/2025..
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/

update investigationallegation 
set incidentdate = '2025-04-30 00:00:00',
	updatedby = 'CJAMS-65672',
	updatedon = now()
where investigationid = '68e0b5eb-50fb-4b68-ba69-58a5260b6e97'  
and activeflag =1;