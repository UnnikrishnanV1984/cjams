--- Prod payment hot fix..
---The draft payment amount is -ve for the placement id  1564120. 
---inactivate the negative details 
update
	tb_payment_detail set
		delete_sw = 'Y',
		update_ts = now(),
		update_user_id = 'data_fix_finance_02072021'
	where
		payment_id = 3051134
		and placement_id = 1564120
		and payment_detail_id=4200025;
--- Update the header	
--back gross_amount_no= 84839.28	
	update
		tb_payment_header set
			gross_amount_no = (
			select
				sum(draft_amount_no)
			from
				tb_payment_detail
			where
				payment_id = 3051134
				and delete_sw = 'N') ,
			update_ts = now(),
			update_user_id = 'data_fix_finance_02072021'
		where
			payment_id = 3051134;
			
