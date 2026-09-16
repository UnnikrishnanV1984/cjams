
/*
   Issue Description: CDM-20323
   Category/ Module  : Updating tb_client_eligibility
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--200305746
update tb_client_eligibility set client_id = '4432381', update_ts = now(), update_user_id = 'CDM-20323'
where removal_id = '253112' and eligibility_id = '10003800';