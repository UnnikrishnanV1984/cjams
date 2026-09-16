-- FUNCTION: cjams.sp_cses_outbound_interface_gen_data_10(integer, bigint, character varying, integer, timestamp without time zone)

-- DROP FUNCTION cjams.sp_cses_outbound_interface_gen_data_10(integer, bigint, character varying, integer, timestamp without time zone);

CREATE OR REPLACE FUNCTION cjams.sp_cses_outbound_interface_gen_data_10(
	vl_client_id integer,
	vl_other_id bigint,
	vs_transaction_type_cd character varying,
	vl_transaction_sequence integer,
	vd_transaction_ts timestamp without time zone,
	OUT vs_message character varying,
	OUT vl_output_sqlcode character varying)
RETURNS record
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
AS $FUNCTION$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Sudhin
-- Date Created :08/01/2005
-- generates Cares Interface Outbound Data
------------------------------------------------------------------------
DECLARE

    
    VS_RECORD_TYPE VARCHAR(2);--
    VS_OUTPUT_STATE VARCHAR(5) DEFAULT '00000';--
    VL_RECORD_SEQUENCE INTEGER DEFAULT 000;--
    VS_TRANSACTION_SEQUENCE VARCHAR(5);--
	VL_OUTPUT_SQLCODE Varchar(100);
    VS_RECORD_SEQUENCE VARCHAR(100);--
    -- Client Variables
    VS_CIS_CLIENT_ID VARCHAR(10);      --  CARES_OUT_COL6
    CSES_OUT_SO_COL1 CHAR(1);--
    CSES_OUT_SO_COL2 VARCHAR(20);--
    CSES_OUT_SO_COL3 VARCHAR(20);--
    CSES_OUT_SO_COL4 CHAR(2);--
    CSES_OUT_SO_COL5 VARCHAR(20);--
-- select * from csesclientsupportorder

    DECLARE CURSOR_SO  CURSOR FOR
    SELECT (SELECT CASE WHEN COUNT(*) > 0 THEN 'Y'
                    ELSE 'N'
            END
            FROM csesclientsupportorder B
            WHERE B.old_id::integer =  VL_CLIENT_ID
            AND B.activeflag = 1),
           A.socounty,
           A.socityname,
           A.sostate,
           A.sonumber
    FROM csesclientsupportorder A
    WHERE A.old_id::integer =  VL_CLIENT_ID
    AND A.activeflag = 1;
	
	
 BEGIN
--
 VL_OUTPUT_SQLCODE := '00000';
    -- SET transaction sequence
    VS_TRANSACTION_SEQUENCE := LTRIM(RTRIM(CAST(VL_TRANSACTION_SEQUENCE AS VARCHAR))) ;--

    -- Get CIS_CLIENT_ID
BEGIN
    SELECT  person.cisclientid
    INTO    VS_CIS_CLIENT_ID
    FROM    person  	
    WHERE   person.cjamspid =  VL_CLIENT_ID
    AND     person.activeflag = 1;--
	
	 EXCEPTION WHEN OTHERS THEN
	   VL_OUTPUT_SQLCODE :=SQLSTATE;
       VS_MESSAGE := 'SELECT cisclientid FAILED FOR person'  || SQLERRM  ;--
	 RETURN ;
