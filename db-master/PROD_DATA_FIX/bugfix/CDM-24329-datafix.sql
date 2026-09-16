/*
   Issue Description: CDM-24329
   Category/ Module  : IVE
   Root cause: User unable to make IV-E eligibility decision. RemovalId was wrongly mapped to different Person in the same family.

   Reason why no related code fix: Assigned the correct ClientId in the removal table
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	tb_client_eligibility
set 	   client_id = 200784824, 
         update_user_id = 'CDM-24329',
         update_ts = now()
where 	removal_id = 254026 and client_id = 4330977;