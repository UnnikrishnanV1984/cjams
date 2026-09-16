/*
    Issue Description: CJAMS-63577 Child Removal reopen
  Category/ Module  : Child Removal
  Root cause: User error
  case #: 3240575
  Client ID: 3673636 (Azia Anthony Eley)
    1) Remove the Child Removal End Date
    2) Remove the OOH program assignment End Date
  Client ID: 200940337 (Malaysia C Eley)
    1) Remove the Child Removal End Date
    2) Change the Living Arrangement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure
    3) Remove the OOH program assignment End Date
  Client ID: 200940334 (Mackenzie Christiana Beccles)
    1) Remove the Child Removal End Date
    2) Change the Living Arrangement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure
    3) Remove the OOH program assignment End Date
  Client ID: 200940336 (Royalty K Goldstocks)
    1) Remove the Child Removal End Date
    2) Change the Living Arrangement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure
    3) Remove the OOH program assignment End Date
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
  removalexitreason,removalid ,intakeservreqchildremovalid ,personid , * from intakeservreqchildremoval i where servicecaseid  = 'a4e550c2-c939-43a5-835d-254c657ea544' and activeflag =1;

    select * from person where personid in ('90d2d2c3-5da1-4865-9e25-16f0ab1b1504',
    '2bc8f9bf-1de0-4e31-8339-d3f9202af344',
    'bc4ccbc1-27b4-4424-b206-3afee513721e',
    '1316da1b-fbaa-4bb0-b40c-f0ff5f092d6d');
*/

update intakeservreqchildremoval
  set exitdate = null,
  returntransts = Null,
  returndate = Null,
  returntime = Null,
  removalexitreason = NULL,
  updatedon = now(), 
  updatedby = 'CJAMS-63589'
where servicecaseid  = 'a4e550c2-c939-43a5-835d-254c657ea544'	
  and personid in ('90d2d2c3-5da1-4865-9e25-16f0ab1b1504',
	'2bc8f9bf-1de0-4e31-8339-d3f9202af344',
	'bc4ccbc1-27b4-4424-b206-3afee513721e',
	'1316da1b-fbaa-4bb0-b40c-f0ff5f092d6d')
  and activeflag  = 1 ;
 
/*
select exitdate ,removalexitreason ,* from intakeservreqchildremoval_history ih where servicecaseid = 'a4e550c2-c939-43a5-835d-254c657ea544'
and intakeservreqchildremovalid in ('c6bfba17-5bb4-43aa-99de-7b68ac82e69d',
'1e7f5b6d-4747-4c82-9a26-9ec1142d413f',
'8b20c4d4-561f-4920-a5a5-3d1194bd8688',
'0100116f-1096-4eb1-aee4-43d75959c700')
and activeflag =1 
order by updatedon desc;
*/

update intakeservreqchildremoval_history 
set exitdate = null ,
    removalexitreason = null,
    updatedby = 'CJAMS-63589', 
    updatedon = now()
where servicecaseid = 'a4e550c2-c939-43a5-835d-254c657ea544'
and intakeservreqchildremovalhistoryid in ('c9ec2e24-4538-4f74-9032-df6fcd2d1d9f',
'391d2fb3-2242-4035-99a5-59e4485332e2',
'da88d898-1bcf-42e9-92e8-6c1be65174db',
'6cef1efa-de41-4d7f-8282-4f6de3466789')
and activeflag =1;

/*
select end_dt ,* from tb_client_eligibility where removal_id in (366821,
366822,
366819,
366820);
*/

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CJAMS-63589',
	update_ts = now()
where removal_id in (366821,
	366822,
	366819,
	366820)
and delete_sw = 'N';

/*
--8b20c4d4-561f-4920-a5a5-3d1194bd8688: Client ID: 3673636 (Azia Anthony Eley) no update on exity typekey
select intakeservreqchildremovalid ,exittypekey ,exittime ,* from placement p where servicecaseid = 'a4e550c2-c939-43a5-835d-254c657ea544' 
and activeflag =1
and intakeservreqchildremovalid in ('c6bfba17-5bb4-43aa-99de-7b68ac82e69d',
'1e7f5b6d-4747-4c82-9a26-9ec1142d413f',
'0100116f-1096-4eb1-aee4-43d75959c700')
order by updatedon desc;
*/

update cjams.placement  
set exittypekey = 'CIPS',
	updatedon = now(), 
	updatedby = 'CJAMS-63589'
where placementid in ('bbc3036d-b19c-4fa8-982f-39abfdf56b40',
'0ec86845-18e0-45d8-b57e-a86634513f31',
'ddb10abb-1d96-4ef5-baee-7c8e7ac5490f')
	and activeflag  = 1;

/*
select * from placementrevision p 
where placementid in ('bbc3036d-b19c-4fa8-982f-39abfdf56b40',
'0ec86845-18e0-45d8-b57e-a86634513f31',
'ddb10abb-1d96-4ef5-baee-7c8e7ac5490f')
	and activeflag  = 1;
*/

