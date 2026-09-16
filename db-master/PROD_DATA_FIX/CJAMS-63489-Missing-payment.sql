/*
-- Issue Description: 
221030015413:Placement #2107197 had a date change for client 2679463. A placement validation did not generate nor did the one day payment. Provider is missing a payment for one night.   
-- Client ID: 2679463 (Xaviera Buie)
-- Provider ID: 5001625 (MENTOR Maryland - Baltimore CPA)
-- Provider Organization ID: 5001618 (MENTOR Maryland, Inc)
-- Placement Structure: Treatment Foster Care (Private)
-- Program Name: Teens in Transition Baltimore Office (#2817)
-- Placement ID: 2107197
-- Category/ Module: Account Receivable (Finance Management) 
-- Root cause: placement validation table wasn't updated leading to lack in payment for a night.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_placement_validation
set placement_entry_dt = '2025-07-14',
	update_ts = now(),  
	update_user_id  = 'CJAMS-63489'
where placement_id  = 2107197
    and delete_sw  = 'N'
    and placement_entry_dt  <> '2025-07-14'::date