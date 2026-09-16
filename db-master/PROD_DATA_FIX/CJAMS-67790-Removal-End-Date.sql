/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates  ,they can only create.
    1. Remove the Child Removal end date (02/18/2026) for Damari Holder (PID# 4341929)
    2. Remove the OOH program assignment end date (02/18/2026) for Damari Holder (PID# 4341929)
    3. Update the Placement Exit Type (Placement ID# 1997791) from "Permanently Leaving Custody & Care" to "Change In Placement Structure".Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-67790
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-67790', updatedon = now(),
returntransts = Null,
returndate = Null,
returntime = Null,
removalexitreason = NULL
where intakeservreqchildremovalid = '966fdb98-183b-4f45-9c18-abf9ecc2f562' and activeflag =1;


update intakeservreqchildremoval_history
set exitdate = null ,updatedby = 'CJAMS-67790', updatedon = now()
where intakeservreqchildremovalhistoryid = '55bd8a95-7269-4414-9315-d37eba80a55f' and activeflag =1;

update personprogramarea
set enddate = null, updatedby = 'CJAMS-67790', updatedon = now()
where personprogramid = '341dad16-3648-4c84-8ffb-62ff1ad8e32d' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-67790'
where eligibility_id  = 10034454 and delete_sw = 'N';

update
    placement
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    exitreasontypekey = NULL,
    updatedby = 'CJAMS-67790',
    updatedon = now()
where
    placementid = 'f58aed90-a5cb-4981-89e8-e214addbe857'
    and activeflag = 1;

update
    placementrevision
set
    exittypekey = 'CIPS',
    exitreasontypkey = NULL,
    -- Change in Placement Structure
    updatedby = 'CJAMS-67790',
    updatedon = now()
where
    placementid = 'f58aed90-a5cb-4981-89e8-e214addbe857'
    and placementrevisionid in ('ff77c0dc-2576-40af-a6ac-711969c4437d')
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
intakeservicerequestactorid,                             
removaltypekey,                                          
servicecaseid,                                           
personid,                                                
modifieddata)                                            
values
(
 gen_random_uuid(),
  'HISTORY',
  '966fdb98-183b-4f45-9c18-abf9ecc2f562',
  '16127772-34b6-4903-a670-766a8a092989',
  '1',
  'CJAMS-67790',
  now(),
  'CJAMS-67790',
  now(),
  '4991dd2e-af0c-442c-9d68-a91c17854190',
  'JD',
  '67ac3773-ab32-4d7f-be26-42ef8adec3c7',
  '26205161-862e-4a13-a3d4-639fe72e744a',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-67790.","display_name": "Comments"}]}');

