/*
  Issue Description:  CDM-40158
   Category/ Module  :  Child Removal
   Root cause: User request the data fixes mentioned in the sheet
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

--coloumn-4

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-40158',
updatedon = now()  where intakeservreqchildremovalid = '48f727db-842d-4bfe-be3c-0db699e6499b' and removalid = '157073' and activeflag =1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-40158',
updatedon = now() where personprogramid = '87e415fd-5915-4869-a923-11f9e2bf1dc0' and personid = 'a108e4b5-24de-4ef5-b814-d94cdc63970f'; 

update routing set activeflag = 0, updatedby = 'CDM-40158',
updatedon = now() where objectid = '48f727db-842d-4bfe-be3c-0db699e6499b' and activeflag =1;

update     tb_client_eligibility
set  delete_sw = 'Y', update_user_id = 'CDM-40158',
update_ts = now()
where  removal_id = 157073 and delete_sw  = 'N' ;

--coloumn-14

update personprogramarea set activeflag = 0, updatedby = 'CDM-40158',
updatedon = now() where personprogramid = '7e78e7ce-3657-4167-89cb-019a5ee1381c' and personid = '77119316-173c-4e6c-ac5a-5b90476518da'; 

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-40158',
updatedon = now() where intakeservreqchildremovalid = '8bfde75d-2d0e-4019-8e20-dc783717d2b5' and removalid = '174702' and activeflag =1;

update routing set activeflag = 0, updatedby = 'CDM-40158',
updatedon = now() where objectid = '8bfde75d-2d0e-4019-8e20-dc783717d2b5' and activeflag =1; 

update     tb_client_eligibility
set delete_sw = 'Y',update_user_id = 'CDM-40158',
update_ts = now()
where  removal_id = 174702 and delete_sw  = 'N' ;

update placement  set intakeservreqchildremovalid = 'b8d91e8e-af29-415b-b78f-2efe47b71439' 
where intakeservreqchildremovalid = '8bfde75d-2d0e-4019-8e20-dc783717d2b5' and activeflag = 1;

--coloumn-10

update
    intakeservreqchildremoval
set
    removaldate  = '2015-07-21 00:00:00',
    updatedby = 'CDM-40158',
    updatedon = now()
where
    intakeservreqchildremovalid = '4c4d17de-4d22-4dee-be7c-cd94a26c20b9';


update
   tb_client_eligibility
set
   start_dt  = '2015-07-21 00:00:00',
   update_user_id = 'CDM-40158',
   update_ts = now()
where
   removal_id = '194773';
 
update
   personprogramarea
set
   startdate  = '2015-07-21 00:00:00',
   updatedby = 'CDM-40158',
   updatedon = now()
where
   personprogramid = 'ebe6e4df-00cb-4ba2-81ac-0420f5fda981' and personid = '1677b3f4-fa48-4132-a334-686119e52fef';

   --coloumn-7

   	update intakeservreqchildremoval set exitdate =  '2006-02-01',updatedby = 'CDM-40158',
   updatedon = now() where intakeservreqchildremovalid='5316cc06-dd8f-4141-ba27-82455a7ca63a' and activeflag = 1;

       --coloumn-9

 update
    intakeservreqchildremoval
set
    exitdate  = '2024-06-05 00:00:00',
    updatedby = 'CDM-40158',
    updatedon = now()
where
    intakeservreqchildremovalid = '127e91f0-5fc0-4f35-88c9-89c733ed2ccc';


update
   tb_client_eligibility
set
   end_dt  = '2024-06-05 00:00:00',
   update_user_id = 'CDM-40158',
   update_ts = now()
where
   removal_id = '252579';

  
update
   personprogramarea
set
   enddate  = '2024-06-05 00:00:00',
   updatedby = 'CDM-40158',
   updatedon = now()
where
   personprogramid = '6ffb2eec-4fbf-40b8-bdf8-bef252bbde0b' and personid = 'e225b8e7-f832-4074-9256-c6e3e1bba523';

   --coloumn 11

update personprogramarea set activeflag = 0, updatedby = 'CDM-40158',
updatedon = now() where personprogramid = 'f07ac76b-e1b2-4303-96c3-9eed67e49d83' and personid = '1677b3f4-fa48-4132-a334-686119e52fef'; 

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-40158',
updatedon = now() where intakeservreqchildremovalid = 'be5d1f57-b669-402b-8d16-7c1ac406d674' and removalid = '174698' and activeflag =1;

update routing set activeflag = 0 where objectid = 'be5d1f57-b669-402b-8d16-7c1ac406d674' and activeflag =1; 


update tb_client_eligibility
set delete_sw = 'Y',update_user_id = 'CDM-40158',
update_ts = now()
where  removal_id = 174698 and delete_sw  = 'N' ;


update placement  set intakeservreqchildremovalid = '4c4d17de-4d22-4dee-be7c-cd94a26c20b9',updatedby = 'CDM-40158',
updatedon = now()
where intakeservreqchildremovalid = 'be5d1f57-b669-402b-8d16-7c1ac406d674' and activeflag = 1;

update personprogramarea set activeflag =0,updatedby = 'CDM-40158',
updatedon = now() where personprogramid = '4621c3de-b953-4ad9-a604-6de3717a52f3' and activeflag = 1;

update placement
set intakeservreqchildremovalid  = '127e91f0-5fc0-4f35-88c9-89c733ed2ccc',
    updatedby = 'CDM-40158',
    updatedon = now()
where intakeservreqchildremovalid  = '33b2e7ee-2934-4b0e-aa34-11ecd5a1aa37'
    and activeflag  = 1 ;
      