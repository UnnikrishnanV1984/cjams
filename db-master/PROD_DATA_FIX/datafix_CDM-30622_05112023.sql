-- CDM-30622 - DHS 111 Missing AR; Not equal to Applicaiton AR Balance
/*
-- Issue Description: 
   To update the AR balance of Provider ID: 6005765	(ANGELA Ayers BEASLEY)
      
-- CASE ID: 211030009218
-- Provider ID: 6005765	(ANGELA Ayers BEASLEY)- Local Department Home
-- Client ID: 200780827	(Cheyanne Locklear) - eb19c05b-1f6b-40bc-8d60-17dc40317b14
-- Voided Placement - Placement ID: 1572468 - Emergency Foster Home Care
-- Enrty Date: 04/20/2022 Voided on 03/28/2023 - Payments: April 2022 to Oct 2022 (ARs complete period)
  
-- Category/ Module: Accounts Receivables (Finance Management) 
-- Root cause: The wrong AR balalnce is due to, there was an issue in the code for Emergency Foster Home Care 
--    	Placement payments calculation logic, for which we have promoted the code fix in Dec 2022 (S20220336046213).
--		So, the in Dec 2022 the wrong/duplicate payment 3269750 - $1,146.24 was generated. 	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Receivable ID: 1245169
/*
receivable_detail_id, receivable_ts, 		payment_detail_id, start_dt, end_dt, amount_no
---------------------------------------------------------------------------------------------------------
	1728283			  2023-03-28 19:06:43	4495935				2022-06-01	2022-06-19	1146.24
	1724884			  2022-12-19 19:14:23	4402475				2022-06-01	2022-06-30	1146.24
	
payment_detail_id	final_service_start_dt	final_service_end_dt	final_amount_no	final_service_id	create_ts	
---------------------------------------------------------------------------------------------------------
4402475	2022-06-01	2022-06-19	573.12	13	2022-07-01 17:44:07.153
4495935	2022-06-01	2022-06-19	1146.24	13	2022-12-01 18:39:51.716
*/

-- Data fix to update the AR balance 
select receivable_detail_id, payment_detail_id, amount_no, receivable_balance_no, start_dt, end_dt, delete_sw, update_ts, update_user_id
	from tb_receivable_detail 
where delete_sw = 'N'
	and receivable_detail_id = 1728283;

update tb_receivable_detail
set amount_no = 573.12,
	receivable_balance_no = 0.00,
	payment_detail_id = 4402475,
	update_ts = now(),
	update_user_id = 'CDM-30622'
where delete_sw = 'N'
	and receivable_detail_id = 1728283;

select receivable_detail_id, payment_detail_id, amount_no, receivable_balance_no, start_dt, end_dt, delete_sw, update_ts, update_user_id
	from tb_receivable_detail 
where delete_sw = 'N'
	and receivable_detail_id = 1724884;

update tb_receivable_detail
set payment_detail_id = 4495935,
	update_ts = now(),
	update_user_id = 'CDM-30622'
where delete_sw = 'N'
	and receivable_detail_id = 1724884;		 
	
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
	and rh.receivable_id = 1245585 ;
	
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
	update_user_id = 'CDM-30622'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1245585 ;
		 
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
	and pp.receivable_id = 1245585 ;
	
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
	update_user_id = 'CDM-30622'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1245585 ;
