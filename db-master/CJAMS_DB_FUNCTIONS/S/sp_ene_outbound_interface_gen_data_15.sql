CREATE OR REPLACE FUNCTION cjams.sp_ene_outbound_interface_gen_data_15(vl_client_id integer, vl_other_id bigint, vs_transaction_type_cd character varying, vl_transaction_sequence integer, vd_transaction_ts timestamp without time zone, OUT vs_message character varying, OUT vl_output_sqlcode character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 11/25/2020
-- Description: To generate E&E Inbound data for Record Type 15

-- Revision(s):
-- 01/07/2022 - Vineet Tirodkar - Modifications to pass NULL for unknown Patient Policyholder Relation code(s) (CIDM-4136)
-- 11/19/2022 Vineet Tirodkar - To char fix for Aurora DB migration 
------------------------------------------------------------------------
DECLARE VS_RECORD_TYPE VARCHAR(2);
	VS_OUTPUT_STATE VARCHAR(5) DEFAULT '00000';
	VL_RECORD_SEQUENCE INTEGER DEFAULT 000;
	VS_TRANSACTION_SEQUENCE VARCHAR(5);
	VS_RECORD_SEQUENCE VARCHAR(3);

	VS_ADDRESS_DIR VARCHAR(3) DEFAULT '   '; --	#27062019
	VS_ADDRESS_STREET VARCHAR(5) DEFAULT '     '; -- #27062019
	VS_HEALTH_HMO VARCHAR(10) DEFAULT '          '; -- #27062019
	   -- Client Variables
	VS_CIS_CLIENT_ID VARCHAR(10); -- ENE_OUT_COL6
	ENE_OUT_MED_COL1 VARCHAR(20);
	ENE_OUT_MED_COL2 VARCHAR(20);
	ENE_OUT_MED_COL3 VARCHAR(5);
	ENE_OUT_MED_COL4 INTEGER;
	ENE_OUT_MED_COL5 VARCHAR;
	ENE_OUT_MED_COL6 CHAR(3);
	ENE_OUT_MED_COL7 VARCHAR(9); -- INTEGER
	ENE_OUT_MED_COL8 VARCHAR(50);
	ENE_OUT_MED_COL9 CHAR(5);
	ENE_OUT_MED_COL10 CHAR(3);
	ENE_OUT_MED_COL11 CHAR(5);
	ENE_OUT_MED_COL12 VARCHAR(50);
	ENE_OUT_MED_COL13 CHAR(2);
	ENE_OUT_MED_COL14 INTEGER;
	ENE_OUT_MED_COL15 VARCHAR(10);
	ENE_OUT_MED_COL16 VARCHAR(20);
	ENE_OUT_MED_COL17 CHAR(3);
	ENE_OUT_MED_COL18 VARCHAR(9); -- INTEGER
	ENE_OUT_MED_COL19 VARCHAR(50);
	ENE_OUT_MED_COL20 CHAR(5);
	ENE_OUT_MED_COL21 CHAR(3);
	ENE_OUT_MED_COL22 CHAR(5);
	ENE_OUT_MED_COL23 VARCHAR(50);
	ENE_OUT_MED_COL24 CHAR(2);
	ENE_OUT_MED_COL25 INTEGER;
	ENE_OUT_MED_COL26 VARCHAR(10);
	ENE_OUT_MED_COL27 CHAR(1);

DECLARE CURSOR_MED CURSOR FOR
	SELECT	personhealthinsurance.policyname,
		personhealthinsurance.groupnumber,
		(select btrim(tpv.picklist_value_cd)
			from cjams.tb_picklist_values tpv 
		 where tpv.picklist_type_id = 172
			and btrim(tpv.picklist_value_cd) = btrim(personhealthinsurance.patientpolicyholderrelation)
		) as patientpolicyholderrelation,
		-- personhealthinsurance.patientpolicyholderrelation,
		to_char(personhealthinsurance.effectivedate,'yyyymmdd')::integer,
		to_char(personhealthinsurance.expirationdate,'yyyymmdd')::integer, 
		VS_ADDRESS_DIR, 
		substring(personhealthinsurance.address1,'(^[0-9]+)'), -- personhealthinsurance.ADR_STREET_NO
		TRIM(SUBSTRING(personhealthinsurance.address1,'([[:alpha:]\s]+)')),
		VS_ADDRESS_STREET,			    
		VS_ADDRESS_DIR,		
		substring(substring(personhealthinsurance.address2,'(^[0-9]+)'),1,5), -- ADR_UNIT_NO_TX		
		personhealthinsurance.city,		
		personhealthinsurance.state,
		cast(SUBSTRING(COALESCE(nullif(personhealthinsurance.zip,''),'0'),1,9) as integer),
		substring(personhealthinsurance.providerphone,1,10),		
		VS_HEALTH_HMO,		
		VS_ADDRESS_DIR,
		SUBSTRING(personhealthinsurance.address1,'(^[0-9]+)'), -- personhealthinsurance.PADR_STREET_NO
		TRIM(SUBSTRING(personhealthinsurance.address1,'([[:alpha:]\s]+)')),
		VS_ADDRESS_STREET,
		VS_ADDRESS_DIR,
		substring(substring(personhealthinsurance.address2,'(^[0-9]+)'),1,5), -- PADR_UNIT_NO_TX		
		personhealthinsurance.city,
		personhealthinsurance.state,
		cast(SUBSTRING(COALESCE(nullif(personhealthinsurance.zip,''),'0'),1,9) as integer),
		substring(personhealthinsurance.providerphone,1,10),
		(CASE WHEN btrim(lower(personhealthinsurance.policyholdername)) =  btrim(lower(person.firstname || ' ' || person.lastname)) THEN 
			'Y'
		ELSE 
			'N'
		END) 
	FROM personhealthinsurance, person
	WHERE personhealthinsurance.personid = person.personid
		AND person.cjamspid = VL_CLIENT_ID
		AND personhealthinsurance.caresauno IS NULL
		AND personhealthinsurance.activeflag  = 1 
		AND person.activeflag = 1 ;
     
BEGIN
	VL_OUTPUT_SQLCODE:='00000';  
  
    -- SET transaction sequence
    VS_TRANSACTION_SEQUENCE = LTRIM(RTRIM(VL_TRANSACTION_SEQUENCE::VARCHAR)) ;

    -- Get CIS_CLIENT_ID
	BEGIN
		SELECT person.cisclientid
			INTO VS_CIS_CLIENT_ID
		FROM person  	
		WHERE person.cjamspid = VL_CLIENT_ID
			AND person.activeflag  = 1;  
	
		--raise notice 'VS_CIS_CLIENT_ID %', VS_CIS_CLIENT_ID;
		--raise notice 'VL_CLIENT_ID %', VL_CLIENT_ID;
		EXCEPTION WHEN OTHERS THEN 
			VL_OUTPUT_SQLCODE  :=  SQLSTATE;
			VS_MESSAGE :=  '(E&E) SELECT cisclientid FAILED FOR person ' || SQLERRM  ;
		RETURN;
    END;

    -- Generate records for record type 15
	VS_RECORD_TYPE := '15';
	VL_RECORD_SEQUENCE := 000 ;
	VS_RECORD_SEQUENCE := '';

    IF  VS_RECORD_TYPE = '15' THEN
		OPEN CURSOR_MED;
		<<CURS_MED>>
		WHILE VL_OUTPUT_SQLCODE = '00000'  LOOP
			FETCH CURSOR_MED INTO ENE_OUT_MED_COL1, ENE_OUT_MED_COL2, ENE_OUT_MED_COL3, ENE_OUT_MED_COL4,
							ENE_OUT_MED_COL5, ENE_OUT_MED_COL6, ENE_OUT_MED_COL7, ENE_OUT_MED_COL8,
							ENE_OUT_MED_COL9, ENE_OUT_MED_COL10, ENE_OUT_MED_COL11, ENE_OUT_MED_COL12,
							ENE_OUT_MED_COL13, ENE_OUT_MED_COL14, ENE_OUT_MED_COL15, ENE_OUT_MED_COL16,
							ENE_OUT_MED_COL17, ENE_OUT_MED_COL18, ENE_OUT_MED_COL19, ENE_OUT_MED_COL20,
							ENE_OUT_MED_COL21, ENE_OUT_MED_COL22, ENE_OUT_MED_COL23, ENE_OUT_MED_COL24,
							ENE_OUT_MED_COL25, ENE_OUT_MED_COL26, ENE_OUT_MED_COL27   ;

			EXIT CURS_MED WHEN NOT FOUND;
			   
		
			VL_RECORD_SEQUENCE := VL_RECORD_SEQUENCE + 1 ;

			VS_RECORD_SEQUENCE := LTRIM(RTRIM(VL_RECORD_SEQUENCE::VARCHAR));
			
			-- Set Interface Data
			INSERT INTO eneoutboundinterface
				(	ENE_RECORD_ID,
					STATUS_CD,
					BATCH_SEQ_NO,
					TRANSACTION_SEQ_NO,
					TRANSACTION_TYPE_CD,
					CIS_CLIENT_ID,
					RECORD_TYPE_CD,
					TRANSACTION_TS,
					RECORD_SEQ_NO,
					ENE_OUT_COL1,
					ENE_OUT_COL2,
					ENE_OUT_COL3,
					ENE_OUT_COL4,
					ENE_OUT_COL5,
					ENE_OUT_COL6,
					ENE_OUT_COL7,
					ENE_OUT_COL8,
					ENE_OUT_COL9,
					ENE_OUT_COL10,
					ENE_OUT_COL11,
					ENE_OUT_COL12,
					ENE_OUT_COL13,
					ENE_OUT_COL14,
					ENE_OUT_COL15,
					ENE_OUT_COL16,
					ENE_OUT_COL17,
					ENE_OUT_COL18,
					ENE_OUT_COL19,
					ENE_OUT_COL20,
					ENE_OUT_COL21,
					ENE_OUT_COL22,
					ENE_OUT_COL23,
					ENE_OUT_COL24,
					ENE_OUT_COL25,
					ENE_OUT_COL26,
					ENE_OUT_COL27
				)
			SELECT
				NEXTVAL('SQ_ENEOUTBOUNDINTERFACE'),
				'000',
				'',
				(CASE WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 1 THEN '0000'||VS_TRANSACTION_SEQUENCE
					WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 2 THEN '000'||VS_TRANSACTION_SEQUENCE
					WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 3 THEN '00'||VS_TRANSACTION_SEQUENCE
					WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 4 THEN '0'||VS_TRANSACTION_SEQUENCE
					WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 5 THEN VS_TRANSACTION_SEQUENCE
				END),
				VS_TRANSACTION_TYPE_CD,
				COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID)),'000000000'),
				'15',
				VD_TRANSACTION_TS,
				(CASE WHEN LENGTH(VS_RECORD_SEQUENCE) = 1 THEN '00'||VS_RECORD_SEQUENCE
					WHEN LENGTH(VS_RECORD_SEQUENCE) = 2 THEN '0'||VS_RECORD_SEQUENCE
					WHEN LENGTH(VS_RECORD_SEQUENCE) = 3 THEN VS_RECORD_SEQUENCE
				END),
				COALESCE(SUBSTRING('00000000000000000000',1,20 - LENGTH(LTRIM(RTRIM(ENE_OUT_MED_COL1)))) || LTRIM(RTRIM(ENE_OUT_MED_COL1)),'00000000000000000000'),

				COALESCE(SUBSTRING('00000000000000000000',1,20 - LENGTH(LTRIM(RTRIM(ENE_OUT_MED_COL2)))) || LTRIM(RTRIM(ENE_OUT_MED_COL2)),'00000000000000000000'),
				ENE_OUT_MED_COL3,
				COALESCE(ENE_OUT_MED_COL4 :: VARCHAR,'00000000'),
				(CASE WHEN ENE_OUT_MED_COL5 = '99991231' THEN '00000000'
					WHEN ENE_OUT_MED_COL5 IS NULL THEN '00000000'
					WHEN ENE_OUT_MED_COL5 = '0' THEN '00000000'
					ELSE ENE_OUT_MED_COL5 
				END),
				ENE_OUT_MED_COL6,
				ENE_OUT_MED_COL7,
				ENE_OUT_MED_COL8,
				ENE_OUT_MED_COL9,
				ENE_OUT_MED_COL10,
				ENE_OUT_MED_COL11,
				ENE_OUT_MED_COL12,
				ENE_OUT_MED_COL13,
				(CASE WHEN ENE_OUT_MED_COL14 = 0 THEN '000000000'
					WHEN ENE_OUT_MED_COL14 IS NULL THEN '000000000'
					ELSE SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(ENE_OUT_MED_COL14 :: VARCHAR)))) || LTRIM(RTRIM(ENE_OUT_MED_COL14:: VARCHAR))
				END), 		
				COALESCE(ENE_OUT_MED_COL15 :: VARCHAR,'0000000000'),
				ENE_OUT_MED_COL16,
				ENE_OUT_MED_COL17,
				ENE_OUT_MED_COL18,
				ENE_OUT_MED_COL19,
				ENE_OUT_MED_COL20,
				ENE_OUT_MED_COL21,
				ENE_OUT_MED_COL22,
				ENE_OUT_MED_COL23,
				ENE_OUT_MED_COL24,
				(CASE WHEN ENE_OUT_MED_COL25 = 0 THEN '000000000'
					WHEN ENE_OUT_MED_COL25 IS NULL THEN '000000000'
					ELSE substring('000000000',1,9 - LENGTH(LTRIM(RTRIM(ENE_OUT_MED_COL25 :: VARCHAR)))) || LTRIM(RTRIM(ENE_OUT_MED_COL25 :: VARCHAR))
				END), 		
				COALESCE(ENE_OUT_MED_COL26 :: VARCHAR,'0000000000'),
				ENE_OUT_MED_COL27	
			; 	
			-- RAISE NOTICE '(E&E) INSERT IN GEN DATA 15 SUCCESSFUL';
		
		END LOOP;
        CLOSE CURSOR_MED;

	END IF; 	

    RETURN ;
	
    EXCEPTION WHEN OTHERS THEN 
		VL_OUTPUT_SQLCODE  :=  SQLSTATE;
		VS_MESSAGE := '(E&E) INSERT INTO eneoutboundinterface FAILED ' ||SQLERRM ;
		RETURN;
END 
;
$function$
;
