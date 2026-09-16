/*
Issue Description:CJAMS-68989
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
    updatedby = 'CJAMS-68989',
    updatedon = now()
where intakeservreqchildremovalid='8d5bfa6c-5530-4427-9589-1efd220d07a8'
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
  '8d5bfa6c-5530-4427-9589-1efd220d07a8',
  '9dd46448-721a-4c7c-9201-4be43220a597',
  '1',
  'CJAMS-68989',
  now(),
  'CJAMS-68989',
  now(),
  null,
  'EMANIND',
  '2bc0c7eb-bf81-4e4d-9732-d0543158910d',
  'a2a17523-cab9-4f3c-b408-adfcd94e9e02',
  '9d0652ca-4a24-4988-9a56-5dac0d39e9f4',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-68989.","display_name": "Comments"}]}');


update personprogramarea 
set enddate = null, 
    updatedby ='CJAMS-68989', 
    updatedon = now()  
where personprogramid ='b6203907-60da-488b-ae03-69e1cfddc4fa' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-68989',
    update_ts = now()
where removal_id = 193798
and delete_sw = 'N';