-- CDM-24422 - Selina Houston Accounts Receivable 5087885
/*
-- Issue Description: 
   Dupliacte Accounts Receivable for Provider Selina Houston for the same months. 
   Only one line should be showing per month. From February 2022 to July 2022. 
      
-- Case ID: 3272009
-- Client ID: 3790440 (JUELZ WESCOTT) - d00f7c4c-8c4b-46d4-92fe-9c867ce97123
-- GAP ID: 4980 - 2018-09-19 To 2032-05-27 - d68b9e85-3635-40d3-843d-8af1d0eb37ab
-- Provider ID: 5087885	(Selina Houston) - Local Department Home
  
-- Category/ Module: Accounts Receivables (Finance Management) 
-- Root cause: Under/Over batch was having flaw in calculating the current balance (sp_get_current_balance)
			   Code fix was promoted as a part of this defect.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next prod deployment
*/

-- Receivable ID: 1245169
/*
--	Rec 	AR 		Payment 
--	Detl ID Amount	Detail ID
-----------------------------------------------------
	1723084	152.83	4426380		2022-07-01	2022-07-31
	1723083	147.90	4409882		2022-06-01	2022-06-30
	1723082	152.83	4392709		2022-05-01	2022-05-31
	1723081	147.90	4375605		2022-04-01	2022-04-30
	1723080	152.83	4359577		2022-03-01	2022-03-31
*/

-- Data fix to delete ARs 
select collection_status_id, collection_status_cd, collection_status_dt, delete_sw, update_ts, update_user_id 
	from tb_receivable_collection_status 
where delete_sw = 'N'
	and receivable_detail_id in (1723084, 1723083, 1723082, 1723081, 1723080) ;

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24422'
where delete_sw = 'N'
	and receivable_detail_id in (1723084, 1723083, 1723082, 1723081, 1723080) ;
		

select receivable_detail_id, payment_detail_id, delete_sw, update_ts, update_user_id 
	from tb_receivable_detail 
where delete_sw = 'N'
	and receivable_detail_id in (1723084, 1723083, 1723082, 1723081, 1723080) ;

update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24422'
where delete_sw = 'N'
	and receivable_detail_id in (1723084, 1723083, 1723082, 1723081, 1723080) ;
		   
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
	and rh.receivable_id = 1245370 ;
	
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
	rh.update_user_id = 'CDM-24422'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1245370 ;
		 
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
	and pp.receivable_id = 1245370 ;
	
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
	pp.update_user_id = 'CDM-24422'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1245370 ;
