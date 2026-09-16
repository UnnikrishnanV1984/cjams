/*
   Issue Description: CJAMS-65961
   Category/ Module:  User wants to update the requested date to '2026-02-27 16:00:27.000'
   Root Cause: User asked to update the requested date to '2026-02-27 16:00:27.000'
   Fix provided: Data fix has been done by updating the requested date to '2026-02-27 16:00:27.000'
*/

update intakeservicerequestdispositioncode 
set insertedon ='2026-02-27 16:00:27.000', updatedby ='CJAMS-65961', updatedon =now()
where intakeservicerequestdispositioncodeid ='830dbfa9-e75b-4f78-acec-2c68a93392bf';