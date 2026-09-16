-- CIDM-9466 - Remove playment plan record
/*
-- Issue Description: 
Internal ticket created to remove the Payment Plan record as completed data fix for ticket # CDM-41506 & CDM-41221.   
-- Provider ID: 5094439 (Lawrence Wallace-powell)
-- Provider ID:6129182 (KENDRA BALDWIN)

-- receivable_ids (1254660,1254627);

-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: Data Issue (nternal ticket created to remove the Payment Plan record)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 	Update Payment Plan record

/*select * from tb_payment_plan
where --delete_sw = 'N'
	 end_dt is null 
	and receivable_id in (1254627,1254660) ;*/

update tb_payment_plan 
set delete_sw = 'Y',
	 update_ts = now(),
	update_user_id = 'CIDM-9466'
where delete_sw = 'N'
	and end_dt is null 
	and receivable_id in (1254627,1254660);
