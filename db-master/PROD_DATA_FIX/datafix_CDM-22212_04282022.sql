-- CDM-22212 - Negative A/R Balance
/*
-- Issue Description: 
   Account Receivable balace is -ve after Write-Off approvals
   
-- Provider ID: 5086682 (Karen Mercer) - Local Department Home
-- Receivable ID: 1245277

-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
Receivable Details
ID		Start DT	End DT		Amount	Balance	Write OFF
1721769	2021-09-01	2021-09-15	530.40	-530.40	530.40
1721741	2020-09-01	2020-09-30	874.80	-874.80	874.80
1721719	2022-02-01	2022-02-28	928.20	-928.20	928.20
*/
		
-- Update -ve Balance 		
select receivable_detail_id, amount_no, receivable_balance_no, written_off_amount_no, 
	receivable_status_cd, write_off_approval_status, write_off_request_date, 
	written_off_request_amount_no, comments_tx, update_ts, update_user_id  
from tb_receivable_detail 
where receivable_detail_id in ( 1721769, 1721741, 1721719 )
	and delete_sw = 'N' ;

update tb_receivable_detail
set receivable_balance_no = 0.00,
	update_ts = now(),
	update_user_id = 'CDM-22212'
where receivable_detail_id in ( 1721769, 1721741, 1721719 )
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
	rh.update_user_id = 'CDM-22212'
where rh.receivable_id = 1245277
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
			    ) * pp.percentage_no ) / 25 ),0), -- 25% Public Provider 
    pp.update_ts = now(),
	pp.update_user_id = 'CDM-22212'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1245277 ;
	