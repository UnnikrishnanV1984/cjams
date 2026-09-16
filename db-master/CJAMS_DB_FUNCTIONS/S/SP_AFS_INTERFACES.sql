CREATE OR REPLACE FUNCTION cjams.sp_afs_interfaces(OUT vs_message character varying, OUT vl_output_sqlcode character varying, OUT a timestamp without time zone, OUT b timestamp without time zone)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Mohan
-- Date Created :04/26/2005
-- generates AFS Interface payment records
-- Revision
-- Mohan    10/24/05  - AFS - Previous payments are re-sent if no data in current day(Incident 4687)
-- Mohan    12/29/05  - #5267
-- Mohan    13/01/06  - #6025
-- MOhan    01/18/06    #6095
-- Mohan    01/18/06    #6138
-- Mohan    01/25/06    #6211
-- sandhya  05/23/06    #7581 (rectified)
-- sandhya  05/23/06    #7621  (populate error table)
-- sandhya  06/12/06    #7573, #7574, #7575, #7716  --  Error log  table
-- sandhya  07/08/06    #8464  --  Truncated vendor name columns to 20 char and added error logging
-- Hema     07/17/06    #8759 -- Modified error messages and ADDED EXCEP MESSAGE FOR ADDRESS TYPE
-- Hema     07/24/06    #8759 -- Modified Exceptional Messages to add county name, provider and client name
-- Hema     08/01/06    #8759 -- Modified county code to county name
-- Hema     08/10/06    #8759 -- If updating tb_payment_status fails write exception record and if any sql fails
                                 -- write error messages without interupting the program run.
-- Hema     08/23/06    #9676 -- Insert one exception record per payment

-- Hema     08/28/06    #9752 -- User friendly error message client_name and missing column seperate by '-'
-- Hema     09/11/06    #9903 -- For county code map payment_id instead of client_id and reinitialize
                              -- vl_output_sqlcode.
-- Hema    09/19/06    #10001 -- Fixed
-- Hema    09/25/06    #10001 -- modified zipcode5 error message
-- Hema    10/02/2006  #10094  -- fixed
-- Hema    12/07/06    #11127  -- Modified code not to get subsidized guardianship payments
-- sandhya 02/05/2007  #12174 exclude montgomery county
-- Sandhya 02/20/07  - #12174 Not to exception Child disbursement payments whose payee number is zero (added child disbursement flag)
-- sandhya - 02/22/07 --#12174 - commented cursors.. provider & client
-- Sandhya - 08/07/2007 -- #13427 - change the length of Vendor Name and Payee Short Name to 40 from the original 20.
-- Sandhya - 08/29/2007 -- #15672 - REMOVED DISTINCT FROM THE CURSOR DUE TO SINGLE RECORDS IN THE ERROR LOG TABLE check payid : 46706 in reportsdb
-- Sandhya - 08/29/2007 -- #15672 - Added condition for validating Final Amount.  Check if Final Amt is null along with the check final amt =0
-- sandhya - 06/04/2008 -  COUNTY ROLL-UP
-- Sandhya - 10/14/2008 - #18816 -(CIS-18129) For System Adjustment payments, check if the linked payment ID is released, if so, mark the new paymnet as 'RELS'
-- Sandhya - 12/01/2008 - #19071 - Pad Zip codes with leading zeros.
-- Sandhya - 02/20/2009 - #19508 - Payment_detail_id added to cursor and also in the INSERT
-- Raghu T   12/10/2010 - #Prj-01179 1) Replacing payment_detail_id with payment_id
--                                   2) Replacing zero provider_id with client_id for CHAC types.
-- 07/25/2012 Samir Patil PRJ-02667 - MD CHESSIE Batch Process Redesign - To change Return 0 on success
-- 01/21/2019	Vineet Tirodkar - B-28317 - AFS interface Modernization
-- 				Modification to populate newly added columns in TB_AFS_INTERFACES for New AFS system Interface
-- 03/09/2019 Raghuveer Reddy Dachani CJAMS implementation converted from DB2 - POSTGRESQL
-- 10/11/2019 H. S.     CJAMS - For Child Account change the Location ID to match the Vendor ACCOUNT
--                            - Change Approve by from 100 to 200
-- 05/21/2020 Tanmay M - CJAMS - Handling Foreign Address Zip Code
-- 07/30/2020 Vineet Tirodkar - CJAMS - To fix error of Provider address Street number greater than 5 characters
-- 11/03/2020 Vineet Tirodkar - CDM-4627 - To update JOURNAL_DESC as unique timestamp values
-- 12/16/2020 Vineet Tirodkar - Changes to first look for provider_nm column else provider_first_nm and provider_last_nm (CDM-3556)
-- 04/14/2022 Chandra Ramasamy -- Added the new payment for D365 - CfE Bed Hold Retainer Fee(payment type code =26)
-- 01/17/2024 Vineet Tirodkar - To fix error of Provider address PO Box number Length greater than 6 digits (CIDM-8328)
-- 05/04/2026 Yogeshvar Senthilkumar - 1099 Reportable Tax selection new option request - NEC-01 support. (CIDM-11355)
-- 05/11/2026 Yogeshvar Senthilkumar - 1099 Reportable Tax selection new type code/prov tax code changes. (CIDM-11365)
---------------------------------------------------------------------------------------------------------------------------
-- VARIABLE DECLARATION

DECLARE VS_OUTPUT_STATE VARCHAR(5) DEFAULT '00000';
DECLARE vts_previous_run_ts timestamp;
DECLARE vts_current_run_ts timestamp ;
DECLARE VL_ROWCOUNT INTEGER DEFAULT 0;
DECLARE VS_USER_ID  VARCHAR(10)  DEFAULT 'interface';
DECLARE VL_INTERFACE_ROWCOUNT INTEGER DEFAULT 0;
DECLARE li_provider_id INTEGER DEFAULT 0;
DECLARE ls_county Varchar(4) DEFAULT '0000';
DECLARE ls_county_cd Varchar(2) DEFAULT '99';
DECLARE ls_provider_nm Varchar(500);
DECLARE ls_INDICATOR_1099_SW Varchar(3);
DECLARE ls_Provider_last_nm  Varchar(100);
DECLARE ls_Provider_first_nm Varchar(100);
DECLARE ls_Provider_middle_nm Varchar(100);
DECLARE ls_person_nm Varchar(100);
DECLARE ls_org_nm Varchar(100);
DECLARE ls_vendor_nm Varchar(100);
DECLARE li_vendor_ln_1 INTEGER;
DECLARE li_vendor_ln_2 INTEGER;
DECLARE ls_payment_method_cd  CHAR(1);
DECLARE LS_LINK_PAYMENT_STATUS  VARCHAR(4); -- new
DECLARE li_linked_pymnt_id  INTEGER; -- new
DECLARE li_payment_id  INTEGER;
DECLARE ls_payment_id  VARCHAR(20);
DECLARE li_afs_interface_record_id  INTEGER;
DECLARE ld_Payment_dt  DATE  ;
DECLARE ld_final_service_dt DATE  ;
DECLARE li_client_id    INTEGER;
DECLARE ls_client_first_nm  VARCHAR(100);
DECLARE ls_client_last_nm   VARCHAR(100);
DECLARE ls_client_nm   VARCHAR(100);
DECLARE li_client_nm   INTEGER;
DECLARE li_final_amount_no  DECIMAL(13,2) DEFAULT 0.0;
DECLARE ls_prov_tax_type_cd  VARCHAR(4);
DECLARE ls_TYPE_1099_CD  VARCHAR(5);
DECLARE ls_FINAL_FISCAL_CATEGORY_CD  VARCHAR(5);
DECLARE li_TAX_ID_NO  INTEGER;
DECLARE ls_TAX_ID_NO  Varchar(100);
DECLARE li_STORE_RECEIPT_ID INTEGER;
DECLARE ls_STORE_RECEIPT_ID  VARCHAR(100);
DECLARE ls_ADR_WORK_PHONE_TX VARCHAR(20);
DECLARE ls_ADR_HOME_PHONE_TX  VARCHAR(20);
DECLARE ls_ADR_CELL_PHONE_TX  VARCHAR(20);
DECLARE ls_PHONE_TX  VARCHAR(20);
DECLARE ls_adr_type_cd  VARCHAR(5);
DECLARE ls_Adr_format_cd VARChar(5);
DECLARE li_Adr_street_no  Integer Default 0;
DECLARE li_Adr_Box_no     Integer Default 0;
DECLARE ls_Adr_pre_dir_cd VARChar(5);
DECLARE ls_Adr_street_nm   VARChar(50) ;
DECLARE ls_Adr_street_suffix_cd VARChar(5);
DECLARE ls_Adr_post_dir_cd VARChar(5);
DECLARE ls_Adr_unit_type_cd VARChar(5);
DECLARE ls_Adr_unit_no_tx   VARChar(5);
DECLARE ls_Adr_city_nm      VARChar(50);
DECLARE ls_adr_state_cd  VARChar(5);
DECLARE ls_Adr_foreign_tx VArChar(500);
DECLARE ls_Adr_foreign_state_tx VARChar(50);
DECLARE ls_Adr_country_tx VARChar(50);
DECLARE li_Adr_zip5_no Integer ;
DECLARE li_Adr_zip4_no Integer;
DECLARE ls_address_1  VARChar(100);
DECLARE ls_Adr_zip5_no   VarChar(5);
DECLARE ls_Adr_zip4_no   Varchar(4);
DECLARE ls_Adr_street_no  Varchar(10) ; -- Changed from Varchar(5) 07/30/2020
DECLARE ls_Adr_street_no1  Varchar(50) ;
DECLARE ls_Adr_Box_no     Varchar(30) ; -- Changed from Varchar(15) 01/17/2024
DECLARE ls_address_2  VARChar(100);
DECLARE ls_zip_code  Varchar(50);
DECLARE li_payment_count  Integer;
DECLARE li_client_count  Integer;
DECLARE ls_pay_to_affiliate_cd  Varchar(5);
DECLARE li_check Integer default 0;
DECLARE li_address_1  Integer;
DECLARE li_address_2  Integer;
DECLARE li_city  Integer;
DECLARE ls_payee_nbr Varchar(10);
DECLARE li_payee_nbr Integer;
DECLARE ls_REPORT_1099_SW  Varchar(1);
DECLARE ls_payment_type_cd  Varchar(5);
DECLARE ls_manual_sw Char(1);
DECLARE li_length  INTEGER default 0;
DECLARE ls_alternate_adr_type_cd  VARCHAR(5);
DECLARE li_temp_provider_id  INTEGER Default 0;
DECLARE li_affiliate_provider_id INTEGER Default 0;
DECLARE VS_PAYEE_SHORT_NM   VARCHAR(100);
DECLARE VS_PAYMENT_TYPE_CD  VARCHAR(5) DEFAULT '0000';
DECLARE VL_PAYMENT_COUNT    INTEGER DEFAULT 0;
DECLARE VL_ERROR_COUNT    INTEGER DEFAULT 0;
DECLARE VL_INTERFACES_ERROR_LOG_ID    INTEGER DEFAULT 0;
DECLARE VL_ERROR_LOGGED    INTEGER DEFAULT 0;
DECLARE VS_EXCEP_MESSAGE VARCHAR(2000)  default '' ;
Declare VS_EXC_ADR_TYPE varchar(100) DEFAULT '';
DECLARE LS_COUNTY_NAME VARCHAR(25) DEFAULT  '' ;
DECLARE LS_ERROR_PROVNAME VARCHAR(2)DEFAULT  '' ;
DECLARE LS_ERROR_CHILDNAME VARCHAR(2)DEFAULT  '' ;
DECLARE VS_EXCEP_MESSAGE1 VARCHAR(500)DEFAULT  '' ;
DECLARE VS_CHILD_DISBURSEMENT varchar (1) default 'N';
DECLARE li_payment_detail_id  INTEGER;
-- B-28317
DECLARE ld_amount_1099 DECIMAL(10,2);
DECLARE ls_code_1099 VARCHAR(10);
DECLARE ls_account_type VARCHAR(10);
DECLARE ll_address_id BIGINT;
DECLARE ls_address_id_tx VARCHAR(20);
DECLARE ls_approved VARCHAR(5);
DECLARE ls_approved_by VARCHAR(5);
DECLARE ls_currency VARCHAR(5);
DECLARE ls_invoice VARCHAR(20);
DECLARE ls_invoice_desc VARCHAR(100);
DECLARE ls_journal_desc VARCHAR(50);
DECLARE ls_payor_company VARCHAR(5);
DECLARE ls_offset_account VARCHAR(30);
DECLARE ls_offset_account_type VARCHAR(10);
DECLARE ls_posting_profile VARCHAR(10);
DECLARE ls_terms_of_payment VARCHAR(5);
DECLARE ls_vendoraccount VARCHAR(15);
DECLARE ls_childacc_id VARCHAR; --04072019

