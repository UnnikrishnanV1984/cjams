-- CDM-41336 - A R Module
/*
-- Issue Description: 
   Payment plans with Percentage the Fields are blank in CJAMS.
   
-- Category/ Module: GAP (Case Management) 
-- Root cause: System has generated Payment plans with Percentage the Fields are blank (0.00%)
-- Fix Provided: Datafix has been promoted to fix all impacted Payment plans
--				 and code fix has been promoted to avoid error of CJAMS creating Payment plans with Percentage as 0.00% 
-- Pull request# N/A 
-- Is Code fix Required?: Yes
--	Code fix ticket#: CDM-41336
--	Reason why no related code fix: N/A
--  Regression Impacts: 
	Finance Account Receivable Module 
	Identify provider placement with existing payments, void that placement in CJAMS and verify that CJAMS is updating plan correctly 
*/

-- To fix Payment Plan data  (CDM-41336) 
-- To fix and pl.percentage_no = 0 issue
update tb_payment_plan pl
set percentage_no = 
		(select pl1.percentage_no 
			from tb_payment_plan pl1
		where pl1.receivable_id = pl.receivable_id
			and pl1.payment_plan_id <> pl.payment_plan_id
			-- and pl1.percentage_no <> 0
			-- and pl1.delete_sw  = 'N' 
			and pl1.create_user_id <> 'online'
		order by pl1.payment_plan_id desc
		limit 1 ),
	payment_option_sw = 'A',
	update_ts = now(), 
	update_user_id = 'CDM-41336' 
where pl.delete_sw  = 'N'
	and pl.percentage_no = 0
	and pl.create_user_id = 'online' 
	and (select count(*)
			from tb_payment_plan pl1
		where pl1.receivable_id = pl.receivable_id
			and pl1.payment_plan_id <> pl.payment_plan_id
			and pl1.percentage_no <> 0
			and pl1.create_user_id <> 'online'
		) > 0 ;
		

-- To update payment_option_sw = 'A' Recovery (NO Active Placements)
update tb_payment_plan pl
set payment_option_sw = 'A', -- Recovery 
	update_ts = now(), 
	update_user_id = 'CDM-41336' 
where pl.delete_sw = 'N'
	and pl.payment_option_sw is null 
	and pl.offset_option_sw is null ;


-- To update payment_option_sw = 'A' Recovery (NO Active Placements)
update tb_payment_plan pl
set payment_option_sw = 'A', -- Recovery 
	update_ts = now(), 
	update_user_id = 'CDM-41336' 
where pl.payment_option_sw = 'P' -- Application % Recovery
	and pl.offset_option_sw is null 
	and pl.delete_sw  = 'N' ;
	
-- update payment_option_sw = null (No data) Offset (Active Placements)
update tb_payment_plan pl
set payment_option_sw = NULL, -- Offset 
	update_ts = now(), 
	update_user_id = 'CDM-41336' 
where pl.payment_option_sw = 'P' -- Application % Offset
	and pl.offset_option_sw = 'A' -- Offset (Active Placements)
	and pl.delete_sw = 'N' ;

-- Update offset_option_sw =  C  Number of Months
update tb_payment_plan pl
set payment_option_sw = 'C', -- Recovery 
	update_ts = now(), 
	update_user_id = 'CDM-41336' 
where pl.payment_option_sw = 'M' -- Application Number of Months
	and pl.offset_option_sw is null 
	and pl.delete_sw = 'N';
	
-- update payment_option_sw = null (No data)
update tb_payment_plan pl
set payment_option_sw = NULL, -- Offset 
	update_ts = now(), 
	update_user_id = 'CDM-41336' 
where pl.payment_option_sw = 'M' -- Application Number of Months
	and pl.offset_option_sw = 'A' -- Offset (Active Placements)
	and pl.delete_sw = 'N' ;
	

-- Update Provider AR Balances & Payment Plan		   
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
	update_user_id = 'CDM-41336'
where rh.delete_sw = 'N'  
	and rh.receivable_id in ( select receivable_id from tb_payment_plan where update_user_id = 'CDM-41336' ) ;
		 
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
	update_user_id = 'CDM-41336'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id in ( select receivable_id from tb_payment_plan where update_user_id = 'CDM-41336' ) ;
	