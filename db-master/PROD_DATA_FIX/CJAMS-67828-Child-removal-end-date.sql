/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates  ,they can only create.
        211030011702:The child removal for this child was end dated. We are in need of the end date to be deleted add a paid kin before we close it, so they can be reimbursed. The child is Chase Christian #2048866271 and the Kin is Jonae Christian #6301072.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-67828
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-67828', updatedon = now(),
returntransts = Null,
returndate = Null,
returntime = Null,
removalexitreason = NULL
where intakeservreqchildremovalid = '1a471937-34f7-4351-9ce1-5ad0484ac2b4' and activeflag =1;


update intakeservreqchildremoval_history
set exitdate = null ,updatedby = 'CJAMS-67828', updatedon = now()
where intakeservreqchildremovalhistoryid = '839e7773-ffe8-4ea6-9309-0b8791da46d6' and activeflag =1;

update personprogramarea
set enddate = null, updatedby = 'CJAMS-67828', updatedon = now()
where personprogramid = 'f2bccde1-4733-4238-8ad2-b3f46ace3094' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-67828'
where eligibility_id  = 10189176 and delete_sw = 'N';

update
    placement
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    exitreasontypekey = NULL,
    updatedby = 'CJAMS-67828',
    updatedon = now()
where
    placementid = 'bd4e3aa5-a697-4547-9648-8bc9f51dd31a'
    and activeflag = 1;

update
    placementrevision
set
    exittypekey = 'CIPS',
    exitreasontypkey = NULL,
    -- Change in Placement Structure
    updatedby = 'CJAMS-67828',
    updatedon = now()
where
    placementid = 'bd4e3aa5-a697-4547-9648-8bc9f51dd31a'
    and placementrevisionid in ('e9f29c11-d5ee-4705-85a1-6ac503000bc1',
'bea98c3d-b7ad-47b4-b85d-46ffb34d3b91')
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
  '1a471937-34f7-4351-9ce1-5ad0484ac2b4',
  '321f2a84-6dc1-4932-b0e8-e16a15b71927',
  '1',
  'CJAMS-67828',
  now(),
  'CJAMS-67828',
  now(),
  'dc3aa810-1c1f-4edc-a6ec-96f6ce712e12',
  'JD',
  'bae04029-467b-49d3-ac20-a1b1ae1a897d',
  'a69b6acc-9297-4f17-9c00-cc2af0686e4a',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-67828.","display_name": "Comments"}]}');