DECLARE PAYMENT_CUR CURSOR  FOR
	SELECT  HDR.PAYMENT_id,
		DTL.LINKED_PYMNT_HDR_ID,
		HDR.provider_id,
		HDR.PAYMENT_METHOD_CD,
		DTL.client_id,
		DTL.TYPE_1099_CD,
		DTL.FINAL_FISCAL_CATEGORY_CD,
		HDR.STORE_RECEIPT_ID,
		DTL.FINAL_AMOUNT_NO,
		HDR.PAYMENT_DT,
		DTL.FINAL_SERVICE_END_DT,
		DTL.REPORT_1099_SW,
		HDR.PAYMENT_TYPE_CD,
		HDR.MANUAL_SW      ,
		DTL.PAYMENT_DETAIL_ID
	FROM TB_PAYMENT_HEADER as HDR,
		TB_PAYMENT_DETAIL as DTL,
		TB_PAYMENT_STATUS
	WHERE HDR.Payment_id = Dtl.Payment_id
		AND HDR.Delete_sw = 'N'
		AND (TB_PAYMENT_STATUS.PAYMENT_STATUS_CD = '1634' )
		AND HDR.Delete_sw = 'N'
		AND DTL.Delete_sw = 'N'
		AND TB_PAYMENT_STATUS.Delete_sw = 'N'
		AND HDR.Payment_id = TB_PAYMENT_STATUS.Payment_id
		AND HDR.PAYMENT_TYPE_CD  NOT IN ('6','5689','7')   -- 12/07/06 #11127
		-- VINEET 04/21/2020 - To exclude payments created in MD CHESSIE
		AND HDR.PAYMENT_id >= 2896828 -- First CJAMS Payment ID
		--AND btrim(DTL.county_cd) IN ( select statecountycode from county where activeflag = 1 and golivedate <= CURRENT_DATE )
		/*
		and  dtl.create_ts::date >= (select min(golivedate)
									from county
									where activeflag = 1
									and golivedate is not null
									and statecountycode is not null
									)
		*/							
	ORDER BY  HDR.PAYMENT_ID;

BEGIN
	vts_previous_run_ts := CURRENT_TIMESTAMP;
	vts_current_run_ts := CURRENT_TIMESTAMP;
	ld_Payment_dt := '1900-01-01'::DATE;
	ld_final_service_dt := '1900-01-01'::DATE;
	VL_OUTPUT_SQLCODE := '00000';

	--  if first run, i.e., no rows in log, then leave as initialized
	IF EXISTS (SELECT 1 FROM INTERFACESRUNTIMESLOG) THEN
	BEGIN
		SELECT MAX(CURRENTRUNTIMESTAMP) INTO vts_previous_run_ts FROM INTERFACESRUNTIMESLOG ;
		EXCEPTION WHEN OTHERS THEN
			VS_MESSAGE := 'SELECT MAX(CURRENTRUNTIMESTAMP) FAILED '||SQLERRM  ;
			VL_OUTPUT_SQLCODE := SQLSTATE;
			INSERT INTO interfaceserrorlog(INTERFACEID, CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE,
				ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id, payment_amount)
			VALUES ('AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0',
					VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id ,
					li_final_amount_no);
			RETURN;
		END;
	END IF;

-- DELETE Of the Output table AFS_INTERFACES -- takes place on the script which call the procedure

-- Check for rows to interface, if none then quit.
BEGIN
	IF EXISTS (	SELECT 1
				FROM TB_PAYMENT_DETAIL as DTL,
					TB_PAYMENT_HEADER as HDR,
					TB_PAYMENT_STATUS, TB_PROVIDER
				WHERE ( HDR.PAYMENT_ID = DTL.PAYMENT_ID ) and
					( HDR.PAYMENT_ID = TB_PAYMENT_STATUS.PAYMENT_ID ) and
					( TB_PAYMENT_STATUS.PAYMENT_STATUS_CD = '1634' ) and
					( TB_PROVIDER.PROVIDER_ID = HDR.PROVIDER_ID ) AND
					HDR.Delete_sw = 'N'
					AND DTL.Delete_sw = 'N'
					AND TB_PAYMENT_STATUS.Delete_sw = 'N'
					AND TB_PROVIDER.DELETE_SW  = 'N'
					-- TANMAY 05/21/2020 - To exclude payments created in MD CHESSIE
					AND HDR.PAYMENT_TYPE_CD  NOT IN ('6','5689','7')
					AND HDR.PAYMENT_id >= 2896828 -- First CJAMS Payment ID
					--AND DTL.county_cd  IN( select statecountycode from county where activeflag = 1 and golivedate <= CURRENT_DATE )
					/*and  dtl.create_ts::date >= (select min(golivedate)
													from county
												 where activeflag = 1
													and golivedate is not null
													and statecountycode is not null
													)
					*/
				) THEN
	 --
	ELSE
		VS_MESSAGE := 'THERE ARE NO ROWS TO INTERFACE; PAYMENT_STATUS_CD <> 1634'  ;
	END IF;

	EXCEPTION WHEN OTHERS THEN
		VS_MESSAGE := 'SELECT OF ROWS TO INTERFACE COUNT(*) FAILED '||SQLERRM  ;
		VL_OUTPUT_SQLCODE := SQLSTATE;
		INSERT INTO interfaceserrorlog(INTERFACEID,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE,
			ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
		VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0',
			VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);
		RETURN;
END;


-- Delete the existing records in the interface table
-- Insert records into the TB_AFS_INTERFACES table from
-- the TB_PAYMENT DETAIL, TB_PAYMENT_HEADER, and TB_PROVIDER
-- when the status code is 1634.
-- Update the records with "interfaced" status.
-- Insert new record in interface log with the date/time of the run.
SELECT COUNT(*) INTO VL_PAYMENT_COUNT
	FROM TB_PAYMENT_HEADER as HDR,
		TB_PAYMENT_DETAIL as DTL,
		TB_PAYMENT_STATUS
WHERE HDR.Payment_id = Dtl.Payment_id
	AND HDR.Delete_sw = 'N'
	AND ( TB_PAYMENT_STATUS.PAYMENT_STATUS_CD = '1634' )
	AND HDR.Delete_sw = 'N'
	AND DTL.Delete_sw = 'N'
	AND TB_PAYMENT_STATUS.Delete_sw = 'N'
	AND HDR.Payment_id = TB_PAYMENT_STATUS.Payment_id
	AND HDR.PAYMENT_TYPE_CD NOT IN  ('6','5689','7') --12/07/06 #11127
	-- TANMAY 05/21/2020 - To exclude payments created in MD CHESSIE
	AND HDR.PAYMENT_id >= 2896828 -- First CJAMS Payment ID
	--AND DTL.county_cd  IN( select statecountycode from county where activeflag = 1 and golivedate <= CURRENT_DATE )
	/*and  dtl.create_ts::date >= (select min(golivedate)
									from county
								 where activeflag = 1
									and golivedate is not null
									and statecountycode is not null
								);
	*/
	;

OPEN PAYMENT_CUR;
	<<PAYMENT>>
