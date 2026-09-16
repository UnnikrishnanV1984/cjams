/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on 07/17/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for the alleged maltreator from 06/27/2025 to 06/16/2025.
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/

update investigationallegation 
set incidentdate = '2025-06-16 00:00:00',
	updatedby = 'CJAMS-65669',
	updatedon = now()
where investigationid = '6453ab07-eacf-4161-8d90-9aa5d85937fd'  
and activeflag =1;