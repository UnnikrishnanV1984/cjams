/*
   Issue Description: CDM-15073
   Category/ Module  :  
   Root cause: removing the selected client of CTW
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 3304212	TEQUIALA BRADLEY
update tb_foster_care_judicial set clientidofsubjectctwfinding = null,nameofsubjectctwfinding = null, update_ts = now()
where client_id::BIGINT = 3304875 and removal_id::BIGINT = 199091 
and period_type = 'I';