WHILE VL_PAYMENT_COUNT > 0  LOOP
	-- #10001
	li_payment_id := 0;
	li_provider_id := 0;
	ls_payment_method_cd := '';
	li_client_id := 0;
	ls_TYPE_1099_CD := '';
	LS_FINAL_FISCAL_CATEGORY_CD := '';
	ls_STORE_RECEIPT_ID := '';
	li_final_amount_no := 0 ;
	ld_Payment_dt := NULL ;
	ld_final_service_dt := NULL;
	ls_REPORT_1099_SW := '';
	ls_payment_type_cd := '';
	ls_manual_sw := '';
	li_linked_pymnt_id := 0;          --new
	LS_LINK_PAYMENT_STATUS := '';     --new
	li_payment_detail_id := 0;

	FETCH PAYMENT_CUR INTO  li_payment_id,
       li_linked_pymnt_id,
       li_provider_id,
       ls_payment_method_cd,
       li_client_id ,
       ls_TYPE_1099_CD,
       ls_FINAL_FISCAL_CATEGORY_CD,
       ls_STORE_RECEIPT_ID,
       li_final_amount_no,
       ld_Payment_dt,
       ld_final_service_dt,
       ls_REPORT_1099_SW,
       ls_payment_type_cd,
       ls_manual_sw,
       li_payment_detail_id;

	EXIT PAYMENT WHEN NOT FOUND;

	LI_CLIENT_COUNT := 0; -- #10001

	li_provider_id := COALESCE(li_provider_id,0);
	-- added 09/08/06

	ls_provider_nm := '' ;
	ls_Provider_last_nm := '';
	ls_Provider_first_nm := '';
	ls_Provider_middle_nm := '';
	ls_INDICATOR_1099_SW := '';
	ls_ADR_WORK_PHONE_TX := '';
	ls_ADR_HOME_PHONE_TX := '';
	ls_ADR_CELL_PHONE_TX := '';
	ls_prov_tax_type_cd := '';
	li_TAX_ID_NO := 0;
	ls_pay_to_affiliate_cd := '';

	IF li_provider_id > 0 THEN   -- Provider Information
		VS_CHILD_DISBURSEMENT := 'N';

		BEGIN
			SELECT  TB_PROVIDER.PROVIDER_NM,
				TB_PROVIDER.Provider_last_nm,
				TB_PROVIDER.Provider_First_nm,
				TB_PROVIDER.Provider_middle_nm
			INTO ls_provider_nm,
				ls_Provider_last_nm,
				ls_Provider_first_nm,
				ls_Provider_middle_nm
			FROM TB_PROVIDER
			WHERE TB_PROVIDER.provider_id  = li_provider_id
				AND TB_PROVIDER.Delete_sw  = 'N' ;


			SELECT DISTINCT TB_PROVIDER.INDICATOR_1099_SW,
				TB_PROVIDER.ADR_WORK_PHONE_TX,
				TB_PROVIDER.ADR_HOME_PHONE_TX,
				TB_PROVIDER.ADR_CELL_PHONE_TX,
				coalesce (TB_PROVIDER.prov_tax_type_cd,
							(select TB_PROVIDER.prov_tax_type_cd
								from tb_provider
							where provider_id = (select affiliate_provider_id from tb_provider
								where provider_id = li_provider_id))) as prov_tax_type_cd,
				coalesce (TB_PROVIDER.TAX_ID_NO,
							(select TAX_ID_NO
								from tb_provider
							where provider_id = (select affiliate_provider_id from tb_provider
								where provider_id = li_provider_id)))as TAX_ID_NO,
				pay_to_affiliate_cd
			INTO ls_INDICATOR_1099_SW,
				ls_ADR_WORK_PHONE_TX,
				ls_ADR_HOME_PHONE_TX,
				ls_ADR_CELL_PHONE_TX,
				ls_prov_tax_type_cd,
				li_TAX_ID_NO,
				ls_pay_to_affiliate_cd
			FROM TB_PROVIDER
			WHERE TB_PROVIDER.provider_id  = li_provider_id
				AND TB_PROVIDER.Delete_sw  = 'N';

			EXCEPTION WHEN OTHERS THEN
				VS_MESSAGE := 'Error in fetching Provider Information '||SQLERRM  ;
				VL_OUTPUT_SQLCODE := SQLSTATE;
				INSERT INTO interfaceserrorlog(INTERFACEID,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
				VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);
				RETURN;
		END;

		IF VL_PAYMENT_COUNT > 0 THEN
			li_check := 1;
		END IF;

		IF ls_prov_tax_type_cd = '2517' THEN
			ls_prov_tax_type_cd := '1';
		ELSIF ls_prov_tax_type_cd in ('2518', '2519') THEN
			ls_prov_tax_type_cd := '2';
		ELSE
			ls_prov_tax_type_cd := LPAD('',1);
		END IF;

		IF ls_TYPE_1099_CD = '3155' THEN
			ls_TYPE_1099_CD := '1';
		ELSIF ls_TYPE_1099_CD = '3156' THEN
			ls_TYPE_1099_CD := '6';
		ELSIF ls_TYPE_1099_CD = '3157' THEN
			ls_TYPE_1099_CD := '7';
		ELSIF ls_TYPE_1099_CD = '3159' THEN
			ls_TYPE_1099_CD := '9';
		ELSE
			ls_TYPE_1099_CD := NULL;
		END IF;

		ls_tax_id_no := Substring(RTRIM(LTRIM(li_TAX_ID_NO::VARCHAR)),1,9);
		li_length := LENGTH(RTRIM(ls_tax_id_no));
		IF li_length < 9 THEN
			li_length := 9 - li_length ;
			WHILE li_length > 0 LOOP
				ls_tax_id_no := '0' || ls_tax_id_no;
				li_length := li_length - 1;
			END LOOP;
		END IF;

		ls_STORE_RECEIPT_ID := RTRIM(LTRIM((ls_STORE_RECEIPT_ID)));

		CASE WHEN LENGTH(ls_ADR_WORK_PHONE_TX) = 0 THEN
			ls_phone_tx := COALESCE( ls_ADR_CELL_PHONE_TX, ls_ADR_HOME_PHONE_TX );
		ELSE
			ls_phone_tx := ls_ADR_WORK_PHONE_TX;
		END CASE;

		ls_provider_last_nm := RTRIM(LTRIM(ls_provider_last_nm));
		ls_provider_first_nm := RTRIM(LTRIM(ls_provider_first_nm));
		ls_provider_middle_nm := RTRIM(LTRIM(ls_provider_middle_nm));

		CASE WHEN LENGTH(ls_provider_last_nm) = 0 THEN
			ls_provider_last_nm := '';
		ELSE
			ls_provider_last_nm := COALESCE(ls_provider_last_nm,'');
		END CASE;

		IF ls_provider_last_nm <> '' THEN
			ls_provider_last_nm := ls_provider_last_nm;
		END IF;

		CASE WHEN length(ls_provider_first_nm) = 0 THEN
			ls_provider_first_nm := '';
		ELSE
			ls_provider_first_nm := COALESCE(ls_provider_first_nm,'');
		END CASE;

		IF ls_provider_first_nm <> '' THEN
			ls_provider_first_nm := ls_provider_first_nm;
		END IF;

		CASE WHEN length(ls_provider_middle_nm) = 0 THEN
			ls_provider_middle_nm := '';
		ELSE
			ls_provider_middle_nm := COALESCE(ls_provider_middle_nm,'');
		END CASE;

		IF ls_provider_middle_nm <> '' THEN
			ls_provider_middle_nm := ',' || ' ' || ls_provider_middle_nm;
		END IF;

		CASE WHEN length(ls_provider_nm) = 0 THEN
			ls_provider_nm := '';
		ELSE
			ls_provider_nm := COALESCE(ls_provider_nm,'');
		END CASE;

		ls_person_nm :=  COALESCE(RTRIM(LTRIM(ls_provider_last_nm)),'') || ',' || ' ' ||
		COALESCE(RTRIM(LTRIM(ls_provider_first_nm)),'') ;

		-- Current Code
		/*
		IF ls_person_nm = ','  THEN
		ls_person_nm := ' ';
		END IF;
		*/

		-- New Code
		IF ls_person_nm = ', '  THEN
			ls_person_nm := '';
		END IF;

		ls_org_nm := COALESCE(RTRIM(LTRIM(ls_provider_nm)),'');
		VS_PAYEE_SHORT_NM :=  COALESCE(RTRIM(LTRIM(ls_provider_first_nm)),'') || ' ' ||
			  COALESCE(RTRIM(LTRIM(ls_provider_last_nm)),'');

		CASE WHEN length(ls_person_nm) = 0 THEN
			ls_person_nm := '';
		ELSE
			ls_person_nm := COALESCE(ls_person_nm,'');
		END CASE;

		CASE WHEN length(ls_org_nm) = 0 THEN
			ls_org_nm := '';
		ELSE
			ls_org_nm := COALESCE(ls_org_nm,'');
		END CASE;
		
		-- CDM-3556
		IF ls_org_nm <> '' THEN
			ls_vendor_nm := ls_org_nm;
			VS_PAYEE_SHORT_NM := ls_org_nm;
		ELSIF ls_person_nm <> '' THEN
			ls_vendor_nm := ls_person_nm;
		END IF;
		-- Old code
		/*
		IF ls_person_nm <> '' THEN
			ls_vendor_nm := ls_person_nm;
		ELSIF ls_org_nm <> '' THEN
			ls_vendor_nm := ls_org_nm;
			VS_PAYEE_SHORT_NM := ls_org_nm;
		END IF;
		*/
		
		li_vendor_ln_1 := Length(ls_vendor_nm);
		li_vendor_ln_2 := Length(ls_vendor_nm);

		IF li_vendor_ln_1 > 40 OR li_vendor_ln_1 = 40 THEN  -- #13427
			li_vendor_ln_1 := 40 ;
		END IF;

		IF li_vendor_ln_2 > 40 OR li_vendor_ln_2 = 40 THEN  -- #13427
			li_vendor_ln_2 := 40;
		END IF;

		ls_payment_id := RTRIM(LTRIM((li_payment_id::VARCHAR)));

		BEGIN
			CASE WHEN ls_pay_to_affiliate_cd IN ('3366') THEN    --  For LDSS
				ls_alternate_adr_type_cd := '3357';
				li_temp_provider_id := li_provider_id;
			WHEN ls_pay_to_affiliate_cd IN ('3367') THEN  --  For Private Department
				ls_alternate_adr_type_cd := '3356';
				li_temp_provider_id := li_provider_id;
			WHEN ls_pay_to_affiliate_cd IN ('3368') THEN
				li_affiliate_provider_id := 0;  --#10001


			SELECT DISTINCT TB_PROVIDER.Affiliate_Provider_ID
				INTO li_affiliate_provider_id
			FROM TB_PROVIDER
			WHERE TB_PROVIDER.provider_id = li_provider_id
				AND TB_PROVIDER.Delete_sw  = 'N';


			IF li_affiliate_provider_id > 0 THEN
				ls_pay_to_affiliate_cd := ''; -- #10001

				SELECT pay_to_affiliate_cd
					INTO ls_pay_to_affiliate_cd
				FROM TB_PROVIDER
				WHERE Affiliate_Provider_ID = li_affiliate_provider_id
					AND provider_id = li_provider_id
					AND delete_sw = 'N';


				CASE WHEN ls_pay_to_affiliate_cd in ('3366') THEN    --  For LDSS
					ls_alternate_adr_type_cd := '3357';
					li_temp_provider_id := li_provider_id;
				WHEN ls_pay_to_affiliate_cd IN ('3367') THEN  --  For Private Department
					ls_alternate_adr_type_cd := '3356'     ;
					li_temp_provider_id := li_provider_id;
				WHEN ls_pay_to_affiliate_cd IN ('3368') THEN
					ls_pay_to_affiliate_cd := '' ; -- #10001

					SELECT pay_to_affiliate_cd
						INTO ls_pay_to_affiliate_cd
					FROM TB_PROVIDER
					WHERE provider_id = li_affiliate_provider_id
						AND delete_sw  = 'N';

						--VL_OUTPUT_SQLCODE := 0 ; -- 09/08/06

						CASE WHEN ls_pay_to_affiliate_cd in ('3366') THEN    --  For LDSS
							ls_alternate_adr_type_cd := '3357';
							li_temp_provider_id := li_affiliate_provider_id;
						WHEN ls_pay_to_affiliate_cd IN ('3367') THEN  --  For Private Department
							ls_alternate_adr_type_cd := '3356'     ;
							li_temp_provider_id := li_affiliate_provider_id;
						ELSE
							ls_alternate_adr_type_cd := lpad('',4);
						END CASE;
					ELSE
						ls_alternate_adr_type_cd := lpad('',4);
					END CASE;
				END IF;  --  If affiliate provider is zero
			ELSE
				ls_alternate_adr_type_cd := lpad('',4);
			END CASE;

			EXCEPTION WHEN OTHERS THEN
				VS_MESSAGE := 'Error in fetching  Affiliate Provider for Private Department '||SQLERRM  ;
				VL_OUTPUT_SQLCODE := SQLSTATE;

		END;

		-- ADDED EXCEP MESSAGE FOR ADDRESS TYPE  07/14/06
		IF ls_alternate_adr_type_cd = '3356' Then
			VS_EXC_ADR_TYPE := 'Provider Payment address ' ;
		ELSIF ls_alternate_adr_type_cd = '3357' Then
			VS_EXC_ADR_TYPE := 'Provider Location address ' ;
		ELSE
			VS_EXC_ADR_TYPE := 'Provider address ' ;
		END IF;

		-- B-28317
		ll_address_id := NULL; -- for AddressCode
		-- 09/19/06 #10001
		ls_Adr_type_cd := '';
		ls_Adr_format_cd := '';
		ls_Adr_street_no := '';
		li_Adr_Box_no := 0 ;
		ls_Adr_pre_dir_cd := '';
		ls_Adr_street_nm := '';
		ls_Adr_street_suffix_cd := '';
		ls_Adr_post_dir_cd := '';
		ls_Adr_unit_type_cd := '';
		ls_Adr_unit_no_tx := '';
		ls_Adr_city_nm := '';
		ls_Adr_state_cd := '';
		ls_Adr_foreign_tx := '';
		ls_Adr_foreign_state_tx := '';
		ls_Adr_country_tx := '';
		li_Adr_zip5_no := 0;
		li_Adr_zip4_no := 0;  -- #10001
		BEGIN
			SELECT DISTINCT ADDRESS_ID,
				Adr_type_cd,
				Adr_format_cd,
				Adr_street_tx,
				Adr_Box_no,
				Adr_pre_dir_cd,
				Adr_street_nm,
				Adr_street_suffix_cd,
				Adr_post_dir_cd,
				Adr_unit_type_cd,
				Adr_unit_no_tx,
				Adr_city_nm,
				Adr_state_cd,
				Adr_foreign_tx,
				Adr_foreign_state_tx,
				Adr_country_tx,
				Adr_zip5_no,
				Adr_zip4_no
			INTO ll_address_id,
				ls_Adr_type_cd,
				ls_Adr_format_cd,
				ls_Adr_street_no,
				li_Adr_Box_no,
				ls_Adr_pre_dir_cd,
				ls_Adr_street_nm,
				ls_Adr_street_suffix_cd,
				ls_Adr_post_dir_cd,
				ls_Adr_unit_type_cd,
				ls_Adr_unit_no_tx,
				ls_Adr_city_nm,
				ls_Adr_state_cd,
				ls_Adr_foreign_tx,
				ls_Adr_foreign_state_tx,
				ls_Adr_country_tx,
				li_Adr_zip5_no,
				li_Adr_zip4_no
			FROM TB_PROVIDER_ADDRESSES,TB_PROVIDER
			WHERE TB_PROVIDER_ADDRESSES.parent_key_id = li_temp_provider_id::character varying
				AND TB_PROVIDER_ADDRESSES.Delete_sw = 'N'
				AND TB_PROVIDER_ADDRESSES.ADR_DEFAULT_SW = 'Y'
				AND Adr_type_cd = ls_alternate_adr_type_cd  ;

			EXCEPTION WHEN OTHERS THEN
				VS_MESSAGE := 'Error in fetching Provider Address '||SQLERRM  ;
				VL_OUTPUT_SQLCODE := SQLSTATE;
				INSERT INTO interfaceserrorlog(INTERFACEID,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO,
					ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd,
					client_id,  payment_amount)
				VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE,
					VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);

		END;


		CASE WHEN LENGTH(ls_Adr_street_no) = 0 THEN
			ls_Adr_street_no := '';
		ELSE
			ls_Adr_street_no := COALESCE(ls_Adr_street_no,'');
		END CASE;

		IF li_Adr_Box_no > 0 THEN
			ls_Adr_Box_no := 'P.O. Box ' || RTRIM(LTRIM((li_Adr_Box_no::VARCHAR))) ;
		ELSE
			ls_Adr_Box_no := '      '; --lpad('',6);
		END IF;

		--  Based on the Address Format Get the values
		CASE WHEN ls_Adr_format_cd = 'S' THEN
			ls_address_1 := COALESCE(RTRIM(LTRIM(ls_Adr_street_no)),'')    || ' '||
			UPPER(COALESCE(F_PDESC(ls_Adr_pre_dir_cd,69),''))        || ' '||
			UPPER(RTRIM(LTRIM(ls_Adr_street_nm)))   || ' '||
			UPPER(COALESCE(F_PDESC(ls_Adr_street_suffix_cd,212),'')) || ' '||
			UPPER(COALESCE(F_PDESC(ls_Adr_post_dir_cd,69) ,''));
			ls_address_1 := COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40));
		WHEN ls_Adr_format_cd = 'R' THEN
			ls_address_1 := COALESCE(RTRIM(LTRIM(ls_Adr_street_no)),'')    || ' '||
			COALESCE(RTRIM(LTRIM(ls_Adr_Box_no)),'') ;
			ls_address_1 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40))) ;
		WHEN ls_Adr_format_cd = 'P' THEN
			ls_address_1 := 'P.O. Box ' || RTRIM(LTRIM((li_Adr_Box_no::VARCHAR)));
			ls_address_1 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40)));
		WHEN ls_Adr_format_cd = 'F' THEN
			ls_address_1 := RTRIM(LTRIM(ls_Adr_foreign_tx));
			ls_address_1 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40))) ;
			ls_Adr_state_cd := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_Adr_foreign_tx)),1,2),LPAD('',2))) ;
			li_Adr_zip5_no := -1 ;
		ELSE
			ls_address_1 := LPAD('',40);
		END CASE;

		--Get For the Address Line 2
		ls_address_2 := UPPER(COALESCE(F_PDESC(ls_Adr_unit_type_cd,250), '') || ' '|| ls_Adr_unit_no_tx);
		ls_address_2 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_2)),1,40),LPAD('',40)));
		li_length := 0;

		IF li_Adr_zip5_no > 0 THEN
			ls_Adr_zip5_no := RTRIM(LTRIM(li_Adr_zip5_no::VARCHAR));
			-- 19071
			li_length := LENGTH (ls_Adr_zip5_no);
			IF li_length < 5 THEN
				li_length := 5 - li_length ;
				WHILE li_length > 0 LOOP
					ls_Adr_zip5_no := '0' || ls_Adr_zip5_no;
					li_length := li_length - 1;
				END LOOP;
			END IF;
			-- 19071
			ls_zip_code := COALESCE(ls_Adr_zip5_no,'00000');
		ELSE
			ls_Adr_zip5_no := '00000';
			ls_zip_code := ls_Adr_zip5_no;
		END IF;

		li_length := 0;
		IF li_Adr_zip4_no > 0 THEN
			ls_Adr_zip4_no := RTRIM(LTRIM((li_Adr_zip4_no::VARCHAR)));
			-- 19071
			li_length := LENGTH (ls_Adr_zip4_no);
			IF li_length < 4 THEN
				li_length := 4 - li_length ;
				WHILE li_length > 0 LOOP
					ls_Adr_zip4_no :=  '0' || ls_Adr_zip4_no;
					li_length := li_length - 1;
				END LOOP;
			END IF;
			-- 19071
			ls_zip_code := LPAD('',5);
			ls_zip_code := COALESCE(ls_Adr_zip5_no,'00000')   || '-'  ||COALESCE(ls_Adr_zip4_no,'');
		END IF;

		li_length := 0;
		li_length := LENGTH(ls_zip_code);
		IF li_length < 7 THEN
			ls_zip_code := Substring(ls_zip_code,1,5);
		END IF;

	ELSE -- if no provider for payment_id then Child Disbrusment Account
		-- ADDED 07/14/06 EXCEP ADDRESS TYPE
		VS_EXC_ADR_TYPE := 'Child Account Disbursement address' ;

		-- #10001
		ls_provider_nm := '';
		ls_prov_tax_type_cd := '';
		li_TAX_ID_NO := 0;
		VS_CHILD_DISBURSEMENT := 'Y'   ;                -- 02/20/07  - #12174

		BEGIN
			SELECT DISTINCT TB_CHILD_ACCOUNT_DISBURSEMENT.PAYEE_NM,
				TB_CHILD_ACCOUNT_DISBURSEMENT.tax_type_cd,
				TB_CHILD_ACCOUNT_DISBURSEMENT.TAX_ID_NO
			INTO ls_provider_nm,
				ls_prov_tax_type_cd,
				li_TAX_ID_NO
			FROM TB_CHILD_ACCOUNT_DISBURSEMENT
			WHERE TB_CHILD_ACCOUNT_DISBURSEMENT.PAYMENT_ID = li_payment_id
				AND TB_CHILD_ACCOUNT_DISBURSEMENT.Delete_sw = 'N';

			IF VL_PAYMENT_COUNT > 0 THEN
				li_check := 1;
			END IF;
			EXCEPTION WHEN OTHERS THEN
				VS_MESSAGE := 'Error in fetching Child Account Disbursement Information '||SQLERRM  ;
				VL_OUTPUT_SQLCODE := SQLSTATE;
				INSERT INTO interfaceserrorlog(INTERFACEID,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
				VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);

		END;

		IF ls_prov_tax_type_cd = '2517' THEN
			ls_prov_tax_type_cd := '1';
		ELSIF  ls_prov_tax_type_cd in ('2518', '2519') THEN
			ls_prov_tax_type_cd := '2';
		ELSE
			ls_prov_tax_type_cd := LPAD('',1);
		END IF;

		IF ls_TYPE_1099_CD = '3155' THEN
			ls_TYPE_1099_CD := '1';
		ELSIF ls_TYPE_1099_CD = '3156' THEN
			ls_TYPE_1099_CD := '6';
		ELSIF ls_TYPE_1099_CD = '3157' THEN
			ls_TYPE_1099_CD := '7';
		ELSIF ls_TYPE_1099_CD = '3159' THEN
			ls_TYPE_1099_CD := '9';
		ELSE
			ls_TYPE_1099_CD := NULL;
		END IF;

		ls_tax_id_no := Substring(RTRIM(LTRIM((li_TAX_ID_NO::VARCHAR))),1,9);
		li_length := LENGTH(RTRIM(ls_tax_id_no));
		IF li_length < 9 THEN
			li_length := 9 - li_length ;
			WHILE li_length > 0 LOOP
				ls_tax_id_no :=  '0' ||   ls_tax_id_no;
				li_length := li_length - 1;
			END LOOP;
		END IF;

		ls_STORE_RECEIPT_ID := RTRIM(LTRIM(ls_STORE_RECEIPT_ID));
		ls_org_nm := COALESCE(RTRIM(LTRIM(ls_provider_nm)),'');

		CASE WHEN length(ls_org_nm) = 0 THEN
			ls_org_nm := '';
		ELSE
			ls_org_nm := COALESCE(ls_org_nm,'');
		END CASE;
		--#6095
		IF ls_org_nm <> '' THEN
			ls_vendor_nm := ls_org_nm;
			VS_PAYEE_SHORT_NM  := ls_org_nm;
		END IF;

		li_vendor_ln_1 := Length(ls_vendor_nm);
		li_vendor_ln_2 := Length(ls_vendor_nm);

		IF li_vendor_ln_1 > 40 OR li_vendor_ln_1 = 40 THEN  -- #13427
			li_vendor_ln_1 := 40 ;
		END IF;

		IF li_vendor_ln_2 > 40 OR li_vendor_ln_2 = 40  THEN  -- #13427
			li_vendor_ln_2 := 40;
		END IF;

		ls_payment_id := RTRIM(LTRIM((li_payment_id::VARCHAR)));
		-- B-28317
		ll_address_id := -1; -- for AddressCode
		-- 09/19/06 #10001
		ls_Adr_type_cd := '';
		ls_Adr_format_cd := '';
		ls_Adr_street_no := '';
		li_Adr_Box_no := 0 ;
		ls_Adr_pre_dir_cd := '';
		ls_Adr_street_nm := '';
		ls_Adr_street_suffix_cd := '';
		ls_Adr_post_dir_cd := '';
		ls_Adr_unit_type_cd := '';
		ls_Adr_unit_no_tx := '';
		ls_Adr_city_nm := '';
		ls_Adr_state_cd := '';
		ls_Adr_foreign_tx := '';
		ls_Adr_foreign_state_tx := '';
		ls_Adr_country_tx := '';
		li_Adr_zip5_no := 0 ;
		li_Adr_zip4_no := 0;  -- #10001
		BEGIN
			SELECT  Adr_type_cd,
				Adr_format_cd,
				Adr_street_tx,
				Adr_Box_no,
				Adr_pre_dir_cd,
				Adr_street_nm,
				Adr_street_suffix_cd,
				Adr_post_dir_cd,
				Adr_unit_type_cd,
				Adr_unit_no_tx,
				Adr_city_nm,
				Adr_state_cd,
				Adr_foreign_tx,
				Adr_foreign_state_tx,
				Adr_country_tx,
				Adr_zip5_no,
				Adr_zip4_no,
				adr_street_no
			INTO    ls_Adr_type_cd,
				ls_Adr_format_cd,
				ls_Adr_street_no,
				li_Adr_Box_no,
				ls_Adr_pre_dir_cd,
				ls_Adr_street_nm,
				ls_Adr_street_suffix_cd,
				ls_Adr_post_dir_cd,
				ls_Adr_unit_type_cd,
				ls_Adr_unit_no_tx,
				ls_Adr_city_nm,
				ls_Adr_state_cd,
				ls_Adr_foreign_tx,
				ls_Adr_foreign_state_tx,
				ls_Adr_country_tx,
				li_Adr_zip5_no,
				li_Adr_zip4_no,
				ls_adr_street_no1
			FROM TB_CHILD_ACCOUNT_DISBURSEMENT
			WHERE TB_CHILD_ACCOUNT_DISBURSEMENT.payment_id  =  li_payment_id
				AND TB_CHILD_ACCOUNT_DISBURSEMENT.Delete_sw = 'N';

			EXCEPTION WHEN OTHERS THEN
				VS_MESSAGE := 'Error in fetching Child Account Disbursement Address '||SQLERRM  ;
				VL_OUTPUT_SQLCODE := SQLSTATE;
				INSERT INTO interfaceserrorlog(INTERFACEID,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
				VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);

		END;


		CASE WHEN length(ls_Adr_street_no) = 0 THEN
			ls_Adr_street_no := '';
		ELSE
			ls_Adr_street_no := COALESCE(ls_Adr_street_no,'');
		END CASE;

		IF li_Adr_Box_no > 0 THEN
			ls_Adr_Box_no := 'P.O. Box ' || RTRIM(LTRIM(li_Adr_Box_no::VARCHAR)) ;
		ELSE
			ls_Adr_Box_no := LPAD('',6);
		END IF;

		-- Modified on 02/21/2020
		-- CJAMS child account disbursement screen is not have Address format Code logic - START
		-- Get the Address Line 1
		ls_address_1 := COALESCE(RTRIM(LTRIM(ls_Adr_street_nm)),'');
		ls_address_1 := COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40));

		-- Get the Address Line 2
		ls_address_2 := UPPER(COALESCE(ls_adr_street_no1, ''));
		ls_address_2 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_2)),1,40),LPAD('',40)));

		/*
		--  Based on the Address Format Get the values
		CASE WHEN ls_Adr_format_cd = 'S' THEN
			ls_address_1 := COALESCE(RTRIM(LTRIM(ls_Adr_street_no)),'')    || ' '||
			UPPER(COALESCE(F_PDESC(ls_Adr_pre_dir_cd,69),''))        || ' '||
			UPPER(RTRIM(LTRIM(ls_Adr_street_nm)))   || ' '||
			UPPER(COALESCE(F_PDESC(ls_Adr_street_suffix_cd,212),'')) || ' '||
			UPPER(COALESCE(F_PDESC(ls_Adr_post_dir_cd,69) ,''));
			ls_address_1 := COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40));
		WHEN ls_Adr_format_cd = 'R' THEN
			ls_address_1 := COALESCE(RTRIM(LTRIM(ls_Adr_street_no)),'')    || ' '||
			COALESCE(RTRIM(LTRIM(ls_Adr_Box_no)),'') ;
			ls_address_1 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40))) ;
		WHEN ls_Adr_format_cd = 'P' THEN
			ls_address_1 := 'P.O. Box ' ||  RTRIM(LTRIM((li_Adr_Box_no::VARCHAR)));
			ls_address_1 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40)));
		WHEN ls_Adr_format_cd = 'F' THEN
			ls_address_1 := RTRIM(LTRIM(ls_Adr_foreign_tx));
			ls_address_1 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_1)),1,40),LPAD('',40))) ;
			ls_Adr_state_cd := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_Adr_foreign_tx)),1,2),LPAD('',2))) ;
		ELSE
			ls_address_1 := LPAD('',40);
		END CASE;

		--Get For the Address Line 2
		ls_address_2 := UPPER(COALESCE(F_PDESC(ls_Adr_unit_type_cd,250), '') || ' '|| ls_Adr_unit_no_tx);
		ls_address_2 := UPPER(COALESCE(Substring(RTRIM(LTRIM(ls_address_2)),1,40),LPAD('',40)));
		*/
		-- CJAMS child account disbursement screen is not have Address format Code logic - END

		li_length := 0;           --19071

		IF li_Adr_zip5_no > 0 THEN
			ls_Adr_zip5_no := RTRIM(LTRIM((li_Adr_zip5_no::VARCHAR)));
			-- 19071
			li_length := LENGTH (ls_Adr_zip5_no);
			IF li_length < 5 THEN
				li_length := 5 - li_length ;
				WHILE li_length > 0 LOOP
					ls_Adr_zip5_no := '0' || ls_Adr_zip5_no;
					li_length := li_length - 1;
				END LOOP;
			END IF;
			-- 19071
             ls_zip_code := COALESCE(ls_Adr_zip5_no,'00000');
		ELSE
			ls_Adr_zip5_no := '00000';
			ls_zip_code := ls_Adr_zip5_no;
		END IF;
		li_length := 0;

		IF li_Adr_zip4_no > 0 THEN
			ls_Adr_zip4_no := RTRIM(LTRIM((li_Adr_zip4_no::VARCHAR)));
			-- 19071
			li_length := LENGTH (ls_Adr_zip4_no);
			IF li_length < 4 THEN
				li_length := 4 - li_length ;
				WHILE li_length > 0 LOOP
					ls_Adr_zip4_no :=  '0' || ls_Adr_zip4_no;
					li_length := li_length - 1;
				END LOOP;
			END IF;
			-- 19071
			ls_zip_code := LPAD('',5);
			ls_zip_code := COALESCE(ls_Adr_zip5_no,'00000')   || '-'  || COALESCE(ls_Adr_zip4_no,'');
		END IF;
		li_length := 0;

		li_length := LENGTH(ls_zip_code);
		IF li_length < 7 THEN
			ls_zip_code := Substring(ls_zip_code,1,5);
		END IF;
	END IF; -- Provider Information

	--Payment Type
	LS_COUNTY_NAME := '' ;
	ls_county_cd := ''; -- 07/24/06
	IF ls_payment_type_cd = '3294' AND ls_manual_sw = 'N'  THEN
		ls_payment_method_cd := '1';
		ls_REPORT_1099_SW := 'N';
		ls_TYPE_1099_CD := NULL;
	END IF;

	SELECT DISTINCT DTL.COUNTY_CD
		INTO ls_county
	FROM TB_PAYMENT_DETAIL as DTL
	WHERE DTL.PAYMENT_ID = li_payment_id  -- added 09/08/06
		AND DTL.Delete_sw = 'N'
		AND (DTL.COUNTY_CD IS NOT NULL AND LENGTH(DTL.COUNTY_CD) > 0);



	CASE WHEN ls_county ='1427' THEN  ls_county_cd := '01';   LS_COUNTY_NAME := 'Allegany';    -- 07/24/06
	WHEN ls_county ='1428'  THEN  ls_county_cd := '02';   LS_COUNTY_NAME := 'Anne Arundel';
	WHEN ls_county ='1430'  THEN  ls_county_cd := '03';   LS_COUNTY_NAME := 'Baltimore County';
	WHEN ls_county ='1431'  THEN  ls_county_cd := '04';   LS_COUNTY_NAME := 'Calvert';
	WHEN ls_county ='1432'  THEN  ls_county_cd := '05';   LS_COUNTY_NAME := 'Caroline';
	WHEN ls_county ='1433'  THEN  ls_county_cd := '06';   LS_COUNTY_NAME := 'Carroll';
	WHEN ls_county ='1434'  THEN  ls_county_cd := '07';   LS_COUNTY_NAME := 'Cecil';
	WHEN ls_county ='1435'  THEN  ls_county_cd := '08';   LS_COUNTY_NAME := 'Charles';
	WHEN ls_county ='1436'  THEN  ls_county_cd := '09';   LS_COUNTY_NAME := 'Dorchester';
	WHEN ls_county ='1437'  THEN  ls_county_cd := '10';   LS_COUNTY_NAME := 'Frederick';
	WHEN ls_county ='1438'  THEN  ls_county_cd := '11';   LS_COUNTY_NAME := 'Garrett';
	WHEN ls_county ='1439'  THEN  ls_county_cd := '12';   LS_COUNTY_NAME := 'Harford';
	WHEN ls_county ='1440'  THEN  ls_county_cd := '13';   LS_COUNTY_NAME := 'Howard';
	WHEN ls_county ='1441'  THEN  ls_county_cd := '14';   LS_COUNTY_NAME := 'Kent';
	WHEN ls_county ='1442'  THEN  ls_county_cd := '15';   LS_COUNTY_NAME := 'Montgomery';
	WHEN ls_county ='1443'  THEN  ls_county_cd := '16';   LS_COUNTY_NAME := 'Prince George';
	WHEN ls_county ='1444'  THEN  ls_county_cd := '17';   LS_COUNTY_NAME := 'Queen Anne';
	WHEN ls_county ='1446'  THEN  ls_county_cd := '18';   LS_COUNTY_NAME := 'St. Marys';
	WHEN ls_county ='1445'  THEN  ls_county_cd := '19';   LS_COUNTY_NAME := 'Somerset';
	WHEN ls_county ='1447'  THEN  ls_county_cd := '20';   LS_COUNTY_NAME := 'Talbot';
	WHEN ls_county ='1448'  THEN  ls_county_cd := '21';   LS_COUNTY_NAME := 'Washington';
	WHEN ls_county ='1449'  THEN  ls_county_cd := '22';   LS_COUNTY_NAME := 'Wicomico';
	WHEN ls_county ='1450'  THEN  ls_county_cd := '23';   LS_COUNTY_NAME := 'Worcester';
	WHEN ls_county ='1429'  THEN  ls_county_cd := '30';   LS_COUNTY_NAME := 'Baltimore City';
	ELSE
	ls_county_cd  :='99'  ;
	END CASE   ;
	-- # 10001
	ls_client_first_nm := '';
	ls_client_last_nm := '';
	SELECT  FIRSTNAME,
		LASTNAME
	INTO ls_client_first_nm,
		ls_client_last_nm
	FROM person
	WHERE cjamspid = li_client_id AND ACTIVEFLAG = 1;
	--Raise Notice '1026  %',  li_client_id;
	--Raise Notice '1027  %',  ls_client_first_nm;
	--Raise Notice '1028  %',  ls_client_last_nm;
	ls_Client_nm := COALESCE(RTRIM(LTRIM(ls_client_last_nm)),'') || ',' || ' '||
    COALESCE(RTRIM(LTRIM(ls_client_first_nm)),'');

	IF ls_Client_nm = ','  THEN
		ls_Client_nm  := ' ';
	END IF; -- 07/25/06

	CASE WHEN length(ls_Client_nm) = 0 THEN
		ls_Client_nm := '';
	ELSE
		ls_Client_nm := COALESCE(ls_Client_nm,'');
	END CASE;

	li_Client_nm :=  Length(ls_Client_nm);
	IF li_Client_nm > 40 OR li_Client_nm = 40 THEN
		li_Client_nm := 40 ;
	END IF;

	li_address_1 := Length(RTRIM(LTRIM(ls_address_1)));
	li_address_2 := Length(RTRIM(LTRIM(ls_address_2)));
	li_city := Length(RTRIM(LTRIM(ls_Adr_city_nm)));

	IF li_address_1 > 40 OR li_address_1 = 40 THEN
		li_address_1 := 40 ;
	END IF;

	IF li_address_2 > 40 OR li_address_2 = 40 THEN
		li_address_2 := 40;
	END IF;

	IF li_city > 30 OR li_city = 30 THEN
		li_city := 30 ;
	END IF;

	CASE WHEN length(ls_REPORT_1099_SW) = 0 THEN
		ls_REPORT_1099_SW := 'N';
	ELSE
		ls_REPORT_1099_SW := COALESCE(ls_REPORT_1099_SW,'N');
	END CASE;

	ls_payee_nbr := COALESCE(Substring(RTRIM(LTRIM((li_PROVIDER_ID::VARCHAR))),1,10), '0');
	li_payee_nbr := Length(RTRIM(LTRIM(ls_payee_nbr)));

	IF li_payee_nbr > 10 OR li_payee_nbr = 10 THEN
		li_payee_nbr := 10 ;
	END IF;

	--#6025
	CASE ls_payment_type_cd WHEN '3294' THEN
		IF ls_manual_sw = 'Y' THEN
			VS_PAYMENT_TYPE_CD := 'MNAD';
		ELSIF ls_manual_sw IS NULL THEN
			VS_PAYMENT_TYPE_CD := 'SYAD';
		ELSIF ls_manual_sw = 'N' THEN
			VS_PAYMENT_TYPE_CD := 'SYAD';
		END IF;
	WHEN '4' THEN
		VS_PAYMENT_TYPE_CD := 'ANCL';
	WHEN '26' THEN -- '26' - New payments for cfe bed retainer fee
		VS_PAYMENT_TYPE_CD := 'ANCL';
	WHEN '27' THEN -- '27' - Emergency Foster Parent Bed Retainer Payments
		VS_PAYMENT_TYPE_CD := 'ANCL';
	ELSE
		VS_PAYMENT_TYPE_CD := 'CHAC';
	END CASE;

	---- // #18816 - New changes for Withhold & Release Payments
	IF VS_PAYMENT_TYPE_CD = 'SYAD' THEN
		IF li_linked_pymnt_id > 0 THEN
			SELECT PAYMENT_STATUS_CD INTO LS_LINK_PAYMENT_STATUS
				FROM TB_PAYMENT_STATUS
			WHERE PAYMENT_ID = li_linked_pymnt_id AND DELETE_SW = 'N' ;

			IF LS_LINK_PAYMENT_STATUS = '1639' THEN
				VS_PAYMENT_TYPE_CD := 'RELS' ;
			ELSE
				VS_PAYMENT_TYPE_CD := 'SYAD';
			END IF;
		END IF;
	END IF;
	------///////

	-- B-28317 - Fields for new AFS System - Start
	-- 1099Amount & 1099Code
	ld_amount_1099 := NULL;
	ls_code_1099 := NULL;

	IF ls_REPORT_1099_SW = 'Y' THEN
		ld_amount_1099 := li_final_amount_no;

		IF ls_TYPE_1099_CD = '1' THEN -- 1 - Rental (Code '3155')
			ls_code_1099 := 'MISC-01';
		ELSIF ls_TYPE_1099_CD = '6' THEN -- 6 - Med Exp (Code '3156')
			ls_code_1099 := 'MISC-06';
		ELSIF ls_TYPE_1099_CD = '7' THEN -- 7 - Misc. (Code '3157')
			ls_code_1099 := 'MISC-07';
		ELSIF ls_TYPE_1099_CD = '9' THEN -- 1 - NEC-01 (Code '3159')
			ls_TYPE_1099_CD := '1';
			ls_code_1099 := 'NEC-01';
		END IF;

	END IF;
	-- AccountType
	ls_account_type := 'Vendor';
	-- Approved
	ls_approved := 'Yes';
	-- ApprovedBy
	ls_approved_by := '200';    -- 10112019 Change from 100 to 200, 100 was for Chessie
	-- Currency
	ls_currency := 'USD';
	-- Invoice
	ls_invoice := NULL;
	ls_invoice := RTRIM(LTRIM((li_payment_id::VARCHAR)));
	-- InvoiceDescription
	ls_invoice_desc := NULL;
	-- JournalDescription -- (see the below code after cursor statement)
	ls_journal_desc := NULL;
	-- PayorCompany
	ls_payor_company := NULL;
	ls_payor_company := 'N' || RTRIM(LTRIM(ls_county_cd));
	-- OffsetAccount
	ls_offset_account := NULL;
	ls_offset_account := RTRIM(LTRIM(ls_FINAL_FISCAL_CATEGORY_CD)) ;
	-- OffsetAccountType
	ls_offset_account_type := 'Ledger';
	-- PostingProfile
	ls_posting_profile := 'APSTD';
	-- TermsOfPayment
	ls_terms_of_payment := 'N00';
	-- VendorAccount
	ls_vendoraccount := NULL;
	--04/07/2019
	if li_provider_id <=0  then

		IF EXISTS( SELECT 1 FROM TB_AFS_CHILD_ACCOUNT_MAPID TAC  WHERE TAC.CJAMSPID = LI_CLIENT_ID ) THEN
			SELECT TAC.CHILDACCOUNTID INTO LS_CHILDACC_ID FROM TB_AFS_CHILD_ACCOUNT_MAPID TAC
			WHERE TAC.CJAMSPID = LI_CLIENT_ID ;
		ELSE
			INSERT INTO TB_AFS_CHILD_ACCOUNT_MAPID(CJAMSPID,
				CHILDACCOUNTID,
				CREATE_TS,
				CREATE_USER_ID)
			VALUES (
				LI_CLIENT_ID,
				NEXTVAL('SQ_AFS_CHILD_ACCOUNT'),
				NOW(),
				VS_USER_ID
				);

			SELECT TAC.CHILDACCOUNTID INTO LS_CHILDACC_ID FROM TB_AFS_CHILD_ACCOUNT_MAPID TAC
			WHERE TAC.CJAMSPID = LI_CLIENT_ID ;
		END IF;

	END IF;


	IF li_provider_id > 0 THEN
		ls_vendoraccount := 'CH' || RTRIM(LTRIM((li_provider_id::VARCHAR)));
	ELSE
		--ls_vendoraccount := 'CH' || RTRIM(LTRIM((li_client_id::VARCHAR))); 04/07/2019
		ls_vendoraccount := 'CH' || RTRIM(LTRIM((ls_childacc_id::VARCHAR)));
	END IF;
	-- AddressCode
	ls_address_id_tx := NULL;
	IF li_provider_id > 0 THEN
		ls_address_id_tx := RTRIM(LTRIM(ll_address_id::VARCHAR));
	ELSE
		ls_address_id_tx := 'CH' || RTRIM(LTRIM((ls_childacc_id::VARCHAR)));	 --101119 - Set same as Vendor Account
		--ls_address_id_tx := 'CH' || RTRIM(LTRIM(li_client_id::VARCHAR));    --101119
	END IF;
	-- B-28317 - Fields for new AFS System - END

	VS_PAYMENT_TYPE_CD := COALESCE(VS_PAYMENT_TYPE_CD,'0000');
	VS_MESSAGE := '';
	VS_EXCEP_MESSAGE := '';
	LS_ERROR_PROVNAME := 'p';
	LS_ERROR_CHILDNAME := 'c';

	-- Get Interface data          --
	IF li_afs_interface_record_id = 0 THEN
		--SET VS_MESSAGE  =   'AFS-Interface-Record-ID :'     ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := 'AFS-Interface-Record-ID is missing; ' ;
		li_check := 0;
	END IF;

	IF ls_county_cd is null OR ls_county_cd = '' OR ls_county_cd = '99' THEN
		--SET VS_MESSAGE  = VS_MESSAGE ||  'County / LDSS code :' ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE ||'County/LDSS code is missing; ';
		li_check := 0;
	END IF;

	IF ls_payment_method_cd='0' OR ls_payment_method_cd = '' OR ls_payment_method_cd IS NULL THEN
		-- SET VS_MESSAGE  =  VS_MESSAGE || 'Payment Method Code : '   ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Payment Method Code is missing; ';
		li_check := 0;
	END IF;

	IF ls_payment_id = '0' OR ls_payment_id IS NULL OR ls_payment_id = '' THEN
		--SET  VS_MESSAGE  =  VS_MESSAGE || 'Payment Id : '    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Payment ID is missing; ';
		li_check := 0;
	END IF;
	IF VS_CHILD_DISBURSEMENT = 'Y' THEN               -- 02/20/07  - #12174
		ls_payee_nbr := (li_client_id::VARCHAR);     -- #Prj-01179
	ELSE
		IF ls_payee_nbr ='0' OR ls_payee_nbr IS NULL OR ls_payee_nbr='' THEN
			-- SET VS_MESSAGE  = VS_MESSAGE ||  'Payee Number : '  ||  'ISNULL ; ';
			VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Payee Number is missing; ';
			li_check := 0;
		END IF;
	END IF;

	IF VS_PAYEE_SHORT_NM ='0' OR VS_PAYEE_SHORT_NM IS NULL OR VS_PAYEE_SHORT_NM ='' THEN
		-- SET VS_MESSAGE  = VS_MESSAGE ||  'Payee Short Name : '   ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Provider/Payee Name is missing; ';
		li_check := 0;
		LS_ERROR_PROVNAME := '';
	END IF;

	IF ls_vendor_nm ='0' OR ls_vendor_nm IS NULL OR ls_vendor_nm ='' THEN
		-- SET VS_MESSAGE  = VS_MESSAGE ||  'Vendor Name : '   ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Vendor name is missing; ';
		li_check := 0;
	END IF;

	IF ls_address_1 ='0' OR ls_address_1 IS NULL OR ls_address_1 ='' THEN
		-- SET VS_MESSAGE  =  VS_MESSAGE || 'Address Line 1 : '    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE ||VS_EXC_ADR_TYPE || 'line 1 is missing; ';
		li_check := 0;
	END IF;

	IF ls_Adr_city_nm ='0' OR ls_Adr_city_nm IS NULL OR ls_Adr_city_nm ='' THEN
		-- SET VS_MESSAGE  = VS_MESSAGE ||  'City Name : '    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE ||VS_EXC_ADR_TYPE|| 'city name is missing; ';
		li_check := 0;
	END IF;

	IF ls_Adr_state_cd ='0' OR ls_Adr_state_cd IS NULL OR ls_Adr_state_cd ='' THEN
		-- SET VS_MESSAGE  = VS_MESSAGE ||   'State code :'    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE ||VS_EXC_ADR_TYPE || 'state code is missing; ';
		li_check := 0;
	END IF;

	-- IF ls_zip_code ='00000' OR ls_zip_code IS NULL OR ls_zip_code ='' THEN  -- added ls_zip_code ='00000' #10001
	IF li_Adr_zip5_no = 0 OR li_Adr_zip5_no IS NULL then  -- #10094
		-- SET VS_MESSAGE  = VS_MESSAGE ||   'Zip Code :'    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE ||VS_EXC_ADR_TYPE || 'zip code is missing; ';
		li_check := 0;
	END IF;

	IF ls_prov_tax_type_cd ='0' OR ls_prov_tax_type_cd IS NULL OR ls_prov_tax_type_cd ='' THEN
		-- SET VS_MESSAGE  =  VS_MESSAGE ||  'Prov Tax Type Code : '   ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Prov Tax Type code is missing; ';
		li_check := 0;
	END IF;

	IF ls_TAX_ID_NO ='0' OR ls_TAX_ID_NO IS NULL OR ls_TAX_ID_NO = '' THEN
		-- SET VS_MESSAGE  =  VS_MESSAGE ||  'Tax ID No. : '   ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Tax ID No is missing; ';
		li_check := 0;
	END IF;

	IF ls_FINAL_FISCAL_CATEGORY_CD ='0' OR ls_FINAL_FISCAL_CATEGORY_CD IS NULL OR ls_FINAL_FISCAL_CATEGORY_CD ='' THEN
		-- SET VS_MESSAGE  = VS_MESSAGE ||   'Final Fiscal Category Code : '    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Final Fiscal Category code is missing; ';
		li_check := 0;
	END IF;

	IF ls_REPORT_1099_SW ='0' OR ls_REPORT_1099_SW IS NULL OR ls_REPORT_1099_SW ='' THEN
		-- SET VS_MESSAGE  = VS_MESSAGE ||   'REPORT 1099 SW :'    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'REPORT 1099 SW is missing; ';
		li_check := 0;
	END IF;

	IF li_final_amount_no = 0 OR li_final_amount_no IS NULL THEN           -- #15672
		-- SET VS_MESSAGE  =   VS_MESSAGE ||  'Final Amount : '    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Final Amount is missing; ';
		li_check := 0;
	END IF;

	IF RTRIM(LTRIM((ld_Payment_dt::varChar))) ='01/01/1900' THEN
		-- SET VS_MESSAGE  =  VS_MESSAGE ||   'Payment Date :'    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Payment Date is missing; ';
		li_check := 0;
	END IF;

	IF RTRIM(LTRIM((ld_final_service_dt::VARChar)))= '01/01/1900'  THEN
		-- SET VS_MESSAGE  =  VS_MESSAGE ||   'Final Service Date :'  ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Final Service Date is missing; ';
		li_check := 0;
	END IF;

	IF ls_Client_nm ='0' OR ls_Client_nm IS NULL OR ls_Client_nm ='' THEN
		-- SET VS_MESSAGE  =  VS_MESSAGE ||   'Client Name :'   ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Client Name is missing; ';
		li_check := 0;
		LS_ERROR_CHILDNAME := '';
	END IF;

	IF VS_PAYMENT_TYPE_CD ='0' OR VS_PAYMENT_TYPE_CD IS NULL OR VS_PAYMENT_TYPE_CD ='' THEN
		-- SET VS_MESSAGE  =   VS_MESSAGE ||  'Payment Type code :'    ||  'ISNULL ; ';
		VS_EXCEP_MESSAGE := VS_EXCEP_MESSAGE || 'Payment Type code is missing; ';
		li_check := 0;
	END IF;

	------------ INSERT INTO ERROR LOG TABLE FOR ALL PREVIOUS MESSAGES
	VL_ERROR_LOGGED := 0;
	--07/24/06
	VS_EXCEP_MESSAGE1 := '';
	IF ls_county_cd <> '99' THEN
		VS_EXCEP_MESSAGE1 := 'County Name: ' || ls_county_name || '; ';
	END IF;

	IF LS_ERROR_PROVNAME <> '' THEN
		VS_EXCEP_MESSAGE1 := VS_EXCEP_MESSAGE1 ||'Provider/Payee Name: ' || VS_PAYEE_SHORT_NM || '; ';
	END IF;

	IF LS_ERROR_CHILDNAME <> '' THEN
		VS_EXCEP_MESSAGE1 :=  VS_EXCEP_MESSAGE1 ||'Client Name: ' || ls_Client_nm || '; ';
	END IF;
	--08/25/06  #9752

	VS_EXCEP_MESSAGE1 := Substring((VS_EXCEP_MESSAGE1),1,LENGTH(VS_EXCEP_MESSAGE1)-2) ||' - ' ;
	-- IF VS_MESSAGE <> '' AND VS_MESSAGE IS NOT NULL THEN
	IF li_check = 0 AND VS_EXCEP_MESSAGE <> '' AND VS_EXCEP_MESSAGE IS NOT NULL THEN
		VS_EXCEP_MESSAGE :=  VS_EXCEP_MESSAGE1 || VS_EXCEP_MESSAGE;

		--SET VS_EXCEP_MESSAGE = 'County Code: ' || ls_county_cd || '; ' || VS_EXCEP_MESSAGE ;
		-- #9676 uncommented
		VL_ERROR_LOGGED := 1;

		BEGIN

			VL_OUTPUT_SQLCODE := '00000';    --09/08/06
			INSERT INTO INTERFACESERRORLOG(
				--ERRORID,
				INTERFACEID,
				CURRENTRUNTIMESTAMP,
				BATCHNUMBER,
				ERRORLINENO,
				ERRORCODE,
				ERRORSQLCODE,
				ERRORDESCRIPTION ,
				payment_id,
				provider_id,
				county_cd,
				client_id,
				payment_amount)
			VALUES (
				--NEXTVAL('SQ_INTERFACES_ERROR_LOG') ,
				'AFS_INTERFACES',
				current_timestamp,
				'000',
				li_payment_id,
				'0',
				VL_OUTPUT_SQLCODE,
				VS_EXCEP_MESSAGE,
				li_payment_id,
				li_provider_id,
				ls_county,
				li_client_id ,
				li_final_amount_no);


			EXCEPTION WHEN OTHERS THEN
				VS_MESSAGE := VS_MESSAGE || '. INSERT FAILED INTO INTERFACESERRORLOG '||SQLERRM  ;
				VL_OUTPUT_SQLCODE := SQLSTATE;
				INSERT INTO INTERFACESERRORLOG(INTERFACEid,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
				VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);

		END;

	END IF;
	Raise Notice '1364  %',  ls_client_nm;
	--------------------------------------------
	IF li_check > 0 THEN
		VS_PAYEE_SHORT_NM := Substring(VS_PAYEE_SHORT_NM, 1, 40);    -- #13427
		ls_vendor_nm := Substring(ls_vendor_nm, 1, 40);    -- #13427
		vl_output_sqlcode := '00000'; -- 07/24/06

		SELECT NEXTVAL('SQ_AFS_INTERFACES')
			INTO li_afs_interface_record_id
		;
		BEGIN
			INSERT INTO TB_AFS_INTERFACES(
				AFS_INTERFACE_RECORD_ID,
				LDSS_NM,
				PAYMENT_METHOD_CD,
				PAYMENT_ID,
				PAYEE_NBR,
				PAYEE_NM,
				PAYEE_ALPHA_SORT_NM,
				ADR_LINE_1,
				ADR_LINE_2,
				ADR_CITY_NM,
				ADR_STATE_CD,
				ADR_ZIP5_NO,
				PHONE_TX,
				TAXPAYER_TYPE_CD,
				TAXPAYER_ID,
				BUDGET_CD,
				IND_1099_SW,
				TYPE_1099_SW,
				INVOICE_NBR_TX,
				PAYMENT_AMT,
				Payment_Approval_Dt,
				Payment_Service_DT,
				Client_Name,
				CREATE_TS,
				CREATE_USER_ID,
				UPDATE_TS,
				UPDATE_USER_ID,
				DELETE_SW,
				PAYMENT_TYPE_CD,
				PAYMENT_DETAIL_ID,
				AMOUNT_1099,
				CODE_1099,
				ACCOUNT_TYPE,
				ADDRESS_ID,
				APPROVED,
				APPROVED_BY,
				CURRENCY,
				INVOICE,
				INVOICE_DESC,
				JOURNAL_DESC,
				PAYOR_COMPANY,
				OFFSET_ACCOUNT,
				OFFSET_ACCOUNT_TYPE,
				POSTING_PROFILE,
				TERMS_OF_PAYMENT,
				VENDORACCOUNT
				)

			SELECT
				li_afs_interface_record_id,
				ls_county_cd,
				ls_payment_method_cd,
				ls_payment_id,
				ls_payee_nbr,
				VS_PAYEE_SHORT_NM,
				ls_vendor_nm,
				ls_address_1,
				UPPER(coalesce(Substring(RTRIM(LTRIM(ls_address_2)),1,li_address_2),LPAD('',40))),
				ls_Adr_city_nm,
				UPPER(ls_Adr_state_cd),
				ls_zip_code,
				ls_PHONE_TX,
				ls_prov_tax_type_cd,
				ls_TAX_ID_NO,
				ls_FINAL_FISCAL_CATEGORY_CD,
				ls_REPORT_1099_SW,
				ls_TYPE_1099_CD,
				ls_STORE_RECEIPT_ID,
				li_final_amount_no,
				ld_Payment_dt,
				ld_final_service_dt,
				ls_Client_nm,
				CURRENT_TIMESTAMP,
				VS_USER_ID,
				CURRENT_TIMESTAMP,
				VS_USER_ID,
				'N',
				VS_PAYMENT_TYPE_CD,
				li_payment_detail_id,
				ld_amount_1099,
				ls_code_1099,
				ls_account_type,
				ls_address_id_tx,
				ls_approved,
				ls_approved_by,
				ls_currency,
				ls_invoice,
				ls_invoice_desc,
				ls_journal_desc,
				ls_payor_company,
				ls_offset_account,
				ls_offset_account_type,
				ls_posting_profile,
				ls_terms_of_payment,
				ls_vendoraccount
			;
			EXCEPTION WHEN OTHERS THEN
				VS_MESSAGE := 'INSERT FAILED INTO TB_AFS_INTERFACES  '||SQLERRM  ;
				VL_OUTPUT_SQLCODE := SQLSTATE;
				INSERT INTO interfaceserrorlog(INTERFACEID,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
				VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);

		END;

		BEGIN

			UPDATE TB_PAYMENT_STATUS
			SET PAYMENT_STATUS_CD = '1636',
				PAYMENT_STATUS_DT = vts_current_run_ts::DATE,
				UPDATE_TS = CURRENT_TIMESTAMP
			WHERE (TB_PAYMENT_STATUS.PAYMENT_STATUS_CD = '1634' )
				AND PAYMENT_ID = li_payment_id
				AND DELETE_SW = 'N';

			EXCEPTION WHEN OTHERS THEN
				VS_MESSAGE := 'Error in updating Payment Status  '||SQLERRM  ;
				VL_OUTPUT_SQLCODE := SQLSTATE;
				INSERT INTO interfaceserrorlog(INTERFACEID,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
				VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);

		END;


	END IF;    -- li check  >0



	li_check   := 0;
	--  SET li_payment_count   = li_payment_count - 1;
	VS_CHILD_DISBURSEMENT := 'N';
	ls_person_nm    := '';
	ls_org_nm       := '';
	VS_PAYEE_SHORT_NM  := '';
	VS_MESSAGE   :=  '';
	--     COMMIT; --  ADDED ON 01/18/06


	VL_INTERFACE_ROWCOUNT := VL_INTERFACE_ROWCOUNT - 1;
	VS_PAYMENT_TYPE_CD := '0000';
	VL_PAYMENT_COUNT := VL_PAYMENT_COUNT - 1 ;
