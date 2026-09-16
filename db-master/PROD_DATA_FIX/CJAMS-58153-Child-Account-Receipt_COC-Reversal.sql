-- CDM-41900 - Receipts posted in child account
/*
-- Issue Description: 
   Child Account CID#3517164 Desmond Bruton This ticket is to request the reversal of the Child Account transaction ID's listed below: 
   1542156 3/1/2025 Auto Chg-COC Payment $668.1542157 3/1/2025 Auto Chg-COC Payment $735.1542159 3/1/2025 Auto Chg-COC Payment $691.1542158 3/1/2025 
   Auto Chg-COC Payment $735.1540659 2/28/2025 Receipt SSI $668.1540662 2/28/2025 Receipt SSI $691.1540660 2/28/2025 Receipt SSI $735.1540661 2/28/2025 
   Receipt SSI $735.The system will not allow Finance worker to reverse the 2/28/2025 receipts as 'debit' entry, error message appears-fund negative. 
   Thus, data fix is needed to reverse/delete receipts and COC entries, that will also fix the related reports that reflect cost of care reimbursement.
   As a result of the above reversals/data fix, there is no affect on the CA balance. Worker Error- receipts entered as 'Available for Cost of Care' when they should have been entered as 'Availble for Ancillary'.
   Worker has already entered the funds as Avail for ANCL today 3/5/2025.
   
-- 1. Please delete below highlighted transaction (4 COC Payment & 4 Receipt SSI)
    1542156 3/1/2025 Auto Chg-COC Payment $668.
    1542157 3/1/2025 Auto Chg-COC Payment $735.
    1542159 3/1/2025 Auto Chg-COC Payment $691.
    1542158 3/1/2025 Auto Chg-COC Payment $735.
    1540659 2/28/2025 Receipt SSI $668.
    1540662 2/28/2025 Receipt SSI $691.
    1540660 2/28/2025 Receipt SSI $735.
    1540661 2/28/2025 Receipt SSI $735
-- Commigled Account ID: Yes
2. Need to remove/delete the SSI payment amount and the Re-Stamping as No for below Payment Detail ID in the Funding Source Allocation;
    2397794
    2416112
    2434741 
    2453087
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: CJAMS is not allowing the user to add cents to the Error Correction transaction amount column.
-- Fix provided: Datafix has been promoted to fix the Error Correction transaction amount. 
	Regression Impacts: Child Account Transaction Screen.
	Is Code fix Required?: Yes
	Code fix ticket#: No
	Reason why no related code fix: N/A
*/


/*
select * from tb_account_transaction tat where transaction_id in (
1542156,
1542157,
1542158,
1542159,
1540659,
1540660,
1540661,
1540662
) and delete_sw = 'N';
*/

--select * from tb_client_account tca where client_id = '3517164' 

--client_account_id: 13923

-- update delete switch = 'Y'
update cjams.tb_account_transaction 	
	set delete_sw  = 'Y',
		update_user_id = 'CJAMS-58153',
		update_ts = now()
where transaction_id in (
    1542156,
    1542157,
    1542158,
    1542159,
    1540659,
    1540660,
    1540661,
    1540662
)	and delete_sw = 'N' ;

-- Update Account Balance	
update tb_client_account ta
set obligated_for_anc = 
	 coalesce(( select sum(spa.cost_no) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 13923
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
	),0),	
	update_ts = now(),
	update_user_id = 'CJAMS-58153'
where ta.client_account_id = 13923
and ta.delete_sw = 'N' ;

-- Update Account Balance
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
	),0) + 565.80,
	update_ts = now(),
	update_user_id = 'CJAMS-58153'
where ta.client_account_id = 13923
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-58153'
where ta.client_account_id = 13923
	and ta.delete_sw = 'N' ;
   

-- Update Commingled Account Balance - NOT applicable 
/*select comm_account_id, bank_nm, total_balance_no, update_ts, update_user_id,*
    from cjams.tb_commingled_account  
where comm_account_id = 3
    and delete_sw = 'N' ;
 */                       
update cjams.tb_commingled_account
    set total_balance_no = ( select sum(coalesce(total_balance_no,0))
                                from cjams.tb_client_account
                             where comm_account_id = 3
                                and delete_sw = 'N' ),
        update_ts = now(),
        update_user_id = 'CJAMS-58153'
where comm_account_id = 3
    and delete_sw = 'N' ;


--PART B   
-- for 2397794
--select * from tb_fund_allocation_master where payment_detail_id = 2397794 ;-- ->update 
/*
 * actual value before fix
INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(534602, 0.00, 2397794, '2025-02-28', 5008.67, '7176', 668.00, 0.00, 0.00, 4340.67, 0.00, 0.00, 0.00, 'N', 'N', '2017-05-01 01:01:31.000', 'finance', '2025-03-01 00:15:01.713', 'finance', '2914', NULL, NULL);
*/

--select * from tb_fund_allocation_detail where payment_detail_id = 2397794;-- insert into tb_fund_allocation_master and

