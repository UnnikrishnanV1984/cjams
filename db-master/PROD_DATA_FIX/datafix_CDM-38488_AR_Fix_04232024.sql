-- CDM-38488 - Overpayment balance incorrect
/*
-- Issue Description: 
   An overpayment report (FM210R report) showed up for William Boggs, provider# 6005837 for Simon Boggs, 
   but there is no overpayment balance under his accts.
   
-- Case ID: 3172187 
-- Client ID: 2574032 (SIMON PAUL BOGGS) - 8dcfb34d-5169-4fa4-9f3f-8b56590fa1dc
-- Adoption ID: 20605 - 2009-04-01 To 2024-11-17 - 20c87335-f552-492d-8496-d0386cc5167f
-- Current Provider ID: 5020983	(Jessica Anne Freeman)
-- Prior Provider ID: 6005837 (WIlliam Howard Boggs)

-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: The Current  Adoptive parent on this subsidy is Provider # 5020983	(Jessica Anne Freeman)
--             This Adoption was having Provider # 6005837 as adoptive parent from April 2022 to Nov 2023.
--			   On 12/12/2023 suspension was created on this adoption for 11/30/2023 to 12/01/2023
--             Issue: System has created the AR  correctly but linked to current provider (AR data issue). 
-- Fix Provided: DataFix has been promoted to fix the AR balances.
--				 Jessica Freeman (5020983): $82.35 and William Boggs (6005837): $27.45
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Fix Overpayment balance (CDM-38488)

-- Current Provider ID: 5020983	(Jessica Anne Freeman)
select receivable_id, provider_id, balance_no, update_user_id, update_ts  
	from tb_receivable_header 
where receivable_id = 1251398
	and delete_sw = 'N';

update tb_receivable_header
set provider_id = 5020983, 
	update_ts = now(), -- 2023-12-12 19:19:38.718
	update_user_id = 'CDM-38488' -- finance
where receivable_id = 1251398
	and delete_sw = 'N'	;
	
-- Prior Provider ID: 6005837 (WIlliam Howard Boggs)
-- Add Receivable Header 	
INSERT INTO cjams.tb_receivable_header
	(	receivable_id, provider_id, balance_no, receivable_original_amount_no, written_off_amount_no, 
		create_user_id, update_user_id, delete_sw, create_ts, update_ts, etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_receivable_header'::regclass), 6005837, 27.45, 27.45, NULL, 
		'CDM-38488', 'CDM-38488', 'N', now(), now(), NULL, NULL
	);
	
select receivable_id, receivable_balance_no, update_ts, update_user_id  
	from tb_receivable_detail
where receivable_detail_id = 1739447
	and delete_sw = 'N';
	
update tb_receivable_detail
set receivable_id = (select receivable_id from tb_receivable_header where provider_id = 6005837 and delete_sw  = 'N'),
	update_ts = now(), 
	update_user_id = 'CDM-38488'
where receivable_detail_id = 1739447
	and delete_sw = 'N';
	
INSERT INTO cjams.tb_payment_plan
	(	payment_plan_id, plan_dt, 
		receivable_id, 
		amount_no, percentage_no, months_no, start_dt, end_dt, offset_sw, payment_option_sw, offset_option_sw, 
		manual_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw, 
		current_receivable_amount, etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_payment_plan'::regclass), '2023-12-12', 
		(select receivable_id from tb_receivable_header where provider_id = 6005837 and delete_sw  = 'N'), 
		27.45, 100.00, NULL, '2023-12-12', NULL, NULL, 'A', NULL, 
		'N', now(), 'CDM-38488', now(), 'CDM-38488', 'N', 
		27.45, NULL, NULL
	);


-- Update Provider AR Balances & Payment Plan		   
-- Current Provider ID: 5020983	(Jessica Anne Freeman)
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
	and rh.receivable_id = 1251398 ;
	
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
	update_user_id = 'CDM-38488'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1251398 ;
		 
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
	and pp.receivable_id = 1251398 ;
	
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
	update_user_id = 'CDM-38488'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1251398 ;
	
	
-- Prior Provider ID: 6005837 (WIlliam Howard Boggs)	
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
	and rh.receivable_id = (select receivable_id from tb_receivable_header where provider_id = 6005837 and delete_sw  = 'N')	 ;
	
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
	update_user_id = 'CDM-38488'
where rh.delete_sw = 'N'  
	and rh.receivable_id = (select receivable_id from tb_receivable_header where provider_id = 6005837 and delete_sw  = 'N')	 ;
		 
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
	and pp.receivable_id = (select receivable_id from tb_receivable_header where provider_id = 6005837 and delete_sw  = 'N')	 ;
	
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
	update_user_id = 'CDM-38488'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = (select receivable_id from tb_receivable_header where provider_id = 6005837 and delete_sw  = 'N')	 ;
	
