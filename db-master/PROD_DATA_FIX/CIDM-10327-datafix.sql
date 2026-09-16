/*
Issue Description: Value LT should be changed as Father, In tb_picklist_values the description is mentioned as LT. 
Fix has been promoted to change the description to Father
Category/Module: Bug
Root cause: data fix to remove the Child removal 
Fix provided: Fix has been promoted to change the description to Father
Data/Code fix ticket#: CIDM-10327
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update tb_picklist_values
set description_tx = 'Father', 
update_user_id  = 'CIDM-10327', 
update_ts  = now()    
where picklist_type_id = 150
and picklist_value_cd  = '6899'
and delete_sw = 'N' ;