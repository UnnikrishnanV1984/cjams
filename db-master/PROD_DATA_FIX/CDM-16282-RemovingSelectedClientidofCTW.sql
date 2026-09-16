/*
   Issue Description: CDM-16282
   Category/ Module  :  
   Root cause: removing the selected client of CTW
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 1718305	SYEESA ROBINSON
update tb_foster_care_judicial set clientidofsubjectctwfinding = null,nameofsubjectctwfinding = null, update_ts = now()
where client_id::BIGINT = 4274246 and removal_id::BIGINT = 194661 
and period_type = 'I';