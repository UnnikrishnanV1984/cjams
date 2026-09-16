-- CDM-41506 - Overpayment for the provider occurred
/*
-- Issue Description: 
   To fix GAP case, delete child removal, OOH and GAP Suspension & ARs - User error 

-- Case ID: 3288170
-- Client ID: 4404116 (MASSIYA PAYNE) - 72235472-1849-4e3c-aedc-1704bddc64cc
-- Removal ID: 321233	2019-03-19 00:00:00		b151bbe8-35ce-4e43-929b-a2fe7eb7463e
-- OOH					2019-03-19 00:00:00		4b929696-e68c-4ba7-bb7b-43049f252cde
-- GAP ID: 1005864 - 2021-09-27 To 2040-03-18 - a84b78fd-f3d6-41b1-a286-87ed73ff898c
-- GAP Suspension: d6c2e784-eaf6-47ad-a9e6-58d8f33986d2	COHP	2019-04-19 00:00:00
-- Provider ID: 5094439	(Lawrence Donnell Wallace-powell)
-- receivable_id: 1254627 - $30473.87

-- Category/ Module: GAP (Case Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the child removal, OOH and GAP Suspension & ARs
-- Pull request# N/A 
-- Is Code fix Required?: No
--	Code fix ticket#: N/A
--	Reason why no related code fix: User error 
--  Regression Impacts: N/A
*/

-- To fix GAP case (CDM-41506) 

-- 1. Remove the Child Removal with start date as 03/19/2019
update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-41506',
	updatedon = now()
where intakeservreqchildremovalid = 'b151bbe8-35ce-4e43-929b-a2fe7eb7463e' 
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CDM-41506',
	updatedon = now()
where intakeservreqchildremovalid = 'b151bbe8-35ce-4e43-929b-a2fe7eb7463e' 
	and activeflag = 1;

update routing
set activeflag = 0,
	updatedby = 'CDM-41506',
	updatedon = now()
where objectid = 'b151bbe8-35ce-4e43-929b-a2fe7eb7463e'
	and activeflag = 1; 
	

update tb_client_eligibility 
set delete_sw = 'Y', 
	update_ts = now(), 
	update_user_id = 'CDM-41506' 
where removal_id = 321233
	and delete_sw = 'N' ;	
	
-- 2. Remove the OOH program assignment with start date as 03/19/2019
update personprogramarea 
set activeflag = 0, 
	updatedby = 'CDM-41506', 
	updatedon = now() 
where personprogramid = '4b929696-e68c-4ba7-bb7b-43049f252cde' 
	and activeflag = 1;
	
	
-- 3. Remove the suspension with start date as 04/19/2019
update gapsuspension
set activeflag = 0,
	updatedby = 'CDM-41506', 
	updatedon = now() 
where gapsuspensionid = 'd6c2e784-eaf6-47ad-a9e6-58d8f33986d2'
	and activeflag = 1 ;

update gapsuspensionrevision
set activeflag = 0,
	updatedby = 'CDM-41506', 
	updatedon = now() 
where suspensionid = 'd6c2e784-eaf6-47ad-a9e6-58d8f33986d2'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-41506', 
	updatedon = now() 
where objectid = 'd6c2e784-eaf6-47ad-a9e6-58d8f33986d2'
	and eventcode = 'GASR'
	and activeflag = 1 ;

-- 4. Remove the provider Account Receivable (overpayment) records - balance will be zero
--    Provider ID: 5094439 (Lawrence Wallace-powell)

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-41506'
where delete_sw = 'N'
	and receivable_detail_id 
	in ( select receivable_detail_id
			from tb_receivable_detail
		 where receivable_id = 1254627
			and receivable_ts::date = '2024-08-08'::date
			and delete_sw = 'N'
		);
	
update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-41506'
where receivable_id = 1254627
	and receivable_ts::date = '2024-08-08'::date
	and delete_sw = 'N' ;
	
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
	update_user_id = 'CDM-41506'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1254627 ;
		 
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
	update_user_id = 'CDM-41506'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1254627 ;

-- Delete AR  Ticker 
update tb_ticklers 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-41506'
where tickler_id  = 30166076 
	and delete_sw  = 'N' ;	

