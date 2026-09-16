/*
Issue Description:CJAMS-68586
Category/Module:Child removal
Root cause: Requested to remove program End Date and Child removal End date
Fix provided: Data fix has been done to remove program End Date and Child removal End date
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/



update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    returntime = null,
    returndate = null,
    removalexitreason = null,
    updatedby = 'CJAMS-68586',
    updatedon = now()
where intakeservreqchildremovalid='b2991786-d9f7-4aa4-a7b0-18fed38099be'
and activeflag =1;


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
  'b2991786-d9f7-4aa4-a7b0-18fed38099be',
  '89a7f86b-3a6e-4112-9366-9d6307987267',
  '1',
  'CJAMS-68586',
  now(),
  'CJAMS-68586',
  now(),
  null,
  'EMANIND',
  'da13bfb0-0f1c-4d8a-9340-af3ff79ee883',
  '5190941a-cb89-481e-9706-eb70629923f6',
  '3d7446cf-a1a8-479d-8b6f-c4c96a05974c',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-68586.","display_name": "Comments"}]}');


update personprogramarea 
set enddate = null, 
    updatedby ='CJAMS-68586', 
    updatedon = now()  
where personprogramid ='975a24e5-d77b-4101-ba7b-e0312aae2959' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-68586',
    update_ts = now()
where removal_id = 167731
and delete_sw = 'N';
