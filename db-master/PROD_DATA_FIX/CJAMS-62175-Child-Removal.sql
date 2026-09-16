/*
Issue Description: remove the Child Removal  End Date as requested.
Category/Module: Bug
Root cause: user could not, abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval tables
Data/Code fix ticket#: CJAMS-62175
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-62175', updatedon = now(),
returntransts = Null,returndate = Null,returntime = Null,removalexitreason = NULL
where intakeservreqchildremovalid = '6beedfa6-928b-4a9e-91dd-3d47205d9e70' and activeflag =1;

update intakeservreqchildremoval_history 
set exitdate = null ,updatedby = 'CJAMS-62175', updatedon = now()
where intakeservreqchildremovalhistoryid in ('9a6a9c9b-ab8e-40ac-8ae9-4518c6d19f6a',
'4af370e2-6bc8-4f7b-b469-47873d5f6dff',
'5140b6f2-92f8-4141-bba5-27ae087637bd',
'719e04be-fc25-423f-88e4-a7b0f99849bf',
'fe0d8e15-ea8a-487c-8fe5-341ec0503a6e',
'aaf3d44a-a85f-498f-81f2-1e8e38547c04',
'682bbbb4-b04c-4878-b901-a9ff2d8307e7') and activeflag =1;

update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-62175'
where eligibility_id  = 10001603 and delete_sw = 'N';



update placement
set exittypekey = 'CIPS',updatedby = 'CJAMS-62175', updatedon = now()
where placementid = '8db41e9f-3298-4913-bd24-47b46fad054e' and activeflag=1;


update placementrevision
set exittypekey = 'CIPS',updatedby = 'CJAMS-62175', updatedon = now()
where placementrevisionid = '9fc203e8-a213-4822-b6a1-92692c16390d' and activeflag=1;

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
  '6beedfa6-928b-4a9e-91dd-3d47205d9e70',
  'dfdefd76-f63a-4eae-a777-91803dd7a94a',
  '1',
  'CJAMS-62175',
  now(),
  'CJAMS-62175',
  now(),
  '7995f34b-06c8-4a1b-b0f9-23f413b5cb35',
  'JD',
  '8bee744a-9974-49d8-b615-365bba90bbcd',
  '26f3bd9b-628c-4a64-8332-8adbf404966d',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-62175.","display_name": "Comments"}]}');
  
  
  update personprogramarea
set enddate = null,updatedby = 'CJAMS-62175', updatedon = now()
where personid = '26f3bd9b-628c-4a64-8332-8adbf404966d'
and programkey = 'OOH' and personprogramid = '186aaea4-14e2-4826-8ab6-1574e3c84d76'
and activeflag = 1;