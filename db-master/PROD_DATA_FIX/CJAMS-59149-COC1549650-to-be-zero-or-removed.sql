/*
 * CJAMS-59149 - Child Account COC entered in error
 * Customer Email ID: janet.adetunji1@maryland.gov
 * Focus Area: Child Account
 * Identified As:User Error, Client ID #1050839, transaction #1549650, COC, $967 needs to be removed or adjust to zero. 
 * Category/ Module: Child Account
 * Root cause: User Error
 * Fix Provided: Datafix has been promoted to remove below transections and updated the total amount.
 */

/*
select credit_debit_sw,delete_sw ,comm_acct_trans_id ,* from tb_account_transaction where transaction_id ='1549650';--clientacc: 10084
select comm_account_id,* from tb_client_account where client_account_id = '10084'; --clientid: 1050839
*/

update tb_account_transaction
	set update_ts =  now(),
		update_user_id = 'CJAMS-59149',
		delete_sw = 'Y'
where transaction_id = '1549650'
and delete_sw = 'N';

--select * from tb_client_account tca where client_id ='2570550' and delete_sw = 'N'; --10084

-- Update Obligated for Ancillary
update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 10084
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
	update_user_id = 'CJAMS-59149'
where ta.client_account_id = 10084
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
	update_user_id = 'CJAMS-59149'
where ta.client_account_id = 10084
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-59149'
where ta.client_account_id = 10084
	and ta.delete_sw = 'N' ;

-- NO Commigled Account hence no need to update
-- Update Commingled Account Balance
/*
select comm_account_id, client_id, client_account_id, 
	total_balance_no, obligated_for_anc,obligated_for_coc, available_balance_no, 
	comm_account_id, county_cd	
from tb_client_account 
where client_account_id = 10084
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

--select * from tb_fund_allocation_master tfam where payment_detail_id = '5929261' and delete_sw = 'N' --SW delete = y
--select * from tb_fund_allocation_detail tfad  where payment_detail_id = '5929261' and delete_sw = 'N' --SW delete = y
--17498.00

/*
INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(1836762, 0, 5929261, '2025-03-31', 18019.68, '7177', 967.00, 0.00, 0.00, 17052.68, 0.00, 0, 0, 'Y', 'N', '2025-04-01 00:15:02.389', 'finance', '2025-04-01 00:15:02.389', 'finance', '2914', NULL, NULL);
*/

update tb_fund_allocation_master
set ssi_funding_amt = 0,
	update_user_id = 'CJAMS-59149',
	state_funding_amt = state_funding_amt + 967,
	update_ts = now()
where payment_detail_id = '5929261' and delete_sw = 'N';