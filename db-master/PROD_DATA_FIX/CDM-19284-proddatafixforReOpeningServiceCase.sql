
/*
   Issue Description: CDM-19284
   Category/ Module  : Re-opening Closed Service case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-19284', updatedon = now()
where servicecasedispositionid = '183f44d5-b709-4be6-8345-64fa98aed15d';

-- Closed	Closed	2021-12-21 20:02:07
update servicecase
set statustypekey = 'Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-19284', updatedon = now()
where servicecaseid = '629f03f2-d815-494d-8825-5981ea601fb0';