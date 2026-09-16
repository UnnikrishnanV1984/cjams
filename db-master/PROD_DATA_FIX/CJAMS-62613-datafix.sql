/*
-- Issue Description:  CJAMS-62613
  211030012946:Unable to end date the service log in order to close the provider 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User requested to do Remove the Child Removal End Date, Remove the OOH Program Assignment End Data, Remove end date for Legal custody for clients Addalyn Schneider, 
Juliette Schneider, Eve Schneider and Marla Schneider for Case# 241030289891.
-- Fix Provided: Data fix has been promoted to update the Actual end date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
--Addalyn Schneider
--Juliette Schneider 
--Eve Schneider  
--Marla Schneider

update cjams.intakeservreqchildremoval
set exitdate = Null, 
	returndate = Null,
	returntime = Null,
    returntransts = NULL,
	removalexitreason = NULL, 
	updatedby = 'CJAMS-62613',
	updatedon = now()
where intakeservreqchildremovalid in ('8094252e-b071-48bd-8a0c-3f58a51493e5','3f55460d-f91f-49b8-b09b-eb72134eb10b',
  'e9267c47-4662-47b2-b768-316cc5dcb12d','03a2f945-9413-43de-8b4e-137294078eea')
	and activeflag = 1;
	
update intakeservreqchildremoval_history
set exitdate = null, updatedby = 'CJAMS-62613', updatedon = now()
where intakeservreqchildremovalid in ('8094252e-b071-48bd-8a0c-3f58a51493e5','3f55460d-f91f-49b8-b09b-eb72134eb10b',
'e9267c47-4662-47b2-b768-316cc5dcb12d','03a2f945-9413-43de-8b4e-137294078eea')
 and activeflag = 1;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CJAMS-62613',
	updatedon = now()
where personprogramid in ('2cd3b46e-054a-4fc6-b71f-631b97eb97dd','6f95b6b5-ce92-4acd-a3ba-7d89845cacfd',
  'd8a290ed-b8f1-4994-9eba-f5740074d12b','c6522b4a-37ed-492c-a3d8-bc85f750ea74')
	and activeflag = 1;
	
update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CJAMS-62613',
	update_ts = now()
where removal_id in (306644,306645,306646,306647)
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
  '8094252e-b071-48bd-8a0c-3f58a51493e5',
  '9e986284-85a4-45f7-a5e8-cffd707e85ef',
  '1',
  'CJAMS-62613',
  now(),
  'CJAMS-62613',
  now(),
  'dd2c3888-1ddb-4b3a-a69f-389b045bad5a',
  'JD',
  '88977cbb-a0bb-4a82-a7d1-b25e0dcf89a3',
  '84fe881f-b541-4bca-b0f2-243fdcc1a793',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-62613.","display_name": "Comments"}]}');
  
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
  '3f55460d-f91f-49b8-b09b-eb72134eb10b',
  '9e986284-85a4-45f7-a5e8-cffd707e85ef',
  '1',
  'CJAMS-62613',
  now(),
  'CJAMS-62613',
  now(),
  '59542afb-87a0-43dc-9b5c-ae07fe58bf82',
  'JD',
  '88977cbb-a0bb-4a82-a7d1-b25e0dcf89a3',
  'e38cee49-1fbb-4e16-b9a3-b149eaad080a',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-62613.","display_name": "Comments"}]}');
  
  
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
  'e9267c47-4662-47b2-b768-316cc5dcb12d',
  '9e986284-85a4-45f7-a5e8-cffd707e85ef',
  '1',
  'CJAMS-62613',
  now(),
  'CJAMS-62613',
  now(),
  '4647e155-36da-4a91-ae69-5ec1927ab735',
  'JD',
  '88977cbb-a0bb-4a82-a7d1-b25e0dcf89a3',
  'c3d50e30-8b6c-40a9-9bc3-e478e0bc5385',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-62613.","display_name": "Comments"}]}');
  
  
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
  '03a2f945-9413-43de-8b4e-137294078eea',
  '9e986284-85a4-45f7-a5e8-cffd707e85ef',
  '1',
  'CJAMS-62613',
  now(),
  'CJAMS-62613',
  now(),
  'bc7e0d48-1c47-4fe4-8f65-2ccd21f32563',
  'JD',
  '88977cbb-a0bb-4a82-a7d1-b25e0dcf89a3',
  '52520e26-21fa-4de7-976d-6f91b837f727',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-62613.","display_name": "Comments"}]}');
  
