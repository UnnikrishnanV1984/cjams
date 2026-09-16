/*
Issue Description: remove the Child Removal  End Date as requested.
Category/Module: Bug
Root cause: user could not, abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval tables
Data/Code fix ticket#: CJAMS-60536
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-60536', updatedon = now(),
returntransts = Null,returndate = Null,returntime = Null,removalexitreason = NULL
where intakeservreqchildremovalid = 'a5d59ccb-bb7d-4e40-bac6-2177bcbb53fd' and activeflag =1;

update intakeservreqchildremoval_history 
set exitdate = null ,updatedby = 'CJAMS-60536', updatedon = now()
where intakeservreqchildremovalhistoryid in ('12cff39d-4b53-46e3-a6cc-b489d2260ee2',
'854c935f-83ac-439c-98d9-98837692c9ab',
'9b58592c-f944-4156-bbde-0d54325c2579',
'1c841199-2111-46b6-885b-cd432dc3dbac') and activeflag =1;

update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-60536'
where eligibility_id  = 10125766 and delete_sw = 'N';



update placement
set exittypekey = 'CIPS',updatedby = 'CJAMS-60536', updatedon = now()
where placementid = '10aba544-749f-479d-9ba2-256c64f81a1f' and activeflag=1;


update placementrevision
set exittypekey = 'CIPS',updatedby = 'CJAMS-60536', updatedon = now()
where placementrevisionid = '42c10665-c3fd-4544-808f-80d4c1c6db7f' and activeflag=1;

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
  'a5d59ccb-bb7d-4e40-bac6-2177bcbb53fd',
  '152d4c8a-d8e8-436a-8295-e8d660280386',
  '1',
  'CJAMS-60536',
  now(),
  'CJAMS-60536',
  now(),
  '5a86b3d0-93c0-4747-925e-c7e1dc81f3b5',
  'JD',
  '1e3da262-1a9a-4f4c-8046-73d2c327b724',
  'd3341551-34c3-49ed-9acc-fa9b40e121f7',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-60536.","display_name": "Comments"}]}');
  
  
  update personprogramarea
set enddate = null,updatedby = 'CJAMS-60536', updatedon = now()
where personid = 'd3341551-34c3-49ed-9acc-fa9b40e121f7'
and programkey = 'OOH' and personprogramid = 'ad36fb29-51cc-4611-b925-53afdbaa651c'
and activeflag = 1;
