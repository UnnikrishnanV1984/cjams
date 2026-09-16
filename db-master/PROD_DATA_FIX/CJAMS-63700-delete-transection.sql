/*
 * CJAMS-59149 - Child Account COC entered in error
 * Customer Email ID: janet.adetunji1@maryland.gov
 * Focus Area: Child Account
 * Identified As:User Error, User incorrectly entered the SSA benefit month of October 2025 and requested to delete the transaction so they can re-entered and corrected the SSA benefit month accordingly.
 * Category/ Module: Child Account
 * Root cause: User Error
 * Fix Provided: Datafix has been promoted to remove below transections and updated the total amount.
 Client ID: 4088450 (Cortez Lyon)
    Account #: C102540
    Transaction ID #: 1594943
    Amount: $217.00
*/

/*
select * from tb_client_account tca where client_id = '4088450';
select credit_debit_sw,delete_sw ,comm_acct_trans_id ,* 
from tb_account_transaction where transaction_id in (1594943);
*/

update tb_account_transaction
    set update_ts =  now(),
        update_user_id = 'CJAMS-63700',
        delete_sw = 'Y'
where transaction_id = 1594943
and delete_sw = 'N';

--select * from tb_client_account tca where client_id ='2923067' and delete_sw = 'N'; --1047536

-- Update Obligated for Ancillary
update tb_client_account ta
set obligated_for_anc = 
     ( select coalesce(sum(spa.cost_no),0) 
            from tb_service_purchase_authorization spa
        where spa.delete_sw  = 'N'
            and spa.authorization_id 
                in (    select tr.authorization_id 
                            from tb_account_transaction tr
                        where tr.client_account_id = 1047536
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
    update_user_id = 'CJAMS-63700'
where ta.client_account_id = 1047536
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
    update_user_id = 'CJAMS-63700'
where ta.client_account_id = 1047536
    and ta.delete_sw = 'N' ;
            
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
    update_ts = now(),
    update_user_id = 'CJAMS-63700'
where ta.client_account_id = 1047536
    and ta.delete_sw = 'N' ;

--  Commigled Account: 0
-- No Update needed in Commingled Account Balance
/*
select comm_account_id, client_id, client_account_id, 
    total_balance_no, obligated_for_anc,obligated_for_coc, available_balance_no, 
    comm_account_id, county_cd    
from tb_client_account 
where client_account_id = 1047536
    and delete_sw = 'N' ;
*/ 
   
/*update cjams.tb_commingled_account
    set total_balance_no = ( select sum(coalesce(total_balance_no,0))
                                from cjams.tb_client_account
                             where comm_account_id = 0
                                and delete_sw = 'N' ),
        update_ts = now(),
        update_user_id = 'CJAMS-63700'
where comm_account_id = 'empty'
    and delete_sw = 'N' ;*/

-- no records on the fund allocation/or restaming  for this client '4088450' so no update on tb_fund_allocation_master table.