update cjams.placementrevision  
set 
    exittypekey = 'CIPS',
	updatedon = now(),
	updatedby = 'CJAMS-63589'
where placementrevisionid  in ('9e27fd4a-d6cf-4b89-bfe3-b8a21148f0ab',
'af018b4f-9689-48e3-b985-3a501345e0a5',
'e39964ab-78fe-44a0-8977-da7074c38519') and activeflag  = 1;  


/*
select exitdate ,removalexitreason ,* from intakeservreqchildremoval_history ih where servicecaseid = 'a4e550c2-c939-43a5-835d-254c657ea544'
and intakeservreqchildremovalid in ('c6bfba17-5bb4-43aa-99de-7b68ac82e69d',
'1e7f5b6d-4747-4c82-9a26-9ec1142d413f',
'8b20c4d4-561f-4920-a5a5-3d1194bd8688',
'0100116f-1096-4eb1-aee4-43d75959c700')
and activeflag =1 
order by updatedon desc;
*/

-- personid: bc4ccbc1-27b4-4424-b206-3afee513721e  AZIA	ELEY	ANTHONY
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
  '8b20c4d4-561f-4920-a5a5-3d1194bd8688',
  null,
  '1',
  'CJAMS-63589',
  now(),
  'CJAMS-63589',
  now(),
  'd2ab6a59-6c9c-400e-abfc-b8a73437a09d',
  '2025-10-22 00:00:00.000',
  'JD',
  '93c22e75-fcac-49f0-bae6-472436bd2f56',
  366819,
  'a4e550c2-c939-43a5-835d-254c657ea544',
  'bc4ccbc1-27b4-4424-b206-3afee513721e',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-63589.","display_name": "Comments"}]}');

-- personid: 90d2d2c3-5da1-4865-9e25-16f0ab1b1504  Mackenzie	Beccles	Christiana
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
  'c6bfba17-5bb4-43aa-99de-7b68ac82e69d',
  null,
  '1',
  'CJAMS-63589',
  now(),
  'CJAMS-63589',
  now(),
  '1fed1d72-1930-45f6-a7a8-31e5879a764b',
  '2025-10-22 00:00:00.000',
  'JD',
  '93c22e75-fcac-49f0-bae6-472436bd2f56',
  366821,
  'a4e550c2-c939-43a5-835d-254c657ea544',
  '90d2d2c3-5da1-4865-9e25-16f0ab1b1504',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-63589.","display_name": "Comments"}]}');


-- personid: 2bc8f9bf-1de0-4e31-8339-d3f9202af344  Malaysia	Eley	C
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
  '0100116f-1096-4eb1-aee4-43d75959c700',
  null,
  '1',
  'CJAMS-63589',
  now(),
  'CJAMS-63589',
  now(),
  'eadab24b-eeb5-4a51-b407-d4b077c1dd52',
  '2025-10-22 00:00:00.000',
  'JD',
  '93c22e75-fcac-49f0-bae6-472436bd2f56',
  366820,
  'a4e550c2-c939-43a5-835d-254c657ea544',
  '2bc8f9bf-1de0-4e31-8339-d3f9202af344',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-63589.","display_name": "Comments"}]}');

 
-- personid: 1316da1b-fbaa-4bb0-b40c-f0ff5f092d6d  Royalty	Goldstocks	K
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
  '1e7f5b6d-4747-4c82-9a26-9ec1142d413f',
  null,
  '1',
  'CJAMS-63589',
  now(),
  'CJAMS-63589',
  now(),
  '5b682375-0908-43c1-93fc-bfe08dbe5718',
  '2025-10-22 00:00:00.000',
  'JD',
  '93c22e75-fcac-49f0-bae6-472436bd2f56',
  366822,
  'a4e550c2-c939-43a5-835d-254c657ea544',
  '1316da1b-fbaa-4bb0-b40c-f0ff5f092d6d',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-63589.","display_name": "Comments"}]}');

 
/* select * from personprogramarea p where personid in ('90d2d2c3-5da1-4865-9e25-16f0ab1b1504',
'2bc8f9bf-1de0-4e31-8339-d3f9202af344',
'bc4ccbc1-27b4-4424-b206-3afee513721e',
'1316da1b-fbaa-4bb0-b40c-f0ff5f092d6d')
and objectid = 'a4e550c2-c939-43a5-835d-254c657ea544' 
and entityid  = '3240575'
and activeflag =1;
 */
update personprogramarea
  set enddate = null,
      updatedby = 'CJAMS-63589', 
      updatedon = now()
where programkey = 'OOH' 
  and personprogramid in ('1c5e0af4-db75-4b78-a5b8-3026888cd628',
'24ce56b7-4c2b-4b63-9bbb-c6072a8f48f5',
'aa0e071d-134d-4114-b89f-fe2d09b8e96d',
'fcd75306-36f8-4ec1-a196-8eb61dab358d')
  and activeflag = 1;