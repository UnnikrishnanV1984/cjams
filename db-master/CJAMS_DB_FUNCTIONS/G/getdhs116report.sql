CREATE OR REPLACE FUNCTION cjams.getdhs116report( as_section_type character varying, 
												  vl_client_acc_id integer, 
												  v_lipagesize bigint, 
												  v_lipagenumber bigint, 
												  date_sw character varying, 
												  date_from date, 
												  date_to date
												)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_dhs116report json;
	v_pagenumber int;
	v_pageoffset int;

BEGIN 
	
	IF COALESCE(v_liPageSize, 0) < 1 THEN                     
		v_liPageSize := 10;
	END IF;

	IF COALESCE(v_liPageNumber, 0) < 1 THEN
		v_liPageNumber := 1;	
	END IF;

	v_pagenumber := v_liPageNumber - 1;
	v_pageoffset := v_pagenumber * v_liPageSize;

	drop table if exists  temp_account_transaction;
	drop table if exists tmp_placemnt ;
	drop table if exists temp_payment_detail;
	drop table if exists temp_payment_header;
	drop table if exists temp_payment_status ;

	CREATE TEMP TABLE temp_account_transaction  AS
		SELECT *,to_char(ta.benefit_start_dt  , 'Mon-YY') as benefit_start_dt_MONTH  
		FROM tb_account_transaction ta  WHERE ta.client_account_id = vl_client_acc_id ;

	create temp table tmp_placemnt  as
		--select tp.placement_id  from tb_client_account ac , tb_placement tp  WHERE ac.client_id = tp.client_id  and ac.client_account_id = vl_client_acc_id ;
		select pl.alternateid as placement_id
		FROM placement pl
			JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid AND sc.activeflag = 1
			JOIN person pr ON pr.personid = pl.personid AND pr.activeflag = 1
			join tb_client_account ac on ac.client_id = pr.cjamspid 
			JOIN intakeservreqchildremoval irl ON irl.intakeservreqchildremovalid = pl.intakeservreqchildremovalid AND irl.activeflag = 1
		WHERE pl.activeflag = 1 and ac.client_account_id = vl_client_acc_id;

	create temp table temp_payment_detail as 
		select  PD.FINAL_AMOUNT_NO,PD.PAYMENT_ID,PD.PLACEMENT_ID,PD.FINAL_SERVICE_START_DT, PD.DELETE_SW, PD.FINAL_SERVICE_ID, 
			PD.CLIENT_ID, PD.PAYMENT_DETAIL_ID 
		from tb_payment_detail pd join tmp_placemnt tp on  tp.placement_id  = pd.placement_id;   

	CREATE TEMP TABLE temp_payment_header AS
		SELECT PH.PAYMENT_ID, PH.PAYMENT_TYPE_CD, PH.MANUAL_SW, PH.DELETE_SW
		FROM tb_payment_header ph join temp_payment_detail pd on ph.payment_id = pd.payment_id ;

	CREATE TEMP TABLE temp_payment_status AS
		SELECT PS.PAYMENT_ID,PS.DELETE_SW ,PS.PAYMENT_STATUS_CD  
		FROM tb_payment_status ps join temp_payment_header ph on  ph.payment_id = ps.payment_id  ;

	RAISE NOTICE '>>>>>>>>AS_SECTION_TYPE >>>> %',AS_SECTION_TYPE;

	IF AS_SECTION_TYPE = 'CLTAC' THEN -- Report Header 
		
		SELECT json_agg(e) into v_dhs116report from (
		SELECT 	CA.CLIENT_ID,		
			F_ENAME('2955',CA.CLIENT_ID) AS CLIENT_NAME,
			CONCAT('***-**-',RIGHT(PR.SSNNO::VARCHAR,4)) AS SSN,
			PR.DOB AS DOB,
			CA.OPEN_DT AS OPEN_DATE,
			CA.CLOSE_DT AS CLOSE_DATE,
			CA.BANK_NM AS BANK_NAME,
			CA.ACCOUNT_NO_TX AS ACCT_NUMBER,
			F_PDESC(CA.ACCOUNT_TYPE_CD, 40) AS ACCT_TYPE,
			F_PDESC(CA.STATUS_CD, 41) AS ACCOUNT_STATUS,
			COALESCE(CA.TOTAL_BALANCE_NO,0) AS TOTAL_BALANCE,
			COALESCE(CA.OBLIGATED_FOR_COC,0) AS TOTAL_AVAILABLE_FOR_COC,
			COALESCE(CA.OBLIGATED_FOR_COC,0) + COALESCE(CA.OBLIGATED_FOR_ANC,0) AS TOTAL_OBLIGATED,
			COALESCE(CA.OBLIGATED_FOR_ANC,0) AS TOTAL_AVAILABLE_FOR_ANC
		FROM TB_CLIENT_ACCOUNT CA,
			PERSON PR
		WHERE CA.CLIENT_ID = PR.cjamspid
			AND CA.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
			AND CA.DELETE_SW = 'N'
			AND PR.activeflag = 1
		)e	;

	ELSIF AS_SECTION_TYPE = 'TRANS' THEN -- Transactions Details
  
		SELECT json_agg(e) into v_dhs116report from (
		SELECT 	ACT.TRANSACTION_ID AS TRANSACTION_ID,
			ACT.TRANSACTION_DT AS ENTRY_DATE,
			LPAD(EXTRACT(MONTH FROM ACT.BENEFIT_START_DT)::VARCHAR,2,'0') || '/' || EXTRACT(YEAR FROM ACT.BENEFIT_START_DT) AS "BENEFIT/ANCILLARY MONTH/YEAR",
			F_PDESC(ACT.TRANSACTION_TYPE_CD, 39)AS TRANSACTION_TYPE,
			F_PDESC(ACT.TRANSACTION_SOURCE_CD, 38) AS TRANSACTION_SOURCE,
			ACT.TRANSACTION_AMOUNT_NO AS AMOUNT,
			ACT.CREDIT_DEBIT_SW
		FROM TB_CLIENT_ACCOUNT CA,
			temp_account_transaction ACT
		WHERE CA.CLIENT_ACCOUNT_ID = ACT.CLIENT_ACCOUNT_ID
			AND CA.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
			AND CA.DELETE_SW = 'N'
			AND ACT.DELETE_SW = 'N' 
		ORDER BY ACT.BENEFIT_START_DT desc
			--	 ACT.TRANSACTION_ID
		)e ;

	ELSIF AS_SECTION_TYPE = 'COCRM' THEN -- Cost of Care Reimbursement

		SELECT json_agg(e) into v_dhs116report from (
		select count(1) over() as totalcount, 
			a.monthyear,
			year,
			month, 
			sum(a.RECEIPTS_FOR_COC) as RECEIPTS_FOR_COC ,
			a.ACTUAL_COC as ACTUAL_COC, 
			sum(a.COC_REIMBURSEMENT) as COC_REIMBURSEMENT, 
			(a.AVAILABLE_BALANCE_NO_COC) as AVAILABLE_BALANCE_NO_COC 
		from 
			(select tr.benefit_start_dt_month as monthyear,
				EXTRACT(YEAR FROM TR.BENEFIT_START_DT) AS YEAR, 
				EXTRACT(MONTH FROM TR.BENEFIT_START_DT) AS MONTH, 
				(
				SUM(	
				(CASE WHEN TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C' AND  TR.TRANSACTION_SOURCE_CD in ( '587', '586', '585' ) THEN
					COALESCE(TR.TRANSACTION_AMOUNT_NO,0.00)
				ELSE 
					0.00
				END )
				)
				+
				COALESCE(( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))
					FROM temp_account_transaction TR1,
						TB_CLIENT_ACCOUNT AC1
				WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID  
					AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
					AND TR1.DELETE_SW = 'N'  
					AND AC1.DELETE_SW = 'N' 
					and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
					-- AND EXTRACT(month FROM TR1.BENEFIT_START_DT) =  EXTRACT(month FROM TR.BENEFIT_START_DT)
					-- AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
					AND TR1.TRANSACTION_TYPE_CD = '588'
					AND TR1.CREDIT_DEBIT_SW = 'C'
					AND TR1.TRANSACTION_SOURCE_CD = '5473'	
					AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
					AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
							FROM temp_account_transaction TR2
						   WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
							AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
						   GROUP BY  to_char(tr1.benefit_start_dt,'Mon-YY'),
							-- EXTRACT(year from TR1.BENEFIT_START_DT),
							-- EXTRACT(MONTH from TR1.BENEFIT_START_DT),
							AC1.CLIENT_ID	
				),0.00)		 	    
				- 
				COALESCE(( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))
					FROM temp_account_transaction TR1,
						TB_CLIENT_ACCOUNT AC1
				WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
					AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
					AND TR1.DELETE_SW = 'N'  
					AND AC1.DELETE_SW = 'N' 
					and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
					-- AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) =  EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
					-- AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =   EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
					AND TR1.TRANSACTION_TYPE_CD = '588'
					AND TR1.CREDIT_DEBIT_SW = 'D'
					AND TR1.TRANSACTION_SOURCE_CD = '5473'	
					AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
					AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
							FROM temp_account_transaction TR2
							WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
								AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
							GROUP by to_char(tr1.benefit_start_dt,'Mon-YY'),
							-- EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
							-- EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
							AC1.CLIENT_ID
				),0.00)		 	    
				) AS RECEIPTS_FOR_COC,
	
				(
				COALESCE( (SELECT SUM(COALESCE(PD.FINAL_AMOUNT_NO,0.00)  )
					FROM temp_payment_detail PD, 
						temp_payment_header PH,
						temp_payment_status PS,
						PLACEMENT PL   -- Removing view and placing with table for performance improvementment
				WHERE PH.PAYMENT_ID = PD.PAYMENT_ID
					AND PH.PAYMENT_ID = PS.PAYMENT_ID
					AND PL.alternateid= PD.PLACEMENT_ID    
					and to_char(PD.FINAL_SERVICE_START_DT,'Mon-YY') = TR.benefit_start_dt_MONTH
					-- AND EXTRACT(MONTH FROM PD.FINAL_SERVICE_START_DT) = EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
					-- AND EXTRACT(YEAR FROM PD.FINAL_SERVICE_START_DT) = EXTRACT(YEAR FROM TR.BENEFIT_START_DT) 
					AND ( PH.PAYMENT_TYPE_CD = '6' OR (PH.PAYMENT_TYPE_CD = '3294' AND PH.MANUAL_SW  = 'N' )) 
					AND PH.DELETE_SW = 'N' 
					AND PD.DELETE_SW = 'N'
					AND PS.DELETE_SW = 'N' 
					--AND PL.DELETE_SW = 'N' 
					AND PD.FINAL_SERVICE_ID IS NOT NULL
					AND PS.PAYMENT_STATUS_CD NOT IN ('1635','1639') 
					AND PD.PLACEMENT_ID IS NOT NULL
					--	  AND ( PL.VOID_SW = 'N' OR PL.VOID_SW is null OR RTRIM(LTRIM(PL.VOID_SW)) = '')
					AND (PL.isvoided=0 or PL.isvoided is null)
					AND PD.CLIENT_ID = AC.CLIENT_ID 
				),0.00)  
				-
				COALESCE((SELECT SUM(COALESCE(RD.AMOUNT_NO,0.00)  )
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
							AND PL.alternateid= PD.PLACEMENT_ID  
							and to_char(PD.FINAL_SERVICE_START_DT,'Mon-YY') = TR.benefit_start_dt_MONTH
					-- AND EXTRACT(MONTH FROM PD.FINAL_SERVICE_START_DT) = EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
					-- AND EXTRACT(YEAR FROM PD.FINAL_SERVICE_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
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
					AND PD.CLIENT_ID = AC.CLIENT_ID
													)
				),0.00)	
				) AS ACTUAL_COC,

				SUM(
				(CASE WHEN TR.TRANSACTION_TYPE_CD = '3444' AND TR.CREDIT_DEBIT_SW = 'D' AND TR.TRANSACTION_SOURCE_CD = '5477' THEN
					COALESCE(TR.TRANSACTION_AMOUNT_NO,0.00)
				ELSE
					0.00
				END )
				) AS COC_REIMBURSEMENT,
				
				/*
				COALESCE((
				( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00)) 
						FROM temp_account_transaction TR1,
						 TB_CLIENT_ACCOUNT AC1
				   WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
					AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
					AND TR1.DELETE_SW = 'N' 
					AND TR1.CREDIT_DEBIT_SW = 'C'
					AND AC1.DELETE_SW = 'N'  
					and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
					--	AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) =  EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
					--	AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
					AND TR1.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
					AND ( TR1.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - INTERVAL '2 MONTHS'  ,'L' , 'C')  
							 OR COALESCE(TR1.LATE_ENTRY_SW, 'N')  = 'Y' )  
					GROUP BY  to_char(tr1.benefit_start_dt,'Mon-YY'),
						--	EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
						-- EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
						AC1.CLIENT_ID
				) 
				+ 
				COALESCE((
				SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))	    
					FROM temp_account_transaction TR1,
					 TB_CLIENT_ACCOUNT AC1
				WHERE  TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
					AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
					AND TR1.DELETE_SW = 'N' 
					AND AC1.DELETE_SW = 'N'  
					AND TR1.TRANSACTION_TYPE_CD = '588'
					AND TR1.CREDIT_DEBIT_SW = 'C'
					AND TR1.TRANSACTION_SOURCE_CD = '5473'	
					AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
					and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
					-- AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) = EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
					-- AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
					AND TR1.REFERENCE_TRANSACTION_ID in 
					( 
					  SELECT TR2.TRANSACTION_ID
							FROM temp_account_transaction TR2,
									 TB_CLIENT_ACCOUNT AC2
						WHERE TR2.CLIENT_ACCOUNT_ID = AC2.CLIENT_ACCOUNT_ID 
								AND AC2.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
								AND TR2.DELETE_SW = 'N' 
								AND AC2.DELETE_SW = 'N'  
								AND TR2.CREDIT_DEBIT_SW = 'C'
								AND TR2.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
								AND ( TR2.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - INTERVAL '2 MONTHS'  ,'L' , 'C')  
										 OR COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'Y' )  
					)
					GROUP by    to_char(tr1.benefit_start_dt,'Mon-YY'),
						-- EXTRACT(YEAR FROM TR1.BENEFIT_START_DT),
						-- EXTRACT(MONTH FROM TR1.BENEFIT_START_DT),
						AC1.CLIENT_ID

				),0.00)
				-
				COALESCE((
				SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0.00))	    
					FROM temp_account_transaction TR1,
						TB_CLIENT_ACCOUNT AC1
				WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
					AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
					AND TR1.DELETE_SW = 'N' 
					AND AC1.DELETE_SW = 'N'  
					AND TR1.TRANSACTION_TYPE_CD = '588'
					AND TR1.CREDIT_DEBIT_SW = 'D'
					AND TR1.TRANSACTION_SOURCE_CD = '5473'	
					AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
					and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
					-- AND EXTRACT(MONTH FROM TR1.BENEFIT_START_DT) =  EXTRACT(MONTH FROM TR.BENEFIT_START_DT)
					-- AND EXTRACT(YEAR FROM TR1.BENEFIT_START_DT) =  EXTRACT(YEAR FROM TR.BENEFIT_START_DT)
					AND TR1.REFERENCE_TRANSACTION_ID in 
					( 
					  SELECT TR2.TRANSACTION_ID
							FROM temp_account_transaction TR2,
									 TB_CLIENT_ACCOUNT AC2
						WHERE TR2.CLIENT_ACCOUNT_ID = AC2.CLIENT_ACCOUNT_ID 
								AND AC2.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
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
				),0.00) AS AVAILABLE_BALANCE_NO_COC,
				*/
					 
				(CASE WHEN DATE(RTRIM((extract(year from TR.BENEFIT_START_DT))::varchar) || '-' || RTRIM((extract (month from TR.BENEFIT_START_DT))::varchar) || '-01') > F_daymonth(CURRENT_DATE - interval '2 MONTHS'  ,'L' , 'C')  THEN	 
					0
				ELSE
					--	TAB.BALANCE_AVAIL_FOR_ANCLL
					 
					(COALESCE( 
					(SUM((CASE WHEN TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C' AND  TR.TRANSACTION_SOURCE_CD 
								in ( '587', '586', '585' ) AND COALESCE(TR.LATE_ENTRY_SW, 'N')  = 'N'   THEN
							COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
						 ELSE
							0
						END )
					)
					+
					COALESCE(
					( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
						FROM temp_account_transaction TR1,
							TB_CLIENT_ACCOUNT AC1
					WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
						AND AC1.CLIENT_ACCOUNT_ID = vl_client_acc_id
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
									FROM temp_account_transaction TR2
								WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
											AND COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'N'  
											AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
								GROUP BY  extract (month from TR1.BENEFIT_START_DT), 
									extract (year from TR1.BENEFIT_START_DT) ,	AC1.CLIENT_ID
					),0)		 	    
					- 
					COALESCE(( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
						FROM temp_account_transaction TR1,
							TB_CLIENT_ACCOUNT AC1
					WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
						AND AC1.CLIENT_ACCOUNT_ID = vl_client_acc_id
						AND TR1.DELETE_SW = 'N'  
						AND AC1.DELETE_SW = 'N'  
						and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
						-- AND  extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
						-- AND  extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
						AND TR1.TRANSACTION_TYPE_CD = '588'
						AND TR1.CREDIT_DEBIT_SW = 'D'
						AND TR1.TRANSACTION_SOURCE_CD = '5473'	
						AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
						AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
								FROM temp_account_transaction TR2
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
			
			FROM temp_account_transaction TR, 
				TB_CLIENT_ACCOUNT AC
			WHERE TR.CLIENT_ACCOUNT_ID = AC.CLIENT_ACCOUNT_ID 
				AND AC.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
				AND TR.DELETE_SW = 'N'  
				AND AC.DELETE_SW = 'N'  
				and 
				(date_sw is null 
				or case when date_sw = 'M' then 
					(date_trunc('month', TR.benefit_start_dt) = date_trunc('month', CURRENT_DATE - interval '1' month)) 
				when date_sw = 'Y' then
					date_part('year', now() :: date):: integer = date_part('year', TR.benefit_start_dt):: integer
					--  (tat.benefit_start_dt = date_trunc('year', CURRENT_DATE)) 
				when date_sw = 'D' then 
					to_date(cast(TR.benefit_start_dt as TEXT), 'YYYY-MM-DD') 
						BETWEEN to_date(cast(date_from as TEXT), 'YYYY-MM-DD') 
							AND to_date( cast(date_to as TEXT), 'YYYY-MM-DD' ) 
				end) 
			GROUP BY tr.benefit_start_dt_month,
			   AC.CLIENT_ID,
			   EXTRACT(YEAR FROM TR.BENEFIT_START_DT),
			   EXTRACT(MONTH FROM TR.BENEFIT_START_DT) 
			)a
			group by  a.monthyear ,A.YEAR , A.MONTH ,a.ACTUAL_COC,
				-- a.COC_REIMBURSEMENT  ,
			   a.AVAILABLE_BALANCE_NO_COC
			order by   A.YEAR DESC,
			  A.MONTH desc LIMIT v_liPageSize OFFSET v_pageoffset  
		)e ;
	
	ELSIF AS_SECTION_TYPE = 'ANCLR' THEN -- Ancillary Services Child Account Funded 

		SELECT json_agg(e) into v_dhs116report from 
		(select --a.BENEFIT_START_DT,
			count(1) over() as totalcount,		
			a.YEAR, 
			a.MONTH, 
			a.monthyear,
			sum(a.RECEIPTS_FOR_ANC) as RECEIPTS_FOR_ANC,
			sum(a.EXCESS_AFTER_COC_REIMBURSEMENT) as EXCESS_AFTER_COC_REIMBURSEMENT,
			(a.OBLIGATIONS),
			a.OTHERDISBURSEMENT,
			a.OTHERDISBURSEMENTOBLIGATION,	
			sum(a.ANCILLARY_PAYMENTS) as ANCILLARY_PAYMENTS,
			(a.BALANCE_AVAIL_FOR_ANCILLARY)
		from (
		
			SELECT tab2.MONTHYEAR,
				TAB2.YEAR, 
				TAB2.MONTH, 
				TAB2.RECEIPTS_FOR_ANC,
				TAB2.EXCESS_AFTER_COC_REIMBURSEMENT,
				TAB2.OBLIGATIONS,
				TAB2.ANCILLARY_PAYMENTS,
				TAB2.BALANCE_AVAIL_FOR_ANCILLARY,
				TAB2.OTHERDISBURSEMENT,
				TAB2.OTHERDISBURSEMENTOBLIGATION	
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
						-  TAB.OBLIGATIONS 
						-  TAB.ANCILLARY_PAYMENTS - (TAB.OTHERDISBURSEMENT + TAB.OTHERDISBURSEMENTOBLIGATION)
						) AS MONTHY_BAL_AVAIL_FOR_ANC
						-- TAB.OTHERDISBURSEMENT,
						-- TAB.OTHERDISBURSEMENTOBLIGATION		
					FROM 
					( 
						select 
							tr.benefit_start_dt_MONTH as monthyear,		
							extract(year from TR.BENEFIT_START_DT) AS YEAR, 
							extract (month from TR.BENEFIT_START_DT) AS MONTH, 
							(
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C' 
									AND  TR.TRANSACTION_SOURCE_CD in ( '5471', '582', '583', '584', '5478' ) THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							)
							/* CDM-10843 Fix - Bank Service Charges moved to otherdisbursement
							- 	
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '588' AND TR.CREDIT_DEBIT_SW = 'D' 
								AND ADJUSTMENT_APPROVAL_STATUS_CD = '3047' AND TR.TRANSACTION_SOURCE_CD = '5472' THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							)
							*/
							+	
							COALESCE(( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
								FROM temp_account_transaction TR1,
									TB_CLIENT_ACCOUNT AC1
							WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = vl_client_acc_id
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
										FROM temp_account_transaction TR2
										WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
												AND TR2.DELETE_SW = 'N' ) in  ( '5471', '582', '583', '584', '5478' ))
										GROUP BY  extract (month from TR1.BENEFIT_START_DT) ,  
											extract (year from TR1.BENEFIT_START_DT) ,   AC1.CLIENT_ID
							),0)		 	    
							- 
							COALESCE(( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
								FROM temp_account_transaction TR1,
									TB_CLIENT_ACCOUNT AC1
							WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = vl_client_acc_id
								AND TR1.DELETE_SW = 'N'  
								AND AC1.DELETE_SW = 'N'  
								and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
								-- AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
								-- AND extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
								AND TR1.TRANSACTION_TYPE_CD = '588'
								AND TR1.CREDIT_DEBIT_SW = 'D'
								AND TR1.TRANSACTION_SOURCE_CD = '5473'	
								AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
										FROM temp_account_transaction TR2
									WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
												AND TR2.DELETE_SW = 'N' ) in  ( '5471', '582', '583', '584', '5478' ))
									GROUP BY extract (month from TR1.BENEFIT_START_DT) , 
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
									AND  TR.TRANSACTION_SOURCE_CD = '5475' THEN
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
									AND TR.TRANSACTION_SOURCE_CD in ( '587', '586', '585' ) 
									AND COALESCE(TR.LATE_ENTRY_SW, 'N')  = 'N'  THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END )
							)
							+
							COALESCE(( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
							FROM temp_account_transaction TR1,
									TB_CLIENT_ACCOUNT AC1
							WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = vl_client_acc_id
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
										FROM temp_account_transaction TR2
									WHERE TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
											AND COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'N'  
											AND TR2.DELETE_SW = 'N' ) in  ( '587', '586', '585' ))
									GROUP BY  extract (month from TR1.BENEFIT_START_DT), 
										extract (year from TR1.BENEFIT_START_DT) ,	AC1.CLIENT_ID
							),0)		 	    
							- 
							COALESCE(( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
								FROM temp_account_transaction TR1,
									TB_CLIENT_ACCOUNT AC1
							WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
								AND AC1.CLIENT_ACCOUNT_ID = vl_client_acc_id
								AND TR1.DELETE_SW = 'N'  
								AND AC1.DELETE_SW = 'N'  
								and to_char(tr1.benefit_start_dt,'Mon-YY') = TR.benefit_start_dt_MONTH
								-- AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
								-- AND extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
								AND TR1.TRANSACTION_TYPE_CD = '588'
								AND TR1.CREDIT_DEBIT_SW = 'D'
								AND TR1.TRANSACTION_SOURCE_CD = '5473'	
								AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
								AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
										FROM temp_account_transaction TR2
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
							) ) AS BALANCE_AVAIL_FOR_ANCLL,
							
							(
							ROUND( AVG(
							(select coalesce(sum(tcd.amount),0) 
								from tb_child_account_disbursement tcd 
							where tcd.client_account_id = vl_client_acc_id 
								and tcd.payment_approval_status = '3047'
								and to_char(tcd.disbursement_dt, 'Mon-YY') = tr.benefit_start_DT_MONTH 
								and tcd.service_id != 101
							)):: numeric (10,2),2)
							-- CDM-10843
							+
							SUM(
							(CASE WHEN TR.TRANSACTION_TYPE_CD = '588' AND TR.CREDIT_DEBIT_SW = 'D' 
								AND ADJUSTMENT_APPROVAL_STATUS_CD = '3047' AND TR.TRANSACTION_SOURCE_CD = '5472' THEN
								COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
							ELSE
								0
							END ))
							) as otherdisbursement,
		
							ROUND( AVG(
							( select coalesce(sum(tcd.amount),0) 
								from tb_child_account_disbursement tcd 
							where tcd.client_account_id = vl_client_acc_id 
								and (tcd.payment_approval_status not in ('3047','3281') or tcd.funding_approval_status not in ('3047','3281'))
								-- and (tcd.payment_approval_status is null or tcd.payment_approval_status = '3281')
								-- or (tcd.funding_approval_status is null or tcd.funding_approval_status = '3405' or tcd.funding_approval_status = '3281')
								and to_char(tcd.disbursement_dt, 'Mon-YY') = tr.benefit_start_DT_MONTH
								and tcd.service_id != 101
							) ):: numeric (10,2),2) as otherdisbursementobligation
						FROM temp_account_transaction TR, 
							TB_CLIENT_ACCOUNT AC
						WHERE TR.CLIENT_ACCOUNT_ID = AC.CLIENT_ACCOUNT_ID 
							AND AC.CLIENT_ACCOUNT_ID = vl_client_acc_id 
							AND TR.DELETE_SW = 'N'  
							AND AC.DELETE_SW = 'N'  
						GROUP BY extract (month from TR.BENEFIT_START_DT),
							extract (year from TR.BENEFIT_START_DT),
							tr.benefit_start_dt_month
							, AC.CLIENT_ID
						ORDER by
						-- extract (month from TR.BENEFIT_START_DT) desc
						--	,  extract (year from TR.BENEFIT_START_DT) desc
						tr.benefit_start_dt_month
						,AC.CLIENT_ID
					) TAB
				) TAB1
			) TAB2
		) A
		where (date_sw is null 
				or case 
				when date_sw = 'M' then 
					(date_trunc('month', DATE(RTRIM((a.YEAR)::varchar) || '-' || RTRIM((a.MONTH)::varchar) || '-01')) = date_trunc('month', CURRENT_DATE - interval '1' month)) 
				when date_sw = 'Y' then
					date_part('year', now() :: date):: integer = date_part('year', DATE(RTRIM((a.YEAR)::varchar) || '-' || RTRIM((a.MONTH)::varchar) || '-01')):: integer
					--  (tat.benefit_start_dt = date_trunc('year', CURRENT_DATE))  
				end)
		group by --a.BENEFIT_START_DT, 
			a.YEAR, 
			a.month,--  (a.EXCESS_AFTER_COC_REIMBURSEMENT),
			a.monthyear,
			(a.OBLIGATIONS),
			(a.BALANCE_AVAIL_FOR_ANCILLARY),
			a.OTHERDISBURSEMENT,
			a.OTHERDISBURSEMENTOBLIGATION
			order by  a.year desc , 
			a.month desc 
			LIMIT v_liPageSize OFFSET v_pageoffset
		)e ;

	ELSIF AS_SECTION_TYPE = 'SAVE' THEN -- Save As Excel   	

		SELECT json_agg(e) into v_dhs116report from (
		SELECT 	CA.CLIENT_ID,
			F_ENAME('2955',CA.CLIENT_ID) AS CLIENT_NAME,
			CONCAT('***-**-',RIGHT(PR.SSNNO::varchar,4)) AS SSN,
			PR.DOB AS DOB,
			CA.OPEN_DT AS OPEN_DATE,
			CA.CLOSE_DT AS CLOSE_DATE,
			CA.BANK_NM AS BANK_NAME,
			CA.ACCOUNT_NO_TX AS ACCT_NUMBER,
			F_PDESC(CA.ACCOUNT_TYPE_CD, 40) AS ACCT_TYPE,
			F_PDESC(CA.STATUS_CD, 41) AS ACCOUNT_STATUS,
			COALESCE(CA.TOTAL_BALANCE_NO,0) AS TOTAL_BALANCE,
			COALESCE(CA.OBLIGATED_FOR_COC,0) AS TOTAL_AVAILABLE_FOR_COC,
			COALESCE(CA.OBLIGATED_FOR_COC,0) + COALESCE(CA.OBLIGATED_FOR_ANC,0) AS TOTAL_OBLIGATED,
			COALESCE(CA.OBLIGATED_FOR_ANC,0) AS TOTAL_AVAILABLE_FOR_ANC,
			ACT.TRANSACTION_ID AS TRANSACTION_ID,
			ACT.TRANSACTION_DT AS ENTRY_DATE,
			-- LPAD(extract(month from ACT.BENEFIT_START_DT),2,'0') || '/' ||extract(year from ACT.BENEFIT_START_DT) AS "BENEFIT/ANCILLARY MONTH/YEAR",
			to_char(act.benefit_start_dt  , 'DD-Mon-YY')  AS "BENEFIT/ANCILLARY MONTH/YEAR",
			F_PDESC(ACT.TRANSACTION_TYPE_CD, 39)AS TRANSACTION_TYPE,
			F_PDESC(ACT.TRANSACTION_SOURCE_CD, 38) AS TRANSACTION_SOURCE,
			ACT.TRANSACTION_AMOUNT_NO AS AMOUNT,
			ACT.CREDIT_DEBIT_SW,
			TAB3.*
		FROM TB_CLIENT_ACCOUNT CA,
			PERSON PR,
			temp_account_transaction ACT,
			( select A.BENEFIT_MONTHYEAR, 
				SUM(A.RECEIPTS_AVAILABLE_FOR_COC) as RECEIPTS_AVAILABLE_FOR_COC, 
				SUM(A.ACTUAL_COC) as ACTUAL_COC,
				SUM(A.COC_REIMBURSEMENT) as COC_REIMBURSEMENT, 
				SUM(A.EXCESS_AVAILABLE_FOR_ANCILLARY) as EXCESS_AVAILABLE_FOR_ANCILLARY,
				SUM(A.RECEIPTS_AVAILABLE_FOR_ANCILLARY) as RECEIPTS_AVAILABLE_FOR_ANCILLARY,
				SUM(A.OBLIGATIONS) as OBLIGATIONS,
				SUM(A.ANCILLARY_PAYMENTS) as ANCILLARY_PAYMENTS, 
				SUM(A.BALANCE_AVAIL_FOR_ANCILLARY) as BALANCE_AVAIL_FOR_ANCILLARY  
			from 
				(SELECT	TAB2.MONTHYEAR as BENEFIT_MONTHYEAR,
					--	TAB2.YEAR AS BENEFIT_YEAR, 
					-- TAB2.MONTH AS BENEFIT_MONTH,
					TAB2.RECEIPTS_AVAILABLE_FOR_COC,
					TAB2.ACTUAL_COC,
					TAB2.COC_REIMBURSEMENT,
					(TAB2.RECEIPTS_AVAILABLE_FOR_COC - TAB2.AVAILABLE_BALANCE_NO_COC - TAB2.COC_REIMBURSEMENT) AS EXCESS_AVAILABLE_FOR_ANCILLARY,
					TAB2.RECEIPTS_FOR_ANC AS RECEIPTS_AVAILABLE_FOR_ANCILLARY,
					TAB2.EXCESS_AFTER_COC_REIMBURSEMENT,
					TAB2.OBLIGATIONS,
					TAB2.ANCILLARY_PAYMENTS,
					TAB2.BALANCE_AVAIL_FOR_ANCILLARY

				FROM (
					SELECT TAB1.*,
						SUM(TAB1.MONTHY_BAL_AVAIL_FOR_ANC) OVER (ORDER BY TAB1.monthyear desc/*, TAB1.MONTH*/) AS BALANCE_AVAIL_FOR_ANCILLARY
					FROM (
						SELECT 	TAB.*,
							(CASE WHEN  date('01-' || RTRIM((TAB.monthyear)::varchar)) >  F_daymonth(CURRENT_DATE - interval '2 MONTHS'  ,'L' , 'C') THEN 
								0 
							ELSE 
								TAB.BALANCE_AVAIL_FOR_ANCLL 
							END ) AS EXCESS_AFTER_COC_REIMBURSEMENT,
							( TAB.RECEIPTS_FOR_ANC  
							+ 
							(CASE WHEN  date('01-' || RTRIM((TAB.monthyear)::varchar)) >  F_daymonth(CURRENT_DATE - interval '2 MONTHS'  ,'L' , 'C') THEN 
								0 
							ELSE 
								TAB.BALANCE_AVAIL_FOR_ANCLL 
							END )
							- 
							TAB.OBLIGATIONS 
							- 
							TAB.ANCILLARY_PAYMENTS
							) AS MONTHY_BAL_AVAIL_FOR_ANC
						FROM (
							SELECT	to_char(tr.benefit_start_dt  , 'Mon-YY') as monthyear,
								-- extract (year from TR.BENEFIT_START_DT) AS YEAR,
								-- extract (month from TR.BENEFIT_START_DT) AS MONTH,
								(
								SUM(  
								(CASE WHEN TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C'
										AND TR.TRANSACTION_SOURCE_CD IN ( '5471', '582', '583', '584', '5478' ) THEN 
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
								ELSE 
									0 
								END)
								)
								/* CDM-10843 Fix - Bank Service Charges moved out from here 
								-
								SUM( 
								(CASE WHEN TR.TRANSACTION_TYPE_CD = '588' AND TR.CREDIT_DEBIT_SW = 'D'
										AND ADJUSTMENT_APPROVAL_STATUS_CD = '3047' AND TR.TRANSACTION_SOURCE_CD = '5472' THEN 
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
								ELSE 
									0 
								END)
								)
								*/
								+
								COALESCE(
								(SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
									FROM temp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
								WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
									AND TR1.DELETE_SW = 'N'  
									AND AC1.DELETE_SW = 'N'  
									and to_char(tr1.benefit_start_dt,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									-- AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
									-- AND extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'C'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
									AND (	( SELECT TR2.TRANSACTION_SOURCE_CD 
													FROM temp_account_transaction TR2
													WHERE 	TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
															AND TR2.DELETE_SW = 'N' 
											) IN  ( '5471', '582', '583', '584', '5478' )
										)
								GROUP BY 	to_char(tr1.benefit_start_dt,'Mon-YY'),
									-- extract (year from TR1.BENEFIT_START_DT),
									-- extract (month from TR1.BENEFIT_START_DT),
									AC1.CLIENT_ID
								),0)		 	    
								- 
								COALESCE(
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
									FROM temp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
								WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
									AND TR1.DELETE_SW = 'N'  
									AND AC1.DELETE_SW = 'N'  
									and to_char(tr1.benefit_start_dt,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									-- AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
									-- AND extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'D'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
									AND (	( SELECT TR2.TRANSACTION_SOURCE_CD 
												FROM temp_account_transaction TR2
											WHERE 	TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
													AND TR2.DELETE_SW = 'N' 
											) IN  ( '5471', '582', '583', '584', '5478' )
											)
											GROUP BY to_char(tr1.benefit_start_dt,'Mon-YY') ,
												-- extract (year from TR1.BENEFIT_START_DT),
												-- extract (month from TR1.BENEFIT_START_DT),
												AC1.CLIENT_ID
								),0)
								) AS RECEIPTS_FOR_ANC,

								(COALESCE 
								(SUM(
								(CASE WHEN TR.TRANSACTION_TYPE_CD = '5530' AND TR.CREDIT_DEBIT_SW = 'D'
										AND  TR.TRANSACTION_SOURCE_CD = '5474'THEN 
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
								ELSE 
									0 
								END ))
								-
								SUM(
								(CASE WHEN	TR.TRANSACTION_TYPE_CD = '5530' AND TR.CREDIT_DEBIT_SW = 'C'
										AND TR.TRANSACTION_SOURCE_CD = '5475' THEN 
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
								ELSE 
									0 
								END ))
								,0)
								)AS OBLIGATIONS,

								SUM(
								( CASE WHEN	TR.TRANSACTION_TYPE_CD = '5531' AND TR.CREDIT_DEBIT_SW = 'D'
										AND TR.TRANSACTION_SOURCE_CD = '5476' THEN 
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
								ELSE 
									0 
								END)
								) AS ANCILLARY_PAYMENTS,

								( (	SUM(
								(CASE WHEN 	TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C'
										AND TR.TRANSACTION_SOURCE_CD IN ( '587', '586', '585' )
										AND COALESCE(TR.LATE_ENTRY_SW, 'N')  = 'N' THEN 
									COALESCE (TR.TRANSACTION_AMOUNT_NO,0)
								ELSE 
									0 
								END )
								)
								+
								COALESCE(
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
								FROM temp_account_transaction TR1,
									TB_CLIENT_ACCOUNT AC1
								WHERE TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
									AND TR1.DELETE_SW = 'N'  
									AND AC1.DELETE_SW = 'N' 
									and to_char(tr1.benefit_start_dt,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									-- AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
									-- AND extract (year from TR1.BENEFIT_START_DT) = extract (year from TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'C'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
									AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
											FROM temp_account_transaction TR2
											WHERE 	TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
													AND COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'N'  
													AND TR2.DELETE_SW = 'N' 
										 ) IN  ( '587', '586', '585' )
										)
								GROUP BY to_char(tr1.benefit_start_dt,'Mon-YY'),
									-- extract (year from TR1.BENEFIT_START_DT),
									-- extract (month from TR1.BENEFIT_START_DT),
									AC1.CLIENT_ID
								),0)
								- 
								COALESCE(
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
									FROM	temp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
								WHERE 	TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
									AND TR1.DELETE_SW = 'N'  
									AND AC1.DELETE_SW = 'N'  
									and to_char(tr1.benefit_start_dt,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									-- AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
									-- AND extract (year from TR1.BENEFIT_START_DT) =extract (year from TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'D'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
									AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
												FROM temp_account_transaction TR2
												WHERE	TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
														AND COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'N'  
														AND TR2.DELETE_SW = 'N'
											) IN ( '587', '586', '585' )
										)
									GROUP BY to_char(tr1.benefit_start_dt,'Mon-YY'),
										-- extract (year from TR1.BENEFIT_START_DT),
										-- extract (month from TR1.BENEFIT_START_DT),
										AC1.CLIENT_ID
								),0)		 	    
								) 
								-
								SUM(
								( CASE	WHEN TR.TRANSACTION_TYPE_CD = '3444' AND TR.CREDIT_DEBIT_SW = 'D'
										AND TR.TRANSACTION_SOURCE_CD = '5477' THEN	
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
								ELSE 	
									0 
								END )) 
								) AS BALANCE_AVAIL_FOR_ANCLL,
								
								(SUM(
								(CASE WHEN TR.TRANSACTION_TYPE_CD = '589' AND TR.CREDIT_DEBIT_SW = 'C'
										AND  TR.TRANSACTION_SOURCE_CD IN ( '587', '586', '585' ) THEN	
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
								ELSE 	
									0
								END )
								)
								+
								COALESCE(
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
									FROM	temp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
								WHERE	TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
									AND TR1.DELETE_SW = 'N'  
									AND AC1.DELETE_SW = 'N'
									and to_char(tr1.benefit_start_dt,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									-- AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
									-- AND extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'C'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
									AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
													FROM 	temp_account_transaction TR2
													WHERE	TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
															AND TR2.DELETE_SW = 'N' ) IN  ( '587', '586', '585' )
											)
								GROUP by to_char(tr1.benefit_start_dt,'Mon-YY') ,
									-- extract (year from TR1.BENEFIT_START_DT),
									--	extract (month from TR1.BENEFIT_START_DT),
									AC1.CLIENT_ID
								),0)		 	    
								- 
								COALESCE(
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))
									FROM temp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
								WHERE	TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
									AND TR1.DELETE_SW = 'N'  
									AND AC1.DELETE_SW = 'N'
									and to_char(tr1.benefit_start_dt,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									-- AND extract (month from TR1.BENEFIT_START_DT) = extract (month from TR.BENEFIT_START_DT)
									-- AND extract (year from TR1.BENEFIT_START_DT) = extract (year from TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'D'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
									AND (( SELECT TR2.TRANSACTION_SOURCE_CD 
												FROM	temp_account_transaction TR2
												WHERE	TR2.TRANSACTION_ID =  TR1.REFERENCE_TRANSACTION_ID
														AND TR2.DELETE_SW = 'N' 
											) IN  ( '587', '586', '585' )
										)
								GROUP BY	to_char(tr1.benefit_start_dt,'Mon-YY'),
									-- extract (year from TR1.BENEFIT_START_DT),
									-- extract (month from TR1.BENEFIT_START_DT),
									AC1.CLIENT_ID
								),0)		 	    
								) AS RECEIPTS_AVAILABLE_FOR_COC,
			
								( COALESCE((SELECT SUM(COALESCE(PD.FINAL_AMOUNT_NO,0)  )
									FROM	temp_payment_detail PD, 
										temp_payment_header PH,
										temp_payment_status PS,
										PLACEMENT PL
								WHERE PH.PAYMENT_ID = PD.PAYMENT_ID
									AND PH.PAYMENT_ID = PS.PAYMENT_ID
									AND PL.alternateid= PD.PLACEMENT_ID      
									and to_char(PD.FINAL_SERVICE_START_DT,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									-- AND extract (month from PD.FINAL_SERVICE_START_DT) = extract (month from TR.BENEFIT_START_DT)
									-- AND extract (year from PD.FINAL_SERVICE_START_DT) = extract (year from TR.BENEFIT_START_DT)
									AND ( PH.PAYMENT_TYPE_CD = '6' OR (PH.PAYMENT_TYPE_CD = '3294' AND PH.MANUAL_SW  = 'N' )) 
									AND PH.DELETE_SW = 'N' 
									AND PD.DELETE_SW = 'N'
									AND PS.DELETE_SW = 'N' 
									--AND PL.DELETE_SW = 'N' 
									AND PD.FINAL_SERVICE_ID IS NOT NULL
									AND PS.PAYMENT_STATUS_CD NOT IN ('1635','1639') 
									AND PD.PLACEMENT_ID IS NOT NULL
									--AND ( PL.VOID_SW = 'N' OR PL.VOID_SW is null OR RTRIM(LTRIM(PL.VOID_SW)) = '')
									AND (PL.isvoided=0 or PL.isvoided is null)
									AND PD.CLIENT_ID = AC.CLIENT_ID 
								),0)  
								-
								COALESCE(
								(SELECT SUM(COALESCE(RD.AMOUNT_NO,0)  )
									FROM TB_RECEIVABLE_DETAIL RD
								WHERE 	RD.DELETE_SW = 'N' 
									AND RD.PAYMENT_DETAIL_ID 
									IN ( SELECT PD.PAYMENT_DETAIL_ID	
											FROM	temp_payment_detail PD, 
											temp_payment_header PH,
											temp_payment_status PS,
											PLACEMENT PL
										WHERE	PH.PAYMENT_ID = PD.PAYMENT_ID
											AND PH.PAYMENT_ID = PS.PAYMENT_ID
											AND PL.alternateid= PD.PLACEMENT_ID     
											and to_char(PD.FINAL_SERVICE_START_DT,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
											--	and extract (month from PD.FINAL_SERVICE_START_DT) = extract (month from TR.BENEFIT_START_DT)
											--	AND extract (year from PD.FINAL_SERVICE_START_DT) = extract (year from TR.BENEFIT_START_DT)
											AND ( PH.PAYMENT_TYPE_CD = '6' OR (PH.PAYMENT_TYPE_CD = '3294' AND PH.MANUAL_SW  = 'N' )) 
											AND PH.DELETE_SW = 'N' 
											AND PD.DELETE_SW = 'N'
											AND PS.DELETE_SW = 'N' 
											--AND PL.DELETE_SW = 'N' 
											AND PD.FINAL_SERVICE_ID IS NOT NULL
											AND PS.PAYMENT_STATUS_CD NOT IN ('1635','1639') 
											AND PD.PLACEMENT_ID IS NOT NULL
											--AND ( PL.VOID_SW = 'N' OR PL.VOID_SW is null OR RTRIM(LTRIM(PL.VOID_SW)) = '')
											AND (PL.isvoided=0 or PL.isvoided is null)
											AND PD.CLIENT_ID = AC.CLIENT_ID
																			)
								),0)
								) AS ACTUAL_COC,

								SUM( 
								(CASE WHEN TR.TRANSACTION_TYPE_CD = '3444' AND TR.CREDIT_DEBIT_SW = 'D'
										AND TR.TRANSACTION_SOURCE_CD = '5477' THEN	
									COALESCE(TR.TRANSACTION_AMOUNT_NO,0)
								ELSE 	
									0 
								END)) AS COC_REIMBURSEMENT,

								COALESCE((	
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0)) 
									FROM temp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
								WHERE	TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
									AND TR1.DELETE_SW = 'N' 
									AND TR1.CREDIT_DEBIT_SW = 'C'
									AND AC1.DELETE_SW = 'N'  
									and to_char(TR1.BENEFIT_START_DT,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									--	AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
									--	AND extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
									AND TR1.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
									AND ( TR1.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - interval '2 MONTHS'  ,'L' , 'C')  
											OR COALESCE(TR1.LATE_ENTRY_SW, 'N')  = 'Y' 
										)  
								GROUP BY to_char(TR1.BENEFIT_START_DT,'Mon-YY'),
									-- extract (year from TR1.BENEFIT_START_DT),
									-- extract (month from TR1.BENEFIT_START_DT),
									AC1.CLIENT_ID
								)
								+ 
								COALESCE(
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))	    
									FROM temp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
								WHERE	TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
									AND TR1.DELETE_SW = 'N' 
									AND AC1.DELETE_SW = 'N'  
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'C'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
									and to_char(TR1.BENEFIT_START_DT,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									--	AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
									--	AND extract (year from TR1.BENEFIT_START_DT) = extract (year from TR.BENEFIT_START_DT)
									AND TR1.REFERENCE_TRANSACTION_ID IN 
												(	SELECT TR2.TRANSACTION_ID
													FROM	temp_account_transaction TR2,
														TB_CLIENT_ACCOUNT AC2
													WHERE 	TR2.CLIENT_ACCOUNT_ID = AC2.CLIENT_ACCOUNT_ID 
														AND AC2.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
														AND TR2.DELETE_SW = 'N' 
														AND AC2.DELETE_SW = 'N'  
														AND TR2.CREDIT_DEBIT_SW = 'C'
														AND TR2.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
														AND ( TR2.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - interval '2 MONTHS'  ,'L' , 'C')  
																 OR COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'Y'
															)  
												)
								GROUP BY to_char(TR1.BENEFIT_START_DT,'Mon-YY') ,
									-- extract (year from TR1.BENEFIT_START_DT),
									--	extract (month from TR1.BENEFIT_START_DT),
									AC1.CLIENT_ID

								),0)
								-
								COALESCE(
								( SELECT SUM(COALESCE(TR1.TRANSACTION_AMOUNT_NO,0))	    
									FROM	temp_account_transaction TR1,
										TB_CLIENT_ACCOUNT AC1
								WHERE	TR1.CLIENT_ACCOUNT_ID = AC1.CLIENT_ACCOUNT_ID 
									AND AC1.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
									AND TR1.DELETE_SW = 'N' 
									AND AC1.DELETE_SW = 'N'  
									AND TR1.TRANSACTION_TYPE_CD = '588'
									AND TR1.CREDIT_DEBIT_SW = 'D'
									AND TR1.TRANSACTION_SOURCE_CD = '5473'	
									AND TR1.ADJUSTMENT_APPROVAL_STATUS_CD = '3047'
									and to_char(TR1.BENEFIT_START_DT,'Mon-YY') = to_char(tr.benefit_start_dt  , 'Mon-YY')
									-- AND extract (month from TR1.BENEFIT_START_DT) =  extract (month from TR.BENEFIT_START_DT)
									-- AND extract (year from TR1.BENEFIT_START_DT) =  extract (year from TR.BENEFIT_START_DT)
									AND TR1.REFERENCE_TRANSACTION_ID IN 
										( 	SELECT TR2.TRANSACTION_ID
											FROM 	temp_account_transaction TR2,
												TB_CLIENT_ACCOUNT AC2
											WHERE 	TR2.CLIENT_ACCOUNT_ID = AC2.CLIENT_ACCOUNT_ID 
												AND AC2.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
												AND TR2.DELETE_SW = 'N' 
												AND AC2.DELETE_SW = 'N'  
												AND TR2.CREDIT_DEBIT_SW = 'C'
												AND TR2.TRANSACTION_SOURCE_CD IN ('587', '586', '585' )	
												AND ( TR2.BENEFIT_START_DT >  F_daymonth(CURRENT_DATE  - interval '2 MONTHS'  ,'L' , 'C')  
														 OR COALESCE(TR2.LATE_ENTRY_SW, 'N')  = 'Y' )  
										)
								GROUP BY to_char(TR1.BENEFIT_START_DT,'Mon-YY'),
									-- extract (year from TR1.BENEFIT_START_DT),
									-- extract (month from TR1.BENEFIT_START_DT),
									AC1.CLIENT_ID

								),0)
								),0) AS AVAILABLE_BALANCE_NO_COC
					
							FROM 	temp_account_transaction TR, 
								TB_CLIENT_ACCOUNT AC
							WHERE	TR.CLIENT_ACCOUNT_ID = AC.CLIENT_ACCOUNT_ID 
								AND AC.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID 
								AND TR.DELETE_SW = 'N'  
								AND AC.DELETE_SW = 'N'  
							GROUP BY 	tr.benefit_start_dt,
								-- to_char(TR.BENEFIT_START_DT,'Mon-YY'),
								-- extract (year from TR.BENEFIT_START_DT),
								-- extract (month from TR.BENEFIT_START_DT),
								AC.CLIENT_ID
							ORDER BY to_char(TR.BENEFIT_START_DT,'Mon-YY') desc
							-- extract (year from TR.BENEFIT_START_DT),
							-- extract (month from TR.BENEFIT_START_DT),
							-- AC.CLIENT_ID
						) TAB
					) TAB1
				) TAB2
			) A 
			GROUP BY  A.BENEFIT_MONTHYEAR 
			order by  A.BENEFIT_MONTHYEAR DESC
			)TAB3
			WHERE  CA.CLIENT_ID = PR.CJAMSPID 
				AND CA.CLIENT_ACCOUNT_ID = ACT.CLIENT_ACCOUNT_ID
				AND CA.CLIENT_ACCOUNT_ID = VL_CLIENT_ACC_ID
				AND	CA.DELETE_SW = 'N'
				AND ACT.DELETE_SW = 'N'
				AND PR.ACTIVEFLAG = 1
		)e ;

	end if;
	return v_dhs116report;

	drop TABLE temp_account_transaction;
	drop table tmp_placemnt ;
	drop table temp_payment_detail;
	drop TABLE temp_payment_header;
	drop table temp_payment_status ;
end ;
$function$
;
