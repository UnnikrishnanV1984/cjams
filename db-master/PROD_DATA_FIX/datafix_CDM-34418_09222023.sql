-- CDM-34418 - Service Log Vendor info missing
/*
-- Issue Description: 
	Vendor information is missing from the screen and also when I print the Purchase authorization Form
   
-- Vendor ID: 6005561 (Wendy Ayers)

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Application code issue.
-- Fix Provided: Code fix has been promoted to fix the Provider name display issue.
			     and Datafix has been provided to update all impacted Purchase authorizations of this Provider.
-- Note : Please create CIDM ticket to identify and fix all other impcated records?					 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update provider_name in snapshot table (CDM-34418)
-- 
select provider_id, provider_name, authorization_id, update_ts, update_user_id  
	from tb_slpa_snapshot 
where provider_id  = 6005561
	and delete_sw = 'N'
	and provider_name is null ;

update tb_slpa_snapshot
set provider_name = 'Wendy Ayers',
	update_ts = now(), 
	update_user_id = 'CDM-34418'
where provider_id  = 6005561
	and delete_sw = 'N'
	and provider_name is null ;
