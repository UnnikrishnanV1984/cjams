DROP FUNCTION if exists cjams.sp_fmis_payment_interface(integer, date);

CREATE OR REPLACE FUNCTION cjams.sp_fmis_payment_interface(vn_batch_sz integer, adt_rundate date, OUT al_sqlcode integer, OUT as_error character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
												
------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Raghu Tarlapu
-- Date Created :06/01/2014
-- Description : 'SP_FMIS_PAYMENT_INTERFACE' includes the following logic
--                  1) Generate FMIS records for Adoption, GAP and Fostercare Payments
--                      in 'TB_FMIS_PAYMENT_DETAIL_INTERFACE'.
--                  2) Records for Off-set payments for Fostercare in
--                      'TB_FMIS_PAYMENT_DETAIL_INTERFACE'.
--                  3) Records with cumulative results into 'TB_FMIS_PAYMENT_HEADER_INTERFACE'.
--                  4) Modifications needed for 'Agency_object_cd' correction per PRJ-03892.
-- Modifications by:
-- Raghu Tarlapu : Prj-03892 Formatted Transaction_amt, Current_Document_nbr_cd.
-- Raghu Tarlapu : Prj-03892 Added Update to TB_PAYMENT_STATUS.
-- Vineet Tirodkar 09/18/2014 1) To remove DISTINCT from SQL of Populating Temporary table for Offset Values (INC0030993)
--							  2) To remove CHAR from Order BY clause of Populating FMIS Detail table from Temp table (INC0030993)
-- Vineet Tirodkar 09/23/2014 1) To skip payment where offset amount equals payment amount (INC0030993)	
--							  2) To fix logic of CURRENT_DOCUMENT_NBR_SUFFIX (INC0030993)
--							  3) Change in logic of grouping 200 records per batch (INC0030993)	 
-- Vineet Tirodkar 07/07/2015 To fix FMIS Batch # issue for 1st run in every July (1st of the month)
-- Vineet Tirodkar 07/14/2015 To fix FMIS Batch # issue for 2nd run in every July (13th of the month)
-- Raghuveer Dachani 03/15/2019 CJAMS migration
-- Hadi Siddiqui 06/15/2019 CJAMS - Set Index Code
-- 04/15/2021 - Vineet Tirodkar - Fix to FMIS Batch Number logic one paymnent was skipped on 04/13 batch run (CIDM-2585) 
-- 05/11/2021 - Vineet Tirodkar - Modifications to the missing delete_sw in where clause for updating the Transaction Amount
-- 06/09/2021 - Vineet Tirodkar - Modifications to fix current_document_nbr_suffix null issue (CDM-13301)
-- 04/07/2025 - Vineet Tirodkar - Modifications to fix 1099 Reportable (Agency Object Code) Logic (CDM-44293)
------------------------------------------------------------------------------------------------

DECLARE vs_message_text 			VARCHAR(3000) DEFAULT '';
DECLARE vl_ret_status 				INTEGER DEFAULT 0;
DECLARE vs_Procedure_nm 			VARCHAR(100) DEFAULT 'SP_FMIS_PAYMENT';
DECLARE VN_PROVIDER_ID 				INTEGER DEFAULT 0;
DECLARE VS_PAYMENT_TYPE_CD 			VARCHAR(4) DEFAULT '';
DECLARE VN_PAYMENT_ID 				INTEGER DEFAULT 0;
DECLARE VS_MAIL_CODE_TX 			VARCHAR(3) DEFAULT '';
DECLARE VS_EFT_SW 					VARCHAR(1) DEFAULT '';
DECLARE VS_COUNTY_CD 				VARCHAR(4) DEFAULT '';
DECLARE VS_PAYMENT_TAX_TYPE 		VARCHAR(4) DEFAULT '';
DECLARE VN_FINAL_AMOUNT_NO 			DECIMAL (13,2)  DEFAULT 0;
DECLARE VN_CLIENT_ID 				INTEGER  DEFAULT 0;
DECLARE VN_FINAL_SERVICE_ID 		INTEGER DEFAULT 0;
DECLARE VN_PAYMENT_DETAIL_ID 		INTEGER DEFAULT 0;
---Output from SP
DECLARE VS_PMNT_CAT_SW 				CHAR(1) DEFAULT NULL;
DECLARE VS_AGENCY_OBJECT_CD 		VARCHAR(4) DEFAULT NULL;
DECLARE VS_TRANSACTION_AMT 			VARCHAR(13) DEFAULT NULL;
DECLARE VS_PMNT_DIST_TYPE 			VARCHAR(2) DEFAULT NULL;
DECLARE VS_PAYMENT_ID 				VARCHAR(50) DEFAULT NULL;
DECLARE VN_DETAIL_CNT 				INTEGER DEFAULT 0;
DECLARE VN_APPROPRIATION_YEAR 		INTEGER DEFAULT 0;
DECLARE vd_run_date 				DATE;
DECLARE VN_OFF_PROVIDER_ID 			INTEGER DEFAULT 0;
DECLARE VS_OFF_PAYMENT_TYPE_CD 		VARCHAR(4) DEFAULT '';
DECLARE VN_OFF_PAYMENT_ID 			INTEGER DEFAULT 0;
DECLARE VS_OFF_MAIL_CODE_TX 		VARCHAR(3) DEFAULT '';
DECLARE VS_OFF_EFT_SW 				VARCHAR(1) DEFAULT '';
DECLARE VN_CUR_BATCH 				INTEGER DEFAULT 0;
DECLARE VN_MOD 						INTEGER DEFAULT 0;
DECLARE VN_DTL_CNT 					INTEGER DEFAULT 0;
DECLARE VN_BATCH_CNT 				INTEGER DEFAULT 0;
DECLARE prev_month_last_day 		DATE;
DECLARE prev_month_first_day 		DATE;
DECLARE REPORT_PERIOD_DT 			DATE;
DECLARE VN_UND_19 					INTEGER;
DECLARE VN_OVR_18 					INTEGER;
DECLARE VN_TEMP_Record_ID 			INTEGER;
DECLARE VN_TEMP_BATCH_SEQ_NO 		INTEGER;
DECLARE ls_batch_no 				VARCHAR(50);
DECLARE ls_hdr_transaction_amt 		VARCHAR(50);
DECLARE ls_max_batch_seq_nbr 		VARCHAR(5);
DECLARE li_hdr_transaction_amt 		INTEGER;
DECLARE VN_ERROR_PAYMENT_ID 		INTEGER;
DECLARE VN_ERROR_CLIENT_ID 			INTEGER;
DECLARE VS_ERROR_COUNTY_CD 			VARCHAR(5);
DECLARE VN_ERROR_PROVIDER_ID 		INTEGER;
DECLARE VS_BATCH_NO 				VARCHAR(5);
DECLARE VS_ERROR_TX 				VARCHAR(500);
-- New variables
DECLARE vl_offset_cnt				INTEGER;
DECLARE vl_fmis_detail_id			INTEGER;
DECLARE vl_doc_num_suffix			INTEGER;
DECLARE vl_current_doc_num_suffix	INTEGER;
DECLARE vl_payment_id				INTEGER;
DECLARE vl_batch_size				INTEGER;
DECLARE vl_total_cnt				INTEGER;
DECLARE vs_batchno					VARCHAR(3);	
DECLARE vl_curr_doc_no				INTEGER;
DECLARE vs_curr_doc_no				VARCHAR(8);	

