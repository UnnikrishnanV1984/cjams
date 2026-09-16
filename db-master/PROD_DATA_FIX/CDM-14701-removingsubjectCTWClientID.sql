/*
   Issue Description: CDM-14701
   Category/ Module  :  
   Root cause: removing the selected client of CTW
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 1659857	APRIL GRAHAM
update tb_foster_care_judicial set clientidofsubjectctwfinding = null,nameofsubjectctwfinding = null, update_ts = now()
where client_id::BIGINT = 4141908 and removal_id::BIGINT = 187004;