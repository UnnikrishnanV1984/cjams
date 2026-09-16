/*
Issue Description: remove the Child Removal  End Date as requested.
Category/Module: Bug
Root cause: user could not, abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval tables
Data/Code fix ticket#: CJAMS-62299
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-62299', updatedon = now(),
returntransts = Null,returndate = Null,returntime = Null,removalexitreason = NULL
where intakeservreqchildremovalid = 'f3ab7ba5-9257-48da-8a09-325b67fbef29' and activeflag =1;

update intakeservreqchildremoval_history 
set exitdate = null ,updatedby = 'CJAMS-62299', updatedon = now()
where intakeservreqchildremovalhistoryid in ('cab8e1fa-f67a-4c39-8d88-4315105aeeb0') and activeflag =1;


--select * from tb_client_eligibility  where start_dt='2024-12-12' and end_dt ='2025-08-06' ;
--update tb_client_eligibility 
--set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-62299'
--where eligibility_id  = 10001603 and delete_sw = 'N';



update placement
set exittypekey = 'CIPS',updatedby = 'CJAMS-62299', updatedon = now()
where placementid = '8b789035-361a-4dde-97e4-050c400bccfd' and activeflag=1;


update placementrevision
set exittypekey = 'CIPS',updatedby = 'CJAMS-62299', updatedon = now()
where placementrevisionid = '6ad35595-a2df-46d4-b258-bff468601517' and activeflag=1;

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
  'f3ab7ba5-9257-48da-8a09-325b67fbef29',
  '0e3a5cfc-1eaf-4f8c-ba0f-f6ff3ff2ff50',
  '1',
  'CJAMS-62299',
  now(),
  'CJAMS-62299',
  now(),
  'a9a8294e-91f8-4769-92e4-8fc510a7fef6',
  'JD',
  'a846777e-6081-4041-8e48-24e217dc1391',
  '6b07b59d-db9f-4556-b025-05457a80fedf',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-62299.","display_name": "Comments"}]}');
  
--  no records
  update personprogramarea
set enddate = null,updatedby = 'CJAMS-62299', updatedon = now()
where personid = '6b07b59d-db9f-4556-b025-05457a80fedf'
and programkey = 'OOH' and personprogramid = '4e09632c-5d77-4d1c-aad2-6a94d946ce1a'
and activeflag = 1;