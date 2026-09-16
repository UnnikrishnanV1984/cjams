/*
 * CJAMS-58922 - Child Account COC entered in error
 * Customer Email ID: catherine.gray@maryland.gov
 * Focus Area: Child Account
 * Identified As:User Error, All receipts entered beginning with benefit month November 2024 have been entered incorrectly which is why the balance is negative. 
 * client id 2570550.
 * Category/ Module: Child Account
 * Root cause: User Error
 * Fix Provided: Datafix has been promoted to remove below transections and updated the total amount.
 */
/*
1550750 4/2/2025 4/1/2025 Receipts Other (Cost Of Care) Credit $792.30
1549627 4/1/2025 11/1/2024 Automatic Charge COC Payments Debit $868.70
1545100 3/12/2025 11/1/2024 Adjustments Bank Service Charges Debit $773.70
1545099 3/12/2025 11/1/2024 Receipts Other (Cost Of Care) Credit $773.70
1544899 3/12/2025 11/1/2024 Adjustments Bank Service Charges Debit $95.00
1544998 3/12/2025 11/1/2024 Receipts Other (Cost Of Care) Credit $95.00

1549719 4/1/2025 2/1/2025 Automatic Charge COC Payments Debit $98.00
1549629 4/1/2025 1/1/2025 Automatic Charge COC Payments Debit $98.00
1549628 4/1/2025 12/1/2024 Automatic Charge COC Payments Debit $98.00
1545066 3/12/2025 2/1/2025 Receipts Other (Cost Of Care) Credit $98.00
1545032 3/12/2025 1/1/2025 Receipts Other (Cost Of Care) Credit $98.00
1544999 3/12/2025 12/1/2024 Receipts Other (Cost Of Care) Credit $98.00
*/

/*
select credit_debit_sw,delete_sw ,comm_acct_trans_id ,* from tb_account_transaction where transaction_id in
('1550750',
'1549627',
'1545100',
'1545099',
'1544899',
'1544998');--773.70
*/

update tb_account_transaction
	set update_ts =  now(),
		update_user_id = 'CJAMS-58922',
		delete_sw = 'Y'
where transaction_id in
	('1550750',
	'1549627',
	'1545100',
	'1545099',
	'1544899',
	'1544998',
	'1549719', --new records from here          
	'1549629',        
	'1549628',       
	'1545066',            
	'1545032',        
	'1544999')	
and delete_sw = 'N';

--select * from tb_client_account tca where client_id ='2570550' and delete_sw = 'N'; --1028782

-- Update Obligated for Ancillary
update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 1028782
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
	update_user_id = 'CJAMS-58922'
where ta.client_account_id = 1028782
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
	update_user_id = 'CJAMS-58922'
where ta.client_account_id = 1028782
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-58922'
where ta.client_account_id = 1028782
	and ta.delete_sw = 'N' ;



--  Commigled Account
-- Update Commingled Account Balance

/*
select comm_account_id, client_id, client_account_id, 
	total_balance_no, obligated_for_anc,obligated_for_coc, available_balance_no, 
	comm_account_id, county_cd	
from tb_client_account 
where client_account_id = 1028782
	and delete_sw = 'N' ;
*/

update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 360
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CJAMS-58922'
where comm_account_id = '282'
	and delete_sw = 'N' ;

-- Funding source allocation
--select * from tb_fund_allocation_detail where payment_detail_id in ('5859300','5929288','5905804','5879409')

update tb_fund_allocation_detail
set delete_sw = 'Y',
	update_user_id = 'CJAMS-58922',
	update_ts = now()
where payment_detail_id in ('5859300','5929288','5905804','5879409') and delete_sw = 'N'; -- 5929288 not in allocation details but in master

-- allocation master from allocation details
/*
select * from tb_fund_allocation_master where payment_detail_id in ('5859300');
select * from tb_fund_allocation_master where payment_detail_id in ('5929288','5905804','5879409')
*/


