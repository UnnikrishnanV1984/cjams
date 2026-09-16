/*
Issue Description: remove the Child Removal  End Date as requested.
Category/Module: Bug
Root cause: user could not, abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval tables
Data/Code fix ticket#: CJAMS-60583
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservreqchildremoval
set exitdate = '2025-03-19 09:00:00.000' ,updatedby = 'CJAMS-60583', updatedon = now()
where intakeservreqchildremovalid = '002774f1-2670-405f-bf31-b5e6a6dc1058' and activeflag =1;

update intakeservreqchildremoval_history 
set exitdate  = '2025-03-19 09:00:00.000' ,updatedby = 'CJAMS-60583', updatedon = now()
where intakeservreqchildremovalhistoryid in ('0eedc383-37d1-4a63-9fcc-080d676ea0f5',
'0e939ed3-6ca8-4fa6-ae71-b4471797fadd',
'048e9aa9-e7e1-413f-ba74-9146d84b0be4',
'055a69cd-5907-48a6-98ba-39abd9ced643',
'70ac5708-c3cb-4c7b-9197-1d10b3b3c993',
'1a2b72da-0ab6-4f3b-bd8f-8f46641e7563',
'41cc540e-7baa-4229-8eea-ea4650565d2b',
'a9646a86-8f8c-41c1-82d6-d0867db5ebe5') and activeflag =1 and  intakeservreqchildremovalid = '002774f1-2670-405f-bf31-b5e6a6dc1058' and exitdate::date = '2025-04-19'::date ;

update tb_client_eligibility 
set end_dt = '2025-03-19', update_ts = now(),update_user_id  = 'CJAMS-60583'
where eligibility_id  = 10051206 and delete_sw = 'N';



update placement
set exittypekey = 'CIPS',enddatetime  = '2025-03-19 00:00:00.000',updatedby = 'CJAMS-60583', updatedon = now()
where placementid = 'd1116807-2c47-4612-9a26-c30eec635c2b' and activeflag=1;




update placementrevision
set exittypekey = 'CIPS',enddate  = '2025-03-19',updatedby = 'CJAMS-60583', updatedon = now()
where placementrevisionid = 'b1b9b748-f26a-4402-bd12-bef7fc691b9b' and activeflag=1;



update placement
set enddatetime  = '2025-03-19 00:00:00.000',updatedby = 'CJAMS-60583', updatedon = now()
where placementid = '5dafc177-67b1-432f-9033-868217e85faa' and activeflag=1;


update placementrevision
set enddate  = '2025-03-19',updatedby = 'CJAMS-60583', updatedon = now()
where placementrevisionid = '5672d8a5-45b8-4adc-8365-6c74ed224457' and activeflag=1;

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
  '002774f1-2670-405f-bf31-b5e6a6dc1058',
  '41224b43-1507-4f77-8505-dad44893efb3',
  '1',
  'CJAMS-60583',
  now(),
  'CJAMS-60583',
  now(),
  '698d2f8f-8650-46ab-8aac-37e7f88e9553',
  'JD',
  'ceaba891-73cc-4516-90c4-50ae7606849c',
  'ad04ddae-c11f-41b8-b382-fe6e2c2f0119',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal exit date was changed to 03/192025 (old data was 04/19/2025) with the datafix ticket CJAMS-60583.","display_name": "Comments"}]}');
  
  
  update personprogramarea
set enddate = '2025-03-19',updatedby = 'CJAMS-60583', updatedon = now()
where personid = 'ad04ddae-c11f-41b8-b382-fe6e2c2f0119'
and programkey = 'OOH' and personprogramid in ('de939c06-92df-4937-9f25-73f8af150021')
and activeflag = 1;