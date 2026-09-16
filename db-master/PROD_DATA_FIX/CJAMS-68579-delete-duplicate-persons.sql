/*
   Issue Description: CJAMS-68579
   Category/ Module: persons
   Root cause: User requested to data fix to remove the duplicate persons CJAMS PIDs# 3978580 (BELLA JOHNSON) and 3944597 (BELLA R JOHNSON) from CPS IR # 3145007
   Fix Provided: Data fix was done by removing the duplicate persons CJAMS PIDs# 3978580 (BELLA JOHNSON) and 3944597 (BELLA R JOHNSON) from CPS IR # 3145007 as requested
   Code Fix: Not Needed
*/


update actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-68579'
where actorid = 'ebc46974-20b0-4e47-a1a4-46c9c6ce1bdc' and activeflag=1;

update intakeservicerequestactor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-68579'
where intakeservicerequestactorid = 'bee6bfc2-03cd-413f-9e11-75e8970b69fd' and activeflag=1;

update personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-68579'
where personroleid = '21652db7-bf4f-4751-a635-b5d44b1acfd1' and activeflag=1;

update personroletype
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-68579'
where personroleid = '21652db7-bf4f-4751-a635-b5d44b1acfd1' and activeflag=1;
