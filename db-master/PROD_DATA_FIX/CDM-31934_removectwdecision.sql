/*
   Issue Description: CDM-31934
   Category/ Module  :  
   Root cause: removing the selected client of CTW
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- DECOURSEY WILSON(1658861) - Biological Father
update tb_foster_care_judicial set clientidofsubjectctwfinding = null,nameofsubjectctwfinding = null, update_ts = now()
where client_id::BIGINT = 3821872 and removal_id::BIGINT = 254089 
and period_type = 'I';