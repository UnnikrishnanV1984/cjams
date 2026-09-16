-- CDM-18281 - Overpayment Letter for Center for Social change
/*
-- Issue Description: 
   Invalid A/Rs created on 11/05/2021 for 5001682 (Center for Social Change, Inc)
   
-- Case ID: 3088681
-- Client ID: 1558295 (SHANE H WEDDING) - a12a4dba-ee73-48e0-a793-11e1d458f6fe
-- Client ID: 2387846 (JESSICA DOVE	HARRIS) - adbea036-0ace-42e8-adef-9819ea4875d4

-- Private Organization: 5001682 (Center for Social Change, Inc)
-- Contract ID: 50000079 
-- Program: 50002439 (9806 Marriottsville Rd. Randallstown, MD 21133)

-- Category/ Module: Accounts Receivables (Finance Management) 
-- Root cause: User error (Wrong Contract Program Rate entry on the Provider Module) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Contract Program Rate Fix

-- Delele 215009148 & 215009001 - $444.26
select program_rate_id, per_diem_rate_no, start_dt, end_dt, rate_status, update_ts, update_user_id, delete_sw 
	from prov.tb_prov_program_rates
where program_id = 50002439
	and program_rate_id in (215009148, 215009001)
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-18281'
where program_id = 50002439
	and program_rate_id in (215009148, 215009001)
	and delete_sw = 'N' ;

-- Update 215008910 End date as 2021-06-30 & update rate status as Active
select program_rate_id, per_diem_rate_no, start_dt, end_dt, rate_status, update_ts, update_user_id, delete_sw 
	from prov.tb_prov_program_rates
where program_id = 50002439
	and program_rate_id = 215008910
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates
set end_dt = '2021-06-30',
	rate_status = 'Active',
	update_ts = now(),
	update_user_id = 'CDM-18281'
where program_id = 50002439
	and program_rate_id = 215008910
	and delete_sw = 'N' ;

-- Receivable ID: 234861
/*
--	Rec 	AR 		Payment 
--	Detl ID Amount	Detail ID
-----------------------------------------------------
1720137	1162.50	4218394	2021-07-01	2021-07-31
1720138	1162.50	4218393	2021-07-01	2021-07-31
*/
-- Total AR:   $2325.00

-- Data fix to delete ARs 
select collection_status_id, collection_status_cd, collection_status_dt, delete_sw, update_ts, update_user_id 
	from tb_receivable_collection_status 
where delete_sw = 'N'
	and receivable_detail_id in ( 1720137, 1720138 ) ;

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-18281'
where delete_sw = 'N'
	and receivable_detail_id in ( 1720137, 1720138 ) ;

select receivable_detail_id, payment_detail_id, delete_sw, update_ts, update_user_id 
	from tb_receivable_detail 
where delete_sw = 'N'
	and receivable_detail_id in ( 1720137, 1720138 ) ;

update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-18281'
where delete_sw = 'N'
	and receivable_detail_id in ( 1720137, 1720138 ) ;
		   
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
	and rh.receivable_id = 234861 ;
	
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
	rh.update_user_id = 'CDM-18281'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 234861 ;
		 
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
	and pp.receivable_id = 234861 ;
	
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
	pp.update_user_id = 'CDM-18281'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 234861 ;

