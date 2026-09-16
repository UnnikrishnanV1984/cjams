/*
Issue Description: CJAMS-69022 Removal end date is incorrect
Category/Module: Child Removal / Placement
Root cause: Even though court occurred on 06/15/2026, the case remained open until 06/17/2026
            because the child needed to travel out of state to be reunified with her parent.
            The removal and placement were end dated on 06/15/2026 instead of 06/17/2026,
            causing the foster parent to be missing payment for 2 days.
            Child: Rae'ne Walker / CJAMS PID - 200010953 / Case# 3307700
Fix provided: Data fix to update the child removal end date and program end date 
              from 06/15/2026 to 06/17/2026 so the removal can be appropriately end-dated.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue, data fix resolves the issue.
*/


update personprogramarea
set activeflag =0,
    updatedby = 'CJAMS-69022',
    updatedon = now()
where  personprogramid ='a0622f7d-5f82-433d-a4a7-063b5740d0df'
and activeflag = 1;

update personprogramarea
set enddate  = '2026-06-17 17:00:00',
    updatedby = 'CJAMS-69022',
    updatedon = now()
where  personprogramid ='a557de6f-ed9f-4342-99fe-0a9c2c023914'
and activeflag = 1;

update intakeservreqchildremoval
set exitdate = '2026-06-17 17:00:00',
    updatedby = 'CJAMS-69022',
    updatedon = now()
where intakeservreqchildremovalid = 'd483aee2-c464-4a7e-84a9-598b78b21eee'
and activeflag = 1;

insert into intakeservreqchildremoval_history(           
intakeservreqchildremovalhistoryid,                      
rowtype,                                                 
intakeservreqchildremovalid,                             
intakeserviceid,                                         
activeflag,                                              
insertedby,                                              
insertedon,                                              
updatedby,                                               
updatedon,
exitdate, 
removalexitreason,                                              
intakeservicerequestactorid,                             
servicecaseid,                                           
personid,                                                
modifieddata)                                            
values
(
 gen_random_uuid(),
  'HISTORY',
  'd483aee2-c464-4a7e-84a9-598b78b21eee',
  '4eabfecd-9692-416d-881d-e5990984526a',
  '1',
  'CJAMS-69022',
  now(),
  'CJAMS-69022',
  now(),
  null,
  'EMANIND',
  '5dce0a94-31c6-4939-9902-57eeab19788a',
  'd380c0b2-e639-4100-8ce7-01b427667d0a',
  'de8b3ee5-feb6-48d6-86fb-2c9011796542',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal end date was updated with the datafix ticket CJAMS-69022.","display_name": "Comments"}]}');

update tb_client_eligibility
set end_dt = '2026-06-17 17:00:00',
    update_user_id = 'CJAMS-69022',
    update_ts = now()
where removal_id = 10005589
and delete_sw = 'N';
