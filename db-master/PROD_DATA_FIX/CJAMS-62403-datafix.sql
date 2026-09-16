/*
    Issue Description: CJAMS-62403 Child Removal
  Category/ Module  : Child Removal
  Root cause: Data fix has been done to remove the removal and OOH program end date for the following children from - Case ID - 303586 
Client ID: 4353762 (ALAHNI SURRETTE)
Client ID: 201186705 (Atlus Carter Surrette)
Client ID: 201650044 (Aureliah Cassidy Surrette)
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/
--Client ID: 4353762 (ALAHNI SURRETTE)

update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    returntime = null,
    returndate = null,
    removalexitreason = null,
    updatedby = 'CJAMS-62403',
    updatedon = now()
where intakeservreqchildremovalid='7b3b94c3-7eeb-46a8-90e2-731ce2031b67'
and activeflag =1;

UPDATE cjams.intakeservreqchildremoval_history
SET exitdate=null,updatedby='CJAMS-62403', updatedon=now(), returntransts=null
WHERE intakeservreqchildremovalid='7b3b94c3-7eeb-46a8-90e2-731ce2031b67'
and intakeservreqchildremovalhistoryid = '029c4496-2769-41da-ae41-691347189a0e' 
and activeflag =1 ;

update personprogramarea 
set enddate = null, 
    updatedby ='CJAMS-62403', 
    updatedon = now()  
where personprogramid ='11e9aae2-d0a0-4e4c-88b1-ac115fddabc0' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-62403',
    update_ts = now()
where removal_id = 280564
and client_id  = '4353762'
and delete_sw = 'N';

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
  '7b3b94c3-7eeb-46a8-90e2-731ce2031b67',
  '13b9948e-fecc-4177-bb3e-f00b28e3a101',
  '1',
  'CJAMS-62403',
  now(),
  'CJAMS-62403',
  now(),
  'cbb2b80d-b0bf-4c2a-846d-dfc61438061d',
  'JD',
  '9b38da96-efda-492c-8867-de1693e0e285',
  'f382aed9-9e6a-4e15-b32b-033155292c87',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-62403.","display_name": "Comments"}]}');

--Client ID: 201186705 (Atlus Carter Surrette)

update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    returntime = null,
    returndate = null,
    removalexitreason = null,
    updatedby = 'CJAMS-62403',
    updatedon = now()
where intakeservreqchildremovalid='d49678a3-d515-40ef-a5be-ad14acca3418'
and activeflag =1;

UPDATE cjams.intakeservreqchildremoval_history
SET exitdate=null,updatedby='CJAMS-62403', updatedon=now(), returntransts=null
WHERE intakeservreqchildremovalid='d49678a3-d515-40ef-a5be-ad14acca3418'
and intakeservreqchildremovalhistoryid = '48ad05c5-c382-4c15-bea0-fe917fc770ab' 
and activeflag =1;

update personprogramarea 
set enddate = null, 
    updatedby ='CJAMS-62403', 
    updatedon = now()  
where personprogramid ='7884846b-3e43-49ff-b244-6726849dd43f' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-62403',
    update_ts = now()
where removal_id = 280597
and client_id  = '201186705'
and delete_sw = 'N';

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
  'd49678a3-d515-40ef-a5be-ad14acca3418',
  '13b9948e-fecc-4177-bb3e-f00b28e3a101',
  '1',
  'CJAMS-62403',
  now(),
  'CJAMS-62403',
  now(),
  '96e9fff1-f745-47cd-975e-2c1101cc1600',
  'JD',
  '9b38da96-efda-492c-8867-de1693e0e285',
  '88a5e22b-06c6-4e69-bd5b-8a2635b6e177',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-62403.","display_name": "Comments"}]}');

--Client ID: 201650044 (Aureliah Cassidy Surrette)

update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    returntime = null,
    returndate = null,
    removalexitreason = null,
    updatedby = 'CJAMS-62403',
    updatedon = now()
where intakeservreqchildremovalid='6d483677-b6b8-4127-9f1f-afac696773b2'
and activeflag =1;

UPDATE cjams.intakeservreqchildremoval_history
SET exitdate=null,updatedby='CJAMS-62403', updatedon=now(), returntransts=null
WHERE intakeservreqchildremovalid='6d483677-b6b8-4127-9f1f-afac696773b2'
and intakeservreqchildremovalhistoryid = '7bd4369b-c58e-4b55-858f-c33c9f1dd5a5'
and activeflag =1 ;

update personprogramarea 
set enddate = null, 
    updatedby ='CJAMS-62403', 
    updatedon = now()  
where personprogramid ='85000d92-7bb4-4636-943c-945bdfceddaf' 
and activeflag = 1;


update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-62403',
    update_ts = now()
where removal_id = 284571
and client_id  = '201650044'
and delete_sw = 'N';

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
  '6d483677-b6b8-4127-9f1f-afac696773b2',
  '13b9948e-fecc-4177-bb3e-f00b28e3a101',
  '1',
  'CJAMS-62403',
  now(),
  'CJAMS-62403',
  now(),
  'f4e601b2-fa1a-40c2-b0a5-cbf75ec11ecf',
  'JD',
  '9b38da96-efda-492c-8867-de1693e0e285',
  '4a272fe6-2bfe-40c8-a97a-3fb798458a54',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-62403.","display_name": "Comments"}]}');
  
