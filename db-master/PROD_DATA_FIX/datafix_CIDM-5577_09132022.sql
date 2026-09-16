-- CIDM-5577 - Provider 5001284 (Nexus Woodbourne Family Healing) Payment Plan Update for 09/13 batch run
/*
-- Issue Description: 
   Provider 5001284 (Nexus Woodbourne Family Healing) Payment Plan Update for 09/13 batch run
   
-- Default --> Percentage 5.56% & Plan Amount $76,801.24
-- New AR $33,670.00 created after 08/13/2022 batch run
-- Offset Amount for 09/13 batch run Current Balance $76,801.17  + (New ARs) $33,670.00 = $110,471.17 (7.99%)


-- Category/ Module: Response Timer  (Investigation Management) 
-- Root cause: MDThink team is monitoring & maintaining this provider’s payment plan manually due to exceptional scenario.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

select payment_plan_id, plan_dt, amount_no, percentage_no, months_no, start_dt, end_dt, update_ts, update_user_id 
	from tb_payment_plan
where payment_plan_id = 1055688
   and delete_sw = 'N' ;

update tb_payment_plan
set amount_no = 110471.17,
	percentage_no = 7.99,
	update_ts = now(),
	update_user_id = 'CIDM-5577'
where payment_plan_id = 1055688
	and delete_sw  = 'N' ;
	