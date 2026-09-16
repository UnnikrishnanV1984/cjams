-- CDM-16948- Failed Interface with D365
/*
-- Issue Description: 
   Service Log Authorization 1785975 and 1785974 failed to interface with Microsoft D365 
   Research indicates the payment request never reached (interfaced) Microsoft D365 
   to generate a check. Payments are showing in client history.
   
-- Case ID: 211030008533
-- Client ID: 200671606	(Alyssa Marr-Gavin) - a629178a-5328-44fa-83aa-2de47680199a
-- Provider ID: 6002710 (Karl Stewart) - Local Department Home
-- Service Log ID: 2006309 - Clothing Purchase (Paid) 
-- Auth ID: 1785975 - Payment ID: 3060909 - Date: 07/19/2021 - $99.74

-- Service Log ID: 2006308 - Clothing Purchase (Paid) 
-- Auth ID: 1785974 - Payment ID: 3060910 - Date: 07/19/2021 - $54.94

-- One more payment was there which failed on 07/19/2021 to Interface
-- Service Log ID: 2006310 - Clothing Purchase (Paid) 
-- Auth ID: 1785976 - Payment ID: 3060908 - Date: 07/19/2021 - $20.96
   
-- Category/ Module: D365 Interface - FM106R Report (Finance Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Payment Status updated as "Approved" for CJAMS - D365 Interface to process these payments again.
select payment_id, payment_status_cd, update_ts, update_user_id 
	from tb_payment_status 
where payment_id in ( 3060909, 3060910, 3060908 )
	and delete_sw  = 'N' ;
	
update tb_payment_status 
set payment_status_cd = '1634', -- Approved
	update_ts = now(),
	update_user_id = 'CDM-16948'
where payment_id in ( 3060909, 3060910, 3060908 )
	and delete_sw  = 'N' ;

