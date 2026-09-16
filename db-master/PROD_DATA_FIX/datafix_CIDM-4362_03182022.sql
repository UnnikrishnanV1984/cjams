-- CIDM-4362 - CJAMS application is not updating the Collection Status Date 
/*
-- Issue Description: 
	CJAMS application is not updating the Collection Status Date 
	in the TB_RECEIVABLE_COLLECTION_STATUS table
      
-- Category/ Module: Accounts Receivables (Finance Management) 
-- Root cause: Code Issue
-- Pull request# Code fix has been promoted to update collection_status_dt
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod deployment
*/

-- Datafix to update collection_status_dt in tb_receivable_collection_status table
select collection_status_id, collection_status_cd, collection_status_dt, 
		delete_sw, create_ts, update_ts, update_user_id
	from tb_receivable_collection_status 
where collection_status_dt is null ;

update tb_receivable_collection_status
set collection_status_dt = create_ts::date,
	update_ts = now(),
	update_user_id = 'CIDM-4362'
where collection_status_dt is null ;
