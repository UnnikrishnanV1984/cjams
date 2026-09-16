/*
   Issue Description: CJAMS-59336
   Category/ Module  : Prod data fix to remove duplicate removal
   Root cause:  CDM-44363 
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CJAMS-59336',
updatedon = now()  where intakeservreqchildremovalid = '35f6a6c2-c862-4897-b32a-966c48fb01bf' and removalid = '317039' and activeflag =1;


update   tb_client_eligibility
set  delete_sw = 'Y', update_user_id = 'CJAMS-59336',
update_ts = now()
where  removal_id = 317039 and delete_sw  = 'N' ;

update personprogramarea set activeflag = 0, updatedby = 'CJAMS-59336',
updatedon = now() where personprogramid = '27bbd1d8-56fc-46b7-8329-a60d6ef5c7fb' and personid = 'fe9a68a4-6fef-4f71-a304-62d0ff4c71a1' and activeflag = 1; 


update placement set intakeservreqchildremovalid = '77484fdf-686b-4e2c-8948-a40d723aace3' , updatedby = 'CJAMS-59336', updatedon = now()
where placementid = '1367f50c-e37a-4373-944b-d77c46efdafc' and intakeservreqchildremovalid = '35f6a6c2-c862-4897-b32a-966c48fb01bf' and activeflag =1;