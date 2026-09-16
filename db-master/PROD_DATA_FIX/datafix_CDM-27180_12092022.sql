-- CDM-27180 - FM210R A/R Overpayment Letter Generated
/*
-- Issue Description: 
	Why the the overpayment letter was generated for Account Receivable of $4,299.70 
   
-- Provider ID: 5001276 (Foundations for Home and Community, Inc.) - Private Organization
-- Case ID: 3267642
-- Client ID: 2248897 (KALIL MALIK) - c0aa5a35-92af-486c-b645-198f59071e63
-- Placement ID: 333361 - 02/28/2019 To Current - f78fc83c-0c8e-4ab0-8edb-01a85b05a339
-- Private Organization: 5001276 (Foundations for Home and Community, Inc.)	
-- CPA Office: 5001490 (Foundations For Home and Community CPA - TFC)
-- Program ID: 1686	(Foundations for Home and Coummunity)

-- Category/ Module: Account Receivable (Finance Management) 
-- Root cause: Wrong datafix was promoted with CDM-20221 - Back dating placement
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Data fix to remove incorrect Placement Validation record for Feb 2019   
select placement_id, placement_entry_dt, placement_exit_dt,  validation_start_dt, validation_end_dt,
	validation_status_cd, update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_validation_id = 2022622
	and delete_sw = 'N' ;
	
update tb_placement_validation
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27180'
where placement_validation_id = 2022622
	and delete_sw = 'N' ;

