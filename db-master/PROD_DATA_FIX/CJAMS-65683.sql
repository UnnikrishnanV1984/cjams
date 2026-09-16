/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on  07/22/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for the alleged maltreator from 07/18/2025 to 06/29/2025.
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/

update investigationallegation 
set incidentdate = '2025-06-29 00:00:00',
	updatedby = 'CJAMS-65683',
	updatedon = now()
where investigationid = '9f80b85d-2b57-45b6-b36d-e5e916487246'  
and activeflag =1;