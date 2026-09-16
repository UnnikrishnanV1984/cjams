CREATE OR REPLACE FUNCTION cjams.sp_cses_interface_load_inbound( 	vs_batch_user character varying, 
																	vs_batch_no character varying, 
																	vl_error_line integer, 
																	vs_record_type character varying, 
																	vs_cis_client_id character varying, 
																	vs_value1 character varying, 
																	vs_value2 character varying, 
																	vs_value3 character varying, 
																	vs_value4 character varying, 
																	vs_value5 character varying, 
																	vs_value6 character varying, 
																	vs_value7 character varying, 
																	vs_value8 character varying, 
																	vs_value9 character varying, 
																	vs_value10 character varying, 
																	vs_value11 character varying, 
																	vs_value12 character varying, 
																	vs_value13 character varying, 
																	vs_value14 character varying, 
																	vs_value15 character varying, 
																	vs_value16 character varying, 
																	vs_value17 character varying, 
																	vs_value18 character varying, 
																	vs_value19 character varying, 
																	vs_value20 character varying, 
																	vs_value21 character varying, 
																	vs_value22 character varying, 
																	vs_value23 character varying, 
																	vs_value24 character varying, 
																	vs_value25 character varying, 
																	vs_value26 character varying, 
																	vs_value27 character varying, 
																	vs_value28 character varying, 
																	vs_value29 character varying, 
																	vs_value30 character varying, 
																	vs_value31 character varying, 
																	vs_value32 character varying, 
																	vs_value33 character varying, 
																	vs_value34 character varying, 
																	vs_value35 character varying, 
																	vs_value36 character varying, 
																	vs_value37 character varying, 
																	vs_value38 character varying, 
																	vs_value39 character varying, 
																	vs_value40 character varying, 
																	vs_value41 character varying, 
																	vs_value42 character varying, 
																	vs_value43 character varying, 
																	vs_value44 character varying, 
																	vs_value45 character varying, 
																	vs_value46 character varying, 
																	vs_value47 character varying, 
																	vs_value48 character varying, 
																	vs_value49 character varying, 
																	vs_value50 character varying, 
																	OUT vs_error_code character varying, 
																	OUT vl_output_sqlcode character varying, 
																	OUT vs_error_desc character varying
																)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

--MODIFIES SQL DATA
--NOT DETERMINISTIC
--CALLED ON NULL INPUT
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Sudhin Kollara
-- Date Created :07/25/2005
-- Load data from CSES Interface
--Revision
--Mohan    01/16/06   #5955
-- 04/24/2007 - #13722 - sandhya - change condition that checks IF cis_client_id exists in tb_client for performance
-- 08/10/2012 Vineet Tirodkar PRJ-02667 - CJAMS Batch Process Redesign - To change Return 0 on success
-- 09/10/2012 - Vineet Tirodkar PRJ-02667 - CJAMS Batch Process Redesign - To add Return -1 in Exit Handler 
-- 08/22/2017- Samir Patil B-07674 - to fix the issue of error "Unknown to CJAMS" terminating the program.
-- 08/31/2020 - Vineet Tirodkar - Modifications to Error Handling - (CIDM-415)
--			    Return vl_output_sqlcode as '00000' for all warnings & for all errors return actual Error Codes
------------------------------------------------------------------------

DECLARE VS_OUTPUT_STATE CHAR(5) DEFAULT '00000';
	VS_MESSAGE VARCHAR(2000);
	vl_integer_check INTEGER DEFAULT 0;
	vd_date_check DATE;
	vdec_decimal_check DECIMAL(10,2) DEFAULT 0.0;
	vl_integer_null INTEGER DEFAULT NULL;
	vdec_decimal_null DECIMAL(10,2) DEFAULT NULL;
	vd_date_null DATE DEFAULT NULL;
	vl_client_id BIGINT;
	vl_person_id uuid ; 
	vs_field_name VARCHAR(50);


