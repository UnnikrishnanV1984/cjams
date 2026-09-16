/*
   Issue Description: CDM-23834
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 5930
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

 --- As per QA comments didn't remove the placement 

UPDATE intakeservreqchildremoval 
SET exitdate=null,  
    updatedby='CDM-23834',
    updatedon=now() 
WHERE intakeservreqchildremovalid in('5275f576-d23c-483f-85b6-16722ccb9312','c0049f13-7bb4-49bd-8778-e84c08c4ab76');

UPDATE personprogramarea 
SET enddate = null, 
    updatedby = 'CDM-23834', 
    updatedon = now() 
WHERE personprogramid in('9caf7bd8-fa54-408f-8a81-d995ec1fe7ea','7e66a1cf-beb0-4151-82d6-583efc227567');


update tb_client_eligibility set end_dt = null, update_user_id ='CDM-23834',update_ts =now()
where removal_id in('253704','253706') ; 