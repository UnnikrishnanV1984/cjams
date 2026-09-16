/*
Issue Description:CJAMS-64651 validation old data
Category/Module: Placement 
Root cause: Old Validation data is not allowing user to create new validation
Fix provided: Data fix to delete the outstanding placement validation
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: defect is due to old data
*/

update tb_placement_validation 
set delete_sw = 'Y', update_user_id = 'CDM-64651', update_ts = now() 
where placement_id = '328276';