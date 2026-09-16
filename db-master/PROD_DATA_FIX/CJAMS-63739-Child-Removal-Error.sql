/*
  Issue Description: CJAMS-63577 Child Removal reopen
  Category/ Module  : Child Removal
  Root cause: User error
  case #: 3240575
  Case ID: 202106306379
  Client ID: 200856148 (Treasure Coates)
  Provider ID: 5088981 (Rosa Chittams)
  1) Remove the Child Removal End Date
  2) Remove the OOH Program Assignment End Date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/
/*
select exitdate,
  returntransts,
  returndate,
  returntime,
  removalexitreason,removalid ,intakeservreqchildremovalid ,personid , * from intakeservreqchildremoval i 
 where servicecaseid  = '5a2b084e-1454-4a14-85c3-366c888cdc4f' and activeflag =1
and intakeservreqchildremovalid = '2948ce61-9eb2-4946-be30-a1beb8ec9921';

select * from person where cjamspid = '200856148'
*/

update intakeservreqchildremoval
  set exitdate = null,
  returntransts = Null,
  returndate = Null,
  returntime = Null,
  removalexitreason = NULL,
  updatedon = now(), 
  updatedby = 'CJAMS-63739'
where servicecaseid  = '5a2b084e-1454-4a14-85c3-366c888cdc4f'	
  and personid = '7fce11cf-2f9e-4f8d-b8c9-b7cd3777a640'
  and intakeservreqchildremovalid = '2948ce61-9eb2-4946-be30-a1beb8ec9921'
  and activeflag  = 1 ;
 
/*
select exitdate ,removalexitreason ,* from intakeservreqchildremoval_history 
where servicecaseid = '5a2b084e-1454-4a14-85c3-366c888cdc4f' 
  and intakeservreqchildremovalid = '2948ce61-9eb2-4946-be30-a1beb8ec9921'
	and activeflag =1;
*/
 
update intakeservreqchildremoval_history 
set exitdate = null ,
    removalexitreason = null,
    updatedby = 'CJAMS-63739', 
    updatedon = now()
where servicecaseid = '5a2b084e-1454-4a14-85c3-366c888cdc4f'
and intakeservreqchildremovalhistoryid = '5a98616f-eea6-47f0-899e-fabb6d4b32fd'
 and servicecaseid = '5a2b084e-1454-4a14-85c3-366c888cdc4f' 
  and intakeservreqchildremovalid = '2948ce61-9eb2-4946-be30-a1beb8ec9921'
and activeflag =1;

--select end_dt ,* from tb_client_eligibility where removal_id = '254357'

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CJAMS-63739',
	update_ts = now()
where removal_id = '254357'
and delete_sw = 'N';

--select enddate ,* from personprogramarea p where personid = '7fce11cf-2f9e-4f8d-b8c9-b7cd3777a640' and activeflag =1;

update personprogramarea
  set enddate = null,
      updatedby = 'CJAMS-63739', 
      updatedon = now()
where programkey = 'OOH' 
  and personprogramid = '2df208fc-6de0-4264-84e3-351fcadac961'
  and activeflag = 1;
 
-- personid: 7fce11cf-2f9e-4f8d-b8c9-b7cd3777a640  Royalty	Goldstocks	K
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
removaldate,
removaltypekey, 
primarycaregiveractorid,
removalid,
servicecaseid,                                           
personid,                                                
modifieddata)                                            
values
(
 gen_random_uuid(),
  'HISTORY',
  '2948ce61-9eb2-4946-be30-a1beb8ec9921',
  null,
  '1',
  'CJAMS-63739',
  now(),
  'CJAMS-63739',
  now(),
  'f376673f-b988-4aae-97d6-7a8acb8fdc58',
  '2022-07-06 00:00:00.000',
  'JD',
  '4f070241-c2be-4fbd-8b42-7c570369214f',
  254357,
  '5a2b084e-1454-4a14-85c3-366c888cdc4f',
  '7fce11cf-2f9e-4f8d-b8c9-b7cd3777a640',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-63739.","display_name": "Comments"}]}');