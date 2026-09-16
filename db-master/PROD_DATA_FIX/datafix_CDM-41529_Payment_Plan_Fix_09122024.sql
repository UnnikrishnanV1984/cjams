-- CDM-41529 - AR Balance
/*
-- Issue Description: 
	AR screen Payment Plan tab is showing the receivable balance amount $58,611.60 (doubled)
	
-- Provider ID: 6003060	(Brenda Lee  Chase-Buck)
-- Receivable ID: 1255354	
	
-- Root cause: Data fix was done with CDM-41323 to resolve the double payment Issue due to eth duplicate records in the GAP agreement table.
		ARs, Payment plan and the AR tickler was created as a part of this datafix for this exception scenario.
		Payment Plan balance was doubled due to the duplicate records inserted in AR collection status table (CDM-41323 fix error). 
		And the nightly finance batch has created one additional AR tickler.
-- Fix Provided: Datafix has been promoted to fix the payment plan balance and to remove the duplicare AR Tickler.
-- Is Code fix Required?: No
--	Code fix ticket#: N/A
--	Reason why no related code fix: N/A
--  Regression Impacts: N/A
*/

-- To fix the Payment Plan Amount (CDM-41529)
-- Delete duplicate tb_receivable_collection_status records

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-41529'
where delete_sw = 'N'
	and collection_status_id 
		in (	24002546, 24002547, 24002548, 24002549, 24002550, 24002551, 24002552, 24002553, 24002554, 24002555,
				24002556, 24002557, 24002558, 24002559, 24002560, 24002561, 24002562, 24002563, 24002564, 24002565,
				24002566, 24002567, 24002568, 24002569, 24002570, 24002571, 24002572, 24002573, 24002574, 24002575,
				24002576, 24002577, 24002578, 24002579, 24002580
			) ;	


-- 	Update Payment Plan
update tb_payment_plan pp
set current_receivable_amount 
		= coalesce(( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ),0),
    amount_no 
		= coalesce(((( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ) * pp.percentage_no ) / 100 ),0),
    update_ts = now(),
	update_user_id = 'CDM-41529'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1255354	;	
	
	
-- Delete duplicate Ticker 
update tb_ticklers 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-41529'
where tickler_id  = 30202476 
	and delete_sw  = 'N' ;	