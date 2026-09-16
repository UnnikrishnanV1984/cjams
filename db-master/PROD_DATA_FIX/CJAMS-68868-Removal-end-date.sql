/*
   Issue Description: CJAMS-68868
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to remove end date,
   Needs to remove end date for removal and also for OOH program for the child

                Case #: 221030015948

                CJAMS PID: 3016258
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null, updatedon = now(), updatedby = 'CJAMS-68868'
where intakeservreqchildremovalid = '8925c6a5-5bc2-49eb-9999-74b9ff8c19b8' and activeflag = 1;

update personprogramarea 
set enddate = null, updatedby = 'CJAMS-68868', updatedon = now() 
where personprogramid = 'f1bcf271-0cbc-4bd6-be49-11c33d63ccd3'  and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-68868',
    update_ts = now()
where removal_id = 253978 and delete_sw = 'N';

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
  '8925c6a5-5bc2-49eb-9999-74b9ff8c19b8',
  '50dcac90-80b6-4e6f-bac0-67dea1383079',
  '1',
  'CJAMS-68868',
  now(),
  'CJAMS-68868',
  now(),
  'b3a805af-e301-4755-bd96-841a6d95f921',
  'JD',
  '94bf65cf-d25f-4cb0-97f1-1a2e224781f5',
  '4b85908a-cc62-4145-bd23-8e567032134b',
  '{"status": "Updated", "data": [ {"key": "commsents","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-68868.","display_name": "Comments"}]}');
  
