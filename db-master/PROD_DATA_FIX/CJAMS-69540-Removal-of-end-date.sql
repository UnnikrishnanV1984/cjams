/*
   Issue Description: CJAMS-69540
   Category/ Module  : Prod data fix to remove the removal endaate 
   Root cause: Remove the child removal end date
                        Remove OOH program end date
                        change the placement exit type to change in placement structure
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




--Removing end date from intakeservreqchildremoval
update intakeservreqchildremoval
set exitdate = null, returntransts = null, updatedby = 'CJAMS-69540', updatedon = now()
where intakeservreqchildremovalid = '4d6d0f3e-90cb-4224-a332-96427fc3b533' and activeflag = 1;

--Removing end date from intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set exitdate = null, returntransts = null, updatedby = 'CJAMS-69540', updatedon = now()
where intakeservreqchildremovalid = '4d6d0f3e-90cb-4224-a332-96427fc3b533' and activeflag = 1 and exitdate is not null;

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
  '4d6d0f3e-90cb-4224-a332-96427fc3b533',
  NULL,
  '1',
  'CJAMS-69540',
  now(),
  'CJAMS-69540',
  now(),
  'eab8f0a0-65d7-4d11-af2f-414219903b2c',
  'JD',
  'a32aee9f-af30-42cd-bf17-2f8e50708f89',
  'bc10d2d6-bf53-4989-bb7b-d4bf6d117d3c',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-69540.","display_name": "Comments"}]}');




--Removing end date from tb_client_eligibility
update tb_client_eligibility
set end_dt = null, update_user_id = 'CJAMS-69540', update_ts = now()
where eligibility_id = 10135343;

-------------------3. Removing end date from Program Assignment-----------------
--Removing end date from personprogramarea
update personprogramarea
set enddate = null, updatedby = 'CJAMS-69540', updatedon = now()
where personprogramid = '40b536c2-6da4-4a29-af5f-2d915164429b' and activeflag = 1;