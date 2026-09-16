/*
   Issue Description: CJAMS-68814
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to remove end date,
   Please proceed with the data fix to remove remove the child removal & OOH program end date for both clients (Client ID: 201076283 and Client ID: 204015612)   
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null, updatedon = now(), updatedby = 'CJAMS-68814'
where intakeservreqchildremovalid = 'd2a9b93d-33ab-4911-8b79-9fb5ac487024' and activeflag = 1;

update personprogramarea 
set enddate = null, updatedby = 'CJAMS-68814', updatedon = now() 
where personprogramid = '1210cf92-970c-4bfc-aa40-cf699f20e733'  and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-68814',
    update_ts = now()
where removal_id = 333649 and delete_sw = 'N';

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
intakeservicerequestactorid,                             
removaltypekey,                                          
servicecaseid,                                           
personid,                                                
modifieddata)                                            
values
(
 gen_random_uuid(),
  'HISTORY',
  'd2a9b93d-33ab-4911-8b79-9fb5ac487024',
  '091821b8-6add-4813-acb5-16e26e204233',
  '1',
  'CJAMS-68814',
  now(),
  'CJAMS-68814',
  now(),
  '8c2c9ec4-3675-4023-9cd9-ce01a01d5cec',
  'JD',
  'cfe63960-df61-4254-a003-0667391117aa',
  '1dac41af-4911-4836-a15d-60ed66a5b544',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-68814.","display_name": "Comments"}]}');
  

update intakeservreqchildremoval 
set exitdate = null, 
    returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null,
    updatedon = now(), updatedby = 'CJAMS-68814'
where intakeservreqchildremovalid = 'ac2fc318-e283-4428-83c4-7513004d4be9' and activeflag = 1;

update personprogramarea 
set enddate = null, updatedby = 'CJAMS-68814', updatedon = now() 
where personprogramid = '289220eb-b7fe-4c1f-83f3-1050c236c5c9'  and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-68814',
    update_ts = now()
where removal_id = 333650 and delete_sw = 'N';

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
intakeservicerequestactorid,                             
removaltypekey,                                          
servicecaseid,                                           
personid,                                                
modifieddata)                                            
values
(
 gen_random_uuid(),
  'HISTORY',
  'ac2fc318-e283-4428-83c4-7513004d4be9',
  '091821b8-6add-4813-acb5-16e26e204233',
  '1',
  'CJAMS-68814',
  now(),
  'CJAMS-68814',
  now(),
  '29d28fd7-cd65-44c9-bb9d-d277caa91e2a',
  'JD',
  'cfe63960-df61-4254-a003-0667391117aa',
  'e42b7cb8-a1e1-4f87-9965-1f397e7ebe07',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-68814.","display_name": "Comments"}]}');
  