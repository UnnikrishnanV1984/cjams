CREATE OR REPLACE FUNCTION cjams.getchild116report(	v_clientaccountid integer, 
													v_lipagesize bigint, 
													v_lipagenumber bigint, 
													date_sw character varying DEFAULT NULL::character varying, 
													date_from date DEFAULT NULL::date, 
													date_to date DEFAULT NULL::date
													)
 RETURNS TABLE(totalcount bigint, client_account_id bigint, client_id bigint, account_type_cd character varying, account_type_nm character varying, account_exists_sw character, bank_nm character varying, account_no_tx character varying, total_balance_no numeric, available_balance_no numeric, open_dt text, close_dt text, status_cd character varying, status_nm character varying, comm_account_id integer, case_id bigint, total_obligated numeric, obligated_for_anc numeric, obligated_for_coc numeric, clientfirstname character varying, clientlastname character varying, dob text, transactiondetails json, otherancillaryexcessdetails json, rundate text, ssn character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 02/09/2024 Vineet Tirodkar - To add transaction type SSDI 5487 in child Account balance calculations (CDM-37115)
-- 02/11/2025 Naveenkumar Chemutu- To add Contribution 5491 in child Account balance calculations (CIDM-10159)
-- 05/20/2025 Parshal Chitrakar - Wrong cost of care total (CDM-44389)
------------------------------------------------------------------------------------------------------------	
DECLARE 
	v_pagenumber int;
	v_pageoffset int;
	v_client_acc_id integer;
	v_date_val varchar(50);	
	v_bal_avaliable numeric;
	
BEGIN 
		
	IF COALESCE(v_liPageSize, 0) < 1 THEN                     
		v_liPageSize := 10;
	END IF;

	IF COALESCE(v_liPageNumber, 0) < 1 THEN
		v_liPageNumber := 1;	
	end if;
	
	v_pagenumber := v_liPageNumber - 1;
	v_pageoffset := v_pagenumber * v_liPageSize;
	raise notice 'date_trunc %',date_trunc('year',CURRENT_DATE);
	raise notice 'date_trunc %',date_trunc('month',CURRENT_DATE);
	
	drop table if exists  tmp_account_transaction;
	drop table if exists tmp_placemnt ;
	drop table if exists temp_payment_detail;
	drop table if exists temp_payment_header;
	drop table if exists temp_payment_status ;
	
	CREATE TEMP TABLE tmp_account_transaction  AS
	SELECT *,to_char(ta.benefit_start_dt  , 'Mon-YY') as benefit_start_dt_month  FROM tb_account_transaction ta  WHERE ta.client_account_id = v_clientaccountid ;
	
	create temp table tmp_placemnt  as
		--select tp.placement_id  from tb_client_account ac , tb_placement tp  WHERE ac.client_id = tp.client_id  and ac.client_account_id = v_clientaccountid ;
		select pl.alternateid as placement_id
		FROM placement pl
			JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid AND sc.activeflag = 1
			JOIN person pr ON pr.personid = pl.personid AND pr.activeflag = 1
			join tb_client_account ac on ac.client_id = pr.cjamspid 
			JOIN intakeservreqchildremoval irl ON irl.intakeservreqchildremovalid = pl.intakeservreqchildremovalid AND irl.activeflag = 1
		WHERE pl.activeflag = 1 and ac.client_account_id = v_clientaccountid ;
	  
	create temp table temp_payment_detail as 
		select  PD.FINAL_AMOUNT_NO,PD.PAYMENT_ID,PD.PLACEMENT_ID,PD.FINAL_SERVICE_START_DT, PD.DELETE_SW, PD.FINAL_SERVICE_ID, PD.CLIENT_ID, PD.PAYMENT_DETAIL_ID 
		from tb_payment_detail pd 
			join tmp_placemnt tp on  tp.placement_id  = pd.placement_id
		where pd.delete_sw = 'N';   
	
	CREATE TEMP TABLE temp_payment_header AS
		SELECT PH.PAYMENT_ID, PH.PAYMENT_TYPE_CD, PH.MANUAL_SW, PH.DELETE_SW
		-- FROM tb_payment_header ph join temp_payment_detail pd on ph.payment_id = pd.payment_id 
		FROM tb_payment_header ph 
		where ph.payment_id in (select pd.payment_id from temp_payment_detail pd )
			and ph.delete_sw = 'N';
	
	CREATE TEMP TABLE temp_payment_status AS
		SELECT PS.PAYMENT_ID,PS.DELETE_SW ,PS.PAYMENT_STATUS_CD  
		-- FROM tb_payment_status ps join temp_payment_header ph on  ph.payment_id = ps.payment_id  ;
		FROM tb_payment_status ps 
		where ps.payment_id in ( select ph.payment_id from temp_payment_header ph )
		and ps.delete_sw = 'N';
	
	return query
	select count(1) over() as totalcount,
		tca.client_account_id,
		tca.client_id,
		tca.account_type_cd,
		(select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=tca.account_type_cd AND PICKLIST_TYPE_ID='40') account_type_nm,
		tca.account_exists_sw,
		tca.bank_nm,
		tca.account_no_tx,
		coalesce(tca.total_balance_no,0.00)::numeric(10,2),
		coalesce(tca.available_balance_no,0.00)::numeric(10,2),
		to_char(tca.open_dt,'MM/DD/YYYY')::text as open_dt,
		to_char(tca.close_dt,'MM/DD/YYYY')::text as close_dt,tca.status_cd,
		(select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=tca.status_cd AND PICKLIST_TYPE_ID='41') status_nm,
		tca.comm_account_id,
		tca.case_id,
		coalesce(tca.obligated_for_anc,0.00)::numeric(10,2) as total_obligated,
		coalesce(GETBALANCEFORANCILLARY(tca.client_account_id),0.00)::numeric(10,2) as obligated_for_anc,  
		coalesce(GETAVAILCOC(tca.client_account_id),0.00)::numeric(10,2) as obligated_for_coc,
		p.firstname,
		p.lastname,
		to_char(p.dob,'MM/DD/YYYY')::text as dob,
		
		(select json_agg(x) from 
			(select tat.transaction_id,
				tat.client_account_id,
				tat.transaction_type_cd,
				(select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=tat.transaction_type_cd AND PICKLIST_TYPE_ID='39') transaction_type_nm,
				tat.transaction_source_cd,
				(select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=tat.transaction_source_cd AND PICKLIST_TYPE_ID='38') transaction_source_nm,
				to_char(tat.benefit_start_dt,'MM/DD/YYYY') as benefit_start_dt,
				to_char(tat.benefit_end_dt,'MM/DD/YYYY')  as benefit_end_dt,
				tat.transaction_amount_no,
				to_char(tat.transaction_dt, 'MM/DD/YYYY') as transaction_dt,
				tat.credit_debit_sw,to_char(tat.benefit_start_dt, 'MM/YYYY') as monthyear,
				case when (tat.client_account_id = v_clientaccountid and upper(trim(tat.credit_debit_sw)) = 'C' ) then 'CR' 
				when (tat.client_account_id = v_clientaccountid and upper(trim(tat.credit_debit_sw)) = 'D' ) then 'DR'
				end as credit_debit
			from tmp_account_transaction tat
			where tat.client_account_id = tca.client_account_id
				and tat.benefit_start_dt is not null 
				and tat.delete_sw = 'N' 
				and tat.transaction_id not in
					(select tr3.transaction_id 
						from tb_account_transaction tr3 
					 where tr3.client_account_id =tca.client_account_id and tr3.transaction_source_cd = '5473' and 
						(tr3.adjustment_approval_status_cd !='3047' or tr3.adjustment_approval_status_cd is null))
						and 
						(date_sw is null 
						or 
						case 
						  when date_sw = 'M' then 
							( date_trunc('month', tat.benefit_start_dt) = date_trunc('month', CURRENT_DATE - interval '1' month)) 
						  when date_sw = 'Y' then 
						  date_part('year', now() :: date):: integer = date_part('year', tat.benefit_start_dt):: integer
							  --( tat.benefit_start_dt = date_trunc('year', CURRENT_DATE) ) 
						  when date_sw = 'D' then 
							to_date( cast(tat.benefit_start_dt as TEXT), 'YYYY-MM-DD') 
							BETWEEN to_date( cast(date_from as TEXT), 'YYYY-MM-DD' ) 
							AND to_date( cast(date_to as TEXT), 'YYYY-MM-DD' ) 
						end)
					order by tat.benefit_start_dt desc
			)
		as x) as transactiondetails,
		
		(select json_agg(x) from 
			(SELECT tab2.benefitmonyear,
			       TAB2.YEAR, 
				   TAB2.MONTH, 
				   sum(TAB2.RECEIPTS_FOR_ANC) as RECEIPTS_FOR_ANC,
				   sum(TAB2.EXCESS_AFTER_COC_REIMBURSEMENT) as EXCESS_AFTER_COC_REIMBURSEMENT,
				   TAB2.OBLIGATIONS,
				   sum(TAB2.ANCILLARY_PAYMENTS) as ANCILLARY_PAYMENTS,
				   TAB2.BALANCE_AVAIL_FOR_ANCILLARY,
				   TAB2.OTHERDISBURSEMENT,
				   TAB2.OTHERDISBURSEMENTOBLIGATION	,
				   sum(TAB2.RECEIPTS_FOR_COC) as RECEIPTS_FOR_COC ,
				   TAB2.ACTUAL_COC as ACTUAL_COC ,
				   sum(TAB2.COC_REIMBURSEMENT) as COC_REIMBURSEMENT, 
			   	   (TAB2.AVAILABLE_BALANCE_NO_COC) as AVAILABLE_BALANCE_NO_COC 
			FROM (
				SELECT TAB1.*,
					-- TAB1.OTHERDISBURSEMENT,
					-- TAB1.OTHERDISBURSEMENTOBLIGATION	,
					SUM(TAB1.MONTHY_BAL_AVAIL_FOR_ANC) OVER (ORDER BY TAB1.YEAR, TAB1.MONTH) AS BALANCE_AVAIL_FOR_ANCILLARY
				FROM (
					SELECT TAB.*,
						(CASE WHEN DATE(RTRIM((TAB.YEAR)::varchar) || '-' || RTRIM((TAB.MONTH)::varchar) || '-01') > F_daymonth(CURRENT_DATE - interval '2 MONTHS'  ,'L' , 'C')  THEN
							0
						ELSE
							TAB.BALANCE_AVAIL_FOR_ANCLL
						END ) AS EXCESS_AFTER_COC_REIMBURSEMENT,
						( TAB.RECEIPTS_FOR_ANC  
						+ 
						( CASE WHEN DATE(RTRIM((TAB.YEAR)::varchar) || '-' || RTRIM((TAB.MONTH)::varchar) || '-01') > F_daymonth(CURRENT_DATE - interval '2 MONTHS'  ,'L' , 'C')  THEN
							0
						ELSE
							TAB.BALANCE_AVAIL_FOR_ANCLL
						END )
						- 
						TAB.OBLIGATIONS 
						- 
						TAB.ANCILLARY_PAYMENTS - (TAB.OTHERDISBURSEMENT + TAB.OTHERDISBURSEMENTOBLIGATION)
						) AS MONTHY_BAL_AVAIL_FOR_ANC
						-- TAB.OTHERDISBURSEMENT,
						-- TAB.OTHERDISBURSEMENTOBLIGATION		
					FROM 
					( 
						select
							extract(year from TR.BENEFIT_START_DT) AS YEAR, 
							extract (month from TR.BENEFIT_START_DT) AS MONTH, 
							tr.benefit_start_dt_month  as benefitmonyear,
							(
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C' 
									AND  TR.TRANSACTION_SOURCE_CD in ( '5471', '582', '583', '584', '5478', '5487','5491' ) THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							)
							/* CDM-9130 Fix - Bank Service Charges moved to otherdisbursement
							- 	
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '588' AND TR.CREDIT_DEBIT_SW = 'D' 
								AND ADJUSTMENT_APPROVAL_STATUS_CD = '3047' AND  TR.TRANSACTION_SOURCE_CD = '5472' THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							)
							*/
							+
							COALESCE(( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
							FROM tmp_account_transaction TR1,
								 TB_CLIENT_ACCOUNT AC1
							WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
								AND TR1.DELETE_SW = 'N'  
								AND AC1.DELETE_SW = 'N' 
								and to_char(tr1.benefit_start_dt,'Mon-YY') = tr.benefit_start_dt_month
								--	AND extract (month from TR1.BENEFIT_START_DT) = extract (month from TR.BENEFIT_START_DT)
								--	AND extract (year from TR1.BENEFIT_START_DT) = extract (year from TR.BENEFIT_START_DT)
								AND TR1.TRANSACTION_TYPE_CD = '588'
								AND TR1.CREDIT_DEBIT_SW = 'C'
								AND TR1.TRANSACTION_SOURCE_CD = '5473'	
								AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
											FROM tmp_account_transaction TR2
										WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
													AND TR2.DELETE_SW = 'N' ) in  ( '5471', '582', '583', '584', '5478', '5487','5491' ))
							GROUP BY  extract (month from TR1.BENEFIT_START_DT) , 
								extract (year from TR1.BENEFIT_START_DT) ,   AC1.CLIENT_ID
							),0)		 	    
							- 
							COALESCE(( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
							FROM tmp_account_transaction TR1,
								 TB_CLIENT_ACCOUNT AC1
							WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
								AND TR1.DELETE_SW = 'N'  
								AND AC1.DELETE_SW = 'N'  
								and to_char(tr1.benefit_start_dt,'Mon-YY') = tr.benefit_start_dt_month
								--	AND extract (month from TR1.BENEFIT_START_DT) = extract (month from TR.BENEFIT_START_DT)
								--	AND extract (year from TR1.BENEFIT_START_DT) = extract (year from TR.BENEFIT_START_DT)
								AND TR1.TRANSACTION_TYPE_CD = '588'
								AND TR1.CREDIT_DEBIT_SW = 'D'
								AND TR1.TRANSACTION_SOURCE_CD = '5473'	
								AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
											FROM tmp_account_transaction TR2
										WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
													AND TR2.DELETE_SW = 'N' ) in  ( '5471', '582', '583', '584', '5478', '5487','5491' ))
							GROUP BY  extract (month from TR1.BENEFIT_START_DT) , 
							  extract (year from TR1.BENEFIT_START_DT),
							   AC1.CLIENT_ID
							),0)		 	    
							) AS RECEIPTS_FOR_ANC,
	
							COALESCE(    
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '5530' AND TR.CREDIT_DEBIT_SW = 'D' 
								AND  TR.TRANSACTION_SOURCE_CD = '5474' THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							 )
							-
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '5530' AND TR.CREDIT_DEBIT_SW = 'C' 
								AND TR.TRANSACTION_SOURCE_CD = '5475' THEN
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							)
							,0) AS OBLIGATIONS,
	
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '5531' AND TR.CREDIT_DEBIT_SW = 'D' 
								AND TR.TRANSACTION_SOURCE_CD = '5476' THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							) AS ANCILLARY_PAYMENTS,
	
							(
							(
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C' 
								AND  TR.TRANSACTION_SOURCE_CD in ( '587', '586', '585' ) 
								AND COALESCE(TR.LATE_ENTRY_SW, 'N')  = 'N'   THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							)
							+
							COALESCE(
							( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
								FROM tmp_account_transaction TR1,
										 TB_CLIENT_ACCOUNT AC1
								WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
										AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
										AND TR1.DELETE_SW = 'N'  
										AND AC1.DELETE_SW = 'N' 
										and to_char(tr1.benefit_start_dt,'Mon-YY') = tr.benefit_start_dt_month
--										    AND extract (month from TR1.BENEFIT_START_DT) =   extract (month from TR.BENEFIT_START_DT)
--						   					AND extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
										AND TR1.TRANSACTION_TYPE_CD = '588'
										AND TR1.CREDIT_DEBIT_SW = 'C'
										AND TR1.TRANSACTION_SOURCE_CD = '5473'	
										AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
										AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
													FROM tmp_account_transaction TR2
												WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
															AND COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'N'  
															AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
								GROUP BY     extract (month from TR1.BENEFIT_START_DT), 
										extract (year from TR1.BENEFIT_START_DT) ,	AC1.CLIENT_ID
							),0)		 	    
							- 
							COALESCE(
							( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
								FROM tmp_account_transaction TR1,
									TB_CLIENT_ACCOUNT AC1
								WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
									AND TR1.DELETE_SW = 'N'  
									AND AC1.DELETE_SW = 'N'  
									and to_char(tr1.benefit_start_dt,'Mon-YY') = tr.benefit_start_dt_month
									--	AND extract (month from TR1.BENEFIT_START_DT) =  	   extract (month from TR.BENEFIT_START_DT)
									--	AND extract (year from TR1.BENEFIT_START_DT) =  	   extract (year from TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'D'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
									AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
												FROM tmp_account_transaction TR2
											WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
														AND COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'N'  
														AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
									GROUP BY  extract (month from TR1.BENEFIT_START_DT),   
										extract (year from TR1.BENEFIT_START_DT),	
										AC1.CLIENT_ID
							),0)		 	    
							) 
							-
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '3444' AND TR.CREDIT_DEBIT_SW = 'D' 
								AND TR.TRANSACTION_SOURCE_CD = '5477' THEN
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							) 
							) AS BALANCE_AVAIL_FOR_ANCLL,
							
							(
							ROUND( AVG(
							(select coalesce(sum(tcd.amount),0) 
								from tb_child_account_disbursement tcd 
							where tcd.client_account_id = v_clientaccountid 
								and tcd.payment_approval_status = '3047'
								and to_char(tcd.disbursement_dt, 'Mon-YY') = TR.benefit_start_dt_month 
								and tcd.service_id != 101
							)):: numeric (10,2),2)
							-- CDM-9130
							+
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '588' AND TR.CREDIT_DEBIT_SW = 'D' 
								AND ADJUSTMENT_APPROVAL_STATUS_CD = '3047' AND  TR.TRANSACTION_SOURCE_CD = '5472' THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							))as otherdisbursement,
							
							ROUND( AVG(
							(select coalesce(sum(tcd.amount),0) 
								from tb_child_account_disbursement tcd 
							where tcd.client_account_id = v_clientaccountid 
								and (tcd.payment_approval_status not in ('3047','3281') or tcd.funding_approval_status not in ('3047','3281'))
								--and (tcd.payment_approval_status is null or tcd.payment_approval_status = '3281')
								--or (tcd.funding_approval_status is null or tcd.funding_approval_status = '3405' or tcd.funding_approval_status = '3281')
								and to_char(tcd.disbursement_dt, 'Mon-YY') = TR.benefit_start_dt_month
								and tcd.service_id != 101
							) ):: numeric (10,2),2) as otherdisbursementobligation,
			
							(
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C' 
								AND TR.TRANSACTION_SOURCE_CD in ( '587', '586', '585' ) THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0.00)
							ELSE 
								0.00
							END )
							)
							+
							COALESCE(
							( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))
								FROM tmp_account_transaction TR1,
									 TB_CLIENT_ACCOUNT AC1
								WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID  
									AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
									AND TR1.DELETE_SW = 'N'  
									AND AC1.DELETE_SW = 'N' 
									and to_char(tr1.benefit_start_dt,'Mon-YY') = tr.benefit_start_dt_month
									--	AND EXTRACT(month FROM TR1.BENEFIT_START_DT) =  EXTRACT(month FROM TR.BENEFIT_START_DT)
									--	AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'C'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								    AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
											FROM tmp_account_transaction TR2
											WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
											AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
								GROUP BY  to_char(tr1.benefit_start_dt,'Mon-YY'),
								-- EXTRACT(year from TR1.BENEFIT_START_DT),
								--	EXTRACT(MONTH from TR1.BENEFIT_START_DT),
								  AC1.CLIENT_ID	
							),0.00)		 	    
							- 
							COALESCE(
							( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))
								FROM tmp_account_transaction TR1,
									 TB_CLIENT_ACCOUNT AC1
								WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
									AND TR1.DELETE_SW = 'N'  
									AND AC1.DELETE_SW = 'N' 
									and to_char(tr1.benefit_start_dt,'Mon-YY') = tr.benefit_start_dt_month
									-- AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) =  EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
									-- AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =   EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'D'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								    AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
												FROM tmp_account_transaction TR2
											WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
														AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
								GROUP by to_char(tr1.benefit_start_dt,'Mon-YY'),
									--	EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
									--	EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
									AC1.CLIENT_ID
							),0.00)		 	    
							) AS RECEIPTS_FOR_COC,
			
							(
							COALESCE( 
							(SELECT SUM(COALESCE(PD.FINAL_AMOUNT_NO,0.00)  )
								FROM temp_payment_detail PD, 
									temp_payment_header PH,
									temp_payment_status PS,
									PLACEMENT PL  -- Removing view and placing with table for performance improvementment
								WHERE PH.PAYMENT_ID = PD.PAYMENT_ID
									AND PH.PAYMENT_ID = PS.PAYMENT_ID
									AND PL.alternateid = PD.PLACEMENT_ID    
									and to_char(PD.FINAL_SERVICE_START_DT,'Mon-YY') = tr.benefit_start_dt_month
									--	AND EXTRACT(MONTH FROM PD.FINAL_SERVICE_START_DT) = EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
									--	AND EXTRACT(YEAR FROM PD.FINAL_SERVICE_START_DT) = EXTRACT(YEAR FROM TR.BENEFIT_START_DT) 
									AND ( PH.PAYMENT_TYPE_CD = '6' OR (PH.PAYMENT_TYPE_CD = '3294' AND PH.MANUAL_SW  = 'N' )) 
									AND PH.DELETE_SW = 'N' 
									AND PD.DELETE_SW = 'N'
									AND PS.DELETE_SW = 'N' 
									--AND PL.DELETE_SW = 'N' -- Not needed as this is dummy in tb_placement view
									AND PD.FINAL_SERVICE_ID IS NOT NULL
									AND PS.PAYMENT_STATUS_CD NOT IN ('1635','1639') 
									AND PD.PLACEMENT_ID IS NOT NULL
									-- AND ( PL.VOID_SW = 'N' OR PL.VOID_SW is null OR RTRIM(LTRIM(PL.VOID_SW)) = '')
								    AND (PL.isvoided=0 or PL.isvoided is null)
									AND PD.CLIENT_ID = AC.CLIENT_ID ),0.00)  
							-
							COALESCE(
							(SELECT SUM(COALESCE(RD.AMOUNT_NO,0.00)  )
								FROM TB_RECEIVABLE_DETAIL RD
							WHERE RD.DELETE_SW = 'N' 
								AND RD.PAYMENT_DETAIL_ID  in ( 
									SELECT PD.PAYMENT_DETAIL_ID
									FROM temp_payment_detail PD, 
										temp_payment_header PH,
										temp_payment_status PS,
										PLACEMENT PL
									WHERE PH.PAYMENT_ID = PD.PAYMENT_ID
										AND PH.PAYMENT_ID = PS.PAYMENT_ID
										AND PL.alternateid = PD.PLACEMENT_ID  
										and to_char(PD.FINAL_SERVICE_START_DT,'Mon-YY') = tr.benefit_start_dt_month
										--	AND EXTRACT(MONTH FROM PD.FINAL_SERVICE_START_DT) = EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
										--	AND EXTRACT(YEAR FROM PD.FINAL_SERVICE_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
										AND ( PH.PAYMENT_TYPE_CD = '6' OR (PH.PAYMENT_TYPE_CD = '3294' AND PH.MANUAL_SW  = 'N' )) 
										AND PH.DELETE_SW = 'N' 
										AND PD.DELETE_SW = 'N'
										AND PS.DELETE_SW = 'N' 
										--	AND PL.DELETE_SW = 'N' 
										AND PD.FINAL_SERVICE_ID IS NOT NULL
										AND PS.PAYMENT_STATUS_CD NOT IN ('1635','1639') 
										AND PD.PLACEMENT_ID IS NOT NULL
										--	AND ( PL.VOID_SW = 'N' OR PL.VOID_SW is null OR RTRIM(LTRIM(PL.VOID_SW)) = '')
										AND (PL.isvoided=0 or PL.isvoided is null)
										AND PD.CLIENT_ID = AC.CLIENT_ID )
							),0.00)	
							) AS ACTUAL_COC,
	
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '3444' AND TR.CREDIT_DEBIT_SW = 'D' 
								AND TR.TRANSACTION_SOURCE_CD = '5477' THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0.00)
							ELSE
								0.00
							END )
							) AS COC_REIMBURSEMENT,
	
							/*	COALESCE((
							( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00)) 
								FROM tmp_account_transaction TR1,
										 TB_CLIENT_ACCOUNT AC1
						    WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
								AND TR1.DELETE_SW = 'N' 
								AND TR1.CREDIT_DEBIT_SW = 'C'
								AND AC1.DELETE_SW = 'N'  
								and to_char(tr1.benefit_start_dt,'Mon-YY') = tr.benefit_start_dt_month
								--	AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) =  EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
								--	AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
								AND TR1.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
								AND ( TR1.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - INTERVAL '2 MONTHS'  ,'L' , 'C')  
								OR COALESCE(TR1.LATE_ENTRY_SW, 'N')  = 'Y' )  
							GROUP BY  to_char(tr1.benefit_start_dt,'Mon-YY'),
								-- EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
								--	EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
								AC1.CLIENT_ID
							) 
							+ 
							COALESCE((
							SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))	    
								FROM tmp_account_transaction TR1,
								 TB_CLIENT_ACCOUNT AC1
						    WHERE  TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
								AND TR1.DELETE_SW = 'N' 
								AND AC1.DELETE_SW = 'N'  
								AND TR1.TRANSACTION_TYPE_CD = '588'
								AND TR1.CREDIT_DEBIT_SW = 'C'
								AND TR1.TRANSACTION_SOURCE_CD = '5473'	
								AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								and to_char(tr1.benefit_start_dt,'Mon-YY') = tr.benefit_start_dt_month
								--	AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) = EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
								--	AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
								AND TR1.REFERENCE_TRANSACTION_ID in 
											( 
											  SELECT TR2.TRANSACTION_ID
													FROM tmp_account_transaction TR2,
															 TB_CLIENT_ACCOUNT AC2
												WHERE TR2.CLIENT_ACCOUNT_ID = AC2.CLIENT_ACCOUNT_ID 
														AND AC2.CLIENT_ACCOUNT_ID = v_clientaccountid
														AND TR2.DELETE_SW = 'N' 
														AND AC2.DELETE_SW = 'N'  
														AND TR2.CREDIT_DEBIT_SW = 'C'
														AND TR2.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
														AND ( TR2.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - INTERVAL '2 MONTHS'  ,'L' , 'C')  
																 OR COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'Y' )  
											)
								GROUP by    to_char(tr1.benefit_start_dt,'Mon-YY'),
									--	EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
									-- EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
								    AC1.CLIENT_ID
	
							),0.00)
							-
							COALESCE((
							SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))	    
								FROM tmp_account_transaction TR1,
								 TB_CLIENT_ACCOUNT AC1
							WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
								AND TR1.DELETE_SW = 'N' 
								AND AC1.DELETE_SW = 'N'  
								AND TR1.TRANSACTION_TYPE_CD = '588'
								AND TR1.CREDIT_DEBIT_SW = 'D'
								AND TR1.TRANSACTION_SOURCE_CD = '5473'	
								AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								and to_char(tr1.benefit_start_dt,'Mon-YY') = tr.benefit_start_dt_month
								-- AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) =  EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
								-- AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
								AND TR1.REFERENCE_TRANSACTION_ID in 
									( 
									  SELECT TR2.TRANSACTION_ID
											FROM tmp_account_transaction TR2,
													 TB_CLIENT_ACCOUNT AC2
										WHERE TR2.CLIENT_ACCOUNT_ID = AC2.CLIENT_ACCOUNT_ID 
												AND AC2.CLIENT_ACCOUNT_ID = v_clientaccountid
												AND TR2.DELETE_SW = 'N' 
												AND AC2.DELETE_SW = 'N'  
												AND TR2.CREDIT_DEBIT_SW = 'C'
												AND TR2.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
												AND ( TR2.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - INTERVAL '2 MONTHS'  ,'L' , 'C')  
														 OR COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'Y' )  
									)
								GROUP BY EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
									EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
									AC1.CLIENT_ID
	
								),0.00)
							),0) AS AVAILABLE_BALANCE_NO_COC*/
								 
							(CASE WHEN DATE(RTRIM((extract(year from TR.BENEFIT_START_DT))::varchar) || '-' || RTRIM((extract (month from TR.BENEFIT_START_DT))::varchar) || '-01') > F_daymonth(CURRENT_DATE - interval '2 MONTHS'  ,'L' , 'C')  THEN	 
								0
							ELSE
								--	TAB.BALANCE_AVAIL_FOR_ANCLL
								(COALESCE( 
								(SUM((CASE WHEN TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C' 
										AND TR.TRANSACTION_SOURCE_CD in ( '587', '586', '585' ) 
										AND COALESCE(TR.LATE_ENTRY_SW, 'N')  = 'N' THEN
												COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
										ELSE
												0
										END )
								)
								+
								COALESCE(
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
									FROM tmp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
									WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
										AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
										AND TR1.DELETE_SW = 'N'  
										AND AC1.DELETE_SW = 'N'  
										and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
										-- AND extract (month from TR1.BENEFIT_START_DT) = extract (month from TR.BENEFIT_START_DT)
										-- AND extract (year from TR1.BENEFIT_START_DT) = extract (year from TR.BENEFIT_START_DT)
										AND TR1.TRANSACTION_TYPE_CD = '588'
										AND TR1.CREDIT_DEBIT_SW = 'C'
										AND TR1.TRANSACTION_SOURCE_CD = '5473'	
										AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
										AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
													FROM tmp_account_transaction TR2
												WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
													AND COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'N'  
													AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
									GROUP BY  extract (month from TR1.BENEFIT_START_DT), 
											extract (year from TR1.BENEFIT_START_DT) ,	AC1.CLIENT_ID
								),0)		 	    
								- 
								COALESCE(
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
									FROM tmp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
									WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
										AND AC1.CLIENT_ACCOUNT_ID = v_clientaccountid
										AND TR1.DELETE_SW = 'N'  
										AND AC1.DELETE_SW = 'N'  
										and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
										--	AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
										--  AND extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
										AND TR1.TRANSACTION_TYPE_CD = '588'
										AND TR1.CREDIT_DEBIT_SW = 'D'
										AND TR1.TRANSACTION_SOURCE_CD = '5473'	
										AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
										AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
													FROM tmp_account_transaction TR2
												WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
													AND COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'N'  
													AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
									GROUP BY   to_char(tr1.benefit_start_dt,'Mon-YY') ,	AC1.CLIENT_ID
								),0)		 	    
								) 
								-
								SUM(
								(CASE WHEN TR.TRANSACTION_TYPE_CD = '3444' AND TR.CREDIT_DEBIT_SW = 'D' AND TR.TRANSACTION_SOURCE_CD = '5477' THEN
										COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
								ELSE
										0
								END )
								) 
								,0.00)) 
							END ) AS AVAILABLE_BALANCE_NO_COC
	
						FROM tmp_account_transaction TR, 
							TB_CLIENT_ACCOUNT AC
						WHERE TR.CLIENT_ACCOUNT_ID = AC.CLIENT_ACCOUNT_ID 
							AND AC.CLIENT_ACCOUNT_ID = v_clientaccountid 
							AND TR.DELETE_SW = 'N'  
							AND AC.DELETE_SW = 'N'  
							-- AND (date_sw is null 
							-- or case 
							-- when date_sw = 'M' then 
							-- (date_trunc('month', tr.benefit_start_dt) = date_trunc('month', CURRENT_DATE - interval '1' month)) 
							-- when date_sw = 'Y' then
							-- date_part('year', now() :: date):: integer = date_part('year', tr.benefit_start_dt):: integer
							-- --  (tat.benefit_start_dt = date_trunc('year', CURRENT_DATE)) 
							-- when date_sw = 'D' then 
							-- to_date(cast(tr.benefit_start_dt as TEXT), 'YYYY-MM-DD') 
							-- BETWEEN to_date(cast(date_from as TEXT), 'YYYY-MM-DD') 
							-- AND to_date( cast(date_to as TEXT), 'YYYY-MM-DD' ) 
							-- end) 
						GROUP BY tr.benefit_start_dt_month,
							extract (year from TR.BENEFIT_START_DT),  
							extract (month from TR.BENEFIT_START_DT), 
							AC.CLIENT_ID
						ORDER by tr.benefit_start_dt_month,
							AC.CLIENT_ID
				
					) TAB
				) TAB1
			) TAB2
			where  (date_sw is null 
					or case when date_sw = 'M' then 
						(date_trunc('month', DATE(RTRIM((TAB2.YEAR)::varchar) || '-' || RTRIM((TAB2.MONTH)::varchar) || '-01')) = date_trunc('month', CURRENT_DATE - interval '1' month)) 
					when date_sw = 'Y' then
						date_part('year', now() :: date):: integer = date_part('year', DATE(RTRIM((TAB2.YEAR)::varchar) || '-' || RTRIM((TAB2.MONTH)::varchar) || '-01')):: integer
						-- (tat.benefit_start_dt = date_trunc('year', CURRENT_DATE)) 
					when date_sw = 'D' then 
						-- to_date(cast(to_char(TAB2.benefitmonyear  , 'Mon-YY') as TEXT), 'MM-YY') 
						to_date(cast(DATE(RTRIM((TAB2.YEAR)::varchar) || '-' || RTRIM((TAB2.MONTH)::varchar) || '-01') as TEXT), 'YYYY-MM-DD') 
						BETWEEN to_date(cast(date_from as TEXT), 'YYYY-MM-DD') 
							AND to_date( cast(date_to as TEXT), 'YYYY-MM-DD' ) 
					end)
			group by  TAB2.benefitmonyear,
				TAB2.YEAR, 
				TAB2.MONTH, 
				-- TAB2.RECEIPTS_FOR_ANC,
				-- TAB2.EXCESS_AFTER_COC_REIMBURSEMENT,
				TAB2.OBLIGATIONS,
				-- TAB2.ANCILLARY_PAYMENTS,
				TAB2.BALANCE_AVAIL_FOR_ANCILLARY,
				TAB2.OTHERDISBURSEMENT,
				TAB2.OTHERDISBURSEMENTOBLIGATION	,
				TAB2.ACTUAL_COC  , 
				TAB2.AVAILABLE_BALANCE_NO_COC
			ORDER by  TAB2.year desc, 
			TAB2.month desc
			
			)x --LIMIT v_liPageSize OFFSET v_pageoffset 
	 	) as otherancillaryexcessdetails,
		-- as otherancillaryexcessdetails,
		to_char(now(),'MM/DD/YYYY') as rundate,
		(SELECT SUBSTR(p.ssnno :: character varying, LENGTH(p.ssnno :: character varying) - 3, 4)) :: character varying
			from tb_client_account tca
				inner join person p on p.cjamspid = tca.client_id
				--inner join tb_account_transaction tot on tot.client_account_id = tca.client_account_id
			where tca.client_account_id =v_clientaccountid 
				and tca.delete_sw = 'N' 
		group by p.ssnno, tca.client_account_id,tca.client_id,tca.account_type_cd,tca.account_exists_sw,
		tca.bank_nm,tca.account_no_tx, tca.total_balance_no,tca.available_balance_no,p.firstname,p.lastname,p.dob;
		--LIMIT v_liPageSize OFFSET v_pageoffset; 
		
	drop table if exists tmp_account_transaction;
	drop table if exists tmp_placemnt ;
	drop table if exists temp_payment_detail;
	drop TABLE if exists temp_payment_header;
	drop table if exists temp_payment_status ;
END;
	
$function$
;
