/*
    Issue Description: CJAMS-60574 Child Removal
  Category/ Module  : Child Removal
  Root cause: Data fix has been done 
  1) Remove the Child Removal End Date
  2) Change the Living Arrangement Exit Type from Permanently Leaving Custody & Care to Change In Placement Structure.
  Case ID: 231030198028
  Client ID: 201667778 (Rafael Mejia)
  Removal End Date: 06/13/2025
  case# 2020024802846
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update intakeservreqchildremoval
  set exitdate = null,
  returntransts = Null,
  returndate = Null,
  returntime = Null,
  removalexitreason = NULL,
  updatedon = now(), 
  updatedby = 'CJAMS-60574'
where intakeservreqchildremovalid = '4ecd1c83-2410-45d4-a899-0da252a2ec91'	
  and activeflag  = 1 ;
  
  update intakeservreqchildremoval_history 
  set exitdate = null ,
      updatedby = 'CJAMS-60574', 
      updatedon = now()
where intakeservreqchildremovalid = '4ecd1c83-2410-45d4-a899-0da252a2ec91'	
  and activeflag  = 1;
  
update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CJAMS-60574',
	update_ts = now()
where removal_id =  '334387'
	and delete_sw = 'N';

update cjams.placement  
set
    exittypekey = 'CIPS',
	updatedon = now(), 
	updatedby = 'CJAMS-60574'
where placementid = '3bb45def-ed51-4b79-a3fd-f884670e2a20'
	and activeflag  = 1;

update cjams.placementrevision  
set 
     exittypekey = 'CIPS',
	updatedon = now(),
	updatedby = 'CJAMS-60574'
where placementid = '3bb45def-ed51-4b79-a3fd-f884670e2a20'
and placementrevisionid = '4f31c84b-9104-403f-aca6-7f64f6f21bbe'
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
  '4ecd1c83-2410-45d4-a899-0da252a2ec91',
  'f9a28487-99df-439c-abab-3af3c6e4cde2',
  '1',
  'CJAMS-60574',
  now(),
  'CJAMS-60574',
  now(),
  '2be2a3da-d769-4f87-a714-0564ab4bbefc',
  'JD',
  'dcf60a10-cb3d-4be5-b0cd-dbc16da6a419',
  'fd7ed8a3-41e1-429e-a49c-c408341883e0',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-60574.","display_name": "Comments"}]}');
  
update personprogramarea
  set enddate = null,
      updatedby = 'CJAMS-60574', 
      updatedon = now()
where personid = 'fd7ed8a3-41e1-429e-a49c-c408341883e0'
  and programkey = 'OOH' 
  and personprogramid = '2b009912-720f-4bcd-8a69-32f3c1fd3164'
  and activeflag = 1;