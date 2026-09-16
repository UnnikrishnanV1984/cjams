-- CDM-12920 - Qlik FM106R Error Report 2020
/*
-- Issue Description: 
   Garrett has a transaction from 05/2020 on the current FM106R Error Report. ???
   Ancillary Payment ID: 2902752 Dated 05/18/2020 is failing to Interface with D365 system as the payment amount is $0.00
   
-- Case ID: 3297992
-- Client ID: 3335316 (NATALEE	LYNN DEVER) -- 295254dc-345d-4c39-b021-5587d7f866ba
-- Provider ID: 5007120 (Redwood Toxicology Laboratory)
-- Service Log ID: 1956847 Date 03/20/2020 for Service: Drug/Alcohol Assessment (Paid)
-- Authorization ID: 1733053 

   
-- Category/ Module: D365 Interface - FM106R Report (Finance Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Option 2
select payment_id, payment_status_cd, update_ts, update_user_id 
	from tb_payment_status 
where payment_id = 2902752
	and delete_sw  = 'N' ;
	
update tb_payment_status 
set payment_status_cd = '1638', -- Denied
	update_ts = now(),
	update_user_id = 'CDM-12920'
where payment_id = 2902752 
	and delete_sw  = 'N' ;
	
