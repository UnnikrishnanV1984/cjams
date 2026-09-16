-- CDM-16801 - Payments
/*
-- Issue Description: 
   Adoption Subsidy Payments are on Hold and still going to old Provider
   
-- Case ID: 3136325
-- Client ID: 1691738 (TAYLOR-LEE MORIAH JOR NEAL) - a6a7a0e6-c72e-4cef-99c4-c68f59e67d35
-- Adoption ID: 11500 - 2002-06-03 To 2021-11-25 - c6c07dc8-49d0-4e4f-ae96-833549f01937
-- Old Provider ID: 5026549	(Leroy Neal)
-- New Provider ID: 6001926	(KAREN S Jackson)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Exception scenario, user has changed the Provider on Agreement after the rate apporval 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete All On HOLD Payments for the old Provider
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id
		in ( 3078818, 3066267, 3053524, 3041225, 3028676, 3017285, 3005176, 2994048, 2987527, 2971663, 2987526 )
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16801'
where payment_id 
		in ( 3078818, 3066267, 3053524, 3041225, 3028676, 3017285, 3005176, 2994048, 2987527, 2971663, 2987526 )
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id 
		in ( 3078818, 3066267, 3053524, 3041225, 3028676, 3017285, 3005176, 2994048, 2987527, 2971663, 2987526 )
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16801'
where payment_id 
		in ( 3078818, 3066267, 3053524, 3041225, 3028676, 3017285, 3005176, 2994048, 2987527, 2971663, 2987526 )
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id 
		in ( 3078818, 3066267, 3053524, 3041225, 3028676, 3017285, 3005176, 2994048, 2987527, 2971663, 2987526 )
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16801'
where payment_id 
		in ( 3078818, 3066267, 3053524, 3041225, 3028676, 3017285, 3005176, 2994048, 2987527, 2971663, 2987526 )
	and delete_sw = 'N' ;
	

-- Delete corresponding one AR
select receivable_detail_id, receivable_id, payment_detail_id, amount_no , delete_sw, update_ts, update_user_id 
	from tb_receivable_detail 
where receivable_detail_id  = 1717502
	and delete_sw  = 'N' ;

update tb_receivable_detail
set  delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16801'
where receivable_detail_id  = 1717502
	and delete_sw  = 'N' ;
	
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
	rh.update_user_id = 'CDM-16801'
where rh.receivable_id = 1244977
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
	pp.update_user_id = 'CDM-16801'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1244977 ;
	
-- Update Provider ID
select activeflag, startdate, enddate, provider_id, approvaldate, approvalstatustypekey, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '05510701-7259-4975-acee-0fddcbeb6e25'
and adoptionrevisionid 
	in (	'17101acd-b937-47c5-887f-7798796e78fa',
			'f8cd34a0-c1cc-46f1-929f-c324711e985a',
			'fbd5ac75-7c7d-45a8-9db6-1791ab89c824'
		) ;

Update adoptioncaserevision
set provider_id	= 6001926,
	updatedby = 'CDM-16801',
	updatedon = now()	
where adoptionagreementid = '05510701-7259-4975-acee-0fddcbeb6e25'
and adoptionrevisionid 
	in (	'17101acd-b937-47c5-887f-7798796e78fa',
			'f8cd34a0-c1cc-46f1-929f-c324711e985a',
			'fbd5ac75-7c7d-45a8-9db6-1791ab89c824'
		) ;
		
-- Update Provider ID
select activeflag, startdate, enddate, provider_id, paymentamout, approvaldate, status, updatedby, updatedon 
	from adoptioncaseagreementrate 
where adoptionagreementid = '05510701-7259-4975-acee-0fddcbeb6e25'
	and adoptionagreementrateid  = 'bc7ea8b1-c55b-436d-8f99-3f7d3d35d2f5' ;
	
update adoptioncaseagreementrate
set provider_id	= 6001926,
	updatedby = 'CDM-16801',
	updatedon = now()		
where adoptionagreementid = '05510701-7259-4975-acee-0fddcbeb6e25'
	and adoptionagreementrateid  = 'bc7ea8b1-c55b-436d-8f99-3f7d3d35d2f5' ;
