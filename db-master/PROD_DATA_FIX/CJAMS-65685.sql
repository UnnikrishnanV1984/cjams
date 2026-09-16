/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on 08/19/2025 and user is requested to change the date of incident in the Maltreatment Allegation screen for the alleged maltreator from 07/10/2025 to 06/01/2025
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/


update investigationallegation 
set incidentdate = '2025-06-01 00:00:00.000',
	updatedby = 'CJAMS-65685',
	updatedon = now()
where investigationid = 'cb17a8a7-ff27-4956-bf8a-c9e023f1792a'  
and activeflag =1;