/*
Issue: CJAMS-68112 Overdue Response Timer
Category/Module: Response Timer
Root cause:User requested to update Case Start Date & Time as 06/01/2026 1:54 PM and Response Timer Due Date as 06/02/2026 1:54 PM
Fix provided:  Data fix has been done by updating the Case Start Date & Time as 06/01/2026 1:54 PM and Response Timer Due Date as 06/02/2026 1:54 PM
Data/Code fix ticket#: CJAMS-68112
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:
*/

update intakeservicerequest 
set reporteddate ='2026-06-01 13:54:58.516', updatedby ='CJAMS-68112', updatedon =now()
where intakeserviceid ='2ff00058-7acb-4160-b900-3f9ee08128b0' and activeflag =1;

-- select * from cpsresponsetimeractions c where intakeserviceid ='2ff00058-7acb-4160-b900-3f9ee08128b0' and activeflag =1;