END LOOP;
CLOSE PAYMENT_CUR;


-- B-28317 - To update JOURNAL_DESC as unique Timestamp on each file (system adjustments & Ancillary)
-- Ancillary & other payments
BEGIN
	UPDATE TB_AFS_INTERFACES
		SET JOURNAL_DESC = 'MD CJAMS ' || CURRENT_TIMESTAMP
	WHERE AFS_INTERFACE_RECORD_ID 
		IN ( SELECT AFS.AFS_INTERFACE_RECORD_ID
				FROM TB_AFS_INTERFACES AFS,
					TB_PAYMENT_HEADER PH
			 WHERE RTRIM(AFS.PAYMENT_ID)::INTEGER= PH.PAYMENT_ID
				--AND PH.PAYMENT_TYPE_CD <> '3294'  --OR (PH.PAYMENT_TYPE_CD = '3294' AND PH.MANUAL_SW = 'Y'))
				AND (PH.PAYMENT_TYPE_CD <> '3294' OR (PH.PAYMENT_TYPE_CD = '3294' AND PH.MANUAL_SW = 'Y'))
			);
	EXCEPTION WHEN OTHERS THEN
		VS_MESSAGE := 'Error in updating TB_AFS_INTERFACES --> JOURNAL_DESC (Ancillary & other payments)  '||SQLERRM  ;
		VL_OUTPUT_SQLCODE := SQLSTATE;
		INSERT INTO interfaceserrorlog(INTERFACEID,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
		VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);

