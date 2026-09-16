/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: This is not a defect. The removal was end dated by the system due to placement exit reason is Permanently Leaving Custody & Care for all three children.

Please connect with the user to get confirmation if data fixes are needed as below;
1. Remove the Child Removal End Date for all three children
2. Remove the OOH program End Date for all three children
3. Update the Placement Exit Type for all three children from 'Permanently Leaving Custody & Care' to 'Change In Placement Structure'.

Case ID: 3273829

Client ID: 3529224 (Aliyah C Roth)
Client ID: 4273301 (Javion N Roth)
Client ID: 4430433 (Jacari Jones)
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-67926
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-67926', updatedon = now(),
returntransts = Null,
returndate = Null,
returntime = Null,
removalexitreason = NULL
where intakeservreqchildremovalid = 'fdbb1e4b-5311-4ae1-94dd-aa8bdac74f2d' and activeflag =1;


update intakeservreqchildremoval_history
set exitdate = null ,updatedby = 'CJAMS-67926', updatedon = now()
where intakeservreqchildremovalhistoryid IN ('839259b3-c836-49a2-b3f3-d28ba62a67da'::uuid,'4cfa348c-452f-41b9-bf0a-d8b44d83bbef'::uuid,'61251a2f-a9ac-4233-a16d-8e00dd8dc7b6'::uuid,'65e8efd9-24ed-429b-8f40-86e9eca1bb2e'::uuid,'6ab9febf-1678-470c-b8d0-f17edfec6a9d'::uuid,'e02670ff-824c-4ff8-9917-deb223e0f9b6'::uuid) and exitdate is not null and activeflag =1;

update personprogramarea
set enddate = null, updatedby = 'CJAMS-67926', updatedon = now()
where personprogramid = 'c6c036e3-41be-4659-a40b-c69bf2e0a960' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-67926'
where eligibility_id  = 104856 and delete_sw = 'N';

update
    placement
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    exitreasontypekey = NULL,
    updatedby = 'CJAMS-67926',
    updatedon = now()
WHERE placementid IN ('bbe10dfb-1007-44de-b013-77b68ef3b6d6'::uuid,'03c8fc2c-94aa-4a17-92ec-6699703af084'::uuid,'69c64c87-24e6-4e4e-a1fa-36342154350a'::uuid,'78e9d7cf-38af-41db-84ac-7c29b0bdbf67'::uuid,'c324fa08-f210-460a-833d-5b9b8df31bc2'::uuid,'49e133e8-6f17-44a8-8e9c-9c3ff3d34fb5'::uuid,'f8e5c308-86b5-4c15-9765-c4a28bc61658'::uuid,'e8bda56b-e301-43ce-b743-a3c8b9807448'::uuid,'e0a53d77-30cf-42be-b93f-1f118f5248cd'::uuid,'01e3b586-64dc-47bd-8f35-7f188d190891'::uuid)
    and exittypekey='PLCC' and  activeflag = 1;

update
    placementrevision
set
    exittypekey = 'CIPS',
    exitreasontypkey = NULL,
    -- Change in Placement Structure
    updatedby = 'CJAMS-67926',
    updatedon = now()
   WHERE placementid IN ('bbe10dfb-1007-44de-b013-77b68ef3b6d6'::uuid,'03c8fc2c-94aa-4a17-92ec-6699703af084'::uuid,'69c64c87-24e6-4e4e-a1fa-36342154350a'::uuid,'78e9d7cf-38af-41db-84ac-7c29b0bdbf67'::uuid,'c324fa08-f210-460a-833d-5b9b8df31bc2'::uuid,'49e133e8-6f17-44a8-8e9c-9c3ff3d34fb5'::uuid,'f8e5c308-86b5-4c15-9765-c4a28bc61658'::uuid,'e8bda56b-e301-43ce-b743-a3c8b9807448'::uuid,'e0a53d77-30cf-42be-b93f-1f118f5248cd'::uuid,'01e3b586-64dc-47bd-8f35-7f188d190891'::uuid)
    and exittypekey='PLCC' and  activeflag = 1; 
   

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
  'fdbb1e4b-5311-4ae1-94dd-aa8bdac74f2d',
  'e6be149e-8619-40fe-b69b-44f8afad3091',
  '1',
  'CJAMS-67926',
  now(),
  'CJAMS-67926',
  now(),
  'f7507085-1df1-4e70-bc4a-4f54937ed8c3',
  'JD',
  '695edd69-52fc-49a8-90c5-397d2993cb23',
  '58d8cbb0-b89c-495a-a475-012ad4231510',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-67926.","display_name": "Comments"}]}');
 
