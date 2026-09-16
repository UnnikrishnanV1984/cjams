/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on 07/18/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for the alleged maltreator from 06/24/2025 to 03/31/2025..
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/

update investigationallegation 
set incidentdate = '2025-03-31 00:00:00',
	updatedby = 'CJAMS-65671',
	updatedon = now()
where investigationid = '528dc2b5-25d2-4c3f-96a9-71df96df96bb'  
and activeflag =1;