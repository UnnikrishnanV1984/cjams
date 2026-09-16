-- CDM-27180 - FM210R A/R Overpayment Letter Generated
/*
-- Issue Description: 
   Accounts Receivable for provider 5001276 for the amount $4,299.70 with incorrect dates
      
-- Provider ID: 5001276 (Foundations for Home and Community, Inc.) - Private Organization
-- Case ID: 3267642
-- Client ID: 2248897 (KALIL MALIK) - c0aa5a35-92af-486c-b645-198f59071e63
-- Placement ID: 333361 - 02/28/2019 To Current - f78fc83c-0c8e-4ab0-8edb-01a85b05a339
-- Private Organization: 5001276 (Foundations for Home and Community, Inc.)	
-- CPA Office: 5001490 (Foundations For Home and Community CPA - TFC)
-- Program ID: 1686	(Foundations for Home and Coummunity)
-- Receivable Detail ID: 1724308 Date: 12/02/2022 - $4299.70 - 2019-02-28 To 2019-02-28

-- Category/ Module: Accounts Receivables (Finance Management) 
-- Root cause: Accounts Receivable is having incorrect dates, due to the wrong datafix was promoted as a part of S2022034037543 (CDM-20221).
-- Fix Provided: As per the user's request datafix has been promoted to fix the Accounts Receivable start & end dates. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next prod deployment

-- Revison 01/30 - to update payment detail 2843045
*/

select payment_detail_id, amount_no, start_dt, end_dt, update_ts, update_user_id 
	from tb_receivable_detail 
where delete_sw = 'N'
	and receivable_detail_id = 1724308 ;

-- AR Amount $4299.70 - Update Payment Detail ID 4480472 (Current Payment Detail ID: 2843045)
update tb_receivable_detail
set payment_detail_id = 4480472,
	start_dt = '2019-02-01'::date,
	end_dt = '2019-02-28'::date,
	update_ts = now(),
	update_user_id = 'CDM-27180'
where delete_sw = 'N'
	and receivable_detail_id = 1724308 ;

select payment_detail_id, final_amount_no, final_service_start_dt, final_service_end_dt, 
	final_units_no, final_amount_no, placement_id , update_ts, update_user_id 
	from tb_payment_detail
where delete_sw = 'N'
   and payment_detail_id = 4480472 ;

update tb_payment_detail
set final_service_start_dt = '2019-02-01'::date,
	final_service_end_dt = '2019-02-28'::date,
	final_units_no = 28,
	update_ts = now(),
	update_user_id = 'CDM-27180'
where delete_sw = 'N'
    and payment_detail_id = 4480472 ;