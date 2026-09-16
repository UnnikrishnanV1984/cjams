/*
   Issue Description: CJAMS-67124
   Category/ Module  : Cost of Care Reimbursement
   Root cause: Code issue, analysis is in-progress
   Fix provided: Data fix has been done by updating the COC Reimbursement value
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update tb_account_transaction
set late_entry_sw = null,
    update_ts = now(),
    update_user_id = 'CJAMS-67124'
where delete_sw = 'N'
    and btrim(transaction_source_cd) in ( '587', '586', '585' )
    and btrim(late_entry_sw) = ''  ;