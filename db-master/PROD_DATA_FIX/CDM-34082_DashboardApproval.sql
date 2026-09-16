-- CDM-34082 - In Dashboard Approval Not visible in IVE Suprivosor and Specialist
/* Issue Description:In Dashboard Approval record Not visible for Suprivosor and Specialist in IV-E side #4437622

-- Person ID: 4437622

-- Category/ Module: Title IV-E  

-- Root cause: In Dashboard Approval record Not visible for Suprivosor and Specialist in IV-E side #4437622 
-- Fix Provided: Datafix has been provided and updated eligibility_id with 10000836
-- Pull request# N/A

*/

select * from tb_eligibility_period where eligibility_id='10000835' and delete_sw='N';

update tb_eligibility_period
set eligibility_id='10000836' ,
	update_ts = now(),
	update_user_id = 'CDM-34082' 
where delete_sw='N' and eligibility_id='10000835';