UPDATE cjams.tb_fund_allocation_master
SET fund_allocation_date='2017-04-30', payment_detail_id=2397794, payment_amount=5008.67, fiscal_category_cd='7176 ', ssi_funding_amt=0.00, ssa_funding_amt=0.00, coc_funding_amt=0.00, state_funding_amt=5008.67, ive_funding_amt=0.00, ivd_funding_amt=0.00, local_funding_amt=0.00, initial_stamping_sw='Y', delete_sw='N', create_ts='2025-03-01 00:15:01.713', create_user_id='finance', update_ts=now(), update_user_id='CJAMS-58153', eligibility_status_cd='2914', etl_userid=NULL, etl_load_date=NULL
WHERE fund_alloc_id =534602;

update tb_fund_allocation_detail
set delete_sw = 'Y',
	update_ts = now(),
    update_user_id = 'CJAMS-58153'
where payment_detail_id = 2397794
and delete_sw = 'N';  


--for 2416112
--select * from tb_fund_allocation_master where payment_detail_id = 2416112 ;-- ->update 
/*
INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(538547, 0.00, 2416112, '2025-02-28', 4847.10, '7176', 735.00, 0.00, 0.00, 4112.10, 0.00, 0.00, 0.00, 'N', 'N', '2017-06-01 01:05:58.000', 'finance', '2025-03-01 00:15:01.713', 'finance', '2914', NULL, NULL);
*/

--select * from tb_fund_allocation_detail where payment_detail_id = 2416112;-- insert into tb_fund_allocation_master and

UPDATE cjams.tb_fund_allocation_master
SET fund_allocation_date='2017-05-31', payment_detail_id=2416112, payment_amount=4847.10, fiscal_category_cd='7176 ', ssi_funding_amt=0.00, ssa_funding_amt=0.00, coc_funding_amt=0.00, state_funding_amt=4847.10, ive_funding_amt=0.00, ivd_funding_amt=0.00, local_funding_amt=0.00, initial_stamping_sw='Y', delete_sw='N', create_ts='2025-03-01 00:15:01.713', create_user_id='finance', update_ts=now(), update_user_id='CJAMS-58153', eligibility_status_cd='2914', etl_userid=NULL, etl_load_date=NULL
WHERE fund_alloc_id=538547;

update tb_fund_allocation_detail
set delete_sw = 'Y',
	update_ts = now(),
    update_user_id = 'CJAMS-58153'
where payment_detail_id = 2416112
and delete_sw = 'N';  

--for 2434741
--select * from tb_fund_allocation_master where payment_detail_id = 2434741 ;-- ->update 
/*
INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(542412, 0.00, 2434741, '2025-02-28', 5008.67, '7176', 735.00, 0.00, 0.00, 4273.67, 0.00, 0.00, 0.00, 'N', 'N', '2017-07-01 01:07:29.000', 'finance', '2025-03-01 00:15:01.713', 'finance', '2914', NULL, NULL);
*/
--select * from tb_fund_allocation_detail where payment_detail_id = 2434741;-- insert into tb_fund_allocation_master and

UPDATE cjams.tb_fund_allocation_master
SET fund_allocation_date='2017-06-30', payment_detail_id=2434741, payment_amount=5008.67, fiscal_category_cd='7176 ', ssi_funding_amt=0.00, ssa_funding_amt=0.00, coc_funding_amt=0.00, state_funding_amt=5008.67, ive_funding_amt=0.00, ivd_funding_amt=0.00, local_funding_amt=0.00, initial_stamping_sw='Y', delete_sw='N', create_ts='2025-03-01 00:15:01.713', create_user_id='finance', update_ts=now(), update_user_id='CJAMS-58153', eligibility_status_cd='2914', etl_userid=NULL, etl_load_date=NULL
WHERE fund_alloc_id=542412;


update tb_fund_allocation_detail
set delete_sw = 'Y',
	update_ts = now(),
    update_user_id = 'CJAMS-58153'
where payment_detail_id = 2434741  
and delete_sw = 'N';  

--for 2453087
--select * from tb_fund_allocation_master where payment_detail_id = 2453087 ;-- ->update 
/*
INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(546190, 0.00, 2453087, '2025-02-28', 4847.10, '7176', 691.00, 0.00, 0.00, 4156.10, 0.00, 0.00, 0.00, 'N', 'N', '2017-08-01 01:07:39.000', 'finance', '2025-03-01 00:15:01.713', 'finance', '2914', NULL, NULL);
*/

--select * from tb_fund_allocation_detail where payment_detail_id = 2453087;-- insert into tb_fund_allocation_master and

UPDATE cjams.tb_fund_allocation_master
SET fund_allocation_date='2017-07-31', payment_detail_id=2453087, payment_amount=4847.10, fiscal_category_cd='7176 ', ssi_funding_amt=0.00, ssa_funding_amt=0.00, coc_funding_amt=0.00, state_funding_amt=4847.10, ive_funding_amt=0.00, ivd_funding_amt=0.00, local_funding_amt=0.00, initial_stamping_sw='Y', delete_sw='N', create_ts='2025-03-01 00:15:01.713', create_user_id='finance', update_ts=now(), update_user_id='CJAMS-58153', eligibility_status_cd='2914', etl_userid=NULL, etl_load_date=NULL
WHERE fund_alloc_id=546190;

update tb_fund_allocation_detail
set delete_sw = 'Y',
	update_ts = now(),
    update_user_id = 'CJAMS-58153'
where payment_detail_id = 2453087
and delete_sw = 'N';  