/*
   Issue Description: 43030
   Category/ Module  :  Person, Disbursment History
   Root cause: User requested to update the SSN No and Payment name
   Pull request# for code fix: 
   Reason why no related code fix: User Error.
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_child_account_disbursement
set payee_nm = 'Ruth Perez - Palacios', 
    update_ts = now(), 
    update_user_id ='CDM-43030'
where client_id ='4226235';