DECLARE vl_skipped_payments			INTEGER;
DECLARE vl_skipped_payment_id		INTEGER;

cur_skipped_payments REFCURSOR;
cur_skipped_payment_rec record;

--Cursor for populating the Batch numbers in the FMIS Detail table
DECLARE cur4 CURSOR  FOR SELECT VN_BATCH_CNT;

DECLARE cur_updt_doc_suffix CURSOR 
	FOR  
		SELECT FMIS_PAYMENT_DETAIL_RECORD_ID,
			   (CURRENT_DOCUMENT_NBR_SUFFIX)::INTEGER AS CURRENT_DOCUMENT_NBR_SUFFIX
			FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
		ORDER BY FMIS_PAYMENT_DETAIL_RECORD_ID;
		
		
DECLARE cur_updt_batch_no CURSOR FOR  
		SELECT DISTINCT (INVOICE_NBR)::INTEGER AS INVOICE_NBR
			FROM ( SELECT FMIS_PAYMENT_DETAIL_RECORD_ID, INVOICE_NBR
						FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
					WHERE BATCH_NO IS NULL	
					ORDER BY FMIS_PAYMENT_DETAIL_RECORD_ID	
				 ) TAB;
				 
				 
DECLARE cur_updt_batch_seq CURSOR FOR  
	SELECT DISTINCT BATCH_NO
		FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
	ORDER BY 1;
	

DECLARE ERROR_CUR CURSOR  FOR
	SELECT PD.PAYMENT_ID
		,PD.CLIENT_ID
		,PD.COUNTY_CD COUNTY
		,HD.PROVIDER_ID
		,FMIS.BATCH_NO
		,'County Name :'|| cjams.F_PDESC(PD.COUNTY_CD,104) ||', Provider Name: '
		--|| cjams.F_ENAME(HD.PROVIDER_ID,'2953')
		--||', Client Name : ' || cjams.F_ENAME(PD.CLIENT_ID,'2955')
		||', Transaction amount is missing for '|| (HD.PAYMENT_ID::varchar)
	FROM TB_PAYMENT_DETAIL PD, 
		cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE FMIS,
		TB_PAYMENT_HEADER HD
	WHERE PD.PAYMENT_ID = (FMIS.INVOICE_NBR::INTEGER)
		AND HD.PAYMENT_ID = PD.PAYMENT_ID
		AND HD.DELETE_SW = 'N'
		AND PD.DELETE_SW = 'N'
		AND FMIS.DELETE_SW = 'N'
		AND PD.FINAL_AMOUNT_NO IS NULL;

