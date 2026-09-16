/*
 * CJAMS-59149 - Child Account COC entered in error
 * Customer Email ID: mindy.pearmon@maryland.gov
 * Focus Area: Child Account
 * Identified As:User Error, Client ID: 3459979 (NASEER ABDURRAHIM),Child Account: 4670475201 - Conserved - Active
 1580206 & 1580635 - update amount from $715.20 to $238.40. Also, Funding Source Allocation Details - Payment Detail ID# 6038676:
    1) Change the SSA amount from $715.20 to $238.40
    2) Change the State amount from $12,288.60 to $12,765.40
 * Category/ Module: Child Account
 * Root cause: User Error
 * Fix Provided: Datafix has been promoted to remove below transections and updated the total amount.
 */
/*
select credit_debit_sw,delete_sw ,comm_acct_trans_id ,* from tb_account_transaction 
where transaction_id in ('1580206', '1580635');--clientacc: 1041586

select comm_account_id,* from tb_client_account where client_account_id = '1041586'; --clientid: 3459979 
*/

update cjams.tb_account_transaction 	
	set transaction_amount_no = 238.4,
		update_user_id = 'CJAMS-62059',
		update_ts = now()
where transaction_id in ('1580206', '1580635')--clientacc:1041586
	and delete_sw = 'N' ;

-- Update Obligated for Ancillary
update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 1041586
							and tr.delete_sw = 'N'
							and tr.authorization_id is not null
							and (select count(*)
									from tb_payment_header ph
								 where ph.authorization_id = tr.authorization_id
									and ph.delete_sw = 'N'
								) = 0 
							and (select count(*)
									from routing ro
								 where ro.objectid::character varying = tr.authorization_id::character varying
									and ro.activeflag = 1
									and ro.routingstatustypeid = '62'
								) = 0
					)
	),	
	update_ts = now(),
	update_user_id = 'CJAMS-62059'
where ta.client_account_id = 1041586
and ta.delete_sw = 'N' ;


update tb_client_account ta
set total_balance_no = 
	(
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		),0)	   
		- 
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		),0)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)
		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)
		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CJAMS-62059'
where ta.client_account_id = 1041586
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-62059'
where ta.client_account_id = 1041586
	and ta.delete_sw = 'N' ;

-- NO Commigled Account hence no need to update
-- Update Commingled Account Balance
/*
select comm_account_id, client_id, client_account_id, 
	total_balance_no, obligated_for_anc,obligated_for_coc, available_balance_no, 
	comm_account_id, county_cd	
from tb_client_account 
where client_account_id = 1041586
	and delete_sw = 'N' ;

update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 360
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CJAMS-59149'
where comm_account_id = '282'
	and delete_sw = 'N' ;
*/	


/*
 * updating the FUnding source allocation.
select ssa_funding_amt ,state_funding_amt ,* from tb_fund_allocation_master tfam where payment_detail_id = '6038676' and delete_sw = 'N' --SW delete = y
select ssa_funding_amt ,state_funding_amt ,* from tb_fund_allocation_detail tfad  where payment_detail_id = '6038676' and delete_sw = 'N' --SW delete = y
*/

update tb_fund_allocation_master 
set state_funding_amt = 12765.4,
	ssa_funding_amt =238.4,
	update_user_id = 'CJAMS-62059',
	update_ts = now()
where payment_detail_id = '6038676' and delete_sw = 'N'