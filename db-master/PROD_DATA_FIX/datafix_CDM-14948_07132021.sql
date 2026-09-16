-- CDM-14948 - Accounts Receivable Total Balance Due
/*
-- Issue Description: 
   Provider ID: 5044481 (Carerite T.F.C., Inc.) - A/R Balance Discrepancy Issue
      
-- Category/ Module: Accounts Receivables (Finance Management) 
-- Root cause: TDB (Need further Analysis)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
--	Rec ID	Rec 	AR 		Payment 
--			Detl ID Amount	Detail ID
-----------------------------------------------------
-- 244850	1717669	3054.00	0
-- 244850	1717667	3054.00	0
-- 244850	1717393	3054.00	0
-- 244850	1717392	3054.00	0

-- Data fix to delete ARs 
select collection_status_id, collection_status_cd, collection_status_dt, delete_sw, update_ts, update_user_id 
	from tb_receivable_collection_status 
where delete_sw = 'N'
	and receivable_detail_id in ( 1717669, 1717667, 1717393, 1717392 );

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-14948'
where delete_sw = 'N'
	and receivable_detail_id in ( 1717669, 1717667, 1717393, 1717392 );
		

select receivable_detail_id, payment_detail_id, delete_sw, update_ts, update_user_id 
	from tb_receivable_detail 
where delete_sw = 'N'
	and receivable_detail_id in ( 1717669, 1717667, 1717393, 1717392 );

update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-14948'
where delete_sw = 'N'
	and receivable_detail_id in ( 1717669, 1717667, 1717393, 1717392 );
		   
-- 	Update Provider AR Balances & Payment Plan		   
update tb_receivable_header rh
set rh.balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	rh.receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	rh.written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	rh.update_ts = now(),
	rh.update_user_id = 'CDM-14948'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 244850 ;
		 
-- 	Update Payment Plan
update tb_payment_plan pp
set pp.current_receivable_amount 
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
    pp.amount_no 
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
    pp.update_ts = now(),
	pp.update_user_id = 'CDM-14948'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 244850 ;
