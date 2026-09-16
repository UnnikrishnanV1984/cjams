/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on  06/10/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for the alleged maltreator from 05/22/2025 to 05/08/2025.
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/

update investigationallegation 
set incidentdate = '2025-05-08 00:00:00',
	updatedby = 'CJAMS-65646',
	updatedon = now()
where investigationid = '20b62f3a-f0fb-4c62-aa35-c5c229fec8bd'  
and activeflag =1;