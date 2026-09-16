/*
Issue: CJAMS-66156 116 Report
Category/Module: Child Accounts
Root cause: Balance is going negative in cost of care due to code error where we are inserting empty string in place of null values for late_entry_sw.
            This has happened due to code changes as the part of angular upgrade.
Fix provided:  Data fix is needed for correcting this values and code fix will be done as the part of CIDM
Data/Code fix ticket#: CJAMS-66156
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#:  CIDM-11226
Reason why no related code fix: N/A
*/


update tb_account_transaction
set late_entry_sw = NULL,
    update_ts = now(),
    update_user_id = 'CJAMS-66156'
where transaction_type_cd = '589'
  AND credit_debit_sw = 'C'
  AND transaction_source_cd IN ('587', '586', '585')  
  and delete_sw = 'N'
  and btrim(late_entry_sw)= '' ; 
