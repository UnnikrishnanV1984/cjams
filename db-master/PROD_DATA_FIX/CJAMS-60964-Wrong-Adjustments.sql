/*
Issue Description:Dashboard:Closing the clients #10568011 and needs to remove some adjustments so we can close the case. We also need to send a final disbursement to the clients but could not close the case until the wrong adjustments are removes
Root cause: User Request delete incomplete record ,due to user do not have acces to delete the records.
Fix provided: Data fix has been done to update the tb_account_transaction table.
Data/Code fix ticket#: CJAMS-60964
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#:CIDM-10467
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--select * from tb_client_account tca where client_id = '10568011'
--
--select credit_debit_sw,delete_sw ,comm_acct_trans_id ,* 
--from tb_account_transaction where transaction_id in (1572550,1572549,1572548,1572547,1572546,1572513,1574541,1574372)


update tb_account_transaction
    set update_ts =  now(),
        update_user_id = 'CJAMS-60964',
        delete_sw = 'Y'
where transaction_id in (1572550,1572549,1572548,1572547,1572546,1572513,1574541,1574372,1575943,1568770)
and delete_sw = 'N';

--select * from tb_client_account tca where client_id ='10568011' and delete_sw = 'N'; --1041551

-- Update Obligated for Ancillary
update tb_client_account ta
set obligated_for_anc = 
     ( select coalesce(sum(spa.cost_no),0) 
            from tb_service_purchase_authorization spa
        where spa.delete_sw  = 'N'
            and spa.authorization_id 
                in (    select tr.authorization_id 
                            from tb_account_transaction tr
                        where tr.client_account_id = 1041551
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
    update_user_id = 'CJAMS-60964'
where ta.client_account_id = 1041551
and ta.delete_sw = 'N' ;


update tb_client_account ta
set total_balance_no = 
    (
        coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
            from tb_account_transaction tr
            where tr.client_account_id = ta.client_account_id
               and (     tr.transaction_type_cd <> '588' 
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
                and (     tr.transaction_type_cd <> '588' 
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
    update_user_id = 'CJAMS-60964'
where ta.client_account_id = 1041551
    and ta.delete_sw = 'N' ;
            
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
    update_ts = now(),
    update_user_id = 'CJAMS-60964'
where ta.client_account_id = 1041551
    and ta.delete_sw = 'N' ;

-- NO Commigled Account hence no need to update
-- Update Commingled Account Balance
/*
select comm_account_id, client_id, client_account_id, 
    total_balance_no, obligated_for_anc,obligated_for_coc, available_balance_no, 
    comm_account_id, county_cd    
from tb_client_account 
where client_account_id = 1041551
    and delete_sw = 'N' ;

update cjams.tb_commingled_account
    set total_balance_no = ( select sum(coalesce(total_balance_no,0))
                                from cjams.tb_client_account
                             where comm_account_id = 360
                                and delete_sw = 'N' ),
        update_ts = now(),
        update_user_id = 'CJAMS-60964'
where comm_account_id = '282'
    and delete_sw = 'N' ;
*/    

/*
select * from tb_fund_allocation_master tfam where payment_detail_id = '5906303' and delete_sw = 'N'; --SW delete = y
select * from tb_fund_allocation_detail tfad  where payment_detail_id = '5906303' and delete_sw = 'N'; --SW delete = y
*/


DELETE FROM cjams.tb_fund_allocation_master
WHERE fund_alloc_id=1834015;


INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, fund_allocation_date, payment_detail_id, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(1834015, '2025-02-28', 5906303, 13437.26, '7177', 580.20, 0.00, 0.00, 12857.06, 0.00, 0, 0, 'Y', 'N', '2025-08-01 00:15:01.589', 'finance', now(), 'CJAMS-60964', '2912', NULL, NULL);


-- delete tb_fund_allocation_detail where payment_detail_id = 5906303
DELETE FROM cjams.tb_fund_allocation_detail
WHERE fund_alloc_id=1834015;

/*
INSERT INTO cjams.tb_fund_allocation_detail
(fund_alloc_history_id, fund_alloc_id, fund_allocation_date, payment_detail_id, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(1134489, 1834015, '2025-02-28', 5906303, 13437.26, '7177', 580.20, 0.00, 0.00, 12857.06, 0.00, 0, 0, 'Y', 'N', '2025-08-01 00:15:01.589', 'finance', '2025-08-01 00:15:01.589', 'finance', '2912', NULL, NULL);


INSERT INTO cjams.tb_fund_allocation_master
(fund_alloc_id, funding_amount_no, payment_detail_id, fund_allocation_date, payment_amount, fiscal_category_cd, ssi_funding_amt, ssa_funding_amt, coc_funding_amt, state_funding_amt, ive_funding_amt, ivd_funding_amt, local_funding_amt, initial_stamping_sw, delete_sw, create_ts, create_user_id, update_ts, update_user_id, eligibility_status_cd, etl_userid, etl_load_date)
VALUES(1834015, 0, 5906303, '2025-07-31', 13437.26, '7177', 580.20, 0.00, 580.20, 12276.86, 0.00, 0, 0, 'N', 'N', '2025-03-01 00:15:01.713', 'finance', '2025-08-01 00:15:01.589', 'finance', '2912', NULL, NULL);
*/
