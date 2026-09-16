/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on 06/11/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for the alleged maltreator from 04/22/2025 to 04/15/2025.
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/

update investigationallegation 
set incidentdate = '2025-04-15 00:00:00',
	updatedby = 'CJAMS-65664',
	updatedon = now()
where investigationid = '1aaf9b97-488c-4d85-9234-3ae8839aeb3a'  
and activeflag =1;