/*
INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(1829403, 0, 5859300, '2025-03-31', 34996.00, '2106', 0.00, 0.00, 868.70, 17063.65, 17063.65, 0, 0, 'N', 'N', '2025-01-01 00:15:01.732', 'finance', '2025-04-01 00:15:02.389', 'finance', '2913', NULL, NULL);
INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(1832039, 0, 5879409, '2025-03-31', 83452.00, '2106', 0.00, 0.00, 98.00, 41677.00, 41677.00, 0, 0, 'N', 'N', '2025-02-01 00:15:01.580', 'finance', '2025-04-01 00:15:02.389', 'finance', '2913', NULL, NULL);
INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(1834933, 0, 5905804, '2025-03-31', 83452.00, '2106', 0.00, 0.00, 98.00, 41677.00, 41677.00, 0, 0, 'N', 'N', '2025-03-01 00:15:01.713', 'finance', '2025-04-01 00:15:02.389', 'finance', '2913', NULL, NULL);
INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(1838354, 0, 5929288, '2025-03-31', 26920.00, '2106', 0.00, 0.00, 98.00, 13411.00, 13411.00, 0, 0, 'Y', 'N', '2025-04-01 00:15:02.389', 'finance', '2025-04-01 00:15:02.389', 'finance', '2913', NULL, NULL);
*/

--5859300
UPDATE cjams.tb_fund_allocation_master
SET fund_allocation_date='2024-12-31', payment_detail_id=5859300, payment_amount=34996.00, fiscal_category_cd='2106', ssi_funding_amt=0.00, ssa_funding_amt=0.00, coc_funding_amt=0.00, state_funding_amt=17498.00, ive_funding_amt=17498.00, ivd_funding_amt=0, local_funding_amt=0, initial_stamping_sw='Y', delete_sw='N', create_ts='2025-04-01 00:15:02.389', create_user_id='finance',
update_ts=now(), update_user_id='CJAMS-58922', eligibility_status_cd='2913', etl_userid=NULL, etl_load_date=NULL
WHERE fund_alloc_id=1829403;

--select * from tb_fund_allocation_detail where payment_detail_id in ('5929288','5905804','5879409')
--5879409
UPDATE cjams.tb_fund_allocation_master
SET fund_allocation_date='2025-01-31', payment_detail_id=5879409, payment_amount=83452.00, fiscal_category_cd='2106', ssi_funding_amt=0.00, ssa_funding_amt=0.00, coc_funding_amt=0.00, state_funding_amt=41726.00, ive_funding_amt=41726.00, ivd_funding_amt=0, local_funding_amt=0, initial_stamping_sw='Y', delete_sw='N', create_ts='2025-04-01 00:15:02.389', create_user_id='finance', update_ts=now(), update_user_id='CJAMS-58922', eligibility_status_cd='2913', etl_userid=NULL, etl_load_date=NULL
where fund_alloc_id=1832039;

--5905804
UPDATE cjams.tb_fund_allocation_master
SET fund_allocation_date='2025-02-28', payment_detail_id=5905804, payment_amount=83452.00, fiscal_category_cd='2106', ssi_funding_amt=0.00, ssa_funding_amt=0.00, coc_funding_amt=0.00, state_funding_amt=41726.00, ive_funding_amt=41726.00, ivd_funding_amt=0, local_funding_amt=0, initial_stamping_sw='Y', delete_sw='N', create_ts='2025-04-01 00:15:02.389', create_user_id='finance', update_ts=now(), update_user_id='CJAMS-58922', eligibility_status_cd='2913', etl_userid=NULL, etl_load_date=NULL
WHERE fund_alloc_id=1834933;

--select ive_funding_amt,state_funding_amt,* from tb_fund_allocation_master where fund_alloc_id = '1838354'
-- 5929288
UPDATE cjams.tb_fund_allocation_master
set coc_funding_amt = 0,
	update_ts = now(),
	update_user_id = 'CJAMS-58922',
	state_funding_amt = payment_amount / 2,
	ive_funding_amt =  payment_amount / 2
where fund_alloc_id = '1838354'
and delete_sw = 'N';