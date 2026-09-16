/*
   Issue Description: CDM-35730
   Category/ Module  : Hearing date change.
   Root cause: User is not able to update the hearing date.
   Fix Provided: 
*/

select servicecaseid ,* from intakeservicerequestcourthearing where servicecaseid ='289face1-9314-4d3d-bc90-9a55f3b7de93';

update cjams.intakeservicerequestcourthearing 
set hearingdatetime ='2023-09-19 09:00:00.000', updatedby ='CDM-35730', updatedon = now()
where servicecaseid ='289face1-9314-4d3d-bc90-9a55f3b7de93' and hearingdatetime ='2023-08-17 09:00:00.000';