BEGIN 	

	BEGIN 
	--select person.personid into vl_person_id  from person where person.cjamspid :: integer = vl_client_id;
		select pr.personid
			into vl_person_id
		from person pr, 
			personidentifier pi 
		where pr.personid = pi.personid
			and pi.personidentifiervalue = vs_cis_client_id;

		EXCEPTION WHEN OTHERS THEN
			--SET VS_ERROR_CODE = '602';--
			VS_MESSAGE := 'SELECT FAILED FOR personid FROM TABLE person'|| vl_client_id  || SQLERRM;
			VS_ERROR_DESC := 'cjamspid:' || vl_client_id  || ' UNKNOWN TO cjams';
			--GOTO LOG_ERROR ;--
			VL_OUTPUT_SQLCODE := '00000';
			VS_ERROR_CODE := '000';
			RETURN  ;	
	END ; 

	VS_VALUE1   := RTRIM(LTRIM(VS_VALUE1))     ;
	VS_VALUE2   := RTRIM(LTRIM(VS_VALUE2))     ;	
	VS_VALUE3   := RTRIM(LTRIM(VS_VALUE3))     ;
	VS_VALUE4   := RTRIM(LTRIM(VS_VALUE4))     ;
	VS_VALUE5   := RTRIM(LTRIM(VS_VALUE5))     ;
	VS_VALUE6   := RTRIM(LTRIM(VS_VALUE6))     ;
	VS_VALUE7   := RTRIM(LTRIM(VS_VALUE7))     ;
	VS_VALUE8   := RTRIM(LTRIM(VS_VALUE8))     ;
	VS_VALUE9   := RTRIM(LTRIM(VS_VALUE9))     ;
	VS_VALUE10  := RTRIM(LTRIM(VS_VALUE10))    ;
	VS_VALUE11  := RTRIM(LTRIM(VS_VALUE11))    ;
	VS_VALUE12  := RTRIM(LTRIM(VS_VALUE12))    ;
	VS_VALUE13  := RTRIM(LTRIM(VS_VALUE13))    ;
	VS_VALUE14  := RTRIM(LTRIM(VS_VALUE14))    ;
	VS_VALUE15  := RTRIM(LTRIM(VS_VALUE15))    ;
	VS_VALUE16  := RTRIM(LTRIM(VS_VALUE16))    ;
	VS_VALUE17  := RTRIM(LTRIM(VS_VALUE17))    ;
	VS_VALUE18  := RTRIM(LTRIM(VS_VALUE18))    ;
	VS_VALUE19  := RTRIM(LTRIM(VS_VALUE19))    ;
	VS_VALUE20  := RTRIM(LTRIM(VS_VALUE20))    ;
	VS_VALUE21  := RTRIM(LTRIM(VS_VALUE21))    ;
	VS_VALUE22  := RTRIM(LTRIM(VS_VALUE22))    ;
	VS_VALUE23  := RTRIM(LTRIM(VS_VALUE23))    ;
	VS_VALUE24  := RTRIM(LTRIM(VS_VALUE24))    ;
	VS_VALUE25  := RTRIM(LTRIM(VS_VALUE25))    ;
	VS_VALUE26  := RTRIM(LTRIM(VS_VALUE26))    ;
	VS_VALUE27  := RTRIM(LTRIM(VS_VALUE27))    ;
	VS_VALUE28  := RTRIM(LTRIM(VS_VALUE28))    ;
	VS_VALUE29  := RTRIM(LTRIM(VS_VALUE29))    ;
	VS_VALUE30  := RTRIM(LTRIM(VS_VALUE30))    ;
	VS_VALUE31  := RTRIM(LTRIM(VS_VALUE31))    ;
	VS_VALUE32  := RTRIM(LTRIM(VS_VALUE32))    ;
	VS_VALUE33  := RTRIM(LTRIM(VS_VALUE33))    ;
	VS_VALUE34  := RTRIM(LTRIM(VS_VALUE34))    ;
	VS_VALUE35  := RTRIM(LTRIM(VS_VALUE35))    ;
	VS_VALUE36  := RTRIM(LTRIM(VS_VALUE36))    ;
	VS_VALUE37  := RTRIM(LTRIM(VS_VALUE37))    ;
	VS_VALUE38  := RTRIM(LTRIM(VS_VALUE38))    ;
	VS_VALUE39  := RTRIM(LTRIM(VS_VALUE39))    ;
	VS_VALUE40  := RTRIM(LTRIM(VS_VALUE40))    ;
	VS_VALUE41  := RTRIM(LTRIM(VS_VALUE41))    ;
	VS_VALUE42  := RTRIM(LTRIM(VS_VALUE42))    ;
	VS_VALUE43  := RTRIM(LTRIM(VS_VALUE43))    ;
	VS_VALUE44  := RTRIM(LTRIM(VS_VALUE44))    ;
	VS_VALUE45  := RTRIM(LTRIM(VS_VALUE45))    ;
	VS_VALUE46  := RTRIM(LTRIM(VS_VALUE46))    ;
	VS_VALUE47  := RTRIM(LTRIM(VS_VALUE47))    ;
	VS_VALUE48  := RTRIM(LTRIM(VS_VALUE48))    ;
	VS_VALUE49  := RTRIM(LTRIM(VS_VALUE49))    ;
	VS_VALUE50  := RTRIM(LTRIM(VS_VALUE50))    ;
	VS_BATCH_NO := RTRIM(LTRIM(VS_BATCH_NO))    ;
	VS_RECORD_TYPE := RTRIM(LTRIM(VS_RECORD_TYPE))    ;
	VS_CIS_CLIENT_ID := RTRIM(LTRIM(VS_CIS_CLIENT_ID))    ;

	IF VS_RECORD_TYPE NOT IN ('02','11','21') THEN
		VL_OUTPUT_SQLCODE := '506';
		VS_ERROR_CODE := '506';
		VS_ERROR_DESC := 'Invalid Record Code: ' || VS_RECORD_TYPE;
		VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
		RETURN  ;
	END IF;
	
	-- B-07674 begin
	IF VS_CIS_CLIENT_ID IS NULL OR VS_CIS_CLIENT_ID = '' THEN
		VL_OUTPUT_SQLCODE := '503';
		VS_ERROR_CODE := '503';
		VS_ERROR_DESC := 'Missing Mandatory Field cisclientid';
		VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
		RETURN  ;
	END IF;			
	
	IF NOT EXISTS (SELECT 1 FROM person WHERE cisclientid = VS_CIS_CLIENT_ID::VARCHAR AND activeflag = 1) THEN -- #13722 
		--SET VS_ERROR_CODE = '602';--
		VS_ERROR_DESC := ' ';
		--GOTO LOG_ERROR ;--
		VL_OUTPUT_SQLCODE := '00000';
		VS_ERROR_CODE := '000';
		VS_MESSAGE := ' ';	
		RETURN ;										
	ELSE
	    BEGIN		
			SELECT MAX(CJAMSPID) 
				INTO vl_client_id FROM person
			WHERE cisclientid = VS_CIS_CLIENT_ID::VARCHAR 
				AND activeflag = 1  ;    -- #13722 
			
			EXCEPTION WHEN OTHERS THEN
				--SET VS_ERROR_CODE = '602';
				VS_MESSAGE := ' ' ;
				VS_ERROR_DESC := ' ';
				--GOTO LOG_ERROR ;
				VL_OUTPUT_SQLCODE := '00000';
				VS_ERROR_CODE := '000';
				RETURN  ;	
		END ;	
	END IF;	
	-- B-07674 end

	IF VS_RECORD_TYPE = '11' THEN -- '11' - START				

		IF LENGTH(VS_VALUE4) > 0 THEN
			IF VS_VALUE4 = '00000000' THEN  
				VS_VALUE4 := NULL ;
			END IF;	
			
            IF LENGTH(VS_VALUE4) = 8 THEN	
				VS_VALUE4 := SUBSTRING(VS_VALUE4,1,4) || '-' || SUBSTRING(VS_VALUE4,5,2) || '-' || SUBSTRING(VS_VALUE4,7,2) ;
			END IF ;

            vs_field_name := 'sodate' ;
			BEGIN		 
				vd_date_check := VS_VALUE4::DATE;		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For sodate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END 	;
        ELSE
			VS_VALUE4 := NULL;	
		END IF;	
		
        IF LENGTH(VS_VALUE5) > 0 THEN
			IF VS_VALUE5 = '00000000' THEN 
				VS_VALUE5 := NULL ;
			END IF;	
			
			IF LENGTH(VS_VALUE5) = 8 THEN	
				VS_VALUE5 := SUBSTRING(VS_VALUE5,1,4) || '-' || SUBSTRING(VS_VALUE5,5,2) || '-' || SUBSTRING(VS_VALUE5,7,2) ;
			END IF ;

			vs_field_name := 'sostatusdate' ;
			BEGIN
				vd_date_check = VS_VALUE5::DATE;		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For sostatusdate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END 	;
        ELSE
			VS_VALUE5 := NULL;	
		END IF;				
			
		IF LENGTH(VS_VALUE7) > 0 THEN
			VS_VALUE7 := SUBSTRING(VS_VALUE7,1,LENGTH(VS_VALUE7) - 2) || '.' || SUBSTRING(VS_VALUE7,LENGTH(VS_VALUE7) - 1,2) ;
			vs_field_name := 'sopaymentamount' ;
			BEGIN  
				vdec_decimal_check :=  VS_VALUE7::DECIMAL(10,2);
				EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE := '504';				
				VS_ERROR_CODE := '504';
				VS_ERROR_DESC := 'Batch Line Has Invalid Data For sopaymentamount';
				VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
				RETURN  ;
			END ;	
		ELSE
			VS_VALUE7 := NULL;
		END IF;

		IF EXISTS(SELECT 1 FROM csesclientsupportorder WHERE SUBSTRING('0000000000',1,10 - LENGTH(LTRIM(RTRIM(cisclientid)))) || LTRIM(RTRIM(cisclientid))
			= SUBSTRING('0000000000',1,10 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID)) AND cisclientid = VS_CIS_CLIENT_ID  AND activeflag = 1)   THEN
			BEGIN
                UPDATE csesclientsupportorder 
					SET activeflag = 0
				WHERE SUBSTRING('0000000000',1,10 - LENGTH(LTRIM(RTRIM(cisclientid)))) || LTRIM(RTRIM(cisclientid)) 
					= SUBSTRING('0000000000',1,10 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID))
					AND cisclientid = VS_CIS_CLIENT_ID 
					AND activeflag = 1;

				EXCEPTION WHEN OTHERS THEN
					VS_MESSAGE := 'DELETE OF csesclientsupportorder FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID || ' AND cjamspid:'||vl_client_id::VARCHAR  ;
					VS_ERROR_DESC := 'DELETE OF csesclientsupportorder FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID || ' AND cjamspid:'||vl_client_id::VARCHAR  ;
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
			
            BEGIN
				  
				INSERT INTO csesclientsupportorder
					(	csesclientsupportorderid,
						cisclientid,
						socounty,
						sostate,
						sonumber,
						sodate,
						sostatusdate,
						sostatustypekey,
						sopaymentamount,
						sopaymentfreqtypekey,
						sodatasource,
						insertedby,
						insertedon,
						updatedby,
						updatedon,
						activeflag,
						personid
					)
				SELECT gen_random_uuid(), 
					VS_CIS_CLIENT_ID,				
					CASE WHEN LTRIM(RTRIM(VS_VALUE1)) = '01' THEN 'Allegany'  -- Allegany
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '02' THEN 'Anne Arundel'  -- Anne Arundel
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '03' THEN 'Baltimore County'  -- Baltimore County
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '04' THEN 'Calvert'  -- CALVERT COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '05' THEN 'Caroline'  -- CAROLINE COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '06' THEN 'Carroll' -- CARROLL COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '07' THEN 'Cecil' -- CECIL COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '08' THEN 'Charles' -- CHARLES COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '09' THEN 'Dorchester' -- DORCHESTER COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '10' THEN 'Frederick' -- FREDERICK COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '11' THEN 'Garrett' -- GARRETT COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '12' THEN 'Harford' -- HARFORD COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '13' THEN 'Howard' -- HOWARD COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '14' THEN 'Kent' -- KENT COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '15' THEN 'Montgomery' -- MONTGOMERY COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '16' THEN 'Prince George''s' -- PRINCE GEORGES COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '17' THEN 'Queen Anne''s' -- QUEEN ANNES COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '18' THEN 'St. Mary''s' -- ST. MARYS COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '19' THEN 'Somerset' -- SOMERSET COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '20' THEN 'Talbot' -- TALBOT COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '21' THEN 'Washington' -- WASHINGTON COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '22' THEN 'Wicomico' -- WICOMICO COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '23' THEN 'Worcester' -- WORCESTER COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '30' THEN 'Baltimore City' -- BALTIMORE CITY
						ELSE LTRIM(RTRIM(VS_VALUE1))
					END,
					VS_VALUE2,
					VS_VALUE3,
					CASE WHEN VS_VALUE4 IS NULL THEN NULL
						WHEN VS_VALUE4 = '' THEN NULL
						WHEN LENGTH(VS_VALUE4) <= 0 THEN NULL
						ELSE VS_VALUE4::DATE
					END,
					CASE WHEN VS_VALUE5 IS NULL THEN NULL
						WHEN VS_VALUE5 = '' THEN NULL
						WHEN LENGTH(VS_VALUE5) <= 0 THEN NULL
						ELSE VS_VALUE5::DATE
					END,
					CASE WHEN VS_VALUE6 = 'P' THEN '10280'
						WHEN VS_VALUE6 = 'F' THEN '10281'
						ELSE VS_VALUE6
					END,
					CASE WHEN VS_VALUE7 IS NULL THEN NULL
						WHEN VS_VALUE7 = '' THEN NULL
						WHEN LENGTH(VS_VALUE7) <= 0 THEN NULL
						ELSE VS_VALUE7::DECIMAL(10,2)
					END,
					CASE WHEN VS_VALUE8 = 'W' THEN '2886'
						WHEN VS_VALUE8 = 'B' THEN '2884'
						WHEN VS_VALUE8 = 'M' THEN '2885'
						WHEN VS_VALUE8 = 'S' THEN '10340'
						ELSE VS_VALUE8
					END,
					'S',
					VS_BATCH_USER,
					CURRENT_TIMESTAMP,
					VS_BATCH_USER,
					CURRENT_TIMESTAMP,
					1,
					vl_person_id
				;	

				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE  := '504';
					VS_MESSAGE := 'INSERT INTO csesclientsupportorder FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID  ;
					VS_ERROR_DESC := 'INSERT INTO csesclientsupportorder FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID  ;
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;					
		ELSE
			BEGIN
				INSERT INTO csesclientsupportorder
				(	csesclientsupportorderid, 
					cisclientid,
					socounty,
					sostate,
					sonumber,
					sodate,
					sostatusdate,
					sostatustypekey,
					sopaymentamount,
					sopaymentfreqtypekey,
					sodatasource,
					insertedby,
					insertedon,
					updatedby,
					updatedon,
					activeflag,
					personid
				)
				SELECT gen_random_uuid(), 
					VS_CIS_CLIENT_ID,    				
					CASE WHEN LTRIM(RTRIM(VS_VALUE1)) = '01' THEN 'Allegany'  -- Allegany
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '02' THEN 'Anne Arundel'  -- Anne Arundel
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '03' THEN 'Baltimore County'  -- Baltimore County
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '04' THEN 'Calvert'  -- CALVERT COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '05' THEN 'Caroline'  -- CAROLINE COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '06' THEN 'Carroll' -- CARROLL COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '07' THEN 'Cecil' -- CECIL COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '08' THEN 'Charles' -- CHARLES COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '09' THEN 'Dorchester' -- DORCHESTER COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '10' THEN 'Frederick' -- FREDERICK COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '11' THEN 'Garrett' -- GARRETT COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '12' THEN 'Harford' -- HARFORD COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '13' THEN 'Howard' -- HOWARD COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '14' THEN 'Kent' -- KENT COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '15' THEN 'Montgomery' -- MONTGOMERY COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '16' THEN 'Prince George''s' -- PRINCE GEORGES COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '17' THEN 'Queen Anne''s' -- QUEEN ANNES COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '18' THEN 'St. Mary''s' -- ST. MARYS COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '19' THEN 'Somerset' -- SOMERSET COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '20' THEN 'Talbot' -- TALBOT COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '21' THEN 'Washington' -- WASHINGTON COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '22' THEN 'Wicomico' -- WICOMICO COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '23' THEN 'Worcester' -- WORCESTER COUNTY
						WHEN LTRIM(RTRIM(VS_VALUE1)) = '30' THEN 'Baltimore City' -- BALTIMORE CITY
						ELSE LTRIM(RTRIM(VS_VALUE1))
						END,
					VS_VALUE2,
					VS_VALUE3,
					CASE WHEN VS_VALUE4 IS NULL THEN NULL
						 WHEN VS_VALUE4 = '' THEN NULL
						 WHEN LENGTH(VS_VALUE4) <= 0 THEN NULL
						 ELSE VS_VALUE4::DATE
						 END,
					CASE WHEN VS_VALUE5 IS NULL THEN NULL
						 WHEN VS_VALUE5 = '' THEN NULL
						 WHEN LENGTH(VS_VALUE5) <= 0 THEN NULL
						 ELSE VS_VALUE5::DATE
						 END,
					CASE WHEN VS_VALUE6 = 'P' THEN '10280'
						 WHEN VS_VALUE6 = 'F' THEN '10281'
						 ELSE VS_VALUE6
					END,
					CASE WHEN VS_VALUE7 IS NULL THEN NULL
						 WHEN VS_VALUE7 = '' THEN NULL
						 WHEN LENGTH(VS_VALUE7) <= 0 THEN NULL
						 ELSE VS_VALUE7::DECIMAL(10,2)
					 END,
					CASE WHEN VS_VALUE8 = 'W' THEN '2886'
						 WHEN VS_VALUE8 = 'B' THEN '2884'
						 WHEN VS_VALUE8 = 'M' THEN '2885'
						 WHEN VS_VALUE8 = 'S' THEN '10340'
						 ELSE VS_VALUE8
					END,
					'S',
					VS_BATCH_USER,
					CURRENT_TIMESTAMP,
					VS_BATCH_USER,
					CURRENT_TIMESTAMP,
					1,
					vl_person_id
	 			;	

				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE  := '504';
					VS_MESSAGE := 'INSERT INTO csesclientsupportorder FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID  ;
					VS_ERROR_DESC := 'INSERT INTO csesclientsupportorder FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID  ;
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;		
		END IF;	
    END IF; -- '11' - END

	IF VS_RECORD_TYPE = '21' THEN -- '21' - START					

		IF VS_VALUE1 IS NULL OR VS_VALUE1 = '' THEN
			VL_OUTPUT_SQLCODE := '503';
			VS_ERROR_CODE := '503';
			VS_ERROR_DESC := 'Missing Mandatory Field old_id';
			VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
			RETURN  ;
		END IF;

		IF LENGTH(VS_VALUE4) > 0 THEN
			IF VS_VALUE4 = '00000000' THEN  
				VS_VALUE4 := NULL ; 
			END IF;	

			IF LENGTH(VS_VALUE4) = 8 THEN	
				VS_VALUE4 := SUBSTRING(VS_VALUE4,1,4) || '-' || SUBSTRING(VS_VALUE4,5,2) || '-' || SUBSTRING(VS_VALUE4,7,2) ;
			END IF ;
			vs_field_name := 'parlegalestdate' ;
			
			BEGIN   
				vd_date_check := VS_VALUE4::DATE ;
				EXCEPTION WHEN OTHERS THEN	
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parlegalestdate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END    ;
		ELSE
			VS_VALUE4 := NULL;			
		END IF;
			
		IF LENGTH(VS_VALUE9) > 0 THEN 		
			vs_field_name := 'parssn' ;
			BEGIN	 
				vl_integer_check := VS_VALUE9::INTEGER;
				EXCEPTION WHEN OTHERS THEN 
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parssn';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE9 := NULL;			
		END IF;			
			
		IF LENGTH(VS_VALUE11) > 0 THEN
			IF VS_VALUE11 = '00000000' THEN  
				VS_VALUE11 := NULL ; 
			END IF;	

			IF LENGTH(VS_VALUE11) = 8 THEN	
				VS_VALUE11 := SUBSTRING(VS_VALUE11,1,4) || '-' || SUBSTRING(VS_VALUE11,5,2) || '-' || SUBSTRING(VS_VALUE11,7,2) ;
			END IF ;
			
			vs_field_name := 'pardob' ;
			BEGIN                        
				vd_date_check =  DATE(VS_VALUE11);
				EXCEPTION WHEN OTHERS THEN	
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For pardob';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE11 := NULL;			
		END IF;
		
		IF LENGTH(VS_VALUE19) > 0 THEN
			IF VS_VALUE19 = '00000000' THEN  
				VS_VALUE19 := NULL ; 
			END IF;	
			IF LENGTH(VS_VALUE19) = 8 THEN	
				VS_VALUE19 := SUBSTRING(VS_VALUE19,1,4) || '-' || SUBSTRING(VS_VALUE19,5,2) || '-' || SUBSTRING(VS_VALUE19,7,2) ;
			END IF ; 			
			vs_field_name := 'parlastaddressdate' ;
			
			BEGIN	 
				vd_date_check :=  VS_VALUE19::DATE;
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parlastaddressdate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
				RETURN  ;
			END ;	
		ELSE
			VS_VALUE19 := NULL;			
		END IF;   			

		IF LENGTH(VS_VALUE20) > 0 THEN
			IF VS_VALUE20 = '00000000' THEN 
				VS_VALUE20 := NULL ; 
			END IF;	
			IF LENGTH(VS_VALUE20) = 8 THEN	
				VS_VALUE20 := SUBSTRING(VS_VALUE20,1,4) || '-' || SUBSTRING(VS_VALUE20,5,2) || '-' || SUBSTRING(VS_VALUE20,7,2) ;
			END IF ; 			
			vs_field_name := 'pardateofdeath' ;
			BEGIN                        
				vd_date_check = VS_VALUE20::DATE;

				EXCEPTION WHEN OTHERS THEN 
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For pardateofdeath';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE20 := NULL;			
		END IF;
			
		IF LENGTH(VS_VALUE28) > 0 THEN
			IF VS_VALUE28 = '00000000' THEN  
				VS_VALUE28 := NULL ; 
			END IF;	
			IF LENGTH(VS_VALUE28) = 8 THEN	
				VS_VALUE28 := SUBSTRING(VS_VALUE28,1,4) || '-' || SUBSTRING(VS_VALUE28,5,2) || '-' || SUBSTRING(VS_VALUE28,7,2) ;
			END IF ; 			

			vs_field_name := 'parcuremp1startdate' ;
			BEGIN                        
				vd_date_check := VS_VALUE28::DATE;
				EXCEPTION WHEN OTHERS THEN 
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parcuremp1startdate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE28 := NULL;			
		END IF;   			

		IF LENGTH(VS_VALUE29) > 0 THEN
			IF VS_VALUE29 = '00000000' THEN  
				VS_VALUE29 := NULL ; 
			END IF;	
			IF LENGTH(VS_VALUE29) = 8 THEN	
				VS_VALUE29 := SUBSTRING(VS_VALUE29,1,4) || '-' || SUBSTRING(VS_VALUE29,5,2) || '-' || SUBSTRING(VS_VALUE29,7,2) ;
			END IF ; 			

			vs_field_name := 'parcuremp1enddate' ;
			BEGIN  
				vd_date_check := VS_VALUE29::DATE;
				EXCEPTION WHEN OTHERS THEN 	
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parcuremp1enddate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE29 := NULL;			
		END IF;
			
		IF LENGTH(VS_VALUE37) > 0 THEN
			IF VS_VALUE37 = '00000000' THEN 
				VS_VALUE37 := NULL ; 
			END IF;	

			IF LENGTH(VS_VALUE37) = 8 THEN	
				VS_VALUE37 := SUBSTRING(VS_VALUE37,1,4) || '-' || SUBSTRING(VS_VALUE37,5,2) || '-' || SUBSTRING(VS_VALUE37,7,2) ;
			END IF ; 			

			vs_field_name := 'parcuremp2startdate' ;
			BEGIN	 
				vd_date_check := VS_VALUE37::DATE;
				EXCEPTION WHEN OTHERS THEN 
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parcuremp2startdate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE37 := NULL;			
		END IF;   			

		IF LENGTH(VS_VALUE38) > 0 THEN
			IF VS_VALUE38 = '00000000' THEN  
				VS_VALUE38 := NULL ;
			END IF;	

			IF LENGTH(VS_VALUE38) = 8 THEN	
				VS_VALUE38 := SUBSTRING(VS_VALUE38,1,4) || '-' || SUBSTRING(VS_VALUE38,5,2) || '-' || SUBSTRING(VS_VALUE38,7,2) ;
			END IF ; 			

			vs_field_name := 'parcuremp2enddate' ;
			BEGIN                        
				vd_date_check := VS_VALUE38::DATE;
				EXCEPTION WHEN OTHERS THEN 
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parcuremp2enddate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE38 := NULL;			
		END IF;
		
		IF LENGTH(VS_VALUE40) > 0 THEN
			IF VS_VALUE40 = '00000000' THEN 
				VS_VALUE40 := NULL ; 
			END IF;	
			IF LENGTH(VS_VALUE40) = 8 THEN	
				VS_VALUE40 := SUBSTRING(VS_VALUE40,1,4) || '-' || SUBSTRING(VS_VALUE40,5,2) || '-' || SUBSTRING(VS_VALUE40,7,2) ;
			END IF ; 			
		
			vs_field_name := 'parmilitarystartdate' ;
			BEGIN   
				vd_date_check := VS_VALUE40::DATE;
				EXCEPTION WHEN OTHERS THEN	
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parmilitarystartdate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE40 := NULL;			
		END IF;   			

		IF LENGTH(VS_VALUE41) > 0 THEN
			IF VS_VALUE41 = '00000000' THEN  
				VS_VALUE41 := NULL; 
			END IF;	
			IF LENGTH(VS_VALUE41) = 8 THEN	
				VS_VALUE41 := SUBSTRING(VS_VALUE41,1,4) || '-' || SUBSTRING(VS_VALUE41,5,2) || '-' || SUBSTRING(VS_VALUE41,7,2) ;
			END IF ; 			

			vs_field_name := 'parmilitaryenddate' ;
			BEGIN	 
				vd_date_check := VS_VALUE41::DATE;
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parmilitaryenddate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE41 := NULL;			
		END IF;  			
				
		IF LENGTH(VS_VALUE45) > 0 THEN
			VS_VALUE45 := SUBSTRING(VS_VALUE45,1,LENGTH(VS_VALUE45) - 2) || '.' || SUBSTRING(VS_VALUE45,LENGTH(VS_VALUE45) - 1,2) ;
			vs_field_name := 'parsolastpayamount' ;
			BEGIN                        
				vdec_decimal_check = VS_VALUE45::DECIMAL(10,2);

				EXCEPTION WHEN OTHERS THEN 
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parsolastpayamount';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE45 := NULL ;
		END IF;			
			
		IF LENGTH(VS_VALUE46) > 0 THEN
			IF VS_VALUE46 = '00000000' THEN 
				VS_VALUE46 := NULL ; 
			END IF;	

			IF LENGTH(VS_VALUE46) = 8 THEN	
				VS_VALUE46 := SUBSTRING(VS_VALUE46,1,4) || '-' || SUBSTRING(VS_VALUE46,5,2) || '-' || SUBSTRING(VS_VALUE46,7,2) ;
			END IF ; 			

			vs_field_name := 'parsolastpaydate' ;
			BEGIN	 
				vd_date_check := VS_VALUE46::DATE;
				EXCEPTION WHEN OTHERS THEN 
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_ERROR_DESC := 'Batch Line Has Invalid Data For parsolastpaydate';
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
		ELSE
			VS_VALUE46 := NULL;			
		END IF;  			
			
		IF VS_VALUE15 IS NULL OR  VS_VALUE15 = '' OR LENGTH(VS_VALUE15) <= 0 THEN  
			VS_VALUE15 := NULL; 
		END IF;

		IF VS_VALUE24 IS NULL OR  VS_VALUE24 = '' OR LENGTH(VS_VALUE24) <= 0 THEN  
			VS_VALUE24 := NULL; 
		END IF;
		
		IF VS_VALUE33 IS NULL OR  VS_VALUE33 = '' OR LENGTH(VS_VALUE33) <= 0 THEN  
			VS_VALUE33 := NULL; 
		END IF; 			
		
		IF EXISTS(	SELECT 1 FROM csesclientparent ccp , person p
					WHERE SUBSTR('0000000000',1,10 - LENGTH(LTRIM(RTRIM(ccp.old_id)))) || LTRIM(RTRIM(ccp.old_id)) 
							= SUBSTR('0000000000',1,10 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID)) 
						AND p.CJAMSPID = vl_client_id
						AND SUBSTR('0000000000',1,10 - LENGTH(LTRIM(RTRIM(ccp.cisparentclientid)))) || LTRIM(RTRIM(ccp.cisparentclientid)) = SUBSTR('0000000000',1,10 - LENGTH(LTRIM(RTRIM(VS_VALUE1)))) || LTRIM(RTRIM(VS_VALUE1)) 
						AND ccp.activeflag = 1)   THEN
			BEGIN
				UPDATE csesclientparent ccp 
					SET ccp.activeflag = 0,
					updatedon = CURRENT_TIMESTAMP,
					updatedby = VS_BATCH_USER
				WHERE 	SUBSTR('0000000000',1,10 - LENGTH(LTRIM(RTRIM(ccp.old_id)))) || LTRIM(RTRIM(ccp.old_id)) 
					= SUBSTR('0000000000',1,10 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID))
				AND SUBSTR('0000000000',1,10 - LENGTH(LTRIM(RTRIM(ccp.cisparentclientid)))) || LTRIM(RTRIM(ccp.cisparentclientid)) 
					= SUBSTR('0000000000',1,10 - LENGTH(LTRIM(RTRIM(VS_VALUE1)))) || LTRIM(RTRIM(VS_VALUE1))
				AND p.CJAMSPID = vl_client_id 
				AND ccp.activeflag = 1;

				EXCEPTION WHEN OTHERS THEN 
					VS_MESSAGE := 'DELETE OF csesclientparent FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID || '  AND ccp.old_id:'||vl_client_id::VARCHAR   || SQLERRM;
					VS_ERROR_DESC :='DELETE OF csesclientparent FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID || '  AND ccp.old_id:'||vl_client_id::VARCHAR   || SQLERRM;
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;	
			
			BEGIN
				INSERT INTO csesclientparent
				(	old_id,
					cisparentclientid,
					parrelationshiptypekey,
					parlegalesttypekey,
					parlegalestdate,
					parlastname,
					parfirstname,
					parmiddlename,
					parsuffix,
					parssn,
					pargendertypekey,
					pardob,
					parracetypekey,
					parlastaddressline1,
					parlastaddressline2,
					parlastaddresscity,
					parlastaddressstate,
					parlastaddresszip,
					parlastphonenumber,
					parlastaddressdate,
					pardateofdeath,
					parcuremp1name,
					parcuremp1addressline1,
					parcuremp1addressline2,
					parcuremp1addresscity,
					parcuremp1addressstate,
					parcuremp1addresszip,
					parcuremp1phoneno,
					parcuremp1startdate,
					parcuremp1enddate,
					parcuremp2name,
					parcuremp2addressline1,
					parcuremp2addressline2,
					parcuremp2addresscity,
					parcuremp2addressstate,
					parcuremp2addresszip,
					parcuremp2phoneno,
					parcuremp2startdate,
					parcuremp2enddate,
					parmedinsuranceflag,
					parmilitarystartdate,
					parmilitaryenddate,
					parmilitarybranchtypekey,
					parsoflag,
					parsonumber,
					parsolastpayamount,
					parsolastpaydate,
					parsolastpaymethodtypekey, 		
					insertedby,
					insertedon,
					updatedby,
					updatedon,
					activeflag,
					personid
				)
				SELECT VS_CIS_CLIENT_ID,
					VS_VALUE1,
					CASE WHEN VS_VALUE2 = 'AP' THEN '10308'
						WHEN VS_VALUE2 = 'BR' THEN '10309'
						WHEN VS_VALUE2 = 'CP' THEN '10310'
						WHEN VS_VALUE2 = 'CS' THEN '10311'
						WHEN VS_VALUE2 = 'CU' THEN '10312'
						WHEN VS_VALUE2 = 'DA' THEN '10313'
						WHEN VS_VALUE2 = 'FC' THEN '10314'
						WHEN VS_VALUE2 = 'GG' THEN '10315'
						WHEN VS_VALUE2 = 'GR' THEN '10316'
						WHEN VS_VALUE2 = 'NA' THEN '10317'
						WHEN VS_VALUE2 = 'NC' THEN '10318'
						WHEN VS_VALUE2 = 'NE' THEN '10319'
						WHEN VS_VALUE2 = 'NI' THEN '10320'
						WHEN VS_VALUE2 = 'NP' THEN '10321'
						WHEN VS_VALUE2 = 'RE' THEN '10322'
						WHEN VS_VALUE2 = 'SI' THEN '10323'
						WHEN VS_VALUE2 = 'SO' THEN '10324'
						WHEN VS_VALUE2 = 'ST' THEN '10325'
						ELSE VS_VALUE2
					END,
					CASE WHEN VS_VALUE3 = 'AV' THEN '10282'
						WHEN VS_VALUE3 = 'CE' THEN '10283'
						WHEN VS_VALUE3 = 'MC' THEN '10284'
						WHEN VS_VALUE3 = 'MD' THEN '10285'
						WHEN VS_VALUE3 = 'MS' THEN '10286'
						WHEN VS_VALUE3 = 'PX' THEN '10287'
						WHEN VS_VALUE3 = 'RE' THEN '10288'
						WHEN VS_VALUE3 = 'UN' THEN '10289'
						ELSE VS_VALUE3
					END,
					CASE WHEN VS_VALUE4 IS NULL THEN NULL
						WHEN VS_VALUE4 = '' THEN NULL
						WHEN LENGTH(VS_VALUE4) <= 0 THEN NULL
						ELSE VS_VALUE4::DATE
					END,
					VS_VALUE5,
					VS_VALUE6,
					VS_VALUE7,
					VS_VALUE8,
					CASE WHEN VS_VALUE9 IS NULL THEN NULL
						WHEN VS_VALUE9 = '' THEN NULL
						WHEN LENGTH(VS_VALUE9) <= 0 THEN NULL
						ELSE VS_VALUE9::INTEGER
					END,
					CASE WHEN VS_VALUE10 = 'F' THEN '1281'
						WHEN VS_VALUE10 = 'M' THEN '1282'
						WHEN VS_VALUE10 = 'U' THEN '1283'
						ELSE VS_VALUE10
					END,
					CASE WHEN VS_VALUE11 IS NULL THEN NULL
						WHEN VS_VALUE11 = '' THEN NULL
						WHEN LENGTH(VS_VALUE11) <= 0 THEN NULL
						ELSE VS_VALUE11::DATE
					END,
					CASE WHEN VS_VALUE12 = 'B' THEN '1801'
						WHEN VS_VALUE12 = 'N' THEN '1803'
						WHEN VS_VALUE12 = 'H' THEN '    '
						WHEN VS_VALUE12 = 'C' THEN '1806'
						WHEN VS_VALUE12 = 'A' THEN '6310'
						WHEN VS_VALUE12 = 'P' THEN '1802'
						WHEN VS_VALUE12 = 'U' THEN '6312'
						ELSE VS_VALUE12
					END,
					VS_VALUE13,
					VS_VALUE14,
					VS_VALUE15,
					CASE WHEN VS_VALUE16 IS NULL THEN ' '
						WHEN VS_VALUE16 = '' THEN ' '
						WHEN LENGTH(VS_VALUE16) <= 0 THEN ' '
						ELSE VS_VALUE16
					END,
					CASE WHEN VS_VALUE17 IS NULL THEN ' '
						WHEN VS_VALUE17 = '' THEN ' '
						WHEN LENGTH(VS_VALUE17) <= 0 THEN ' '
						ELSE VS_VALUE17
					END,
					VS_VALUE18,
					CASE WHEN VS_VALUE19 IS NULL THEN NULL
						WHEN VS_VALUE19 = '' THEN NULL
						WHEN LENGTH(VS_VALUE19) <= 0 THEN NULL
						ELSE VS_VALUE19::DATE
					END,
					CASE WHEN VS_VALUE20 IS NULL THEN NULL
						WHEN VS_VALUE20 = '' THEN NULL
						WHEN LENGTH(VS_VALUE20) <= 0 THEN NULL
						ELSE VS_VALUE20::DATE
					END,
					VS_VALUE21,
					VS_VALUE22,
					VS_VALUE23,
					VS_VALUE24,
					CASE WHEN VS_VALUE25 IS NULL THEN ' '
						WHEN VS_VALUE25 = '' THEN ' '
						WHEN LENGTH(VS_VALUE25) <= 0 THEN ' '
						ELSE VS_VALUE25
					END,
					CASE WHEN VS_VALUE26 IS NULL THEN ' '
						WHEN VS_VALUE26 = '' THEN ' '
						WHEN LENGTH(VS_VALUE26) <= 0 THEN ' '
						ELSE VS_VALUE26
					END,   				
					VS_VALUE27,
					CASE WHEN VS_VALUE28 IS NULL THEN NULL
						WHEN VS_VALUE28 = '' THEN NULL
						WHEN LENGTH(VS_VALUE28) <= 0 THEN NULL
						ELSE DATE(VS_VALUE28)
					END,
					CASE WHEN VS_VALUE29 IS NULL THEN NULL
						WHEN VS_VALUE29 = '' THEN NULL
						WHEN LENGTH(VS_VALUE29) <= 0 THEN NULL
						ELSE VS_VALUE29::DATE
					END,
					VS_VALUE30,
					VS_VALUE31,
					VS_VALUE32,
					VS_VALUE33,
					CASE WHEN VS_VALUE34 IS NULL THEN ' '
						WHEN VS_VALUE34 = '' THEN ' '
						WHEN LENGTH(VS_VALUE34) <= 0 THEN ' '
						ELSE VS_VALUE34
					END,
					CASE WHEN VS_VALUE35 IS NULL THEN ' '
						WHEN VS_VALUE35 = '' THEN ' '
						WHEN LENGTH(VS_VALUE35) <= 0 THEN ' '
						ELSE VS_VALUE35
					END,   				
					VS_VALUE36,
					CASE WHEN VS_VALUE37 IS NULL THEN NULL
						WHEN VS_VALUE37 = '' THEN NULL
						WHEN LENGTH(VS_VALUE37) <= 0 THEN NULL
						ELSE VS_VALUE37::DATE
					END,
					CASE WHEN VS_VALUE38 IS NULL THEN NULL
						WHEN VS_VALUE38 = '' THEN NULL
						WHEN LENGTH(VS_VALUE38) <= 0 THEN NULL
						ELSE VS_VALUE38::DATE
					END,
					VS_VALUE39 ::integer ,				
						CASE WHEN VS_VALUE40 IS NULL THEN NULL
						WHEN VS_VALUE40 = '' THEN NULL
						WHEN LENGTH(VS_VALUE40) <= 0 THEN NULL
						ELSE DATE(VS_VALUE40)
					END,
					CASE WHEN VS_VALUE41 IS NULL THEN NULL
						WHEN VS_VALUE41 = '' THEN NULL
						WHEN LENGTH(VS_VALUE41) <= 0 THEN NULL
						ELSE VS_VALUE41::DATE
					END,			
					CASE WHEN VS_VALUE42 = 'A' THEN '1587'
						WHEN VS_VALUE42 = 'C' THEN '1588'
						WHEN VS_VALUE42 = 'F' THEN '1586'
						WHEN VS_VALUE42 = 'G' THEN '7824'
						WHEN VS_VALUE42 = 'M' THEN '1589'
						WHEN VS_VALUE42 = 'N' THEN '1590'
						ELSE VS_VALUE42
					END,
					VS_VALUE43 ::integer ,
					VS_VALUE44,
					CASE WHEN VS_VALUE45 IS NULL THEN NULL
						WHEN VS_VALUE45 = '' THEN NULL
						WHEN LENGTH(VS_VALUE45) <= 0 THEN NULL
						ELSE VS_VALUE45::DECIMAL(10,2)
					END,
					CASE WHEN VS_VALUE46 IS NULL THEN NULL
						WHEN VS_VALUE46 = '' THEN NULL
						WHEN LENGTH(VS_VALUE46) <= 0 THEN NULL
						ELSE VS_VALUE46::DATE
					END,
					CASE WHEN VS_VALUE47 = 'A' THEN '10290'
						WHEN VS_VALUE47 = 'B' THEN '10291'
						WHEN VS_VALUE47 = 'C' THEN '10292'
						WHEN VS_VALUE47 = 'F' THEN '10293'
						WHEN VS_VALUE47 = 'G' THEN '10294'
						WHEN VS_VALUE47 = 'I' THEN '10295'
						WHEN VS_VALUE47 = 'J' THEN '10296'
						WHEN VS_VALUE47 = 'L' THEN '10297'
						WHEN VS_VALUE47 = 'M' THEN '10298'
						WHEN VS_VALUE47 = 'O' THEN '10299'
						WHEN VS_VALUE47 = 'P' THEN '10300'
						WHEN VS_VALUE47 = 'R' THEN '10301'
						WHEN VS_VALUE47 = 'S' THEN '10302'
						WHEN VS_VALUE47 = 'U' THEN '10303'
						WHEN VS_VALUE47 = 'W' THEN '10304'
						WHEN VS_VALUE47 = 'X' THEN '10305'
						WHEN VS_VALUE47 = 'Y' THEN '10306'
						WHEN VS_VALUE47 = 'Z' THEN '10307'
						ELSE VS_VALUE47
					END,
					VS_BATCH_USER,
					CURRENT_TIMESTAMP,
					VS_BATCH_USER,
					CURRENT_TIMESTAMP,
					1,
					vl_person_id
				;	

				EXCEPTION WHEN OTHERS THEN 
					VL_OUTPUT_SQLCODE := '504';
					VS_ERROR_CODE := '504';
					VS_MESSAGE := 'INSERT INTO csesclientparent FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID || ' AND old_id:'|| VS_VALUE1 || ' AND cjamspid:'||vl_client_id::VARCHAR   || SQLERRM ;
					VS_ERROR_DESC := 'INSERT INTO csesclientparent FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID || ' AND old_id:'|| VS_VALUE1 || ' AND cjamspid:'||vl_client_id::VARCHAR    || SQLERRM;--
					VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
					RETURN  ;
			END ;					
		ELSE
			BEGIN
				INSERT INTO csesclientparent
				(	old_id,
					cisclientid,
					parrelationshiptypekey,
					parlegalesttypekey,
					parlegalestdate,
					parlastname,
					parfirstname,
					parmiddlename,
					parsuffix,
					parssn,
					pargendertypekey,
					pardob,
					parracetypekey,
					parlastaddressline1,
					parlastaddressline2,
					parlastaddresscity,
					parlastaddressstate,
					parlastaddresszip,
					parlastphonenumber,
					parlastaddressdate,
					pardateofdeath,
					parcuremp1name,
					parcuremp1addressline1,
					parcuremp1addressline2,
					parcuremp1addresscity,
					parcuremp1addressstate,
					parcuremp1addresszip,
					parcuremp1phoneno,
					parcuremp1startdate,
					parcuremp1enddate,
					parcuremp2name,
					parcuremp2addressline1,
					parcuremp2addressline2,
					parcuremp2addresscity,
					parcuremp2addressstate,
					parcuremp2addresszip,
					parcuremp2phoneno,
					parcuremp2startdate,
					parcuremp2enddate,
					parmedinsuranceflag,
					parmilitarystartdate,
					parmilitaryenddate,
					parmilitarybranchtypekey,
					parsoflag,
					parsonumber,
					parsolastpayamount,
					parsolastpaydate,
					parsolastpaymethodtypekey, 		
					insertedby,
					insertedon,
					updatedby,
					updatedon,
					activeflag,
					personid
				)
				SELECT VS_VALUE1,
					VS_CIS_CLIENT_ID,
					CASE WHEN VS_VALUE2 = 'AP' THEN '10308'
						WHEN VS_VALUE2 = 'BR' THEN '10309'
						WHEN VS_VALUE2 = 'CP' THEN '10310'
						WHEN VS_VALUE2 = 'CS' THEN '10311'
						WHEN VS_VALUE2 = 'CU' THEN '10312'
						WHEN VS_VALUE2 = 'DA' THEN '10313'
						WHEN VS_VALUE2 = 'FC' THEN '10314'
						WHEN VS_VALUE2 = 'GG' THEN '10315'
						WHEN VS_VALUE2 = 'GR' THEN '10316'
						WHEN VS_VALUE2 = 'NA' THEN '10317'
						WHEN VS_VALUE2 = 'NC' THEN '10318'
						WHEN VS_VALUE2 = 'NE' THEN '10319'
						WHEN VS_VALUE2 = 'NI' THEN '10320'
						WHEN VS_VALUE2 = 'NP' THEN '10321'
						WHEN VS_VALUE2 = 'RE' THEN '10322'
						WHEN VS_VALUE2 = 'SI' THEN '10323'
						WHEN VS_VALUE2 = 'SO' THEN '10324'
						WHEN VS_VALUE2 = 'ST' THEN '10325'
						ELSE VS_VALUE2
					END,
					CASE WHEN VS_VALUE3 = 'AV' THEN '10282'
						WHEN VS_VALUE3 = 'CE' THEN '10283'
						WHEN VS_VALUE3 = 'MC' THEN '10284'
						WHEN VS_VALUE3 = 'MD' THEN '10285'
						WHEN VS_VALUE3 = 'MS' THEN '10286'
						WHEN VS_VALUE3 = 'PX' THEN '10287'
						WHEN VS_VALUE3 = 'RE' THEN '10288'
						WHEN VS_VALUE3 = 'UN' THEN '10289'
						ELSE VS_VALUE3
					END,
					CASE WHEN VS_VALUE4 IS NULL THEN NULL
						WHEN VS_VALUE4 = '' THEN NULL
						WHEN LENGTH(VS_VALUE4) <= 0 THEN NULL
						ELSE VS_VALUE4::DATE
					END,
					VS_VALUE5,
					VS_VALUE6,
					VS_VALUE7,
					VS_VALUE8,
					CASE WHEN VS_VALUE9 IS NULL THEN NULL
						WHEN VS_VALUE9 = '' THEN NULL
						WHEN LENGTH(VS_VALUE9) <= 0 THEN NULL
						ELSE VS_VALUE9::INTEGER
					END,
					CASE WHEN VS_VALUE10 = 'F' THEN '1281'
						WHEN VS_VALUE10 = 'M' THEN '1282'
						WHEN VS_VALUE10 = 'U' THEN '1283'
						ELSE VS_VALUE10
					END,
					CASE WHEN VS_VALUE11 IS NULL THEN NULL
						WHEN VS_VALUE11 = '' THEN NULL
						WHEN LENGTH(VS_VALUE11) <= 0 THEN NULL
						ELSE VS_VALUE11::DATE
					END,
					CASE WHEN VS_VALUE12 = 'B' THEN '1801'
						WHEN VS_VALUE12 = 'N' THEN '1803'
						WHEN VS_VALUE12 = 'H' THEN '    '
						WHEN VS_VALUE12 = 'C' THEN '1806'
						WHEN VS_VALUE12 = 'A' THEN '6310'
						WHEN VS_VALUE12 = 'P' THEN '1802'
						WHEN VS_VALUE12 = 'U' THEN '6312'
						ELSE VS_VALUE12
					END,
					VS_VALUE13,
					VS_VALUE14,
					VS_VALUE15,
					CASE WHEN VS_VALUE16 IS NULL THEN ' '
						WHEN VS_VALUE16 = '' THEN ' '
						WHEN LENGTH(VS_VALUE16) <= 0 THEN ' '
						ELSE VS_VALUE16
					END,
					CASE WHEN VS_VALUE17 IS NULL THEN ' '
						WHEN VS_VALUE17 = '' THEN ' '
						WHEN LENGTH(VS_VALUE17) <= 0 THEN ' '
						ELSE VS_VALUE17
					END,
					VS_VALUE18,
					CASE WHEN VS_VALUE19 IS NULL THEN NULL
						WHEN VS_VALUE19 = '' THEN NULL
						WHEN LENGTH(VS_VALUE19) <= 0 THEN NULL
						ELSE VS_VALUE19::DATE
					END,
					CASE WHEN VS_VALUE20 IS NULL THEN NULL
						WHEN VS_VALUE20 = '' THEN NULL
						WHEN LENGTH(VS_VALUE20) <= 0 THEN NULL
						ELSE VS_VALUE20::DATE
					END,
					VS_VALUE21,
					VS_VALUE22,
					VS_VALUE23,
					VS_VALUE24,
					CASE WHEN VS_VALUE25 IS NULL THEN ' '
						WHEN VS_VALUE25 = '' THEN ' '
						WHEN LENGTH(VS_VALUE25) <= 0 THEN ' '
						ELSE VS_VALUE25
					END,
					CASE WHEN VS_VALUE26 IS NULL THEN ' '
						WHEN VS_VALUE26 = '' THEN ' '
						WHEN LENGTH(VS_VALUE26) <= 0 THEN ' '
						ELSE VS_VALUE26
					END,   				
					VS_VALUE27,
					CASE WHEN VS_VALUE28 IS NULL THEN NULL
						WHEN VS_VALUE28 = '' THEN NULL
						WHEN LENGTH(VS_VALUE28) <= 0 THEN NULL
						ELSE VS_VALUE28::DATE
					END,
					CASE WHEN VS_VALUE29 IS NULL THEN NULL
						WHEN VS_VALUE29 = '' THEN NULL
						WHEN LENGTH(VS_VALUE29) <= 0 THEN NULL
						ELSE VS_VALUE29::DATE
					END,
					VS_VALUE30,
					VS_VALUE31,
					VS_VALUE32,
					VS_VALUE33,
					CASE WHEN VS_VALUE34 IS NULL THEN ' '
						WHEN VS_VALUE34 = '' THEN ' '
						WHEN LENGTH(VS_VALUE34) <= 0 THEN ' '
						ELSE VS_VALUE34
					END,
					CASE WHEN VS_VALUE35 IS NULL THEN ' '
						WHEN VS_VALUE35 = '' THEN ' '
						WHEN LENGTH(VS_VALUE35) <= 0 THEN ' '
						ELSE VS_VALUE35
					END,    				
					VS_VALUE36,
					CASE WHEN VS_VALUE37 IS NULL THEN NULL
						WHEN VS_VALUE37 = '' THEN NULL
						WHEN LENGTH(VS_VALUE37) <= 0 THEN NULL
						ELSE VS_VALUE37::DATE
					END,
					CASE WHEN VS_VALUE38 IS NULL THEN NULL
						WHEN VS_VALUE38 = '' THEN NULL
						WHEN LENGTH(VS_VALUE38) <= 0 THEN NULL
						ELSE VS_VALUE38::DATE
					END,
					CASE WHEN VS_VALUE39 = 'N' THEN 1
						WHEN VS_VALUE39 = 'Y' THEN 0
					END,			
					CASE WHEN VS_VALUE40 IS NULL THEN NULL
						WHEN VS_VALUE40 = '' THEN NULL
						WHEN LENGTH(VS_VALUE40) <= 0 THEN NULL
						ELSE VS_VALUE40::DATE
					END,
					CASE WHEN VS_VALUE41 IS NULL THEN NULL
						WHEN VS_VALUE41 = '' THEN NULL
						WHEN LENGTH(VS_VALUE41) <= 0 THEN NULL
						ELSE VS_VALUE41::DATE
					END,			
					CASE WHEN VS_VALUE42 = 'A' THEN '1587'
						WHEN VS_VALUE42 = 'C' THEN '1588'
						WHEN VS_VALUE42 = 'F' THEN '1586'
						WHEN VS_VALUE42 = 'G' THEN '7824'
						WHEN VS_VALUE42 = 'M' THEN '1589'
						WHEN VS_VALUE42 = 'N' THEN '1590'
						ELSE VS_VALUE42
					END,
					CASE WHEN VS_VALUE43 = 'N' THEN 1
						WHEN VS_VALUE43 = 'Y' THEN 0
					END,			
					VS_VALUE44,
					CASE WHEN VS_VALUE45 IS NULL THEN NULL
						WHEN VS_VALUE45 = '' THEN NULL
						WHEN LENGTH(VS_VALUE45) <= 0 THEN NULL
						ELSE VS_VALUE45::DECIMAL(10,2)
					END,
				CASE WHEN VS_VALUE46 IS NULL THEN NULL
					WHEN VS_VALUE46 = '' THEN NULL
					WHEN LENGTH(VS_VALUE46) <= 0 THEN NULL
					ELSE VS_VALUE46::DATE
				END,
				CASE WHEN VS_VALUE47 = 'A' THEN '10290'
					WHEN VS_VALUE47 = 'B' THEN '10291'
					WHEN VS_VALUE47 = 'C' THEN '10292'
					WHEN VS_VALUE47 = 'F' THEN '10293'
					WHEN VS_VALUE47 = 'G' THEN '10294'
					WHEN VS_VALUE47 = 'I' THEN '10295'
					WHEN VS_VALUE47 = 'J' THEN '10296'
					WHEN VS_VALUE47 = 'L' THEN '10297'
					WHEN VS_VALUE47 = 'M' THEN '10298'
					WHEN VS_VALUE47 = 'O' THEN '10299'
					WHEN VS_VALUE47 = 'P' THEN '10300'
					WHEN VS_VALUE47 = 'R' THEN '10301'
					WHEN VS_VALUE47 = 'S' THEN '10302'
					WHEN VS_VALUE47 = 'U' THEN '10303'
					WHEN VS_VALUE47 = 'W' THEN '10304'
					WHEN VS_VALUE47 = 'X' THEN '10305'
					WHEN VS_VALUE47 = 'Y' THEN '10306'
					WHEN VS_VALUE47 = 'Z' THEN '10307'
					ELSE VS_VALUE47
				END,
				VS_BATCH_USER,
				CURRENT_TIMESTAMP,
				VS_BATCH_USER,
				CURRENT_TIMESTAMP,
				1,
				vl_person_id
			;	

			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE := '504';
				VS_ERROR_CODE := '504';
				VS_MESSAGE := 'INSERT INTO csesclientparent FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID || ' AND old_id:'|| VS_VALUE1 || ' AND cjamspid:'||vl_client_id::VARCHAR    || SQLERRM;
				VS_ERROR_DESC := 'INSERT INTO csesclientparent FAILED FOR cisclientid:'||VS_CIS_CLIENT_ID || ' AND old_id:'|| VS_VALUE1 || ' AND cjamspid:'||vl_client_id::VARCHAR    || SQLERRM;
				VS_MESSAGE := 'THE RUN WAS UNSUCCESSFUL';
				RETURN  ;
			END ;			
		END IF;	
    END IF; -- '21' - END					

	-- Success.
	--COMMIT;--
	 VL_OUTPUT_SQLCODE := '00000';
	 VS_ERROR_CODE := '000';
	 VS_ERROR_DESC := 'No error found';
	 VS_MESSAGE := 'THE RUN WAS SUCCESSFUL';
	
	RETURN ;

END ;

$function$
;
