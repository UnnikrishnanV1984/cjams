-- CDM-31560 - Error on Receipts Log &FM200R
/*
-- Issue Description: 
   Provider Account Receivable Error on Receipts 
   
-- Provider ID: 5030992 (Arlene Hawkins) - Local Department Home
    
-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: CJAMS is not reducing the AR balance correctly for 'Reffered to CCU' status
-- Fix Provided: Code fix has been promoted to update receivable balance correctly for Reffered to CCU status
-- 			     and Datafix has been promoted to fix This providers AR data 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Write-Off 
select receivable_balance_no, written_off_amount_no, 
	receivable_status_cd, write_off_approval_status, write_off_action_date, write_off_request_date, 
	written_off_request_amount_no, comments_tx, update_ts, update_user_id  
from tb_receivable_detail 
where receivable_detail_id = 1721763
	and delete_sw = 'N' ;

update tb_receivable_detail
set written_off_amount_no = null, -- 13.55
	-- receivable_status_cd = '19', -- 19 Outstanding
	write_off_approval_status = null, -- 3047
	write_off_action_date = null, -- 2023-03-28
	write_off_request_date = null, -- 2023-03-28
	written_off_request_amount_no = null, -- 13.55
	comments_tx = null,
	update_ts = now(),
	update_user_id = 'CDM-31560'
where receivable_detail_id = 1721763
	and delete_sw = 'N'
	and written_off_amount_no > 0 ;

select routingid, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid  = '1721763'
	and eventcode  = 'FNSWO'
	and activeflag  = 1 ;

update routing
set activeflag = 0, 
	updatedby = 'CDM-31560', 
	updatedon  = now()
where objectid  = '1721763'
	and eventcode  = 'FNSWO'
	and activeflag  = 1 ;
	
-- Fix Payment Receipt Amount
-- update collected_amount_no =  $27.95
select receivable_detail_id, collected_amount_no, update_ts, update_user_id  
from tb_receivable_liquidation
where rcvbl_liquidation_id = 3383836
	and delete_sw  = 'N' ;

update tb_receivable_liquidation
set collected_amount_no = 27.95,
	update_ts = now(),
	update_user_id = 'CDM-31560'
where rcvbl_liquidation_id = 3383836
	and delete_sw  = 'N' ;
	
-- Update Paymnet Plan -ve balance 
select start_dt, end_dt, current_receivable_amount, update_ts, update_user_id 
from tb_payment_plan
where payment_plan_id = 55014
	and delete_sw = 'N' ;
	
update tb_payment_plan	
set current_receivable_amount = 0.00,
	update_ts = now(),
	update_user_id = 'CDM-31560'
where payment_plan_id = 55014
	and delete_sw = 'N' ;

-- 	Update Provider AR Balances & Payment Plan		   
select rh.balance_no 
	  ,coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0) as calculated_balance_no 
	 ,rh.receivable_original_amount_no 
	 ,coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0) as calculated_original_amount_no
	,rh.written_off_amount_no
	,coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0) as written_off_amount_no
	,rh.update_ts 
	,rh.update_user_id 
from  tb_receivable_header rh
where rh.delete_sw = 'N'  
	and rh.receivable_id = 244713 ;
	
update tb_receivable_header rh
set balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	update_ts = now(),
	update_user_id = 'CDM-31560'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 244713 ;
		 
-- 	Update Payment Plan
select pp.payment_plan_id
	,pp.current_receivable_amount 
	,coalesce(( select sum(rd.receivable_balance_no)       
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
			    ),0) as calculated_current_receivable_amount
    ,pp.amount_no 
	,coalesce(((( select sum(rd.receivable_balance_no)       
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
			    ) * pp.percentage_no ) / 100 ),0) as calculated_amount_no
    ,pp.update_ts
	,pp.update_user_id
from tb_payment_plan pp	
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 244713 ;
	
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
	update_user_id = 'CDM-31560'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 244713 ;
	
