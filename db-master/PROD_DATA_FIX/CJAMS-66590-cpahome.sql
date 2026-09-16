/*
-- Issue Description: 
   Application Data Fix Request
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: User Error, requested to update the CPA Home Placement exit date from 12/02/2025 to 12/01/2025 for PID: 2946877 and  Soft delete the duplicate CPA home entry time at 3:00 PM for PID: 204290581
-- Fix provided: Datafix has been promoted to update the placement exit date and soft delete the placement
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placementcpahomes set exitdt='2025-12-01 00:00:00',
 updatets = now(), updateuserid = 'CJAMS-66590' where placementcpahomeid='800fbda2-e6ff-4155-bc43-1d60d1d02d7f' and activeflag=1;
 
update placementcpahomes set activeflag=0,
updatets = now(), updateuserid = 'CJAMS-66590' where placementcpahomeid='d18800d8-c358-41e9-b0ef-0c712f4ba764' and activeflag=1;