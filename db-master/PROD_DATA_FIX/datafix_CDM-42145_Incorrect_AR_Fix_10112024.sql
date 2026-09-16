-- CDM-42145 Incorrect A/R Balance
/*
-- Issue Description: 
   Incorrect A/R Balance fix

-- Case ID: 3146683
-- Client ID: 1788396 (ALEATHIA	L CONNER) - ebd9afcc-69b0-4425-a4e8-e85cd562201a
-- Provider ID: 5095279	(Robin Perry) - Receivable ID: 1247812
-- GAP ID: 1005654 - 0af83a14-0496-4696-ac17-789c9fd353c3	

-- Category/ Module: GAP (Case Management) 
-- Root cause: This GAP case was created with the Private Provider ( This was an issue in CJAMS back in 2021) 
		       and the system has generated the GAP payments as well for Jan, Feb, March & April 2021 services.
			   Datafix has been promoted to change the GAP to Public Provider (CDM-13228)	
			   These wrong ARs are for that Private Provider.
-- Fix Provided: Datafix has been promoted to delete the Incorrect A/R.
-- Pull request# N/A 
-- Is Code fix Required?: No
--	Code fix ticket#: N/A
--	Reason why no related code fix: This issue was fixed back in 2021.
--  Regression Impacts: N/A
*/

-- To fix Incorrect A/R Balance (CDM-42145) 
-- Provider ID: 5095279	(Robin Perry)

-- provider_id	provider_id	receivable_detail_id	payment_detail_id	receivable_id	amount_no
-- 5095279		5000543		1729103					4150068				1247812			18.29
-- 5095279		5000543		1729104					4165884				1247812			17.70

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-42145'
where receivable_detail_id in (1729103, 1729104)
	and delete_sw = 'N';
	
update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-42145'
where receivable_detail_id in (1729103, 1729104)
	and delete_sw = 'N';
	
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
	update_user_id = 'CDM-42145'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1247812 ;
		 
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
	update_user_id = 'CDM-42145'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1247812 ;