/*************************************************/  


  update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-67926', updatedon = now(),
returntransts = Null,
returndate = Null,
returntime = Null,
removalexitreason = NULL
where intakeservreqchildremovalid = 'b52e3a27-625c-4ec3-8162-bec9a5870c73' and activeflag =1;


update intakeservreqchildremoval_history
set exitdate = null ,updatedby = 'CJAMS-67926', updatedon = now()
where intakeservreqchildremovalid = 'b52e3a27-625c-4ec3-8162-bec9a5870c73' and exitdate is not null and activeflag =1;

update personprogramarea
set enddate = null, updatedby = 'CJAMS-67926', updatedon = now()
where personprogramid = 'a361ee88-f373-4231-8cea-f24cf746675c"' and activeflag = 1 ;



update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-67926'
where eligibility_id  = 170018 and delete_sw = 'N';

update
    placement
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    exitreasontypekey = NULL,
    updatedby = 'CJAMS-67926',
    updatedon = now()
WHERE placementid IN ('8989affa-42a8-4e8e-99e0-2a9fee58ee93')  and exittypekey ='PLCC'  and activeflag = 1;

update
    placementrevision
set
    exittypekey = 'CIPS',
    exitreasontypkey = NULL,
    -- Change in Placement Structure
    updatedby = 'CJAMS-67926',
    updatedon = now()
   WHERE placementid IN ('8989affa-42a8-4e8e-99e0-2a9fee58ee93')  and exittypekey ='PLCC'  and activeflag = 1;

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
  'b52e3a27-625c-4ec3-8162-bec9a5870c73',
  'e6be149e-8619-40fe-b69b-44f8afad3091',
  '1',
  'CJAMS-67926',
  now(),
  'CJAMS-67926',
  now(),
  'a9db546f-4225-47ca-b2ba-88344676dc18',
  'JD',
  '695edd69-52fc-49a8-90c5-397d2993cb23',
  '66d7b256-e19b-43b5-9aac-113130bf3ddd',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-67926.","display_name": "Comments"}]}');


 
/*************************************************/  

  update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-67926', updatedon = now(),
returntransts = Null,
returndate = Null,
returntime = Null,
removalexitreason = NULL
where intakeservreqchildremovalid = '9156a375-63ee-4b10-bbc8-f2427a0f8405' and activeflag =1;


update intakeservreqchildremoval_history
set exitdate = null ,updatedby = 'CJAMS-67926', updatedon = now()
 where intakeservreqchildremovalid = '9156a375-63ee-4b10-bbc8-f2427a0f8405' and exitdate is not null and activeflag =1;

update personprogramarea
set enddate = null, updatedby = 'CJAMS-67926', updatedon = now()
where personprogramid = 'a361ee88-f373-4231-8cea-f24cf746675c' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-67926'
where eligibility_id  = 170032 and delete_sw = 'N';


update
    placement
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    exitreasontypekey = NULL,
    updatedby = 'CJAMS-67926',
    updatedon = now()
where
    placementid = '0250a75e-7716-4228-be23-8c44c828e30a' and exittypekey ='PLCC'
    and activeflag = 1;

update
    placementrevision
set
    exittypekey = 'CIPS',
    exitreasontypkey = NULL,
    -- Change in Placement Structure
    updatedby = 'CJAMS-67926',
    updatedon = now()
where
    placementid = '0250a75e-7716-4228-be23-8c44c828e30a' and exittypekey ='PLCC'
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
  '9156a375-63ee-4b10-bbc8-f2427a0f8405',
  'e6be149e-8619-40fe-b69b-44f8afad3091',
  '1',
  'CJAMS-67926',
  now(),
  'CJAMS-67926',
  now(),
  'a924e4d3-68ba-434f-bdbe-71bc00bd38ae',
  'JD',
  '695edd69-52fc-49a8-90c5-397d2993cb23',
  'e341ed9a-2ddf-4cd4-bf3c-afcca6f55625',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-67926.","display_name": "Comments"}]}');
 
 
