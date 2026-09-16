/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on  05/13/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for the alleged maltreator from 05/01/2025 to 04/26/2025.
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/


update investigationallegation 
set incidentdate = '2025-04-26 00:00:00',
	updatedby = 'CJAMS-65650',
	updatedon = now()
where investigationid = 'b1ca7972-d381-4ec7-8252-4c1378042589'  
and activeflag =1;