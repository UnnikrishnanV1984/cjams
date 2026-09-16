/*
 Issue Description: CDM-40053
-- Category/ Module: Child Removal
-- Root cause: User wants to udpate child removal history end date.
-- Fix Provided: Datafix has been promoted to update end date.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea 
set 
enddate= '04/30/2024',
updatedby = 'CDM-40053',
updatedon= now()
where 
personprogramid='81991f18-d52d-41cf-995b-89534fceb2c4';


update Intakeservreqchildremoval
set 
exitdate= '04/30/2024',
updatedby = 'CDM-40053',
updatedon = now()
where   
intakeservreqchildremovalid ='969c1309-332b-48e0-8fba-b7543818ea5f';


update tb_client_eligibility
set
end_dt = '04/30/2024',
update_user_id = 'CDM-40053',
update_ts = now()
where 
removal_id = 199421 and case_id = 3257172;