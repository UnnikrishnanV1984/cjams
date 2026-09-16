-- CDM-16806 - Missing Approval Button
/*
-- Issue Description: 
   Account Receivable Write-Off approval Issue (Routing record is missing).
   
-- Provider ID: 5078675	(April Dortch) - Local Department Home
    
-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
Receivable Detail 
1719279	2018-07-01	2018-07-31	983.63	983.63		983.63 -> Missing Routing
1719257	2016-11-01	2016-11-30	951.90	951.90		951.90 -> Missing Routing
1719254	2016-08-01	2016-08-31	983.63	-1967.26	983.63 -> -ve balance
*/

-- 22   Write-Off Request
select receivable_detail_id, amount_no, receivable_balance_no, written_off_amount_no, 
	receivable_status_cd, write_off_approval_status, write_off_request_date, 
	written_off_request_amount_no, comments_tx, update_ts, update_user_id  
from tb_receivable_detail 
where receivable_detail_id in (1719279, 1719257)
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;

	
update 	tb_receivable_detail
set written_off_amount_no = null,
	receivable_status_cd = '19', -- Outstanding
	write_off_approval_status = null,
	write_off_request_date = null,
	written_off_request_amount_no = null,
	update_ts = now(),
	update_user_id = 'CDM-16806'
where receivable_detail_id in (1719279, 1719257)
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;
		
-- Update -ve Balance 		
select receivable_detail_id, amount_no, receivable_balance_no, written_off_amount_no, 
	receivable_status_cd, write_off_approval_status, write_off_request_date, 
	written_off_request_amount_no, comments_tx, update_ts, update_user_id  
from tb_receivable_detail 
where receivable_detail_id = 1719254
	and delete_sw = 'N' ;

update tb_receivable_detail
set receivable_balance_no = 0.00,
	update_ts = now(),
	update_user_id = 'CDM-16806'
where receivable_detail_id = 1719254
	and delete_sw = 'N' ;
	
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
	rh.update_user_id = 'CDM-16806'
where rh.receivable_id = 1245131
	and rh.delete_sw = 'N'  ;
		 
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
	pp.update_user_id = 'CDM-16806'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1245131 ;
	