END ;

    -- Generate records for record type 10
 	
    VS_RECORD_TYPE := '10';--
 	
    VL_RECORD_SEQUENCE := 000 ;--

    VS_RECORD_SEQUENCE := '';--

    IF  VS_RECORD_TYPE = '10' THEN

        OPEN CURSOR_SO;--
        <<CURS_SO>>
        WHILE VL_OUTPUT_SQLCODE = '00000'  LOOP
            FETCH CURSOR_SO INTO CSES_OUT_SO_COL1, CSES_OUT_SO_COL2, CSES_OUT_SO_COL3, CSES_OUT_SO_COL4, CSES_OUT_SO_COL5;--
            EXIT CURS_SO WHEN NOT FOUND;
            
			IF VL_OUTPUT_SQLCODE  = '100' THEN
                 -- LEAVE CURS_SO;--
            END IF;--

	    VL_RECORD_SEQUENCE := VL_RECORD_SEQUENCE + 1 ;--
	
	    VS_RECORD_SEQUENCE := VL_RECORD_SEQUENCE;--

	
	    -- Set Interface Data
		BEGIN
	    INSERT INTO csesoutboundinterface
	        (csesoutboundinterfaceid,
	         statustypekey,
	         batchseqno,
		 transactionseqno,
			 transactiontypekey,
	    	 cisclientid,
		 recordtypekey,
		 transactionon,
	         recordseqno,
	         csesoutcol1,
		 csesoutcol2,
		 csesoutcol3,
		 csesoutcol4,
		 csesoutcol5
	         )
			 
	
	    SELECT
		NEXTVAL ('SQ_CSES_OUTBOUND_INTERFACE'),
		'000',
		'',
		CASE WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 1 THEN '0000'||VS_TRANSACTION_SEQUENCE
		     WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 2 THEN '000'||VS_TRANSACTION_SEQUENCE
		     WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 3 THEN '00'||VS_TRANSACTION_SEQUENCE
		     WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 4 THEN '0'||VS_TRANSACTION_SEQUENCE
		     WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 5 THEN VS_TRANSACTION_SEQUENCE
		     END,
		VS_TRANSACTION_TYPE_CD,
		COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID)),'000000000'),
		'10',
		VD_TRANSACTION_TS,
		'002',
		CSES_OUT_SO_COL1,
		CASE WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Allegany' THEN '01' -- Allegany
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Anne Arundel' THEN '02' -- Anne Arundel
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Baltimore County' THEN '03' -- Baltimore County
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Calvert' THEN '04' -- CALVERT COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Caroline' THEN '05' -- CAROLINE COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Carroll' THEN '06' -- CARROLL COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Cecil' THEN '07' -- CECIL COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Charles' THEN '08' -- CHARLES COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Dorchester' THEN '09' -- DORCHESTER COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Frederick' THEN '10' -- FREDERICK COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Garrett' THEN '11' -- GARRETT COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Harford' THEN '12' -- HARFORD COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Howard' THEN '13' -- HOWARD COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Kent' THEN '14' -- KENT COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Montgomery' THEN '15' -- MONTGOMERY COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Prince George''s' THEN '16' -- PRINCE GEORGES COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Queen Anne''s' THEN '17' -- QUEEN ANNES COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'St. Mary''s' THEN '18' -- ST. MARYS COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Somerset' THEN '19' -- SOMERSET COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Talbot' THEN '20' -- TALBOT COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Washington' THEN '21' -- WASHINGTON COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Wicomico' THEN '22' -- WICOMICO COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Worcester' THEN '23' -- WORCESTER COUNTY
	             WHEN LTRIM(RTRIM(CSES_OUT_SO_COL2)) = 'Baltimore City' THEN '24' -- BALTIMORE CITY
	             ELSE '00'
	        END,
                CSES_OUT_SO_COL3,
                CSES_OUT_SO_COL4,
                CSES_OUT_SO_COL5;		--
	
	
	        EXCEPTION WHEN OTHERS THEN
        VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
	    VS_MESSAGE := 'TABLE INSERT 10 FAILED FOR TB_CSES_OUTBOUND_INTERFACE '  || SQLERRM  ;--
	    -- GOTO ERROR_SECTION ;--
		RETURN;
       END ;

       END LOOP;--
       CLOSE CURSOR_SO;--
	   
  END IF ;

--  VL_OUTPUT_SQLCODE  != '00000' ;
--	RAISE NOTICE 'INSERTED DATA_10';
VS_MESSAGE := 'Procedure ran succesfully'  ;
    RETURN ;--
	
	END;

$FUNCTION$;