END;


-- System Adjustments
BEGIN
	UPDATE TB_AFS_INTERFACES
		SET JOURNAL_DESC = 'MD CJAMS ' || CURRENT_TIMESTAMP + interval '5000 microseconds'
	WHERE AFS_INTERFACE_RECORD_ID 
		IN ( SELECT AFS.AFS_INTERFACE_RECORD_ID
				FROM TB_AFS_INTERFACES AFS,
					TB_PAYMENT_HEADER PH
			 WHERE RTRIM(AFS.PAYMENT_ID)::INTEGER= PH.PAYMENT_ID
				--AND (PH.PAYMENT_TYPE_CD = '3294' AND (PH.MANUAL_SW IS NULL OR PH.MANUAL_SW = 'Y' OR PH.MANUAL_SW = 'N'))
				AND (PH.PAYMENT_TYPE_CD = '3294' AND (PH.MANUAL_SW IS NULL OR PH.MANUAL_SW <> 'Y'))
			);
	EXCEPTION WHEN OTHERS THEN
		VS_MESSAGE := 'Error in updating TB_AFS_INTERFACES --> JOURNAL_DESC (System Adjustments)  '||SQLERRM  ;
		VL_OUTPUT_SQLCODE := SQLSTATE;
		INSERT INTO interfaceserrorlog(INTERFACEID,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
		VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);

