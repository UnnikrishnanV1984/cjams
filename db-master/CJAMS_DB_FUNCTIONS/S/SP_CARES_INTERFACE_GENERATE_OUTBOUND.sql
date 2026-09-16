-- DROP FUNCTION cjams.sp_cares_interface_generate_outbound(character varying, character varying,);--

CREATE OR REPLACE FUNCTION cjams.sp_cares_interface_generate_outbound(OUT vs_message character varying, OUT vl_output_sqlcode character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Ravali
-- Date Created : 01/11/2019
-- revision : 	  06/26/2019 commented with tag #26062019 Ram Kumar 
-- generates Cares Interface Outbound
-- REVISION : Sandhya   05/22/2006  #7618
-- 02/09/2007 - Sandhya - #12329   Added condition for transaction type = '15' (Subsidy Guardianship)
-- 02/16/2007 - Sandhya - #12329  added a flag variable to do the process accordingly.
-- 04/16/2007 - sandhya - #12463 - Commented code (as per specs) for when client is not registered in CIS - subsidy guardianship
-- 09/10/2012 Vineet Tirodkar PRJ-02667 - MD CHESSIE Batch Process Redesign - To change Return 0 on success
------------------------------------------------------------------------
	-- VARIABLE DECLARATION
	DECLARE 
	vts_previous_run_ts         	timestamp;--
	vts_current_run_ts          	timestamp;--
--	DECLARE VL_ROWCOUNT 			INTEGER 		DEFAULT 0;--
--	DECLARE VL_INTERFACE_ROWCOUNT 	INTEGER 		DEFAULT 0;--
	VL_TRIGGER_ROWCOUNT         	INTEGER     	DEFAULT 0;--
	VL_TRANSACTION_SEQUENCE 		INTEGER 		DEFAULT 0;--
	VL_RECORD_SEQUENCE 				INTEGER 		DEFAULT 000;--
	VL_CASE_ID 						BIGINT;-- CHANGED FROM VARCHAR 
	VL_CLIENT_ID 					INTEGER;--
	VL_CASE_CLIENT_ID 				INTEGER;--
	VS_TRANSACTION_TYPE_CD 			VARCHAR(2);--
	VS_BATCH_SEQ_NO 				VARCHAR(5);--
	VL_CIS_CLIENT_ROWCOUNT 			INTEGER 		DEFAULT 0;--
	VL_CIS_CASE_CLIENT_ROWCOUNT 	INTEGER 		DEFAULT 0;--
	VS_RECORD_TYPE_CD 				VARCHAR(2);--
	VD_TRANSACTION_TS 				TIMESTAMP;--
	VL_PARENT_EXISTS 				INTEGER 		DEFAULT 0;--
	VL_PAYMENT_MAINTENANCE 			INTEGER 		DEFAULT 0;--
	VDEC_PAYMENT_AMOUNT 			DECIMAL(10,2);--
	VDEC_PAYMENT_PREVIOUS_AMOUNT 	DECIMAL(10,2);--
	VL_PLACEMENT_EXISTS 			INTEGER 		DEFAULT 0;--
	VL_PLACEMENT_END_DATED_EXISTS 	INTEGER 		DEFAULT 0;--
	VS_NULL 						VARCHAR(10);--
	VS_INTERFACE_PROCESSED_FLAG 	CHAR(1) 		DEFAULT 'N';--
	vl_case_client_count 			integer 		default 0;--
	vl_trigger_outbound_count 		integer 		default 0;--
	VL_INTERFACES_ERROR_LOG_ID 		INTEGER 		DEFAULT 0;--
	VS_PROCESS_FLAG 				VARCHAR(1) 		DEFAULT  'N';--
	VL_CASE_PERSON_ID  				UUID;
	ERROR_EXE_FLAG 					INTEGER;
	ERROR_FLAG 						INTEGER;
	
	VL_SERVICECASENUMBER			VARCHAR			DEFAULT NULL; -- NEW VARIABLE TO FETCH SERVICECASE NUMBER FROM PAYMENT_ID
	VL_ADOPTIONCASENUMBER			VARCHAR			DEFAULT NULL;-- NEW VARIABLE 


--- DECLARE MAIN CURSOR FROM TRIGGER_OUTBOUND TABLE
	DECLARE TRIGGER_OUTBOUND CURSOR  FOR
	SELECT 	old_id, fk_id, transactiontypekey, transactionon
	FROM 	caresoutboundtrigger
	WHERE 	statusflag = 'N'	AND activeflag = 1
	ORDER BY transactionon ASC
	FOR UPDATE;--

-- DECLARE CURSOR FOR CASE_CLIENT	
	DECLARE CASE_CLIENT CURSOR FOR
	SELECT 	P.cjamspid, p.personid
	FROM 	intakeservicerequestactor A, 
			person P, 
			intakeservicerequest C, 
			--intakeservicerequestactor TA, 
			servicecase SC
	WHERE 	A.personid = P.personid
			and A.intakeserviceid = C.intakeserviceid
			and C.servicecaseid = SC.servicecaseid
			and SC.servicecasenumber = VL_CASE_ID
			and A.personid = P.personid
			--and A.actorid = TA.actorid
			and A.intakeservicerequestpersontypekey = 'CHILD'
			AND A.activeflag = 1 
			and C.activeflag = 1
			and P.activeflag = 1 AND
			EXISTS (	SELECT 1 
						FROM 	TB_PLACEMENT TBP
						WHERE  	TBP.client_id = P.cjamspid
								AND TBP.EXIT_DT IS NULL 
								AND TBP.ENTRY_DT IS NOT NULL
								AND TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
								AND TBP.APPROVAL_STATUS_CD = '3047' 
								AND TBP.DELETE_SW = 'N' );

BEGIN

	VL_OUTPUT_SQLCODE:=	'00000';
	ERROR_EXE_FLAG := 	0;
	
	vts_previous_run_ts	:= CURRENT_TIMESTAMP;--
	vts_current_run_ts	:= CURRENT_TIMESTAMP;--

	
--  IF FIRST RUN, i.e. NO ROWS IN RUNTIMES_LOG, THEN LEAVE AS INITIALIZED
--	table changed to interfacesruntimeslog and column to interfaceid #26062019

	IF EXISTS(SELECT 1 FROM cjams.interfacesruntimeslog) THEN
		BEGIN	
                SELECT 	MAX(currentruntimestamp) --- changed from current_ts #28/06/2019 
				INTO 	vts_previous_run_ts 
				FROM 	cjams.interfacesruntimeslog
                WHERE 	interfaceid = 'CARES_OUTBOUND';--
		
			EXCEPTION WHEN OTHERS THEN 
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
				VS_MESSAGE := 'SELECT MAX(currentruntimestamp) FAILED';--
		END;
             
	END IF;-- 


	BEGIN	
-- CHECK FOR ROWS TO INTERFACE, IF NONE THEN QUIT.

		IF EXISTS (SELECT 1 FROM cjams.caresoutboundtrigger) THEN
		--ITERATE
		ELSE
			VS_MESSAGE := 'THERE ARE NO ROWS TO INTERFACE'  ;--
			ERROR_EXE_FLAG := -1;
		END IF;--
		EXCEPTION WHEN OTHERS THEN 
			VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
			VS_MESSAGE := 'SELECT caresoutboundtrigger FAILED'  ;--
	END;
	
	                                 	
-- DELETE RECORDS IN CARES INTERFACE TABLE

	IF EXISTS(	SELECT 1 FROM cjams.TB_CARES_OUTBOUND_INTERFACE) AND ERROR_EXE_FLAG <>-1 THEN

		BEGIN		
                DELETE FROM CJAMS.TB_CARES_OUTBOUND_INTERFACE  ;--
			
			EXCEPTION WHEN OTHERS THEN 
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
				VS_MESSAGE := 'DELETE FROM CJAMS.TB_CARES_OUTBOUND_INTERFACE FAILED'  ;--
		END;
	END IF;--

-- COUNT ROWS IN TRIGGER_OUTBOUND TO LOOP IN CURSOR

    SELECT 	count(*) 
	INTO 	vl_trigger_outbound_count 
	FROM 	cjams.caresoutboundtrigger
    WHERE 	statusflag = 'N' AND activeflag = 1   ;--

-- OPEN MAIN CURSOR

    OPEN TRIGGER_OUTBOUND;--
    <<TRIG_OUTBOUND>>
    
    LOOP 
	
		IF ERROR_EXE_FLAG = -1 THEN
		
-- ADD RECORD TO ERROR INTERFACE LOG

	/*  SELECT NEXTVAL('SQ_INTERFACES_ERROR_LOG')
        INTO VL_INTERFACES_ERROR_LOG_ID;*/
     
			
        INSERT INTO CJAMS.interfaceserrorlog (	interfaceid,
												currentruntimestamp,
												batchnumber,
												errorlineno,
												errordescription,
												errorsqlcode,
												--payment_id,
												old_id, --provider_id,
												county_cd,
												--client_id,
												insertedon)
												
		VALUES 								(	'CARES_OUTBOUND_TEST',
                                                CURRENT_TIMESTAMP,
												'000',
                                                0,
                                                VS_MESSAGE || ' VL_client_id ' || VL_client_id::varchar || ' VL_CASE_CLIENT_ID ' || VL_CASE_CLIENT_ID,
                                                VL_OUTPUT_SQLCODE,
												--VL_CASE_CLIENT_ID,
                                                VL_CASE_ID:: varchar,
                                                '15',
                                                --VL_client_id::Bigint , ---- #26062019 type cast -- table data type needs to be changed to bigint 
                                                CURRENT_DATE);	
												
       /* INSERT INTO TB_INTERFACES_ERROR_LOG(ERROR_ID,
                        INTERFACE_TX,
                        ERROR_TS,
                        BATCH_NO,
                        ERROR_LINE_NO,
                        ERROR_CODE,
                        ERROR_SQL_CODE,
                        ERROR_DESCRIPTION,
                        payment_id,
                        provider_id,
                        county_cd,
                        client_id)
                VALUES  (VL_INTERFACES_ERROR_LOG_ID ,
                        'CARES_OUTBOUND_TEST',
                        current_timestamp,
                        '000',
                        0,
                        '0',
                        VL_OUTPUT_SQLCODE,
                        VS_MESSAGE,
                        VL_CASE_CLIENT_ID,
                        VL_CASE_ID,
                        '15',
                        VL_client_id );--
   */
		-- a := vts_current_run_ts;--
	    -- b := vts_previous_run_ts;--
		
    RETURN ;
	END IF;

    IF 	VS_PROCESS_FLAG = 'Y' THEN               --02/16/2007  #12329
	
        VL_TRANSACTION_SEQUENCE := VL_TRANSACTION_SEQUENCE + 1 ;--
        
        BEGIN
			/* RAISE NOTICE 'Flag Y insert '; 
			RAISE NOTICE 'VL_CLIENT_ID %',VL_CLIENT_ID; 
			RAISE NOTICE 'VL_CASE_ID %',VL_CASE_ID; 
			RAISE NOTICE 'VS_TRANSACTION_TYPE_CD %',VS_TRANSACTION_TYPE_CD; 
			RAISE NOTICE 'VL_TRANSACTION_SEQUENCE %',VL_TRANSACTION_SEQUENCE; 
			RAISE NOTICE 'VD_TRANSACTION_TS %',VD_TRANSACTION_TS; 
			RAISE NOTICE 'VL_SERVICECASENUMBER %',VL_SERVICECASENUMBER; 
			RAISE NOTICE 'VL_ADOPTIONCASENUMBER %',VL_ADOPTIONCASENUMBER; 
			 */
				SELECT 	* 
				INTO 	VS_MESSAGE,VL_OUTPUT_SQLCODE 
                from    SP_CARES_OUTBOUND_INTERFACE_GEN_DATA(	VL_CLIENT_ID,
																VL_CASE_ID,
																VS_TRANSACTION_TYPE_CD::varchar,
																VL_TRANSACTION_SEQUENCE,
																VD_TRANSACTION_TS,
																VL_SERVICECASENUMBER, -- PASSING THE NEW VARIABLE 
																VL_ADOPTIONCASENUMBER
																);--

                EXCEPTION WHEN OTHERS THEN 
                         VL_OUTPUT_SQLCODE := SQLSTATE;--
						 VS_MESSAGE := 'FAILED TO GENERATE INTERFACE DATA FOR TRANSACTION_TYPE_CD at line 235:- ' ||SQLERRM||VS_TRANSACTION_TYPE_CD || ' AND CLIENT_ID:'||(VL_CLIENT_ID ::VARCHAR)  ;--
                         ERROR_EXE_FLAG := -1;
				CONTINUE TRIG_OUTBOUND;
		END;
						
                
        BEGIN 
        -- UPDATE STATUS
            UPDATE 	cjams.caresoutboundtrigger 
			SET 	statusflag = 'P'
            WHERE CURRENT OF TRIGGER_OUTBOUND;--
	
            EXCEPTION WHEN OTHERS THEN 
                         VL_OUTPUT_SQLCODE := SQLSTATE;--
                         VS_MESSAGE := 'UPDATE OF STATUS FAILED FOR  TABLE caresoutboundtrigger- ' ||SQLERRM  ;--
                         ERROR_EXE_FLAG := -1;
						 CONTINUE TRIG_OUTBOUND;
        END ;--
		VS_PROCESS_FLAG:='N';
    END IF;--

		
	/* 	DECLARE TRIGGER_OUTBOUND CURSOR  FOR
	SELECT old_id, fk_id, transactiontypekey, transactionon
	FROM caresoutboundtrigger
	WHERE statusflag = 'N'
	AND activeflag = 1
	ORDER BY transactionon ASC
	FOR UPDATE */
	
	FETCH 	TRIGGER_OUTBOUND 
	INTO 	VL_CASE_ID,--OLD ID 
			VL_CLIENT_ID,--FK_ID 
			VS_TRANSACTION_TYPE_CD, 
			VD_TRANSACTION_TS ;--
			
			
		/* 	
			RAISE NOTICE 'VL_CLIENT_ID %',VL_CLIENT_ID; 
			RAISE NOTICE 'VL_CASE_ID %',VL_CASE_ID; 
			RAISE NOTICE 'VS_TRANSACTION_TYPE_CD %',VS_TRANSACTION_TYPE_CD; 
			RAISE NOTICE 'VL_TRANSACTION_SEQUENCE %',VL_TRANSACTION_SEQUENCE;
	 */
	EXIT 	TRIG_OUTBOUND WHEN NOT FOUND;

---------- DETERMINE CIS_CLIENT EXISTS AND PLACEMENT (OPEN/ENDED) BOTH EXISTS -----------------
		         
	VL_PLACEMENT_EXISTS := 0 ;--
    VL_CIS_CLIENT_ROWCOUNT := 0 ;--
    VL_PLACEMENT_END_DATED_EXISTS := 0 ;--

                IF VL_CLIENT_ID > 0 THEN
				
                --COUNT CIS_CLIENT
                
						BEGIN
							SELECT 	COUNT(*) 
							INTO 	VL_CIS_CLIENT_ROWCOUNT 
							FROM 	person
							WHERE 	cjamspid = VL_CLIENT_ID AND 
									LENGTH(cisclientid) > 0 AND 
									activeflag = 1;--
									
						--	RAISE NOTICE 'VL_CIS_CLIENT_ROWCOUNT %',VL_CIS_CLIENT_ROWCOUNT;
	                    
						EXCEPTION WHEN OTHERS THEN 
							VL_OUTPUT_SQLCODE := SQLSTATE;--
							VS_MESSAGE := 'SELECT COUNT(*) FROM person FAILED FOR CLIENT_ID:- ' ||SQLERRM || (VL_CLIENT_ID ::VARCHAR)  ;--
							ERROR_EXE_FLAG := -1;
						CONTINUE TRIG_OUTBOUND;
                        END;

--COUNT PLACEMENT_OPEN+6
						BEGIN
							SELECT 	COUNT(*) 
							INTO 	VL_PLACEMENT_EXISTS 
							FROM 	Tb_placement A 
							WHERE 	A.CLIENT_ID = VL_CLIENT_ID
									AND A.EXIT_DT IS NULL 
									AND A.ENTRY_DT IS NOT NULL 
									AND A.PLACEMENT_STRUCTURE_ID IS NOT NULL
									AND A.APPROVAL_STATUS_CD = '3047' 
									AND A.DELETE_SW = 'N'  ;--
									
						--	RAISE NOTICE 'VL_PLACEMENT_EXISTS %',VL_PLACEMENT_EXISTS;
	
                        EXCEPTION WHEN OTHERS THEN 
							VL_OUTPUT_SQLCODE := SQLSTATE;--
							VS_MESSAGE :=  'SELECT COUNT(*) FROM TB_PLACEMENT FAILED FOR CLIENT_ID:- ' ||SQLERRM || (VL_CLIENT_ID ::VARCHAR)  ;--
							ERROR_EXE_FLAG := -1;
							CONTINUE TRIG_OUTBOUND;
                        END;
--COUNT PLACEMENT ENDED
                        BEGIN
							SELECT 	COUNT(*) 
							INTO 	VL_PLACEMENT_END_DATED_EXISTS 
							FROM 	TB_PLACEMENT A
							WHERE 	A.CLIENT_ID = VL_CLIENT_ID AND 
									A.EXIT_DT IS NOT NULL	AND 
									A.ENTRY_DT IS NOT NULL AND 
									A.PLACEMENT_STRUCTURE_ID IS NOT NULL AND 
									A.DELETE_SW = 'N'  ;--
									
						--	RAISE NOTICE 'VL_PLACEMENT_END_DATED_EXISTS %',VL_PLACEMENT_END_DATED_EXISTS;
	
                        EXCEPTION WHEN OTHERS THEN 
							VL_OUTPUT_SQLCODE := SQLSTATE;--
							VS_MESSAGE := 'SELECT COUNT(*) FOR END DATED PLACEMENT FROM placement FAILED FOR CLIENT_ID:- ' ||SQLERRM|| (VL_CLIENT_ID ::VARCHAR)  ;--
							ERROR_EXE_FLAG := -1;
							CONTINUE TRIG_OUTBOUND;
                        END;
						
						BEGIN
							
							select 	A.adoptioncasenumber 
							into 	VL_ADOPTIONCASENUMBER
							from  	adoptioncase A, 
									adoptioncaseactor B , 
									person C , 
									servicecase D , 
									intakeservicerequestactor E 
							where  	A.adoptioncaseid = B.adoptioncaseid and 
									B.personid = C.personid	and 
									D.servicecaseid = E.servicecaseid  and 
									E.personid = C.personid and 
									D.servicecasenumber = VL_CASE_ID::varchar;
									
								--	RAISE NOTICE 'VL_ADOPTIONCASENUMBER %',VL_ADOPTIONCASENUMBER;
									
							EXCEPTION WHEN OTHERS THEN 
								VL_OUTPUT_SQLCODE := SQLSTATE;--
								VS_MESSAGE := 'ADOPTION CASE NUMBER GENERATION FAILED FOR CLIENT_ID:- ' ||SQLERRM|| (VL_CLIENT_ID ::VARCHAR)  ;--
								ERROR_EXE_FLAG := -1;
							CONTINUE TRIG_OUTBOUND;
							
						END;

------- SUBSIDY GUARDIANSHIP ----------

                        IF 	VS_TRANSACTION_TYPE_CD = '15' THEN    						-- #12174
						
                                IF 	VL_CIS_CLIENT_ROWCOUNT <= 0 THEN                             -- UPDATE STATUS TO 'I'
                                    
									VS_PROCESS_FLAG := 'N';                              --02/16/2007  #12329
                                    CONTINUE TRIG_OUTBOUND;
                                       -- commneted as per specs - #12463
                                       -- UPDATE caresoutboundtrigger SET STATUS_SW = 'I' WHERE CURRENT OF TRIGGER_OUTBOUND;--
	
                                       -- SET VL_OUTPUT_SQLCODE = SQLCODE;--
                                       -- IF SQLCODE <> 0 AND (SQLSTATE <> '00000') THEN
                                       --         SET VS_MESSAGE = 'UPDATE OF STATUS FAILED FOR TABLE caresoutboundtrigger'  ;--
                                       --         GOTO ERROR_SECTION ;--
                                       -- END IF;--
                                ELSIF 
								
									EXISTS(	SELECT 	1 
											FROM 	TB_GUARDIAN_SUBSIDY A 
											WHERE 	A.CLIENT_ID = VL_CLIENT_ID
													AND A.SUBSIDY_START_DT IS NOT NULL 
													AND A.SUBSIDY_END_DT IS NOT NULL
													AND A.CHECK_LIST_APPROVAL_STATUS_CD = '3047' 
													AND A.SUSBSIDY_APPROVAL_STATUS_CD = '3047'
													AND A.DELETE_SW = 'N') THEN
                                        
										VS_PROCESS_FLAG := 'Y';                                       -- 02/16/2007  #12329
                                    CONTINUE TRIG_OUTBOUND;-- ****CALL GENDATA TO PROCESS AND CHANGE STATUS TO 'P'.
                                END IF;--
                        
						ELSIF 	VS_TRANSACTION_TYPE_CD IN ('10','70','20','40','50','62') THEN
						
                                IF (	VL_CIS_CLIENT_ROWCOUNT <= 0 OR (VL_PLACEMENT_EXISTS <= 0 AND VS_TRANSACTION_TYPE_CD <> '70')) THEN
                                       
										IF 	VL_PLACEMENT_EXISTS <= 0 AND VS_TRANSACTION_TYPE_CD <> '70' THEN        -- #12463
                                        
										-- UPDATE STATUS TO 'I'
                                                VS_PROCESS_FLAG := 'N';--
												
                                                BEGIN
													UPDATE 	caresoutboundtrigger 
													SET 	statusflag = 'I' 
													WHERE CURRENT OF TRIGGER_OUTBOUND;--
	
													EXCEPTION WHEN OTHERS THEN 
														VL_OUTPUT_SQLCODE := SQLSTATE;--
														VS_MESSAGE :=  'UPDATE OF STATUS FAILED FOR TABLE caresoutboundtrigger- ' ||SQLERRM  ;--
														ERROR_EXE_FLAG := -1;
													CONTINUE TRIG_OUTBOUND;
												END;
                                        END IF;--
										
                                ELSIF 	
										VL_CIS_CLIENT_ROWCOUNT > 0 AND 
										((VL_PLACEMENT_EXISTS > 0 AND VS_TRANSACTION_TYPE_CD <> '70') OR 
										(VL_PLACEMENT_END_DATED_EXISTS > 0 AND VS_TRANSACTION_TYPE_CD = '70')) THEN
                                        
										IF 	LENGTH	(VS_TRANSACTION_TYPE_CD) > 0 THEN
                                                IF VS_TRANSACTION_TYPE_CD = '40' THEN
												
													SELECT	SC.SERVICECASENUMBER
													INTO 	VL_SERVICECASENUMBER
													FROM	SERVICECASE SC,
															TB_PAYMENT_DETAIL PD
													WHERE 	PD.CASE_ID = SC.SERVICECASENUMBER::BIGINT	AND
															PD.PAYMENT_ID = VL_CASE_ID;
															
												--	RAISE NOTICE 'VL_SERVICECASENUMBER %',VL_SERVICECASENUMBER; 
															
                                                        VL_PAYMENT_MAINTENANCE := 0 ;--
                                                        BEGIN
															SELECT 	COUNT(*) 
															INTO 	VL_PAYMENT_MAINTENANCE 
															FROM 	TB_PAYMENT_HEADER
															WHERE 	PAYMENT_ID = VL_CASE_ID 	AND -- type cast to integer #26062019
																	PAYMENT_TYPE_CD = '6' 			AND 
																	PAYMENT_DT 			IS NOT NULL AND 
																	DELETE_SW = 'N'  ;--
																	
														--	RAISE NOTICE 'VL_PAYMENT_MAINTENANCE %',VL_PAYMENT_MAINTENANCE; 
	
															EXCEPTION WHEN OTHERS THEN 
																VL_OUTPUT_SQLCODE := SQLSTATE;--
																VS_MESSAGE :='SELECT PAYMENT MAINTENANCE FAILED FOR TABLE TB_PAYMENT_HEADER- ' ||SQLERRM ;--
																ERROR_EXE_FLAG := -1;
															CONTINUE TRIG_OUTBOUND;
                                                        END;
                                                        
														IF 	VL_PAYMENT_MAINTENANCE <=0 THEN                 -- UPDATE DELETE STATUS
                                                            VS_PROCESS_FLAG := 'N';--
															
															BEGIN     
																UPDATE	caresoutboundtrigger 
																SET 	activeflag = 1
                                                                WHERE CURRENT OF TRIGGER_OUTBOUND;--
	
                                                                EXCEPTION WHEN OTHERS THEN 
																	VL_OUTPUT_SQLCODE := SQLSTATE;--
																	VS_MESSAGE := 'DELETE OF RECORD FAILED FOR TABLE caresoutboundtrigger- ' ||SQLERRM ;--
																	ERROR_EXE_FLAG := -1;
						                                        CONTINUE TRIG_OUTBOUND;
															END;
	
                                                                CONTINUE TRIG_OUTBOUND;
                                                        
														ELSIF 	VL_PAYMENT_MAINTENANCE > 0 THEN
                                                               
															BEGIN 
																SELECT 	SUM(FINAL_AMOUNT_NO) 
																INTO 	VDEC_PAYMENT_AMOUNT
                                                                FROM 	TB_PAYMENT_DETAIL
                                                                WHERE 	CLIENT_ID = VL_CLIENT_ID AND 
																		PAYMENT_ID = VL_CASE_ID	AND 
																		DELETE_SW = 'N';--
																		
															--	RAISE NOTICE 'VDEC_PAYMENT_AMOUNT %',VDEC_PAYMENT_AMOUNT; 
	
                                                                EXCEPTION WHEN OTHERS THEN 
																	VL_OUTPUT_SQLCODE := SQLSTATE;--
																	VS_MESSAGE :=  'SELECT PAYMENT SUM FAILED FOR TABLE TB_PAYMENT_DETAIL- ' ||SQLERRM  ;--
																	ERROR_EXE_FLAG := -1;
						                                        CONTINUE TRIG_OUTBOUND;
                                                            END;
															 
															BEGIN	
                                                                SELECT 	SUM(FINAL_AMOUNT_NO) 
																INTO 	VDEC_PAYMENT_PREVIOUS_AMOUNT
                                                                FROM 	TB_PAYMENT_DETAIL 
																WHERE 	CLIENT_ID = VL_CLIENT_ID	AND 
																		DELETE_SW = 'N' 			AND 
																		PAYMENT_ID = (	SELECT 	MAX(A.PAYMENT_ID)
																						FROM 	TB_PAYMENT_DETAIL A, 
																								TB_PAYMENT_HEADER B
																						WHERE 	A.CLIENT_ID = VL_CLIENT_ID AND 
																								A.PAYMENT_ID = B.PAYMENT_ID AND 
																								A.PAYMENT_ID < VL_CASE_ID AND 
																								B.PAYMENT_TYPE_CD = '6' AND 
																								B.PAYMENT_DT IS NOT NULL AND 
																								A.DELETE_SW = 'N' AND 
																								B.DELETE_SW = 'N');--
																								
																--	RAISE NOTICE 'VDEC_PAYMENT_PREVIOUS_AMOUNT %',VDEC_PAYMENT_PREVIOUS_AMOUNT; 

                                                                EXCEPTION WHEN OTHERS THEN 
																	VL_OUTPUT_SQLCODE := SQLSTATE;--
																	VS_MESSAGE :=  'SELECT PREVIOUS PAYMENT SUM FAILED FOR TABLE TB_PAYMENT_DETAIL- ' ||SQLERRM  ;--
																	ERROR_EXE_FLAG := -1;
						                                        CONTINUE TRIG_OUTBOUND;
                                                            END;	--
	
                                                            IF 	VDEC_PAYMENT_AMOUNT IS NOT NULL	AND VDEC_PAYMENT_PREVIOUS_AMOUNT IS NOT NULL THEN
                                                                        
																		IF VDEC_PAYMENT_AMOUNT = VDEC_PAYMENT_PREVIOUS_AMOUNT THEN
                                                                        
																		-- UPDATE DELETE STATUS
																		
                                                                                VS_PROCESS_FLAG := 'N';--
																				
                                                                                BEGIN
																					UPDATE	caresoutboundtrigger 
																					SET 	activeflag = 1
																					WHERE CURRENT OF TRIGGER_OUTBOUND;--
	
																					EXCEPTION WHEN OTHERS THEN 
																						VL_OUTPUT_SQLCODE := SQLSTATE;--
																						VS_MESSAGE :=  'DELETE OF RECORD FAILED FOR TABLE caresoutboundtrigger- ' ||SQLERRM  ;--
																						ERROR_EXE_FLAG := -1;
																					CONTINUE TRIG_OUTBOUND;
																				END;
                                                                                
																				VS_PROCESS_FLAG := 'N';--
																				CONTINUE TRIG_OUTBOUND;
																				
                                                                        END IF;--
																		
                                                            END IF;-- VDEC_PAYMENT_AMT IS NOT NULL AND PREV_AMT IS NOT NULL
															
                                                        END IF;-- VL_PAYMENT_MAINTENANCE >0
														
                                                END IF;-- IF TRANSACTION_TYPE = 40
												
	                                        VS_PROCESS_FLAG := 'Y';--
											
                                            CONTINUE TRIG_OUTBOUND;-- ****CALL GENDATA TO PROCESS AND CHANGE STATUS TO 'P'.
                                        END IF;-- IF TRANSACTION TYPE CODE > 0
										
                                END IF;-- MAIN CIS_CLIENT CONDITION
	
                        ELSIF 	VS_TRANSACTION_TYPE_CD = '64' THEN
                                
								IF VL_CIS_CLIENT_ROWCOUNT > 0 AND VL_PLACEMENT_EXISTS > 0 AND VS_TRANSACTION_TYPE_CD = '64' THEN
                                
									VS_PROCESS_FLAG := 'Y';--
                                    CONTINUE TRIG_OUTBOUND;     -- ****CALL GENDATA TO PROCESS AND CHANGE STATUS TO 'P'.
								END IF;--
                        END IF;--
                ELSIF 	VL_CLIENT_ID <= 0 OR VL_CLIENT_ID IS NULL OR VS_TRANSACTION_TYPE_CD IN ('60','64') AND VS_TRANSACTION_TYPE_CD NOT IN ('40','50') THEN
	                
					IF VL_CASE_ID > 0 THEN
					
                            VL_PLACEMENT_EXISTS := 0 ;--
							
                            BEGIN                 
							
								/* SELECT 	COUNT(*) 
								INTO 	VL_PLACEMENT_EXISTS
                                FROM 	intakeservicerequestactor A, 
										person P, 
										intakeservicerequest C, 
										actor TA
	                            WHERE 	A.personid = P.personid							and 
										A.intakeserviceid = C.intakeserviceid  			and 
										C.servicerequestnumber = VL_CASE_ID ::VARCHAR	and 
										TA.personid = P.personid						and 
										A.actorid = TA.actorid							and 
										TA.actortype = 'CHILD'							AND 
										A.activeflag = 1 								and 
										C.activeflag = 1								and 
										P.activeflag = 1 								AND
	                                    EXISTS (	SELECT 	1 
													FROM 	TB_PLACEMENT TBP, person p
													WHERE  	TBP.client_id = P.cjamspid
															AND TBP.EXIT_DT IS NULL AND TBP.ENTRY_DT IS NOT NULL
															AND TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
															AND TBP.APPROVAL_STATUS_CD = '3047' AND TBP.DELETE_SW = 'N' ); */
															
								select  COUNT(*)
								INTO 	VL_PLACEMENT_EXISTS
								FROM    intakeservicerequestactor A,
										person P,  
										servicecase S,
										intakeservicerequest C 
								WHERE   A.personid = P.personid                            and
										A.intakeserviceid = C.intakeserviceid              and
										A.intakeservicerequestpersontypekey = 'CHILD'  and
										S.servicecasenumber = VL_CASE_ID    and
										s.servicecaseid = C.servicecaseid and
										A.activeflag = 1                                 and
										C.activeflag = 1                                and
										P.activeflag = 1                                 AND
										EXISTS (    SELECT     1
													FROM     TB_PLACEMENT TBP, person p
													WHERE      TBP.client_id = P.cjamspid 
															AND TBP.EXIT_DT IS NULL AND TBP.ENTRY_DT IS NOT NULL
															AND TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
															AND TBP.APPROVAL_STATUS_CD = '3047' AND TBP.DELETE_SW = 'N' );
															
									--RAISE NOTICE 'VL_PLACEMENT_EXISTS %',VL_PLACEMENT_EXISTS; 
	                                     
								EXCEPTION WHEN OTHERS THEN 
										VL_OUTPUT_SQLCODE := SQLSTATE;--
										VS_MESSAGE :=   'SELECT COUNT(*) FROM intakeservicerequestactor FAILED FOR CASE_ID:- '||SQLERRM || (VL_CASE_ID::VARCHAR)  ;--
										ERROR_EXE_FLAG := -1;
						        CONTINUE TRIG_OUTBOUND;
                            END;	--
	
                            IF 	VL_PLACEMENT_EXISTS <= 0 THEN        -- UPDATE STATUS TO 'I'
                                
								BEGIN                                       
									   UPDATE 	caresoutboundtrigger 
									   SET 		statusflag = 'I' 
									   WHERE CURRENT OF TRIGGER_OUTBOUND;--

                                        EXCEPTION WHEN OTHERS THEN 
                                            VL_OUTPUT_SQLCODE := SQLSTATE;--
                                            VS_MESSAGE :='UPDATE OF STATUS FAILED FOR TABLE caresoutboundtrigger- '||SQLERRM  ;--
                                            ERROR_EXE_FLAG := -1;
						                    CONTINUE TRIG_OUTBOUND;
                                END;
                                CONTINUE TRIG_OUTBOUND ;--
                            END IF;--

                                -- Added code 22/05
                            SELECT 	count(*) 
							INTO 	VL_case_client_count 
                            FROM 	intakeservicerequestactor A, 
									intakeservicerequest C, 
									actor TA 
    	                    where 	A.intakeserviceid = C.intakeserviceid	
									and TA.actorid = A.actorid
									and C.servicerequestnumber = VL_CASE_ID
									and TA.actortype = 'CHILD'
									AND A.activeflag = 1
									and C.activeflag = 1
									AND EXISTS (	SELECT 	1 
													FROM 	TB_PLACEMENT TBP, 
															person P, 
															intakeservicerequestactor A, 
															intakeservicerequest C
													WHERE	TBP.case_id ::VARCHAR = C.servicerequestnumber
															and A.intakeserviceid = C.intakeserviceid
															and A.actorid = p.personid
															and TBP.client_id = P.cjamspid
															AND TBP.EXIT_DT IS NULL 
															AND TBP.ENTRY_DT IS NOT NULL 
															AND TBP.DELETE_SW = 'N' 
															and P.activeflag = 1 
															and A.activeflag = 1
															AND TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
															AND TBP.APPROVAL_STATUS_CD = '3047');
															
								--	RAISE NOTICE 'VL_case_client_count %',VL_case_client_count; 
                                -- Added code 22/05
	
                                OPEN  CASE_CLIENT;--
                                <<CASE_CLIENT_LABEL>> 
								
                                WHILE vl_case_client_count > 0 LOOP
                                FETCH CASE_CLIENT INTO VL_CASE_CLIENT_ID, VL_CASE_PERSON_ID;--
								
								--RAISE NOTICE 'VL_CASE_CLIENT_ID %',VL_CASE_CLIENT_ID; 
								--RAISE NOTICE 'VL_CASE_PERSON_ID %',VL_CASE_PERSON_ID; 
								
	                            EXIT CASE_CLIENT_LABEL WHEN NOT FOUND;
		
                                        IF 	VL_CASE_CLIENT_ID > 0 THEN
										
                                            VL_CIS_CASE_CLIENT_ROWCOUNT := 0 ;--
                                            VL_PARENT_EXISTS := 0 ;--
		                                
											BEGIN
													SELECT 	COUNT(*)  
													INTO 	VL_CIS_CASE_CLIENT_ROWCOUNT  
													FROM 	person P
													where 	P.cjamspid = VL_CASE_CLIENT_ID 
															AND LENGTH(P.cisclientid) > 0 
															AND p.activeflag = 1;--
															
												--	RAISE NOTICE 'VL_CIS_CASE_CLIENT_ROWCOUNT %',VL_CIS_CASE_CLIENT_ROWCOUNT; 
	
												EXCEPTION WHEN OTHERS THEN 
													VL_OUTPUT_SQLCODE := SQLSTATE;--
													VS_MESSAGE :='SELECT COUNT(*) FROM person FAILED FOR CLIENT_ID:- ' ||SQLERRM || (VL_CASE_CLIENT_ID::VARCHAR)  ;--
													ERROR_EXE_FLAG := -1;
												CONTINUE TRIG_OUTBOUND;
                                            END;
	
                                            IF 	VL_CIS_CASE_CLIENT_ROWCOUNT <= 0 THEN
											
	                                        -- ITERATE CASE_CLIENT_LABEL;--
											
                                                        IF VS_TRANSACTION_TYPE_CD = '64' THEN
														
                                                        -- INSERT INTO OUTBOUND_TRIGGER
                                                            BEGIN            
															
																INSERT INTO caresoutboundtrigger	(	old_id,
																										fk_id,
																										transactionon,
																										transactiontypekey,
																										statusflag,
																										activeflag)
                                                                VALUES								(	VL_CASE_ID,
																										VL_CASE_CLIENT_ID,
																										CURRENT_TIMESTAMP,
																										'64',
																										'N',
																										1);--
			
                                                                EXCEPTION WHEN OTHERS THEN 
																	VL_OUTPUT_SQLCODE := SQLSTATE;--
																	VS_MESSAGE := 'INSERT INTO caresoutboundtrigger FAILED- ' ||SQLERRM  ;--
																	ERROR_EXE_FLAG := -1;
						                                            CONTINUE TRIG_OUTBOUND;
                                                            END;
	
															VS_INTERFACE_PROCESSED_FLAG := 'Y' ;--
                                                        END IF;--
											
											ELSIF 	VL_CIS_CASE_CLIENT_ROWCOUNT > 0 THEN
                                                    
													IF LENGTH	(	VS_TRANSACTION_TYPE_CD) > 0 THEN

                                                                IF VS_TRANSACTION_TYPE_CD = '60' THEN
                                                                    
																	BEGIN                                                                       
																		SELECT  COUNT(*) 
																		INTO 	VL_PARENT_EXISTS 
                                                                        FROM 	actorrelationship acr, 
																				person p  
																		WHERE 	p.personid = acr.client2id 
																				and p.cjamspid = VL_CLIENT_ID  
																				AND client1id = VL_CASE_PERSON_ID
																				AND relationshiptypekey IN ('3447','3449', 'BGCHLD') 
																				AND acr.activeflag = 1 and p.activeflag = 1;--
																				
																		--RAISE NOTICE 'VL_PARENT_EXISTS %',VL_PARENT_EXISTS; 
																				
																		EXCEPTION WHEN OTHERS THEN 
																			VL_OUTPUT_SQLCODE := SQLSTATE;--
																			VS_MESSAGE := 'SELECT PARENT EXISTS COUNT FAILED FOR  TABLE TB_CLIENT_RELATIONSHIPS- ' ||SQLERRM;--
																			ERROR_EXE_FLAG := -1;
																		CONTINUE TRIG_OUTBOUND;
                                                                    END;

                                                                    IF VL_PARENT_EXISTS <= 0 THEN
																	
																		VL_case_client_count := VL_case_client_count - 1;
                                                                        CONTINUE  CASE_CLIENT_LABEL;
                                                                    END IF ;--

                                                                    VL_TRANSACTION_SEQUENCE := VL_TRANSACTION_SEQUENCE + 1 ;--
                                                                    
																	BEGIN                                                                       
																		SELECT 	* 
																		iNTO 	VS_MESSAGE,
																				VL_OUTPUT_SQLCODE 
																		from 	SP_CARES_OUTBOUND_INTERFACE_GEN_DATA(	
																				
																				VL_CASE_CLIENT_ID,
																				VL_CLIENT_ID,
																				VS_TRANSACTION_TYPE_CD,
																				VL_TRANSACTION_SEQUENCE,
																				VD_TRANSACTION_TS,
																				VL_SERVICECASENUMBER, --PASSING THE NEW VARIABLE
																				VL_ADOPTIONCASENUMBER);--
                                                                        EXCEPTION WHEN OTHERS THEN 
																			VL_OUTPUT_SQLCODE := SQLSTATE;--
																			VS_MESSAGE := 'FAILED TO GENERATE INTERFACE DATA FOR TRANSACTION_TYPE_CD at line 499:- '||SQLERRM||VS_TRANSACTION_TYPE_CD || ' AND CLIENT_ID:'||(VL_CASE_CLIENT_ID::VARCHAR)  ;--
																			ERROR_EXE_FLAG := -1;
						                                                CONTINUE TRIG_OUTBOUND;
                                                                    END;--
																	
                                                                ELSE
                                                                         VL_TRANSACTION_SEQUENCE := VL_TRANSACTION_SEQUENCE + 1 ;--
																		 
																		BEGIN 
																			SELECT	* 
																			INTO 	VS_MESSAGE,
																					VL_OUTPUT_SQLCODE 
																			FROM 	SP_CARES_OUTBOUND_INTERFACE_GEN_DATA(				VL_CASE_CLIENT_ID,
																			VL_CASE_ID,
																			VS_TRANSACTION_TYPE_CD,
																			VL_TRANSACTION_SEQUENCE,
																			VD_TRANSACTION_TS,
																			VL_SERVICECASENUMBER,--- PASSING THE NEW VARIABLE 
																			VL_ADOPTIONCASENUMBER);--)
                                                                        EXCEPTION WHEN OTHERS THEN 
																			VL_OUTPUT_SQLCODE := SQLSTATE;--
																			VS_MESSAGE :='FAILED TO GENERATE INTERFACE DATA FOR TRANSACTION_TYPE_CD at line 508:- ' ||SQLERRM||VS_TRANSACTION_TYPE_CD || ' AND CLIENT_ID:'||(VL_CASE_CLIENT_ID::VARCHAR)  ;--
																			ERROR_EXE_FLAG := -1;
						                                                CONTINUE TRIG_OUTBOUND;
																		END;--
                                                                
																END IF;--
	
                                                                VS_INTERFACE_PROCESSED_FLAG := 'Y' ;--
	
                                                        END IF;-- VS_TRANSACTION_TYPE_CD > 0
														
                                                END IF;--VL_CIS_CASE_CLIENT_ROWCOUNT > 0
												
                                        END IF;--VL_CASE_CLIENT_ID> 0
										
                                    VL_case_client_count := VL_case_client_count - 1;
									
                                END LOOP;--
                                
								CLOSE CASE_CLIENT;--

                                IF (VL_OUTPUT_SQLCODE = '00000') AND VS_INTERFACE_PROCESSED_FLAG = 'Y' THEN
                                
								-- UPDATE STATUS TO 'P'
								
										BEGIN  
											UPDATE caresoutboundtrigger 
											SET statusflag = 'P' 
											WHERE CURRENT OF TRIGGER_OUTBOUND;--

                                        EXCEPTION WHEN OTHERS THEN 
                                            VL_OUTPUT_SQLCODE := SQLSTATE;--
                                            VS_MESSAGE := 'UPDATE OF STATUS FAILED FOR TABLE caresoutboundtrigger- ' ||SQLERRM ;--
                                            ERROR_EXE_FLAG := -1;
						                    CONTINUE TRIG_OUTBOUND;
										END;
                                END IF;--
								
                                VS_INTERFACE_PROCESSED_FLAG := 'N' ;--
								
                        END IF; -- CASE_ID <=0

                END IF;    -- CLIENT_ID <=0 OR CLIENT_ID ID NULL

-------CALL OUTBOUND_GEN_DATA TO INSERT INTO INTERFACE TABLE
-------UPDATE STATUS TO 'P'

   END LOOP;		--
        CLOSE TRIGGER_OUTBOUND;--

    
	IF ERROR_EXE_FLAG <> -1 then 
	
	
	 VL_OUTPUT_SQLCODE := '00000';--
	 VS_MESSAGE := 'THE RUN WAS SUCCESSFUL.';--
	 
	
	 end if;
--	 a := vts_current_run_ts;--
--	 b := vts_previous_run_ts;--

	return;
END;

$function$
;
