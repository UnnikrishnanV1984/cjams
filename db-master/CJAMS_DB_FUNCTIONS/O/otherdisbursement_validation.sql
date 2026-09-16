DROP function if exists otherdisbursement_validation(integer,character varying) ;
CREATE OR REPLACE FUNCTION cjams.otherdisbursement_validation(v_client_acc_id integer, v_account_type character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

--------------------------------------
-- CDM-21565 - Veera 06-17 - Disregarding Denied Error Correction
------------------------------------

DECLARE 
v_pending_obj numeric default 0;
v_crnt_coc numeric default 0;
v_error_bal numeric default 0;
v_totl_bal numeric default 0;
v_obli_bal numeric default 0;
over_bal numeric ;
v_pa_count integer;
v_err_count integer;
I_disbursment json;

begin

	
	
select coalesce((select sum(coalesce(cost_no,0.00)):: numeric into v_pending_obj  from tb_service_purchase_authorization ta 
inner join tb_client_account tca on tca.client_account_id=ta.client_account_id
where  coalesce(sprvsr_approval_status_cd,'')= ''
and (select count(1) from routing r where r.objectid = ta.authorization_id :: character varying and r.routingstatustypeid = 62 and r.activeflag=1 ) = 0
and tca.client_account_id=v_client_acc_id and tca.status_cd = v_account_type --and tca.account_type_cd='590' and ta.delete_sw='N'
and Trim(ta.fiscal_category_cd) in (select
	case  v_account_type
		when '590' then '7502' 
		when '591' then '7503'
		else null
		end
	)
),0.00);

--for final disbursement check
select coalesce((select count(1) into v_pa_count  from tb_service_purchase_authorization ta 
inner join tb_client_account tca on tca.client_account_id=ta.client_account_id
where  (coalesce(ta.payment_approval_status_cd,'')= '' or ta.reason_tx is not null)
and tca.client_account_id=v_client_acc_id and tca.status_cd = v_account_type --and tca.account_type_cd='590' and ta.delete_sw='N'
),0.00);


drop table if exists  temp_account_transaction;	
CREATE TEMP TABLE temp_account_transaction  AS
SELECT *,to_char(ta.benefit_start_dt  , 'Mon-YY') as benefit_start_dt_MONTH 
FROM tb_account_transaction ta  WHERE ta.client_account_id = v_client_acc_id ;


										

										
												
 Select sum(A.coc) as AVAILABLE_BALANCE_NO_COC into v_crnt_coc
from 
(  											
select (COALESCE((
				
					( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00)) 
							FROM temp_account_transaction TR1,
									 TB_CLIENT_ACCOUNT AC1
					   WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = v_client_acc_id
								AND TR1.DELETE_SW = 'N' 
								AND TR1.CREDIT_DEBIT_SW = 'C'
								 AND AC1.DELETE_SW = 'N'  
								  and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
--								 AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) =  EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
--								 AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
								AND TR1.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
								AND ( TR1.BENEFIT_START_DT::date >  F_daymonth(CURRENT_DATE  - INTERVAL '2 MONTHS'  ,'L' , 'C')::date  OR
										  COALESCE(TR1.LATE_ENTRY_SW, 'N')  = 'Y' )  
						GROUP BY  to_char(tr1.benefit_start_dt,'Mon-YY'),
--									EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
--									   EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
									   AC1.CLIENT_ID
					 ) 
					+ 
					COALESCE((
					  SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))	    
							FROM temp_account_transaction TR1,
									 TB_CLIENT_ACCOUNT AC1
					   WHERE  TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								  AND AC1.CLIENT_ACCOUNT_ID = v_client_acc_id
								  AND TR1.DELETE_SW = 'N' 
								  AND AC1.DELETE_SW = 'N'  
								  AND TR1.TRANSACTION_TYPE_CD = '588'
								   AND TR1.CREDIT_DEBIT_SW = 'C'
								   AND TR1.TRANSACTION_SOURCE_CD = '5473'	
								   AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								    and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
--								  AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) = EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
--								  AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
								  AND TR1.REFERENCE_TRANSACTION_ID in 
												( 
												  SELECT TR2.TRANSACTION_ID
														FROM temp_account_transaction TR2,
																 TB_CLIENT_ACCOUNT AC2
													WHERE TR2.CLIENT_ACCOUNT_ID = AC2.CLIENT_ACCOUNT_ID 
															AND AC2.CLIENT_ACCOUNT_ID = v_client_acc_id
															AND TR2.DELETE_SW = 'N' 
															AND AC2.DELETE_SW = 'N'  
															AND TR2.CREDIT_DEBIT_SW = 'C'
															AND TR2.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
															AND ( TR2.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - INTERVAL '2 MONTHS'  ,'L' , 'C')  
																	 OR COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'Y' )  
												)
									GROUP by    to_char(tr1.benefit_start_dt,'Mon-YY'),
