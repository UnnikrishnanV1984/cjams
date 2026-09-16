-- Category/ Module: GAP (Case Management) 
-- Root cause: These 2 GAP cases were created with the Private Provider (This was an issue in CJAMS back in 2021) and these wrong ARs are for those Private Providers.
-- The GAP records were fixed with the following tickets:
-- CDM-11716 – 5036072 Parker Therapeutic Services - Baltimore - CPA Office - GAP ID 1005632
-- 5036071    Private Organization - receivable_id: 230043
-- CDM-13228 – 5000553 Associated Catholic Charities, TFC, Baltimore - CPA Office - GAP ID 1005654
-- 5000543    Private Organization - receivable_id: 229504

-- Fix Provided: Datafix has been promoted to move the Account receivables to the associated Private Organizations.
-- Pull request# N/A 
-- Is Code fix Required?: No
--    Code fix ticket#: N/A
--    Reason why no related code fix: This issue was fixed back in 2021.
--  Regression Impacts: N/A

/*
select rd.receivable_id, 
    rd.receivable_detail_id,
    rd.receivable_balance_no, 
    rh.provider_id as rec_provider_id, 
    f_pdesc(f_prvpcklst_cat(rh.provider_id::bigint,'PLACEMENT'), 155) as rec_prov_category,
    ph.provider_id as pay_provider_id,
    f_pdesc(f_prvpcklst_cat(ph.provider_id::bigint,'PLACEMENT'), 155) as pay_prov_category,
    pd.payment_detail_id,
    pd.payment_id,
     pd.final_service_id,
    pd.placement_id,
    pd.subsidy_agreement_id
from tb_receivable_header rh,
    tb_receivable_detail rd,
    tb_payment_detail pd,
    tb_payment_header ph 
where rh.receivable_id = rd.receivable_id 
    and rd.payment_detail_id = pd.payment_detail_id 
    and pd.payment_id = ph.payment_id 
    and rh.delete_sw = 'N'
    and rd.delete_sw = 'N'
    and pd.delete_sw = 'N'
    and ph.delete_sw = 'N'
    and rh.provider_id <> ph.provider_id 
    -- Unit Test
     --and rh.receivable_id = 1245075 -- 5000553    Associated Catholic Charities, TFC, Baltimore
     and rh.receivable_id = 1245029 -- 5036072    Parker Therapeutic Services - Baltimore
    ;
    
-- 5036071    Private Organization - receivable_id: 230043
-- 5000543    Private Organization - receivable_id: 229504

select * from tb_receivable_header trh where provider_id = 5036072;--1245029
select * from tb_receivable_detail trh where receivable_id  = 1245029;--1245029--->230043
select * from tb_receivable_header trh where provider_id = 5036071;--230043
*/

/*
5036071    Private Organization - receivable_id: 230043
5000543    Private Organization - receivable_id: 229504
*/
-- 1. Update tb_receivable_detail from OLD 1245029 reciable Id ---> 230043 NEW receivale id

update tb_receivable_detail 
set receivable_id = 230043, --1245029
	update_ts = now(),
	update_user_id = 'CIDM-10424'
where receivable_detail_id in(1718301,1718300,1718302)
	and delete_sw  = 'N'
	and receivable_id  = 1245029;
	

-- 2.Update Provider AR Balances & Payment Plan		   
-- Current Provider ID: 5036072 with receivable id 1245029 calculation
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
	update_user_id = 'CIDM-10424'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1245029 ;
		 
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
	update_user_id = 'CIDM-10424'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1245029 ;
	

-- Update Provider AR Balances & Payment Plan		   
-- NEW Provider ID 5036071: reciable ID 230043 re-Calcualtion
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
	update_user_id = 'CIDM-10424'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 230043 ;
		 
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
	update_user_id = 'CIDM-10424'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 230043 ;
	

/*
 * second provider 
*/
/*
5036071    Private Organization - receivable_id: 229504
5000543    Private Organization - receivable_id: 229504
*/

-- 1. Update tb_receivable_detail from OLD 1245075 reciable Id ---> 229504 NEW receivale id

update tb_receivable_detail 
set receivable_id = 229504, --1245075
	update_ts = now(),
	update_user_id = 'CIDM-10424'
where receivable_detail_id in(1718583,1718584,1718582,1718581)
	and delete_sw  = 'N'
	and receivable_id  = 1245075;
	
-- 2.Update Provider AR Balances & Payment Plan		   
-- Current Provider ID: 
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
	update_user_id = 'CIDM-10424'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1245075 ;
		 
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
	update_user_id = 'CIDM-10424'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1245075 ;
	

-- Update Provider AR Balances & Payment Plan		   
-- NEW Provider ID: 229504
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
	update_user_id = 'CIDM-10424'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 229504 ;
		 
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
	update_user_id = 'CIDM-10424'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 229504 ;
	