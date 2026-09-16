
/*
Issue Description: Final disbursement for Melissa Martinez- Vasquez, CJAMS ID 201225037 was paid to Chantel Barbour-Mitchem. Correct name is Chantel McDaniel. Please update payees name in CJAMS Final Disbursement system to CHANTEL MCDANIEL so that D365 can also beupdated and the check can be reissued with the correct name
Category/Module: Child Account Disbursement 
Root cause: change the name for vendor Chantel Barbour-Mitchen to Chantel McDaniel.
Fix provided: Data fix done to change the name for vendor Chantel Barbour-Mitchen to Chantel McDaniel.
Data/Code fix ticket#: CJAMS-68082
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Fix
*/
update tb_child_account_disbursement
set payee_nm  = 'Chantel McDaniel', update_ts =now(), update_user_id ='CJAMS-68082'
where disbursement_id ='1059848';

update tb_payment_header
set payee_nm  = 'Chantel McDaniel',update_ts=now(), update_user_id ='CJAMS-68082' where
payment_id = 5204663 and delete_sw = 'N' ;