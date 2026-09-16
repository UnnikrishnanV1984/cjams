/* 
    Issue Description: CDM-38718
   Category/ Module  : Child Removal
   Root cause: user wants to delete  duplicate child removal. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

UPDATE intakeservreqchildremoval 
SET activeflag = 0,
updatedby ='CDM-38718',
updatedon = now()
WHERE intakeservreqchildremovalid = '146eb272-2c06-483c-9c14-25fbf0d3ea87' AND activeflag=1;


UPDATE intakeservreqchildremoval_history 
SET activeflag = 0,
updatedby ='CDM-38718',
updatedon = now()
WHERE intakeservreqchildremovalid = '146eb272-2c06-483c-9c14-25fbf0d3ea87' AND activeflag=1;

update personprogramarea set activeflag =0, updatedby ='CDM-38717', updatedon =now() where personprogramid = '48656124-ac80-498c-979b-009e1118cd7e'
and personid ='85b88950-eb55-4465-a78d-b5293efae53d'
and activeflag = 1 ;

update routing set activeflag =0 WHERE objectid = '146eb272-2c06-483c-9c14-25fbf0d3ea87' 
AND activeflag=1;


update tb_client_eligibility set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-38718' where removal_id = 310855
and delete_sw = 'N' ;