END;

BEGIN
	INSERT INTO INTERFACESRUNTIMESLOG
	( INTERFACEID,
		CURRENTRUNTIMESTAMP,
		PREVIOUSRUNTIMESTAMP,
		BATCHNUMBER,
		INSERTEDON,
		INSERTEDBY,
		UPDATEDON,
		UPDATEDBY,
		ACTIVEFLAG  )
	SELECT
		'AFS',
		vts_current_run_ts,
		vts_previous_run_ts,
		'000',
		CURRENT_TIMESTAMP,
		VS_USER_ID,
		CURRENT_TIMESTAMP,
		VS_USER_ID,
		1
		;

	EXCEPTION WHEN OTHERS THEN
		VS_MESSAGE := 'INSERT INTO INTERFACESRUNTIMESLOG FAILED  '||SQLERRM  ;
		VL_OUTPUT_SQLCODE := SQLSTATE;
		INSERT INTO INTERFACESERRORLOG(INTERFACEid,CURRENTRUNTIMESTAMP, BATCHNUMBER, ERRORLINENO, ERRORCODE, ERRORSQLCODE, ERRORDESCRIPTION, payment_id, provider_id, county_cd, client_id,  payment_amount)
		VALUES ( 'AFS_INTERFACES', current_timestamp, '000', li_payment_id, '0', VL_OUTPUT_SQLCODE, VS_MESSAGE, li_payment_id, li_provider_id, ls_county, li_client_id , li_final_amount_no);

END;

IF VL_OUTPUT_SQLCODE='00000' then

	VS_MESSAGE := 'The run was successful';
	a := vts_current_run_ts;
	b :=  vts_previous_run_ts;
END IF;

END ;
$function$;