--										EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
--									   EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
									   AC1.CLIENT_ID

					),0.00)
					-
					COALESCE((
					  SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))	    
							FROM temp_account_transaction TR1,
									 TB_CLIENT_ACCOUNT AC1
					   WHERE   TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								  AND AC1.CLIENT_ACCOUNT_ID = v_client_acc_id
								  AND TR1.DELETE_SW = 'N' 
								  AND AC1.DELETE_SW = 'N'  
								  AND TR1.TRANSACTION_TYPE_CD = '588'
								   AND TR1.CREDIT_DEBIT_SW = 'D'
								   AND TR1.TRANSACTION_SOURCE_CD = '5473'	
								   AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								   and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
--								  AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) =  EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
--								  AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
								  AND TR1.REFERENCE_TRANSACTION_ID in 
												( 
												  SELECT TR2.TRANSACTION_ID
														FROM temp_account_transaction TR2,
																 TB_CLIENT_ACCOUNT AC2
													WHERE TR2.CLIENT_ACCOUNT_ID = AC2.CLIENT_ACCOUNT_ID 
															AND AC2.CLIENT_ACCOUNT_ID = v_client_acc_id
															AND TR2.DELETE_SW = 'N' 
															AND AC2.DELETE_SW = 'N'  
															AND TR2.CREDIT_DEBIT_SW = 'C'
															AND TR2.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
															AND ( TR2.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - INTERVAL '2 MONTHS'  ,'L' , 'C')  
																	 OR COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'Y' )  
												)
						GROUP BY 		EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
									   EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
									   AC1.CLIENT_ID

					),0.00)
				),0))AS coc
			from temp_account_transaction TR where client_account_id = v_client_acc_id
			group by TR.benefit_start_dt_MONTH) A;

select coalesce((select sum(coalesce(tca.transaction_amount_no,0.00)):: numeric
from tb_account_transaction tca where 
	tca.client_account_id in
(select tcaaa.client_account_id from tb_client_account tcaaa where tcaaa.client_account_id=v_client_acc_id  
 and tcaaa.account_type_cd= v_account_type and tcaaa.status_cd = '592') 
	and  credit_debit_sw = 'C' 
 and trim(transaction_type_cd)= '588' 
  and trim(transaction_source_cd) in ('5473')
   and (select t.transaction_source_cd from tb_account_transaction t 
                          where t.transaction_id = tca.reference_transaction_id )   in
	                        ('587', '586', '585')
  and coalesce(adjustment_approval_status_cd,'') not in  ('3047','3281')--)
  
--  - 
--  (select sum(coalesce(tca.transaction_amount_no,0.00)):: numeric
--from tb_account_transaction tca where 
--	tca.client_account_id in
--(select tcaaa.client_account_id from tb_client_account tcaaa where tcaaa.client_account_id=v_client_acc_id  
-- and tcaaa.account_type_cd= v_account_type and tcaaa.status_cd = '592') 
--	and  credit_debit_sw = 'D' 
-- and trim(transaction_type_cd)= '588' 
--  and trim(transaction_source_cd) in ('5473')
--   and (select t.transaction_source_cd from tb_account_transaction t 
--                          where t.transaction_id = tca.reference_transaction_id )   in
--	                        ('587', '586', '585')
--  and coalesce(adjustment_approval_status_cd,'') not in  ('3047','3281'))
-- and to_char(tca.benefit_start_dt,'Mon-YY') = to_char(now()::date  ,'Mon-YY')
),0)


into v_error_bal;

select count(1) into v_err_count
from tb_account_transaction tca where 
	tca.client_account_id in
(select tcaaa.client_account_id from tb_client_account tcaaa where tcaaa.client_account_id=v_client_acc_id  
 and tcaaa.account_type_cd= v_account_type and tcaaa.status_cd = '592') 
	--and  credit_debit_sw = 'C' 
 and trim(transaction_type_cd)= '588' 
  and trim(transaction_source_cd) in ('5473') 
  and coalesce(adjustment_approval_status_cd,'') not in  ('3047','3281')
   and (select t.transaction_source_cd from tb_account_transaction t 
                          where t.transaction_id = tca.reference_transaction_id )   in
	                        ('587', '586', '585')
-- and to_char(tca.benefit_start_dt,'Mon-YY') = to_char(now()::date  ,'Mon-YY')
 ;

 select coalesce(tcaaa.total_balance_no,0.00),coalesce(tcaaa.obligated_for_anc,0.00) into v_totl_bal,v_obli_bal 
 from tb_client_account tcaaa where tcaaa.client_account_id=v_client_acc_id  
 and tcaaa.account_type_cd= v_account_type and tcaaa.status_cd = '592';

select (coalesce(v_totl_bal,0.00)  - (coalesce(v_pending_obj,0.00) + coalesce(v_crnt_coc,0.00)--+coalesce(v_error_bal,0.00) 
+coalesce(v_obli_bal,0.00) ))::numeric into over_bal;

--
select json_agg(x) into I_disbursment from
(select coalesce(v_totl_bal,0.00) as total_no , coalesce(v_pending_obj,0.00) as pending_obligation_no, 
coalesce(v_crnt_coc,0.00) as current_coc,coalesce(v_error_bal,0.00) as pending_error_no ,
coalesce(v_obli_bal,0.00) as obligation_no , coalesce(over_bal,0.00) as overall_no,v_pa_count,v_err_count) x;

return  
I_disbursment;

drop TABLE temp_account_transaction;

END;
 
$function$
;