BEGIN 
	--Temporary table for the distinct fields to be populated in 'TB_FMIS_PAYMENT_DETAIL_INTERFACE'  
	DROP TABLE IF EXISTS TTB_FMIS_MAIN CASCADE;
 	
	CREATE TEMPORARY TABLE TTB_FMIS_MAIN(   VN_TEMP_PROVIDER_ID INTEGER
                                                ,VS_TEMP_PAYMENT_TYPE_CD VARCHAR(4)
                                                ,VN_TEMP_PAYMENT_ID INTEGER
                                                ,VS_TEMP_MAIL_CODE_TX VARCHAR(3)
                                                ,VS_EFT_SW VARCHAR(1)
                                                ,VS_TRANSACTION_AMT VARCHAR(13)
                                                ,VS_COLLECTED_AMT VARCHAR(500)
                                                ,VS_AGENCY_OBJECT_CD VARCHAR(4)
                                                ,VN_TAX_ID INTEGER
                                                ,VS_OFFSET_FLAG CHAR(1)
                                                ,VS_TEMP_REVERSE_IND CHAR(1)
                                                ,VL_UNDER_19 INTEGER
                                                ,VL_OVER_18 INTEGER
                                                ,VS_PROV_PLMT_TYPE VARCHAR(5)
                                                ,VS_PROV_AFF  VARCHAR(5)
                                                ,VS_DIST_TYPE VARCHAR(2)
                                                ,VN_PRV_ADR_56_CNT INTEGER
                                                ,VN_PRV_ADR_57_CNT INTEGER
                                                ,VN_CURR_DOC_NBR INTEGER
                                                ,VN_CURR_DOC_SUFFIX INTEGER
                                            );


	DROP TABLE IF EXISTS TTB_SKIPPED_PAYMENTS CASCADE;
	CREATE TEMPORARY TABLE TTB_SKIPPED_PAYMENTS(SKIPPED_PAYMENT_ID BIGINT) ;

	IF adt_rundate is null OR adt_rundate = '1900-01-01' THEN
		 vd_run_date := CURRENT_DATE;
	ELSE
		 vd_run_date := adt_rundate;
	END IF;

	-- Get previous months first & last date
	/*
	SET prev_month_first_day = f_daymonth(vd_run_date,' ','');
	SET prev_month_last_day = f_daymonth(vd_run_date,'L','');
	*/
	  
	prev_month_first_day  :=  (SELECT (date_trunc('month', vd_run_date) - interval '1 month')::date);
	prev_month_last_day   :=  (SELECT (date_trunc('month', vd_run_date)::date - 1));

	-- Delete the records from the parent tables if exists - START
	SELECT COUNT(*) 
		INTO VN_DETAIL_CNT
	FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE;

	IF VN_DETAIL_CNT > 0 THEN
		BEGIN
			DELETE FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE;
			
			EXCEPTION WHEN OTHERS THEN
				as_error := 'ERROR in Deleting cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE.';
				vs_message_text :=  SQLERRM;
				al_sqlcode := -1 ;
				as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::varchar) ||'::' || vs_Procedure_nm || '.' ;
				as_error := as_error || vs_message_text;
				Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
			RETURN;	
		END;
			
		BEGIN
			DELETE FROM cjams.TB_FMIS_PAYMENT_HEADER_INTERFACE;
			
			EXCEPTION WHEN OTHERS THEN
				as_error := 'ERROR in Deleting cjams.TB_FMIS_PAYMENT_HEADER_INTERFACE.';
				vs_message_text :=  SQLERRM;
				al_sqlcode := -1 ;
				as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::varchar) ||'::' || vs_Procedure_nm || '.' ;
				as_error := as_error || vs_message_text;
				Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
			RETURN;
		END;		
	END IF;
	-- Delete the records from the parent tables if exists - END

	-- Set BATCH_NO to start with in this run - START
	-- from January to June BATCH_NO from previous run + 1
	IF EXTRACT(MONTH FROM vd_run_date) in (1,2,3,4,5,6) THEN
		 VN_APPROPRIATION_YEAR := EXTRACT(YEAR FROM vd_run_date);

		BEGIN
			SELECT (BATCH_NO::INTEGER) 
				INTO VN_CUR_BATCH 
			FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE_ISS 
			ORDER BY fmis_payment_detail_record_id DESC,RUN_NO DESC 
			FETCH FIRST 1 ROW ONLY;
		
			EXCEPTION WHEN OTHERS THEN
				as_error := 'ERROR in getting max batch number from cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE_ISS ';
				vs_message_text :=  SQLERRM;
				al_sqlcode := -1 ;
				as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
				as_error := as_error || vs_message_text;
				Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
			RETURN;
		END;
		
	ELSE
		 VN_APPROPRIATION_YEAR := (SELECT EXTRACT(YEAR FROM vd_run_date) + 1);
		-- In July reset BATCH_NO to 1 (Change in Fiscal Year)
		-- FMIS run on 13th of the month
		IF EXTRACT(MONTH FROM vd_run_date) = 7 AND EXTRACT(DAY FROM vd_run_date) < 13 THEN 
			 VN_CUR_BATCH := 0;
		ELSE 
			-- from July 13 to December BATCH_NO from previous run + 1
			BEGIN 
			
				SELECT (BATCH_NO::INTEGER) 
					INTO VN_CUR_BATCH 
				FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE_ISS 
				ORDER BY fmis_payment_detail_record_id DESC,RUN_NO DESC 
				FETCH FIRST 1 ROW ONLY;
				
				EXCEPTION WHEN OTHERS THEN
					as_error := 'ERROR in getting max batch number from cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE_ISS ';
					vs_message_text :=  SQLERRM;
					al_sqlcode := -1 ;
					as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
					as_error := as_error || vs_message_text;
					Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
				RETURN;
			END;
		END IF;
	END IF;
	-- Set BATCH_NO to start with in this run - END

	-- Load Temporary table with Payments - START
	INSERT INTO TTB_FMIS_MAIN
	(  SELECT  P.PROVIDER_ID
		,PH.PAYMENT_TYPE_CD
		,PH.PAYMENT_ID
		,P.MAIL_CODE_TX
		,COALESCE(P.EFT_SW,'N')
		,NULL
		,NULL
		,NULL
		,(SELECT COALESCE(TP.TAX_ID_NO,(select TAX_ID_NO 
											from tb_provider
										where provider_id = (select affiliate_provider_id 
																from tb_provider
															 where provider_id = P.PROVIDER_ID
															 )
										)
						  ) as TAX_ID_NO  
			FROM TB_PROVIDER TP
		  WHERE TP.provider_id = P.PROVIDER_ID 
			AND TP.Delete_sw = 'N'
		)
		,NULL
		,NULL
		,(SELECT COUNT(Distinct CLIENT_ID) 
			FROM cjams.TB_PAYMENT_DETAIL
		  WHERE PAYMENT_ID = ph.payment_id
			AND CLIENT_ID IN (SELECT cjamspid 
								FROM person 
							  WHERE cjams.F_AGE(dob) < 19 	
							  	AND activeflag = 1
							 )
			AND DELETE_SW = 'N'  
		)
		,(SELECT COUNT(Distinct CLIENT_ID) 
			FROM cjams.TB_PAYMENT_DETAIL
		  WHERE PAYMENT_ID = ph.payment_id
			AND CLIENT_ID IN (SELECT cjamspid 
								FROM person 
							  WHERE cjams.F_AGE(dob) >= 19 
								AND activeflag = 1
							  )
			AND DELETE_SW = 'N'  
		)
		,COALESCE(F_PRVPCKLST_CAT(P.PROVIDER_ID,'PLACEMENT'),'')
		,(SELECT LTRIM(RTRIM(PAY_TO_AFFILIATE_CD)) 
			FROM TB_PROVIDER
		  WHERE DELETE_SW = 'N' 
			AND PROVIDER_ID =  P.PROVIDER_ID)
		,NULL
		,(SELECT COUNT(*) 
			FROM TB_PROVIDER_ADDRESSES
		  WHERE PARENT_KEY_ID::INTEGER = P.PROVIDER_ID::INTEGER
			AND ADR_DEFAULT_SW = 'Y'
			AND ADR_TYPE_CD = '3356' 
			AND ADR_FORMAT_CD = 'F'
			AND DELETE_SW = 'N'
		)
		,(SELECT COUNT(*) 
			FROM TB_PROVIDER_ADDRESSES
		  WHERE PARENT_KEY_ID::INTEGER = P.PROVIDER_ID::INTEGER
			AND ADR_DEFAULT_SW = 'Y'
			AND ADR_TYPE_CD = '3357' 
			AND ADR_FORMAT_CD = 'F'
			AND DELETE_SW = 'N'
		)
	--	,NEXTVAL FOR cjams.SQ_FMIS_CURR_DOC_NBR
		,NULL
		,1

	   FROM TB_PROVIDER P, 
			TB_PAYMENT_STATUS PS,  
			TB_PAYMENT_HEADER PH
		WHERE P.PROVIDER_ID = PH.PROVIDER_ID 
			AND PH.PAYMENT_ID = PS.PAYMENT_ID
			AND PH.DELETE_SW = 'N' 
			AND PS.DELETE_SW = 'N' 
			AND P.DELETE_SW = 'N'
			AND PS.PAYMENT_STATUS_CD = '1634' 
			AND PH.PAYMENT_TYPE_CD  in ('5689','7','6')
			AND (PH.PAYMENT_START_DT <= prev_month_last_day OR PH.PAYMENT_START_DT BETWEEN prev_month_first_day AND prev_month_last_day)
			AND (PH.PAYMENT_END_DT >= prev_month_first_day OR PH.PAYMENT_END_DT BETWEEN prev_month_first_day AND prev_month_last_day)
		GROUP BY P.PROVIDER_ID, PH.PAYMENT_TYPE_CD, PH.PAYMENT_ID, P.MAIL_CODE_TX, P.EFT_SW, P.DOB_DT           			
		ORDER BY P.PROVIDER_ID, PH.PAYMENT_ID, PH.PAYMENT_TYPE_CD
	);
	-- Load Temporary table with Payments - END

	-- Update Transaction Amount and Collected Amount in Temporary Table- START
	-- Transaction Amount
	UPDATE TTB_FMIS_MAIN
	  SET VS_TRANSACTION_AMT = ( SELECT LPAD(LTRIM(RTRIM(((SUM(FINAL_AMOUNT_NO*100))::INTEGER)::VARCHAR)),13,'0') 
									FROM cjams.TB_PAYMENT_DETAIL 
								 WHERE PAYMENT_ID = TTB_FMIS_MAIN.VN_TEMP_PAYMENT_ID
									AND DELETE_SW = 'N'
								);
								
	-- Collected Amount if Offset is present (ONLY for Maintenance payments)
	UPDATE TTB_FMIS_MAIN
	  SET VS_COLLECTED_AMT = ( SELECT LPAD(LTRIM(RTRIM(((SUM(rl.collected_amount_no*100))::INTEGER)::VARCHAR)),13,'0') 
								  FROM tb_receivable_offset ro, 
									   tb_receivable_liquidation rl, 
									   tb_receivable_detail rd, 
									   tb_payment_detail pd
							   WHERE ro.offset_id = rl.offset_id
									AND rd.receivable_detail_id = rl.receivable_detail_id
									AND pd.payment_detail_id = rd.payment_detail_id
									AND ro.payment_id = TTB_FMIS_MAIN.VN_TEMP_PAYMENT_ID
									AND rl.delete_sw = 'N'
									AND pd.delete_sw = 'N'
									AND rd.delete_sw = 'N'
									AND ro.delete_sw = 'N'
									AND rl.collected_amount_no is not null 
							 )
	WHERE VS_TEMP_PAYMENT_TYPE_CD = '6';
	-- Update Transaction Amount and Collected Amount in Temporary Table- END

	-- To skip payment where offset amount equals payment amount (INC0030993) - START	
	-- Delete payments from Temporary table where offset amount equals payment amount - START
	DELETE FROM TTB_FMIS_MAIN 
	WHERE VS_TEMP_PAYMENT_TYPE_CD = '6'
		AND TTB_FMIS_MAIN.VS_COLLECTED_AMT = TTB_FMIS_MAIN.VS_TRANSACTION_AMT ;
	-- Delete payments from Temporary table where offset amount equals payment amount - END

	-- To skip payment where offset amount equals payment amount (INC0030993) - END

	-- Set the Offset flag to identify offset transactions in Temporary Table - START
	UPDATE TTB_FMIS_MAIN
		SET VS_OFFSET_FLAG = 'Y'
	WHERE (VS_COLLECTED_AMT::INTEGER) > 0;
	-- WHERE INT(VS_COLLECTED_AMT) < INT(VS_TRANSACTION_AMT); -- (INC0030993)
	-- Set the Offset flag to identify offset transactions in Temporary Table - END

	-- Update Distribution Type in Temporary Table - START
	-- '1783' - Local Department Home with EFT_SW = 'Y'
	UPDATE TTB_FMIS_MAIN
		SET VS_DIST_TYPE = '61'
	WHERE TTB_FMIS_MAIN.VS_EFT_SW = 'Y' 
		AND TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE = '1783';

	-- '1783' - Local Department Home with EFT_SW = 'N' 
	-- and '3356' - Provider Payment address and '3357' - Provider Location address; both are Not Foreign address ????
	UPDATE TTB_FMIS_MAIN
		SET VS_DIST_TYPE = '60'
	WHERE TTB_FMIS_MAIN.VS_EFT_SW = 'N' 
		AND TTB_FMIS_MAIN.VN_PRV_ADR_56_CNT = 0 
		AND TTB_FMIS_MAIN.VN_PRV_ADR_57_CNT = 0 
		AND TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE = '1783';

	-- '1783' - Local Department Home with EFT_SW = 'N' and 
	-- payment setting is '3367' - A Different Payment Address & '3356' - Provider Payment address is Foreign address ????
	-- OR 
	-- payment setting is '3366' - The Same Address & '3356' - Provider Location address is Foreign address ????
	UPDATE TTB_FMIS_MAIN
		SET VS_DIST_TYPE = '66'
	WHERE TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE = '1783'
		AND (
			 ( TTB_FMIS_MAIN.VS_EFT_SW = 'N' AND TTB_FMIS_MAIN.VN_PRV_ADR_56_CNT > 0 AND TTB_FMIS_MAIN.VS_PROV_AFF = '3367' )
			 OR 
			 ( TTB_FMIS_MAIN.VS_EFT_SW = 'N' AND TTB_FMIS_MAIN.VN_PRV_ADR_57_CNT > 0 AND TTB_FMIS_MAIN.VS_PROV_AFF = '3366' )
			) ;
			 

	-- Any other Provider type with EFT_SW = 'Y' 
	UPDATE TTB_FMIS_MAIN
		SET VS_DIST_TYPE = '86'
	WHERE TTB_FMIS_MAIN.VS_EFT_SW = 'Y' 
	AND TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE <> '1783';

	-- Any other Provider type with  EFT_SW = 'N' 
	-- and '3356' - Provider Payment address and '3357' - Provider Location address; both are Not Foreign address ????
	UPDATE TTB_FMIS_MAIN
		SET VS_DIST_TYPE = '00'
	WHERE TTB_FMIS_MAIN.VS_EFT_SW = 'N' 
		AND TTB_FMIS_MAIN.VN_PRV_ADR_56_CNT = 0 
		AND TTB_FMIS_MAIN.VN_PRV_ADR_57_CNT = 0 
		AND TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE <> '1783';

	-- Any other Provider type with  EFT_SW = 'N' and 
	-- payment setting is '3367' - A Different Payment Address & '3356' - Provider Payment address is Foreign address ????
	-- OR 
	-- payment setting is '3366' - The Same Address & '3356' - Provider Location address is Foreign address ????
	UPDATE TTB_FMIS_MAIN
		SET VS_DIST_TYPE = '01'
	WHERE TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE <> '1783'
		AND (
			  ( TTB_FMIS_MAIN.VS_EFT_SW = 'N' AND TTB_FMIS_MAIN.VN_PRV_ADR_56_CNT > 0 AND TTB_FMIS_MAIN.VS_PROV_AFF = '3367' )
			  OR 
			  ( TTB_FMIS_MAIN.VS_EFT_SW = 'N' AND TTB_FMIS_MAIN.VN_PRV_ADR_57_CNT > 0 AND TTB_FMIS_MAIN.VS_PROV_AFF = '3366' )
			);
			
	-- Update Distribution Type in Temporary Table - END

	-- Update Agency Object Code in Temporary Table - START
	-- '1783' - Local Department Home with Maintenance payments and 5 or more clients age over 18
	UPDATE TTB_FMIS_MAIN
		SET VS_AGENCY_OBJECT_CD = '1298'   -- Taxable
	WHERE TTB_FMIS_MAIN.VL_OVER_18 > 5  
		AND TTB_FMIS_MAIN.VS_TEMP_PAYMENT_TYPE_CD = '6' 
		AND TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE = '1783';

	-- '1783' - Local Department Home with Maintenance payments and 
	-- 5 or more clients age over 18
	-- OR
	-- more than 10	clients age under 19	
	UPDATE TTB_FMIS_MAIN
		SET VS_AGENCY_OBJECT_CD = '1298'   -- Taxable
	WHERE (TTB_FMIS_MAIN.VL_OVER_18 > 5 OR TTB_FMIS_MAIN.VL_UNDER_19 > 10) 
		AND TTB_FMIS_MAIN.VS_TEMP_PAYMENT_TYPE_CD = '6' 
		AND TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE = '1783';

	/* -- 09242019 - Code Change requested to default all private providers as '0856'	
	-- Any other Provider type with Maintenance payments and 
	-- 5 or more clients age over 18
	-- OR
	-- more than 10	clients age under 19
	UPDATE TTB_FMIS_MAIN
	SET VS_AGENCY_OBJECT_CD = '0856'   -- Private Providers
	WHERE (TTB_FMIS_MAIN.VL_OVER_18 > 5 OR TTB_FMIS_MAIN.VL_UNDER_19 > 10) 
		AND TTB_FMIS_MAIN.VS_TEMP_PAYMENT_TYPE_CD = '6' 
		AND TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE <> '1783';
	*/

	-- Default all private providers to '0856' for Maintenance Payments	
	UPDATE TTB_FMIS_MAIN
	SET VS_AGENCY_OBJECT_CD = '0856'   -- Private Providers
	WHERE TTB_FMIS_MAIN.VS_TEMP_PAYMENT_TYPE_CD = '6' 
		AND TTB_FMIS_MAIN.VS_PROV_PLMT_TYPE <> '1783';
		

	-- for all remaining update Non-Taxable	
	UPDATE TTB_FMIS_MAIN
		SET VS_AGENCY_OBJECT_CD = '1201'   -- Non - Taxable
	WHERE RTRIM(LTRIM(TTB_FMIS_MAIN.VS_AGENCY_OBJECT_CD)) = '' 
		  OR TTB_FMIS_MAIN.VS_AGENCY_OBJECT_CD IS NULL;
	-- Update Agency Object Code in Temporary Table - END

	-- Load Temporary table for Offset Values - START
	INSERT INTO TTB_FMIS_MAIN
	( SELECT TPH.Provider_ID
			,TPH.Payment_type_cd
			,offset_rec.payment_id
			,TP.MAIL_CODE_TX
			,TP.EFT_SW
			,LPAD(LTRIM(RTRIM(((offset_rec.amt_no)::INTEGER)::VARCHAR)),13,'0')
			,NULL
			,(SELECT B.VS_AGENCY_OBJECT_CD 
				FROM TTB_FMIS_MAIN B 
			  WHERE B.VN_TEMP_PAYMENT_ID = offset_rec.PAYMENT_ID 
				AND VS_OFFSET_FLAG = 'Y'
			)
			,(SELECT B.VN_TAX_ID 
				FROM TTB_FMIS_MAIN B 
			  WHERE B.VN_TEMP_PAYMENT_ID = offset_rec.PAYMENT_ID 
				AND VS_OFFSET_FLAG = 'Y'
			)
			,NULL
			,'R'
			,NULL
			,NULL
			,NULL
			,NULL
			,(SELECT B.VS_DIST_TYPE 
				FROM TTB_FMIS_MAIN B 
			  WHERE B.VN_TEMP_PAYMENT_ID = offset_rec.PAYMENT_ID 
				AND VS_OFFSET_FLAG = 'Y'
			)
			,NULL
			,NULL
	--		,(SELECT VN_CURR_DOC_NBR 
	--			FROM TTB_FMIS_MAIN B 
	--		  WHERE B.VN_TEMP_PAYMENT_ID = offset_rec.PAYMENT_ID 
	--			AND VS_OFFSET_FLAG = 'Y'
	--		)
			,NULL 
	--		,(SELECT VN_CURR_DOC_SUFFIX + 1 
	--			FROM TTB_FMIS_MAIN B 
	--		  WHERE B.VN_TEMP_PAYMENT_ID = offset_rec.PAYMENT_ID 
	--			AND VS_OFFSET_FLAG = 'Y'
	--		)
			,NULL
		FROM 
			( SELECT pd.county_cd, pd.agency_object_cd, ro.payment_id, ((sum(rl.collected_amount_no*100))::INTEGER)::VARCHAR AS amt_no
				FROM tb_receivable_offset ro, 
					 tb_receivable_liquidation rl, 
					 tb_receivable_detail rd, 
					 tb_payment_detail pd
			  WHERE ro.offset_id = rl.offset_id
				AND rl.receivable_detail_id = rd.receivable_detail_id
				AND rd.payment_detail_id = pd.payment_detail_id
				AND ro.payment_id IN (SELECT VN_TEMP_PAYMENT_ID 
										FROM TTB_FMIS_MAIN 
									  WHERE VS_OFFSET_FLAG = 'Y'
									 )
				AND ro.DELETE_SW = 'N' 
				AND RL.DELETE_SW = 'N' 
				AND RD.DELETE_SW = 'N' 
				AND PD.DELETE_SW = 'N'
			GROUP BY pd.agency_object_cd, pd.county_cd, ro.payment_id 
			) as offset_rec, 
			tb_payment_header TPH, 
			tb_provider TP
		WHERE offset_rec.payment_id = TPH.payment_id 
			and TPH.delete_sw = 'N'
			and TP.provider_id = TPH.provider_id
			and TP.delete_sw = 'N'
	);	
	-- Load Temporary table for Offset Values - END

	-- Load FMIS Detail table from Temporary table - START
	BEGIN
		INSERT INTO cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
			(   FMIS_PAYMENT_DETAIL_RECORD_ID
				,AGENCY_OBJECT_CD
				,VENDOR_TAX_TYPE_CD
				,VENDOR_MAIL_CODE_TX
				,INVOICE_NBR
				,TRANSACTION_AMT
				,REVERSE_IND
				--,BATCH_SEQUENCE_NO
				--,CURRENT_DOCUMENT_NBR_CD
				,CURRENT_DOCUMENT_NBR_SUFFIX
				,PAYMENT_TYPE_CD
				,PAYMENT_DIS_TYPE_CD
			)
			(SELECT NEXTVAL('SQ_FMIS_PAYMENT_DETAIL_INTERFACE')
				,M.VS_AGENCY_OBJECT_CD
				,'W' || LPAD(LTRIM(RTRIM((M.VN_TAX_ID::VARCHAR))),9,'0')
				,M.VS_TEMP_MAIL_CODE_TX
				,LPAD(LTRIM(RTRIM((M.VN_TEMP_PAYMENT_ID::VARCHAR))),14,'0')
				,M.VS_TRANSACTION_AMT
				,M.VS_TEMP_REVERSE_IND
				-- ,NEXTVAL FOR cjams.SQ_FMIS_BATCH_SEQ_N0
				-- ,'VY' || LPAD(LTRIM(RTRIM(CHAR(VN_CURR_DOC_NBR))),6,'0')
				,LPAD(LTRIM(RTRIM((M.VN_CURR_DOC_SUFFIX::VARCHAR))),3,'0')
				,M.VS_TEMP_PAYMENT_TYPE_CD
				,M.VS_DIST_TYPE
			FROM TTB_FMIS_MAIN M
			WHERE (M.VS_TRANSACTION_AMT IS NOT NULL OR (M.VS_TRANSACTION_AMT::INTEGER) > 0 )
			ORDER BY M.VN_TEMP_PAYMENT_ID, 
				coalesce(VS_TEMP_REVERSE_IND, 'A') -- current_document_nbr_suffix null issue fix (CDM-13301)
			);
			
		EXCEPTION WHEN OTHERS THEN
			as_error := 'ERROR in Inserting cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE.';
			vs_message_text :=  SQLERRM;
			al_sqlcode := -1 ;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;

	-- Load FMIS Detail table from Temporary table - END

	-- To fix logic of CURRENT_DOCUMENT_NBR_SUFFIX (INC0030993) - START
	SELECT COUNT(*)
		INTO vl_offset_cnt
	FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
	WHERE REVERSE_IND = 'R' ;

	IF vl_offset_cnt > 0 THEN
		OPEN cur_updt_doc_suffix;
	   <<cur_updt_doc>>
		LOOP 
		FETCH cur_updt_doc_suffix INTO vl_fmis_detail_id, vl_doc_num_suffix;
		EXIT cur_updt_doc WHEN NOT FOUND;	
			
			IF vl_doc_num_suffix is NOT NULL AND vl_doc_num_suffix > 0 THEN -- Payment Record
				 vl_current_doc_num_suffix := vl_doc_num_suffix;
			ELSE
				 vl_current_doc_num_suffix := vl_current_doc_num_suffix + 1;
				UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
					SET CURRENT_DOCUMENT_NBR_SUFFIX = LPAD(LTRIM(RTRIM((vl_current_doc_num_suffix)::VARCHAR)),3,'0')
				WHERE FMIS_PAYMENT_DETAIL_RECORD_ID = vl_fmis_detail_id;
			END IF;
		END LOOP;
		CLOSE cur_updt_doc_suffix;
	END IF;	
	-- To fix logic of CURRENT_DOCUMENT_NBR_SUFFIX (INC0030993) - END

	-- Update FMIS Detail for all constant columns - START
	BEGIN
		UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
		SET Batch_Agency_CD = cjams.F_picklist_ctxt('7732',1550)
			,Batch_type_cd = cjams.F_picklist_ctxt('8088',1550)
			,User_Operator_id = cjams.F_picklist_ctxt('7733',1550)
			,Transaction_cd = cjams.F_picklist_ctxt('7743',1550)
			,Finance_agency_cd = cjams.F_picklist_ctxt('7744',1550)
			,PCA_CD = cjams.F_picklist_ctxt('7745',1550)
			,IRS_1099_SW = cjams.F_picklist_ctxt('8089',1550)
			,Discount_amt = cjams.F_picklist_ctxt('7741',1550)
			,interest_Terms_CD = cjams.F_picklist_ctxt('7746',1550)
			,Penalty_Amt = cjams.F_picklist_ctxt('7747',1550)
			,Document_agency_cd = cjams.F_picklist_ctxt('7748',1550)
			,Appropriation_year = VN_APPROPRIATION_YEAR
			,Document_year = VN_APPROPRIATION_YEAR
			,INVOICE_DESCRIPTION_TX = cjams.F_picklist_ctxt('7749',1550)
			,index_cd = '72700';

		EXCEPTION WHEN OTHERS THEN	
			as_error = 'ERROR in Updating cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE for Constant Columns';
			vs_message_text :=  SQLERRM;
			al_sqlcode = -1;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;

	-- Update PAYMENT_TYPE_SW only for Maintenance payments
	BEGIN 
		UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
		  SET PAYMENT_TYPE_SW = 'F'
		WHERE PAYMENT_TYPE_CD = '6';

		EXCEPTION WHEN OTHERS THEN
			as_error := 'ERROR in Updating cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE for Constant Columns for payment_type_sw --> F';
			vs_message_text :=  SQLERRM;
			al_sqlcode := -1 ;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;

	-- Update PAYMENT_TYPE_SW only for Adoption Subsidy payments
	BEGIN
		UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
			SET PAYMENT_TYPE_SW = 'A'
		WHERE PAYMENT_TYPE_CD = '5689';

		EXCEPTION WHEN OTHERS THEN
			as_error := 'ERROR in Updating cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE for Constant Columns for payment_type_sw --> A';
			vs_message_text :=  SQLERRM;
			al_sqlcode := -1 ;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;

	-- Update PAYMENT_TYPE_SW only for GAP payments
	BEGIN
		UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
			SET PAYMENT_TYPE_SW = 'S'
		WHERE PAYMENT_TYPE_CD = '7';

		EXCEPTION WHEN OTHERS THEN
			as_error := 'ERROR in Updating cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE for Constant Columns for payment_type_sw --> S';
			vs_message_text :=  SQLERRM;
			al_sqlcode := -1 ;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;
	-- Update FMIS Detail for all constant columns - END	 

	-- New logic of grouping 200 records per batch & Update BATCH_SEQUENCE_NO(INC0030993) - START
	BEGIN
		SELECT COUNT(*) 
			INTO VN_DTL_CNT 
		FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE;

		EXCEPTION WHEN OTHERS THEN
			as_error := 'ERROR in getting record count from cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE ';
			vs_message_text :=  SQLERRM;
			al_sqlcode := -1 ;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;

	-- CIDM-2585
	Raise Notice '1st VN_DTL_CNT  %',  VN_DTL_CNT;

	VN_CUR_BATCH := VN_CUR_BATCH + 1;
	vl_batch_size := VN_BATCH_SZ;

	OPEN cur_updt_batch_no;
	<<cur_updt_batch>>
	LOOP
		FETCH cur_updt_batch_no INTO vl_payment_id; 
		
		EXIT cur_updt_batch WHEN NOT FOUND;
		
		RAISE NOTICE 'vl_payment_id %', vl_payment_id;		
		
		SELECT COUNT(*)
			INTO vl_total_cnt
		FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
		WHERE (INVOICE_NBR)::INTEGER = vl_payment_id ;	
		
		RAISE NOTICE 'vl_total_cnt %', vl_total_cnt;
		
		IF vl_batch_size >= vl_total_cnt THEN
			RAISE NOTICE 'In-side vl_batch_size >= vl_total_cnt';
			
			SELECT NEXTVAL('SQ_FMIS_CURR_DOC_NBR') INTO vl_curr_doc_no;
			vs_curr_doc_no := 'VY' || LPAD(LTRIM(RTRIM((vl_curr_doc_no)::VARCHAR)),6,'0');
			
			UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
				SET BATCH_NO = VN_CUR_BATCH,
					CURRENT_DOCUMENT_NBR_CD = vs_curr_doc_no
			WHERE (INVOICE_NBR::INTEGER) = vl_payment_id;
			
			vl_batch_size := vl_batch_size - vl_total_cnt;
			VN_DTL_CNT := VN_DTL_CNT - vl_total_cnt;
			
		ELSEIF vl_batch_size > 0 and vl_total_cnt > 0 THEN
			INSERT INTO TTB_SKIPPED_PAYMENTS (SKIPPED_PAYMENT_ID) VALUES ( vl_payment_id ) ;
			RAISE NOTICE 'Captured Skipped Payment id';
		END IF;
		
		IF vl_batch_size = 0 THEN
			VN_CUR_BATCH := VN_CUR_BATCH + 1;
			vl_batch_size := VN_BATCH_SZ;
			
			RAISE NOTICE 'New VN_CUR_BATCH %', VN_CUR_BATCH;
			RAISE NOTICE 'New vl_batch_size %', vl_batch_size;
			
			-- New Code to Update Batch No for skipped records
			select count(*) 
				into vl_skipped_payments
			from TTB_SKIPPED_PAYMENTS ;
			
			IF vl_skipped_payments > 0 THEN
				RAISE NOTICE 'Processing Skipped Payment id';
				
				OPEN cur_skipped_payments FOR		
					SELECT SKIPPED_PAYMENT_ID
					FROM TTB_SKIPPED_PAYMENTS;
				LOOP
					fetch cur_skipped_payments into cur_skipped_payment_rec;
					exit when not found;
					
					vl_skipped_payment_id := cur_skipped_payment_rec.SKIPPED_PAYMENT_ID;
					Raise Notice 'vl_skipped_payment_id  %',  vl_skipped_payment_id;
				
					SELECT COUNT(*)
						INTO vl_total_cnt
					FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
					WHERE (INVOICE_NBR)::INTEGER = vl_skipped_payment_id ;	
					
					RAISE NOTICE 'Skipped vl_total_cnt %', vl_total_cnt;
					
					SELECT NEXTVAL('SQ_FMIS_CURR_DOC_NBR') INTO vl_curr_doc_no;
					vs_curr_doc_no := 'VY' || LPAD(LTRIM(RTRIM((vl_curr_doc_no)::VARCHAR)),6,'0');
					
					UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
						SET BATCH_NO = VN_CUR_BATCH,
							CURRENT_DOCUMENT_NBR_CD = vs_curr_doc_no
					WHERE (INVOICE_NBR::INTEGER) = vl_skipped_payment_id;
					
					vl_batch_size := vl_batch_size - vl_total_cnt;
					VN_DTL_CNT := VN_DTL_CNT - vl_total_cnt;
					-- Reset
					vl_skipped_payment_id := 0;	
					Delete from TTB_SKIPPED_PAYMENTS ; 
				END LOOP;
				
				RAISE NOTICE 'vl_batch_size after Processing Skipped Payment%', vl_batch_size;
				RAISE NOTICE 'VN_DTL_CNT after Processing Skipped Payment%', VN_DTL_CNT;
			END IF;
			--continue NEXT_BATCH_NO;
		END IF;
	END LOOP;
	CLOSE cur_updt_batch_no;

	-- Commented Old Logic 04/15/2021
	/*
	--<<NEXT_BATCH_NO>>
	--WHILE VN_DTL_CNT > 0 LOOP
		VN_CUR_BATCH := VN_CUR_BATCH + 1;
		vl_batch_size := VN_BATCH_SZ;
		
		OPEN cur_updt_batch_no;
		<<cur_updt_batch>>
		LOOP
			FETCH cur_updt_batch_no INTO vl_payment_id; 
			
			EXIT cur_updt_batch WHEN NOT FOUND;
			
			--RAISE NOTICE '754 %', vl_batch_size;		
			SELECT COUNT(*)
				INTO vl_total_cnt
			FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
			WHERE (INVOICE_NBR)::INTEGER = vl_payment_id ;	
			--RAISE NOTICE '759 %', vl_total_cnt;
			
			IF vl_batch_size >= vl_total_cnt THEN
				--RAISE NOTICE '762';
				SELECT NEXTVAL('SQ_FMIS_CURR_DOC_NBR') INTO vl_curr_doc_no;
				 vs_curr_doc_no := 'VY' || LPAD(LTRIM(RTRIM((vl_curr_doc_no)::VARCHAR)),6,'0');
				
				UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
					SET BATCH_NO = VN_CUR_BATCH,
						CURRENT_DOCUMENT_NBR_CD = vs_curr_doc_no
				WHERE (INVOICE_NBR::INTEGER) = vl_payment_id;
				
				vl_batch_size := vl_batch_size - vl_total_cnt;
				VN_DTL_CNT := VN_DTL_CNT - vl_total_cnt;
			END IF;
			
			IF vl_batch_size = 0 THEN
				VN_CUR_BATCH := VN_CUR_BATCH + 1;
				vl_batch_size := VN_BATCH_SZ;
				--continue NEXT_BATCH_NO;
			END IF;
		END LOOP;
		CLOSE cur_updt_batch_no;
	--END LOOP;
	*/
	
	-- Update BATCH_SEQUENCE_NO in FMIS Detail table - START

	OPEN cur_updt_batch_seq;
	<<cur_updted_batch_seq>>

	LOOP
	  FETCH cur_updt_batch_seq INTO vs_batchno;
	  EXIT cur_updted_batch_seq WHEN NOT FOUND;
		
		UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE 
		SET BATCH_SEQUENCE_NO =  ( SELECT LPAD(RTRIM(LTRIM((TAB.NUM)::VARCHAR)),5,'0')
									FROM ( SELECT row_number() over() AS NUM, 
												A.FMIS_PAYMENT_DETAIL_RECORD_ID, 
												A.BATCH_NO
											FROM TB_FMIS_PAYMENT_DETAIL_INTERFACE A
											WHERE A.BATCH_NO = vs_batchno
											ORDER BY A.BATCH_NO, A.FMIS_PAYMENT_DETAIL_RECORD_ID
										  ) TAB
									WHERE TAB.FMIS_PAYMENT_DETAIL_RECORD_ID = TB_FMIS_PAYMENT_DETAIL_INTERFACE.FMIS_PAYMENT_DETAIL_RECORD_ID
								   )
		WHERE TB_FMIS_PAYMENT_DETAIL_INTERFACE.BATCH_NO = vs_batchno;
		
	END LOOP;
	CLOSE cur_updt_batch_seq;
	-- Update BATCH_SEQUENCE_NO in FMIS Detail table - END

	-- New logic of grouping 200 records per batch & Update BATCH_SEQUENCE_NO(INC0030993) - END

	-- Splitting logic for every 200 records - END

	-- Load FMIS Header for all batch Nos - START
	INSERT INTO cjams.TB_FMIS_PAYMENT_HEADER_INTERFACE
		( FMIS_PAYMENT_HEADER_Record_ID
		,Batch_No
		,Batch_last_sequence_no
		,Batch_entered_Count
		,Batch_entered_amt
		,payment_type_cd
		,FILLTER_3_TX
		)
		(SELECT NEXTVAL('SQ_FMIS_PAYMENT_HEADER_INTERFACE')
			,batch_no
			,max(Batch_sequence_no)
			,max(Batch_sequence_no)
			,LPAD(LTRIM(RTRIM((SUM(TRANSACTION_AMT::INTEGER))::VARCHAR)),13,'0')
			,''
			,LPAD('',618)
		FROM cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
		GROUP BY Batch_no
		);
	-- Load FMIS Header for all batch Nos - END

	-- Update FMIS Header for all constant columns & Batch No with leading 0 - START
	BEGIN
		UPDATE cjams.TB_FMIS_PAYMENT_HEADER_INTERFACE
		SET Batch_Agency_CD = cjams.F_picklist_ctxt('7732',1550)
			,Batch_type_cd = cjams.F_picklist_ctxt('8088',1550)
			,Batch_User_Operator_Id = cjams.F_picklist_ctxt('7733',1550)
			,Batch_dis_Method_Ind =  cjams.F_picklist_ctxt('7734',1550)
			,Fast_entry_Ind = cjams.F_picklist_ctxt('7735',1550)
			,batch_amt_count_Entered_Ind = cjams.F_picklist_ctxt('7736',1550)
			,Batch_status_Ind = cjams.F_picklist_ctxt('7737',1550)
			,Batch_header_count_Ind = cjams.F_picklist_ctxt('7738',1550)
			,Batch_master_file_Ind = cjams.F_picklist_ctxt('7739',1550)
			,Batch_computed_cnt = cjams.F_picklist_ctxt('7740',1550)
			,Batch_computed_amt = cjams.F_picklist_ctxt('7741',1550)
			,Approval_to_post_Ind = cjams.F_picklist_ctxt('7742',1550)
			,create_ts = CURRENT_TIMESTAMP
			,create_user_id = 'finance'
			,update_ts = CURRENT_TIMESTAMP
			,update_user_id = 'finance'
			,delete_sw = 'N'
			,BATCH_NO = LPAD(LTRIM(RTRIM(BATCH_NO)),3, '0');

		EXCEPTION WHEN OTHERS THEN
			as_error := 'ERROR in Updating cjams.TB_FMIS_PAYMENT_HEADER_INTERFACE  for Constant Columns & for Batch No with leading 0';
			vs_message_text :=  SQLERRM;
			al_sqlcode :=-1;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;

	-- Update PAYMENT_TYPE_CD for FMIS run on 1st of the month
	BEGIN
		UPDATE cjams.TB_FMIS_PAYMENT_HEADER_INTERFACE
			SET PAYMENT_TYPE_CD = 'A'
		WHERE EXTRACT( Day FROM Create_ts) >= 1;

		EXCEPTION WHEN OTHERS THEN
			as_error := 'ERROR in Updating cjams.TB_FMIS_PAYMENT_HEADER_INTERFACE  for PAYMENT_TYPE_CD = A';
			vs_message_text :=  SQLERRM;
			al_sqlcode := -1 ;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;

	-- Update PAYMENT_TYPE_CD for FMIS run on 13th of the month
	BEGIN 
		UPDATE cjams.TB_FMIS_PAYMENT_HEADER_INTERFACE
			SET PAYMENT_TYPE_CD = 'F'
		WHERE EXTRACT( Day FROM Create_ts) <= 31; --TODO please uncomment this date logic when the client ask to do so, for the original logic please check the legacy code.

		EXCEPTION WHEN OTHERS THEN
			as_error := 'ERROR in Updating cjams.TB_FMIS_PAYMENT_HEADER_INTERFACE  for PAYMENT_TYPE_CD = F';
			vs_message_text :=  SQLERRM;
			al_sqlcode := -1 ;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;
	-- Update FMIS Header for all constant columns & Batch No with leading 0 - END

	-- Update FMIS Detail Batch No with leading 0 - START
	BEGIN
		UPDATE cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE
			SET BATCH_NO = LPAD(LTRIM(RTRIM(BATCH_NO)),3, '0') ;
 
		EXCEPTION WHEN OTHERS THEN
			as_error := 'ERROR in Updating cjams.TB_FMIS_PAYMENT_DETAIL_INTERFACE  for Batch No with leading 0';
			vs_message_text :=  SQLERRM;
			al_sqlcode := -1 ;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;
	-- Update FMIS Detail Batch No with leading 0 - END

	-- Update Payment Status as '1636' -Interfaced - START
	BEGIN 
		UPDATE cjams.TB_PAYMENT_STATUS 
			SET PAYMENT_STATUS_CD = '1636'
				,PAYMENT_STATUS_DT = (CURRENT_TIMESTAMP::DATE)
				,UPDATE_TS = CURRENT_TIMESTAMP
		WHERE (TB_PAYMENT_STATUS.PAYMENT_STATUS_CD = '1634')
			AND ( TB_PAYMENT_STATUS.PAYMENT_ID IN (SELECT DISTINCT VN_TEMP_PAYMENT_ID FROM TTB_FMIS_MAIN)
				  OR
				  TB_PAYMENT_STATUS.PAYMENT_ID 
						IN ( SELECT PH.PAYMENT_ID
								FROM TB_PAYMENT_HEADER PH,
									 TB_PAYMENT_STATUS PS
							WHERE PH.PAYMENT_ID = PS.PAYMENT_ID
								AND PH.DELETE_SW = 'N' 
								AND PS.DELETE_SW = 'N' 
								AND PS.PAYMENT_STATUS_CD = '1634' 
								AND PH.PAYMENT_TYPE_CD  in ('5689','7','6')
								AND (PH.PAYMENT_START_DT <= prev_month_last_day OR PH.PAYMENT_START_DT BETWEEN prev_month_first_day AND prev_month_last_day)
								AND (PH.PAYMENT_END_DT >= prev_month_first_day OR PH.PAYMENT_END_DT BETWEEN prev_month_first_day AND prev_month_last_day)
								AND GROSS_AMOUNT_NO = COALESCE(OFFSET_AMOUNT_NO,0) )
							)   
			AND DELETE_SW = 'N';

 
		EXCEPTION WHEN OTHERS THEN
			as_error := 'UPDATE FAILED IN TB_PAYMENT_STATUS' ;
			vs_message_text :=  SQLERRM;
			al_sqlcode := -1 ;
			as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::VARCHAR) ||'::' || vs_Procedure_nm || '.' ;
			as_error := as_error || vs_message_text;
			Select SP_BATCH_ERROR_LOG (vs_Procedure_nm::character varying, NULL::bigint, NULL::bigint, NULL::character varying, NULL::INTEGER, NULL::character varying, SQLSTATE::character varying, as_error::character varying, NULL::character varying) INTO vl_ret_status;
		RETURN;
	END;
	-- Update Payment Status as '1636' -Interfaced - START

	--Error logging
	OPEN ERROR_CUR;
	
    <<ERROR_CUR_CODE>>
	LOOP
		FETCH ERROR_CUR INTO VN_ERROR_PAYMENT_ID, VN_ERROR_CLIENT_ID, VS_ERROR_COUNTY_CD, VN_ERROR_PROVIDER_ID, VS_BATCH_NO, VS_ERROR_TX;
		EXIT ERROR_CUR_CODE WHEN NOT FOUND;
		
		INSERT INTO interfaceserrorlog   
			(	interfaceid,
				currentruntimestamp,
				errorsqlcode,
				insertedby,
				insertedon,
				errordescription,
				batchnumber,
				payment_id ,
				provider_id ,
				county_cd  ,
				client_id 
			)
		VALUES ('FMIS_PAYMENT',
				CURRENT_TIMESTAMP,
				null::varchar,
				'finance',
				CURRENT_TIMESTAMP,
				VS_ERROR_TX::varchar,
				VS_BATCH_NO::varchar,
				VN_ERROR_PAYMENT_ID::bigint,
				VN_ERROR_PROVIDER_ID::bigint,
				VS_ERROR_COUNTY_CD::varchar,
				VN_ERROR_CLIENT_ID::bigint
				);
								
	
	END LOOP;
	
	INSERT INTO INTERFACESRUNTIMESLOG  
        (   INTERFACEID,
            CURRENTRUNTIMESTAMP,
            BATCHNUMBER,
            INSERTEDON,
            INSERTEDBY,
            UPDATEDON,
            UPDATEDBY,
            ACTIVEFLAG,
            OLD_ID
        )
       VALUES (   'FMIS_PAYMENT',
            CURRENT_TIMESTAMP,
            VS_BATCH_NO::bigint,
            CURRENT_TIMESTAMP,
            'finance',                              
            CURRENT_TIMESTAMP,
            'finance',
            1,
            null
        );
		
	al_sqlcode := 0;
    RETURN;

END; 

$function$
;
