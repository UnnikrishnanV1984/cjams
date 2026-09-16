/* Issue Description: Incident date needs changed

-- Category/ Module: Intake/Service

-- Root cause: This is not a defect ,as per the system design The case is closed on  06/10/2025 and user is requested to change the date of incident  from 1/11/2026-1/15/2026.
-- Fix Provided: Data fix is done to modify the incident date 
 -- Is code fix requiredv: N/A
 -- why no code fix is required :No code fix needed as the system is funtioning as designednand the change requires only an approved data override.
-- Pull request# N/A

*/update investigationallegation 
set incidentdate = '2026-01-11 00:00:00',enddate='2026-01-15 00:00:00',
	updatedby = 'CJAMS-65483',
	updatedon = now()
where investigationid = 'cc484d28-a01c-4d1c-b6cd-c17c72b9e33a'  
and activeflag =1;