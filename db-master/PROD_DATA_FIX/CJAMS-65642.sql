

/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on 06/30/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for the alleged maltreator from 06/02/2025 to 05/11/2025.
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/

update investigationallegation 
set incidentdate = '2025-05-11 00:00:00',
	updatedby = 'CJAMS-65642',
	updatedon = now()
where investigationid = '1431d6fe-f438-44dd-8fec-c5c4e77014a7'  
and activeflag =1;