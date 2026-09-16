CREATE OR REPLACE FUNCTION cjams.sp_cses_interface_generate_outbound(OUT vs_message character varying, OUT vl_output_sqlcode character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
-- VARIABLE DECLARATIONr u there

DECLARE

     result                             text;
     VS_OUTPUINTEGERT_STATE             CHAR(5) DEFAULT '00000';--
	 vts_previous_run_ts                timestamp  DEFAULT CURRENT_TIMESTAMP;--
	 vts_current_run_ts                 timestamp DEFAULT CURRENT_TIMESTAMP;--
	 VL_ROWCOUNT                        INTEGER DEFAULT 0;--
	 VL_INTERFACE_ROWCOUNT              INTEGER DEFAULT 0;--
	 VL_TRIGGER_ROWCOUNT                INTEGER DEFAULT 0 ;--
	 VL_TRANSACTION_SEQUENCE            INTEGER DEFAULT 00000;--
	 VL_RECORD_SEQUENCE                 INTEGER DEFAULT 000;--
	 VL_CASE_ID                         BIGINT;--										  
	 vl_client_id                        INTEGER;--
	 vl_case_client_id                   INTEGER;--
	 VS_TRANSACTION_TYPE_CD             VARCHAR(2);--
	 VS_BATCH_SEQ_NO                    VARCHAR(5);--
	 VL_CIS_CLIENT_ROWCOUNT             INTEGER DEFAULT 0;--
	 VL_CIS_CASE_CLIENT_ROWCOUNT        INTEGER DEFAULT 0;--
	 VS_RECORD_TYPE_CD                  VARCHAR(2);--
	 VD_TRANSACTION_TS                  TIMESTAMP;--
	 VL_PARENT_EXISTS                   INTEGER DEFAULT 0;--
	 VL_PAYMENT_MAINTENANCE             INTEGER DEFAULT 0;--
	 VDEC_PAYMENT_AMOUNT                DECIMAL(10,2);--
	 VDEC_PAYMENT_PREVIOUS_AMOUNT       DECIMAL(10,2);--
--   VL_HEARING_ROWCOUNT                INTEGER DEFAULT 0;--
	 VL_PLACEMENT_EXISTS                INTEGER DEFAULT 0;--
	 VL_PLACEMENT_END_DATED_EXISTS      INTEGER DEFAULT 0;--
	 VS_NULL                            VARCHAR(10);--
	 VL_CASE_HEARING_PLACEMENT_EXISTS   INTEGER DEFAULT 0;--
	 VS_INTERFACE_PROCESSED_FLAG        CHAR(1) DEFAULT 'N';--
	 vl_case_client_count               integer default 0;--
	 vl_hearing_clients_count           integer default 0;--
	 vl_trigger_outbound_count          integer default 0;--
	 VS_PROCESS_FLAG                    VARCHAR (1) DEFAULT 'N';--
	 VL_CASE_PERSON_ID                  UUID;					   

	  BEGIN
--  MAIN CURSOR
	DECLARE TRIGGER_OUTBOUND CURSOR FOR
	SELECT old_id, fk_id :: INTEGER, transactiontypekey, transactionon
	FROM csesoutboundtrigger
	WHERE statusflag = 'N'
	AND activeflag = 1
       ORDER BY transactionon ASC
    FOR UPDATE ;--
	
--  CASE_CLIENT CURSOR	
	DECLARE  CASE_CLIENT CURSOR FOR
	SELECT DISTINCT PP.cjamspid, pp.personid 
    FROM intakeservicerequestactor ISA, person PP, intakeservicerequest ISR, 
      servicecase SC
    WHERE ISA.personid = PP.personid
    AND ISR.servicecaseid = ISA.servicecaseid
    AND ISA.servicecaseid = SC.servicecaseid
    AND SC.servicecasenumber:: BIGINT = VL_CASE_ID
    AND ISA.intakeservicerequestpersontypekey = 'CHILD'
    AND ISA.activeflag = 1
    AND PP.activeflag = 1
    AND ISR.activeflag = 1
    AND SC.activeflag = 1
    AND EXISTS (SELECT 1 FROM TB_PLACEMENT TBP,  person PR
                    WHERE TBP.CLIENT_ID = PR.cjamspid 
                    AND TBP.EXIT_DT IS null 
					AND PP.personid = PR.personid 
                    AND   TBP.ENTRY_DT IS NOT NULL AND TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
                    AND   TBP.APPROVAL_STATUS_CD = '3047' AND TBP.DELETE_SW = 'N');--



--  CASE_HEARING CURSOR	
    DECLARE CASE_HEARING CURSOR FOR
   SELECT pp.cjamspid, pp.personid
	FROM hearingclients HC, intakeservicerequestcourthearing ich, person pp, intakeservicerequest ISR, intakeservicerequestactor ISA,servicecase SC
	WHERE HC.courthearingid = ich.intakeservicerequestcourthearingid
	AND pp.personid = HC.personid
	AND ISR.servicecaseid = SC.servicecaseid
	AND SC.servicecasenumber ::bigint = VL_CASE_ID
	AND ISR.intakeserviceid = ICH.intakeserviceid 
	AND ISA.personid = pp.personid
	AND EXISTS (SELECT 1 FROM intakeservicerequestactor TCC, actor TA
	             WHERE TCC.intakeserviceid = ICH.intakeserviceid  AND TCC.personid = HC.personid 
	             AND TA.actortype = 'CHILD' AND TCC.activeflag = 1 and TA.activeflag = 1)
	AND HC.activeflag = 1
	AND ICH.activeflag = 1
	AND SC.activeflag = 1
	AND EXISTS (SELECT 1 FROM TB_PLACEMENT TBP,  person PP
	                WHERE TBP.CLIENT_ID = PP.cjamspid AND PP.personid = HC.personid AND TBP.EXIT_DT IS NULL
                        AND   TBP.ENTRY_DT IS NOT NULL
                        AND   TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
                        AND   TBP.APPROVAL_STATUS_CD = '3047' AND TBP.DELETE_SW = 'N');	--

-- IF 1ST RUN i.e. NO ROWS IN RUNTIMES_LOG, THEN LEAVE AS INITIALIZED	
-- IF EXISTS (SELECT 1 FROM interfacesruntimeslog) THEN
-- SELECT MAX(currentruntimestamp) INTO vts_previous_run_ts FROM interfacesruntimeslog
-- WHERE interfaceid = 'CSES_OUTBOUND';--
-- END IF;--

BEGIN
-- CHECK FOR ROWS TO INTERFACE, IF NONE THEN QUIT.
-- IF 1ST RUN i.e. NO ROWS IN RUNTIMES_LOG, THEN LEAVE AS INITIALIZED	
   IF EXISTS (SELECT 1 FROM interfacesruntimeslog) THEN
               
BEGIN			 
	SELECT MAX(currentruntimestamp) INTO vts_previous_run_ts FROM interfacesruntimeslog
    WHERE interfaceid = 'CSES_OUTBOUND';--
	
    EXCEPTION WHEN OTHERS THEN             
	VL_OUTPUT_SQLCODE := SQLSTATE;--
    VS_MESSAGE := 'SELECT MAX(currentruntimestamp) FAILED'   || SQLERRM  ;--
    RETURN;
               
END;				
END IF;--
	
-- CHECK FOR ROWS TO INTERFACE, IF NONE THEN QUIT.
	IF EXISTS (SELECT 1 FROM csesoutboundtrigger) THEN
    ELSE
    VS_MESSAGE := 'THERE ARE NO ROWS TO INTERFACE'   || SQLERRM  ;--
    RETURN ;--
    END IF;--
		
-- DELETE EXISTING RECORDS IN TEH INTERFACE TABLE	
    IF EXISTS(SELECT 1 FROM csesoutboundinterface ) THEN
BEGIN               
	DELETE FROM csesoutboundinterface  ;--
	
    EXCEPTION WHEN OTHERS THEN   
    VL_OUTPUT_SQLCODE  :=  SQLCODE;--
    VS_MESSAGE := 'DELETE FROM csesoutboundinterface FAILED';--
    RETURN ;--
 END;              
 END IF;--
	
-- COUNT RECORDS IN TRIGGER_OUTBOUND FOR CURSOR LOOP.
   SELECT count(*) INTO vl_trigger_outbound_count FROM csesoutboundtrigger
   WHERE statusflag = 'N' AND   activeflag = 1;--

--OPEN MAIN CURSOR
   OPEN TRIGGER_OUTBOUND;--
   <<TRIG_OUTBOUND>>
   WHILE  vl_trigger_outbound_count >0 LOOP
   
	IF  VS_PROCESS_FLAG = 'Y' THEN                                 --12/07/2018  #12329
      
	VL_TRANSACTION_SEQUENCE := VL_TRANSACTION_SEQUENCE + 1 ;--
	 --  RAISE NOTICE 'V OUTBOUND BEFORE GEN DATA%', VL_CLIENT_ID;
		BEGIN
		
			SELECT * 
			INTO 	VS_MESSAGE , VL_OUTPUT_SQLCODE
			from   sp_cses_outbound_interface_gen_data(VL_CLIENT_ID,VL_CASE_ID,VS_TRANSACTION_TYPE_CD,VL_TRANSACTION_SEQUENCE,VD_TRANSACTION_TS);--
			
			EXCEPTION WHEN OTHERS THEN
			VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
			VS_MESSAGE =  'FAILED BEGIN TO GENERATE INTERFACE DATA FOR TRANSACTION_TYPE_CD:'||VS_TRANSACTION_TYPE_CD || ' AND CLIENT_ID:'||VL_CLIENT_ID::VARCHAR   || SQLERRM  ;--
			RETURN ;--
		END;
		
		BEGIN 
		   
				--	IF VL_OUTPUT_SQLCODE = '00000' -- and vs_message <> 'I' 
					--THEN
							UPDATE csesoutboundtrigger SET statusflag = 'P'
							WHERE CURRENT OF TRIGGER_OUTBOUND;--
							-- 10/30/06
					/* ELSIF VL_OUTPUT_SQLCODE <> '00000' -- and vs_message = 'I'  
					THEN
							UPDATE csesoutboundtrigger  SET statusflag = 'I'
							WHERE CURRENT OF TRIGGER_OUTBOUND;    -- 10/30/06   #6037 */
					--END IF;--
					
					  EXCEPTION WHEN OTHERS THEN
						  VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
						  VS_MESSAGE = 'UPDATE1 OF STATUS FAILED FOR  TABLE TB_CSES_OUTBOUND_TRIGGER'   || SQLERRM  ;--
							RETURN ;--
					END;
			 VS_PROCESS_FLAG := 'N';--	
	END IF;--
		
			
	FETCH  	TRIGGER_OUTBOUND 
	INTO 	VL_CASE_ID,
			VL_CLIENT_ID,
			VS_TRANSACTION_TYPE_CD, 
			VD_TRANSACTION_TS ;--
	/* 
	raise notice 'VL_CASE_ID%', VL_CASE_ID;
	raise notice 'VL_CLIENT_ID%', VL_CLIENT_ID;
	raise notice 'VS_TRANSACTION_TYPE_CD%', VS_TRANSACTION_TYPE_CD;
	raise notice 'VD_TRANSACTION_TS%', VD_TRANSACTION_TS; */
		 
    IF vl_trigger_outbound_count <=0 THEN
        EXIT TRIG_OUTBOUND;--
    END IF;--
				 
	vl_trigger_outbound_count := vl_trigger_outbound_count  -1 ;--
    
	IF VL_CLIENT_ID > 0 THEN
                        
		VL_PLACEMENT_EXISTS := 0 ;--
        VL_CIS_CLIENT_ROWCOUNT := 0 ;--
		VL_PLACEMENT_END_DATED_EXISTS := 0 ;--
		
--- COUNT CIS_CLIENT
                
	BEGIN		               
			SELECT 	COUNT(*) 
			INTO 	VL_CIS_CLIENT_ROWCOUNT 
			FROM 	person
			WHERE 	cjamspid = VL_CLIENT_ID 
					AND LENGTH(cisclientid) > 0 
					AND activeflag = 1;--
							
			--raise notice 'VL_CIS_CLIENT_ROWCOUNT%', VL_CIS_CLIENT_ROWCOUNT;
			
            EXCEPTION WHEN OTHERS THEN 
			
			VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
            VS_MESSAGE := 'SELECT  COUNT(*) FROM person FAILED FOR CLIENT_ID:' || VL_CLIENT_ID::VARCHAR   || SQLERRM  ;--
            RETURN ;--
	
    END;
	
 -- COUNT OPEN PLACEMENTS
                
	BEGIN                    
		
		SELECT 	COUNT(*) 
		INTO 	VL_PLACEMENT_EXISTS 
		FROM 	TB_PLACEMENT A
        WHERE 	A.CLIENT_ID = VL_CLIENT_ID 
				AND A.EXIT_DT IS NULL 
				AND A.ENTRY_DT IS NOT NULL
                AND A.PLACEMENT_STRUCTURE_ID IS NOT NULL 
				AND A.APPROVAL_STATUS_CD = '3047' 
				AND A.DELETE_SW = 'N'  ;----structureid
	            
	--	raise notice 'VL_PLACEMENT_EXISTS%', VL_PLACEMENT_EXISTS;
				
		EXCEPTION WHEN OTHERS THEN  
						VL_OUTPUT_SQLCODE  :=  SQLCODE;--
	                    VS_MESSAGE := 'SELECT  COUNT(*) FROM TB_PLACEMENT FAILED FOR intakeservicerequestactorid:' || VL_CLIENT_ID::VARCHAR   || SQLERRM  ;--
	                    RETURN;
	END;
		
-- COUNT CLOSED OR END-DATED PLACEMENTS

	BEGIN		
		       
		SELECT 	COUNT(*) 
		INTO 	VL_PLACEMENT_END_DATED_EXISTS
        FROM 	TB_PLACEMENT A
	    WHERE 	A.CLIENT_ID = VL_CLIENT_ID
				AND   A.EXIT_DT IS NOT NULL
                AND   A.ENTRY_DT IS NOT NULL
                AND   A.PLACEMENT_STRUCTURE_ID IS NOT NULL
	            AND   A.DELETE_SW = 'N'  ;--
				
	--	raise notice 'VL_PLACEMENT_END_DATED_EXISTS%', VL_PLACEMENT_END_DATED_EXISTS;
	           
		EXCEPTION WHEN OTHERS THEN  
	               VL_OUTPUT_SQLCODE  =  SQLCODE;--
	               VS_MESSAGE = 'SELECT  COUNT(*) FOR END DATED PLACEMENT FROM TB_PLACEMENT FAILED FOR CLIENT_ID:' || VL_CLIENT_ID::VARCHAR   || SQLERRM  ;--
	               RETURN;
    END;
	
-----SUBSIDY GUARDIANSHIP----------	

    IF  VS_TRANSACTION_TYPE_CD = '15' THEN                           -- #12329
            
			IF VL_CIS_CLIENT_ROWCOUNT <= 0 THEN 	VS_PROCESS_FLAG := 'N';                          --02/16/2007  #12329
                
				CONTINUE TRIG_OUTBOUND;--
                                        -- commented below as per specs -#12463
                                        --UPDATE csesoutboundtrigger  STATUS_SW := 'I'             --UPDATE STATUS TO 'I'
                                        --WHERE CURRENT OF TRIGGER_OUTBOUND;--
	
                                        -- VL_OUTPUT_SQLCODE := SQLCODE;--
                                        --IF SQLCODE <> 0 AND (SQLSTATE <> '00000')  THEN
                                        --         VS_MESSAGE := 'UPDATE OF STATUS FAILED FOR  TABLE csesoutboundtrigger'    || SQLERRM ;--
                                        --        CONTINUE ERROR_SECTION ;--
                                        --END IF;--
									
            ELSIF 	
				
				EXISTS	(	SELECT 	1 
							FROM 	TB_GUARDIAN_SUBSIDY A 
							WHERE 	A.CLIENT_ID = VL_CLIENT_ID
									AND A.SUBSIDY_START_DT IS NOT NULL 
									AND A.SUBSIDY_END_DT IS NOT NULL
									AND A.CHECK_LIST_APPROVAL_STATUS_CD = '3047' 
									AND A.SUSBSIDY_APPROVAL_STATUS_CD = '3047'
									AND A.DELETE_SW = 'N') THEN
                                     
				SET VS_PROCESS_FLAG = 'Y' ;                           --02/16/2007  #12329
                CONTINUE TRIG_OUTBOUND;                           --****PROCESS CLIENTS & UPDATE STATUS.
			END IF;--VL_CIS_CLIENT_ROWCOUNT <= 0
								
    ELSIF  VS_TRANSACTION_TYPE_CD IN ('10','70','20','40','41','44') THEN
	
            IF VL_CIS_CLIENT_ROWCOUNT <= 0 OR (VL_PLACEMENT_EXISTS <= 0 AND VS_TRANSACTION_TYPE_CD <> '70') THEN
			
				IF VL_PLACEMENT_EXISTS <= 0 AND VS_TRANSACTION_TYPE_CD <> '70' THEN       --#12463
                                                --UPDATE STATUS TO 'I'
                    VS_PROCESS_FLAG := 'N';--
                                          
					BEGIN                                              
						UPDATE csesoutboundtrigger SET statusflag= 'I'
                        WHERE CURRENT OF TRIGGER_OUTBOUND;--
                                              
						EXCEPTION WHEN OTHERS THEN 	                                            
							VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                            VS_MESSAGE := 'UPDATEx OF STATUS FAILED FOR TABLE csesoutboundtrigger'  || SQLERRM   ;--
                            RETURN ;--
                     END;
                END IF;	--
            ELSIF VL_CIS_CLIENT_ROWCOUNT > 0 AND ((VL_PLACEMENT_EXISTS > 0 AND VS_TRANSACTION_TYPE_CD <> '70') OR (VL_PLACEMENT_END_DATED_EXISTS > 0 AND VS_TRANSACTION_TYPE_CD = '70')) THEN

                IF LENGTH(VS_TRANSACTION_TYPE_CD) > 0 THEN
                                                
					IF VS_TRANSACTION_TYPE_CD = '40' THEN
                                                         
						VL_PAYMENT_MAINTENANCE := 0 ;--
	                                                
						BEGIN
                        
						SELECT 	COUNT(*) 
						INTO 	VL_PAYMENT_MAINTENANCE
                        FROM 	TB_PAYMENT_HEADER 
						WHERE 	PAYMENT_ID :: BIGINT = VL_CASE_ID
                                AND PAYMENT_TYPE_CD = '6' 
								AND PAYMENT_DT IS NOT NULL 
								AND DELETE_SW = 'N'  ;--
								
					--	raise notice 'VL_PAYMENT_MAINTENANCE%', VL_PAYMENT_MAINTENANCE;
	                            
						EXCEPTION WHEN OTHERS THEN 
                            VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
							VS_MESSAGE := 'SELECT PAYMENT MAINTENANCE FAILED FOR  TABLE paymentheader'  || SQLERRM ;
                        END;   
	
						IF VL_PAYMENT_MAINTENANCE <=0 THEN
                            VS_PROCESS_FLAG := 'N';--
                            
							BEGIN   
								UPDATE csesoutboundtrigger SET activeflag = 0    --UPDATE DELETE STATUS
                                WHERE CURRENT OF TRIGGER_OUTBOUND;--
	
                                EXCEPTION WHEN OTHERS THEN 
                                    VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
									VS_MESSAGE := 'DELETE OF RECORD FAILED FOR  TABLE TB_CSES_OUTBOUND_TRIGGER'   || SQLERRM  ;
									RETURN;
                                                                
                            END;
                                                        --END IF;--
	                        CONTINUE TRIG_OUTBOUND;--
	                    ELSIF VL_PAYMENT_MAINTENANCE > 0 THEN
                                                            
							BEGIN   
								SELECT 	SUM(FINAL_AMOUNT_NO) 
								INTO 	VDEC_PAYMENT_AMOUNT
                                FROM 	TB_PAYMENT_DETAIL 
								WHERE 	CLIENT_ID = VL_CLIENT_ID
                                        AND PAYMENT_ID :: BIGINT = VL_CASE_ID 
										AND DELETE_SW = 'N';--
										
								--raise notice 'VDEC_PAYMENT_AMOUNT%', VDEC_PAYMENT_AMOUNT;
	
								EXCEPTION WHEN OTHERS THEN 
									VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
									VS_MESSAGE = 'SELECT PAYMENT SUM FAILED FOR  TABLE TB_PAYMENT_DETAIL'    || SQLERRM ;--
									RETURN;
                            END;
                                                    
                            BEGIN
									SELECT 	SUM(FINAL_AMOUNT_NO) 
									INTO 	VDEC_PAYMENT_PREVIOUS_AMOUNT
                                    FROM 	TB_PAYMENT_DETAIL 
									WHERE 	CLIENT_ID = VL_CLIENT_ID
                                            AND PAYMENT_ID = (	SELECT	MAX(A.PAYMENT_ID)
                                                                FROM 	TB_PAYMENT_DETAIL A, TB_PAYMENT_HEADER B
                                                                WHERE 	A.CLIENT_ID = VL_CLIENT_ID 
																		AND A.PAYMENT_ID = B.PAYMENT_ID
																		AND A.PAYMENT_ID :: BIGINT < VL_CASE_ID AND B.PAYMENT_TYPE_CD = '6'
																		AND B.PAYMENT_DT IS NOT NULL
																		AND A.DELETE_SW = 'N' AND B.DELETE_SW = 'N')  
											AND DELETE_SW = 'N';--
											
								--	raise notice 'VDEC_PAYMENT_PREVIOUS_AMOUNT%', VDEC_PAYMENT_PREVIOUS_AMOUNT;
	
									EXCEPTION WHEN OTHERS THEN 
										VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
										VS_MESSAGE = 'SELECT PREVIOUS PAYMENT SUM FAILED FOR  TABLE paymentdetail'   || SQLERRM  ;--
										RETURN;
							END;
                                   
	
                            IF VDEC_PAYMENT_AMOUNT IS NOT NULL AND VDEC_PAYMENT_PREVIOUS_AMOUNT IS NOT NULL THEN
                                                                        
									IF VDEC_PAYMENT_AMOUNT = VDEC_PAYMENT_PREVIOUS_AMOUNT THEN
                                           VS_PROCESS_FLAG := 'N';--
                                                
											BEGIN                                                                               
												UPDATE csesoutboundtrigger SET activeflag = 0 --UPDATE DELETE STATUS
                                                WHERE CURRENT OF TRIGGER_OUTBOUND;--
	
                                            EXCEPTION WHEN OTHERS THEN 
												VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
												VS_MESSAGE := 'DELETE OF RECORD FAILED FOR  TABLE TB_CSES_OUTBOUND_TRIGGER'   || SQLERRM  ;--
                                                RETURN;
											END; 
                                    END IF;--VDEC_PAYMENT_AMOUNT = VDEC_PAYMENT_PREVIOUS_AMOUNT
																		
									CONTINUE TRIG_OUTBOUND;--
                                                               
                            END IF;                         --VDEC_PAYMENT_AMT IS NOT NULL
                    END IF;                                 --VL_PAYMENT_MAINTENANCE <=0
				END IF;                                         --VS_TRANSACTION_TYPE_CD=40
                VS_PROCESS_FLAG := 'Y';--
                CONTINUE TRIG_OUTBOUND;               --****PROCESS CLIENTS & UPDATE STATUS.                                        	
	            END IF;                                 -- VS_TRANSACTION_TYPE_CD > 0
            END IF;                                         -- VL_CIS_CLIENT_ROWCOUNT <=0
	ELSIF VS_TRANSACTION_TYPE_CD = '43' THEN
                               
		IF EXISTS (/* 	SELECT 1 
					FROM 	hearingtype B , 
							intakeservicerequestcourthearing isrc , 
							intakeservicerequest isr,
							servicecase SC
					WHERE 	b.hearingtypekey = isrc.hearingtypekey
                            AND  isrc.intakeserviceid = isr.intakeserviceid
							AND ISR.servicecaseid = SC.servicecaseid
                            AND SC.servicecasenumber:: BIGINT = VL_CASE_ID
                            AND B.hearingtypekey IN ('Adjudi','Disp','MHC') 
							AND B.activeflag = 1 */
							select 	1
							from 	hearingtype B  
									join intakeservicerequestcourthearing isrc on isrc.hearingtype ? b.hearingtypekey
									join intakeservicerequest isr on isrc.intakeserviceid = isr.intakeserviceid
									join servicecase SC on  ISR.servicecaseid = SC.servicecaseid
							where	SC.servicecasenumber:: BIGINT = VL_CASE_ID
									AND B.hearingtypekey IN ('Adjudi','Disp','MHC', 'CINA', 'CC') 
									AND B.activeflag = 1)  THEN -- '3931','7331'
	
                IF VL_CIS_CLIENT_ROWCOUNT > 0 AND VL_PLACEMENT_EXISTS > 0 AND VS_TRANSACTION_TYPE_CD = '43' THEN
                                                 
						VS_PROCESS_FLAG := 'Y';--
	                    CONTINUE TRIG_OUTBOUND;                --****PROCESS CLIENTS & UPDATE STATUS.
                END IF;--
										
        ELSE
				VS_PROCESS_FLAG := 'N';--
                
				BEGIN                                       
					UPDATE csesoutboundtrigger SET activeflag = 0
                    WHERE CURRENT OF TRIGGER_OUTBOUND;--
                                 
				EXCEPTION WHEN OTHERS THEN 
                                          VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
										  VS_MESSAGE = 'DELETE OF RECORD FAILED FOR  TABLE TB_CSES_OUTBOUND_TRIGGER'    || SQLERRM ;
                                          RETURN;
                END;     
        END IF;--
								
    ELSIF VS_TRANSACTION_TYPE_CD = '45' THEN
                               
			IF VL_CIS_CLIENT_ROWCOUNT > 0 AND VL_PLACEMENT_EXISTS > 0 AND VS_TRANSACTION_TYPE_CD = '45' THEN
						VS_PROCESS_FLAG := 'Y';--
                        CONTINUE TRIG_OUTBOUND;                --****PROCESS CLIENTS & UPDATE STATUS.
            END IF;              	--
    END IF ;                                         --VS_TRANSACTION_TYPE_CD = '15'

    ELSIF VL_CLIENT_ID <= 0 OR VL_CLIENT_ID IS NULL OR VS_TRANSACTION_TYPE_CD IN ('42','45') AND  VS_TRANSACTION_TYPE_CD NOT IN ('40','41') THEN
                      
		IF VL_CASE_ID > 0 THEN
            
			IF VS_TRANSACTION_TYPE_CD = '43' THEN
	
				IF EXISTS(	SELECT 1 FROM hearingtype B , intakeservicerequestcourthearing isrc , intakeservicerequest isr,servicecase SC
							WHERE 	b.hearingtypekey = isrc.hearingtypekey
									AND  isrc.intakeserviceid = isr.intakeserviceid
									AND ISR.servicecaseid = SC.servicecaseid
									AND SC.servicecasenumber:: BIGINT = VL_CASE_ID 
									AND B.hearingtypekey IN ('Adjudi','Disp','MH') 
									AND B.activeflag = 1)  THEN -- '3931','7331'
                                          
							BEGIN
                            
								SELECT 	COUNT(*) 
								INTO 	VL_CASE_HEARING_PLACEMENT_EXISTS
								FROM 	hearingclients HC, 
										intakeservicerequestcourthearing ich, 
										person pp, 
										intakeservicerequest ISR, 
										intakeservicerequestactor ISA,
										servicecase SC
	                            WHERE 	HC.courthearingid = ich.intakeservicerequestcourthearingid
	                                    AND pp.personid = HC.personid
	                                    AND ISR.servicecaseid = SC.servicecaseid
										AND SC.servicecasenumber:: BIGINT = VL_CASE_ID
	                                    AND ISR.intakeserviceid = ICH.intakeserviceid 
	                                    AND ISA.personid = pp.personid
	                                    AND EXISTS (	SELECT 1 FROM intakeservicerequestactor TCC, actor TA
														WHERE 	TCC.intakeserviceid = ICH.intakeserviceid  
																AND TCC.personid = HC.personid 
																AND TA.actortype = 'CHILD' 
																AND TCC.activeflag = 1 
																and TA.activeflag = 1)
	                                    AND HC.activeflag = 1
	                                    AND ICH.activeflag = 1
										AND SC.activeflag = 1
	                                    AND EXISTS (	SELECT 1 FROM TB_PLACEMENT TBP,  person PP
														WHERE 	TBP.CLIENT_ID = PP.cjamspid 
																AND PP.personid = HC.personid 
																AND TBP.EXIT_DT IS NULL
																AND   TBP.ENTRY_DT IS NOT NULL
																AND   TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
																AND   TBP.APPROVAL_STATUS_CD = '3047' 
																AND TBP.DELETE_SW = 'N') ;		

								--	raise notice 'VL_CASE_HEARING_PLACEMENT_EXISTS%', VL_CASE_HEARING_PLACEMENT_EXISTS;							

                                    EXCEPTION WHEN OTHERS THEN 
 											VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
											VS_MESSAGE = 'SELECT  COUNT(*) FROM TB_COURT_HEARINGS FAILED FOR COURT_HEARING_ID:' || VL_CASE_ID::VARCHAR   || SQLERRM  ;--
                                                
                            END;      	--
	
							IF VL_CASE_HEARING_PLACEMENT_EXISTS <= 0 THEN
	                        
							BEGIN
									UPDATE csesoutboundtrigger SET statusflag = 'I'
                                    WHERE CURRENT OF TRIGGER_OUTBOUND;--
                                    
									EXCEPTION WHEN OTHERS THEN
                                        VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                                        VS_MESSAGE = 'UPDATE2 OF STATUS FAILED FOR  TABLE TB_CSES_OUTBOUND_TRIGGER'   || SQLERRM  ;--
										RETURN;
                            END;
                            CONTINUE TRIG_OUTBOUND ;--
                            END IF;  	--
                                               
							SELECT 	count(*) 
							INTO 	vl_hearing_clients_count
                            FROM 	hearingclients HC, 
									intakeservicerequestcourthearing ich, 
									person pp, 
									intakeservicerequest ISR, 
									intakeservicerequestactor ISA,
									servicecase SC
							WHERE 	HC.courthearingid = ich.intakeservicerequestcourthearingid
	                                AND pp.personid = HC.personid
	                                AND ISR.servicecaseid = SC.servicecaseid
									AND SC.servicecasenumber:: BIGINT = VL_CASE_ID
	                                AND ISR.intakeserviceid = ICH.intakeserviceid 
	                                AND ISA.personid = pp.personid
	                                AND EXISTS (	SELECT 	1 FROM intakeservicerequestactor TCC, actor TA
	                                                WHERE 	TCC.intakeserviceid = ICH.intakeserviceid  
															AND TCC.personid = HC.personid 
	                                                        AND TA.actortype = 'CHILD' 
															AND TCC.activeflag = 1 
															and TA.activeflag = 1)
	                                AND HC.activeflag = 1
	                                AND ICH.activeflag = 1
									AND SC.activeflag = 1
	                                AND EXISTS (	SELECT 	1 FROM TB_PLACEMENT TBP,  person PP
													WHERE 	TBP.CLIENT_ID = PP.cjamspid 
															AND PP.personid = HC.personid 
															AND TBP.EXIT_DT IS NULL
															AND   TBP.ENTRY_DT IS NOT NULL
															AND   TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
															AND   TBP.APPROVAL_STATUS_CD = '3047' 
															AND TBP.DELETE_SW = 'N');	---	
					
							--raise notice 'vl_hearing_clients_count%', vl_hearing_clients_count;

        OPEN CASE_HEARING;--
         <<HEAR_CLIENT_LABEL>>
        WHILE vl_hearing_clients_count > 0 LOOP
                                              
		FETCH  CASE_HEARING INTO vl_case_client_id, VL_CASE_PERSON_ID ;--
		
		--raise notice 'vl_case_client_id%', vl_case_client_id;
		
            IF vl_hearing_clients_count <= 0 THEN
                EXIT HEAR_CLIENT_LABEL;--
            END IF;--

            IF vl_case_client_id  > 0 THEN
                    
					VL_CIS_CASE_CLIENT_ROWCOUNT := 0 ;--
                    BEGIN                                                              
							SELECT	COUNT(*) 
							INTO 	VL_CIS_CASE_CLIENT_ROWCOUNT 
							FROM 	person
                            WHERE 	cjamspid =   VL_CASE_CLIENT_ID
                                    AND LENGTH(cisclientid) > 0 
									AND activeflag = 1;--
	                                
					EXCEPTION WHEN OTHERS THEN
                            VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                            VS_MESSAGE = 'SELECT  COUNT(*) FROM TB_CLIENT FAILED FOR CIS_CLIENT_ID:' || VL_CASE_CLIENT_ID::VARCHAR    || SQLERRM ;--
                            RETURN;
					END ;--
	
                                                               
					IF VL_CIS_CASE_CLIENT_ROWCOUNT <= 0 THEN
                            IF VS_TRANSACTION_TYPE_CD = '43' THEN
                                    
									BEGIN                                                                          
										INSERT INTO csesoutboundtrigger	(	old_id,
																			fk_id,
																			transactionon,
																			transactiontypekey,
																			statusflag,
																			activeflag)
                                        VALUES							(	VL_CASE_ID,
																			vl_case_client_id,
																			CURRENT_TIMESTAMP,
																			'43',
																			'N',
																			1);--
			                        EXCEPTION WHEN OTHERS THEN
                                            VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                                            VS_MESSAGE = 'INSERT INTO TB_CSES_OUTBOUND_TRIGGER FAILED'  || SQLERRM   ;--
                                            RETURN;
									END ;--
                                    VS_INTERFACE_PROCESSED_FLAG := 'Y' ;--
                            END IF;	--
	
                    ELSIF VL_CIS_CASE_CLIENT_ROWCOUNT > 0 THEN
                             VL_TRANSACTION_SEQUENCE := VL_TRANSACTION_SEQUENCE + 1 ;--
						--	RAISE NOTICE 'W OUTBOUND BEFORE GEN DATA%', VL_CLIENT_ID; 
                    BEGIN                                                                       
							SELECT 	* 
							INTO 	VS_MESSAGE,VL_OUTPUT_SQLCODE 
							from   	sp_cses_outbound_interface_gen_data(	VL_CLIENT_ID,VL_CASE_ID,VS_TRANSACTION_TYPE_CD,VL_TRANSACTION_SEQUENCE,VD_TRANSACTION_TS);
                    
					EXCEPTION WHEN OTHERS THEN
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;
						VS_MESSAGE = 'FAILED TO GENERATE INTERFACE DATA FOR TRANSACTION_TYPE_CD:'||VS_TRANSACTION_TYPE_CD || ' AND CLIENT_ID:'||VL_CASE_CLIENT_ID::VARCHAR   || SQLERRM  ;--
                        RETURN;
					END ;--
                    VS_INTERFACE_PROCESSED_FLAG := 'Y' ;--
                    END IF;--
            END IF;--
													
            vl_hearing_clients_count := vl_hearing_clients_count -1 ;--
        END LOOP;--
    CLOSE CASE_HEARING;--

    IF VL_OUTPUT_SQLCODE = '00000' AND VS_INTERFACE_PROCESSED_FLAG = 'Y' THEN
                                                   
			BEGIN   
				UPDATE csesoutboundtrigger SET statusflag = 'P'
                WHERE CURRENT OF TRIGGER_OUTBOUND;--

                EXCEPTION WHEN OTHERS THEN
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;
						VS_MESSAGE = 'UPDATE3 OF STATUS FAILED FOR  TABLE TB_CSES_OUTBOUND_TRIGGER'  || SQLERRM ;
                        RETURN;
			END ;
            VS_INTERFACE_PROCESSED_FLAG := 'N' ;--
	END IF;--

    VS_INTERFACE_PROCESSED_FLAG := 'N' ;--
                                        
    ELSE            								-- IF EXISTS TB_HEARING_PICKLIST
        
		BEGIN                                               
				UPDATE csesoutboundtrigger SET statusflag = 'Y'
				WHERE CURRENT OF TRIGGER_OUTBOUND;--

                EXCEPTION WHEN OTHERS THEN
                    VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
					VS_MESSAGE = 'DELETE OF RECORD FAILED FOR  TABLE TB_CSES_OUTBOUND_TRIGGER'   || SQLERRM  ;--
                    RETURN ;--
		END ;--
    END IF;--
	CONTINUE TRIG_OUTBOUND ;--
    END IF;  
	-- VS_TRANSACTION_TYPE_CD='43'
    
	VL_PLACEMENT_EXISTS := 0 ;--
								 
	BEGIN
    
	/* 	SELECT 	COUNT(*) 
		INTO 	VL_PLACEMENT_EXISTS 
        FROM 	intakeservicerequestactor i , intakeservicerequest ins,servicecase SC
        WHERE 	i.intakeserviceid = ins.intakeserviceid
				AND INS.servicecaseid = SC.servicecaseid
                AND SC.servicecasenumber:: BIGINT = VL_CASE_ID  AND i.activeflag = 1
				AND ins.activeflag = 1
				AND SC.activeflag = 1
                AND EXISTS (	SELECT 	1 FROM TB_PLACEMENT TBP , person pp , intakeservicerequestactor i
								WHERE 	pp.personid = i.personid 
										and TBP.CLIENT_ID = pp.cjamspid
										AND TBP.EXIT_DT IS NULL 
										AND TBP.ENTRY_DT IS NOT NULL 
										AND TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
										AND TBP.APPROVAL_STATUS_CD = '3047' 
										AND TBP.DELETE_SW = 'N');            	-- */
										
										
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
															AND TBP.APPROVAL_STATUS_CD = '3047' 
															AND TBP.DELETE_SW = 'N' );

        EXCEPTION WHEN OTHERS THEN
                VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                VS_MESSAGE = 'SELECT  COUNT(*) FROM intakeservicerequestactor FAILED FOR CASE_ID:' || VL_CASE_ID::VARCHAR    || SQLERRM ;
                RETURN;
	END ;--
	
    IF VL_PLACEMENT_EXISTS <= 0 THEN
    
		BEGIN  
				UPDATE csesoutboundtrigger SET statusflag = 'I'
                WHERE CURRENT OF TRIGGER_OUTBOUND;--

                EXCEPTION WHEN OTHERS THEN
                        VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                        VS_MESSAGE = 'UPDATE4 OF STATUS FAILED FOR  TABLE TB_CSES_OUTBOUND_TRIGGER'   || SQLERRM  ;--
						RETURN;
        END ;--
        CONTINUE TRIG_OUTBOUND ;	--
	END IF;--

    SELECT 	Count(*) 
	INTO 	vl_case_client_count  
	FROM 	intakeservicerequestactor i , 
			intakeservicerequest ins,
			servicecase SC
    WHERE 	i.intakeserviceid = ins.intakeserviceid
			AND INS.servicecaseid = SC.servicecaseid
            AND SC.servicecasenumber:: BIGINT = VL_CASE_ID  AND i.activeflag = 1
			AND ins.activeflag = 1
			AND SC.activeflag = 1
            AND EXISTS (	SELECT 1 FROM TB_PLACEMENT TBP , person pp , intakeservicerequestactor i
							WHERE 	pp.personid = i.personid 
									and TBP.CLIENT_ID = pp.cjamspid
									AND TBP.EXIT_DT IS NULL 
									AND TBP.ENTRY_DT IS NOT NULL 
									AND TBP.PLACEMENT_STRUCTURE_ID IS NOT NULL
									AND TBP.APPROVAL_STATUS_CD = '3047' 
									AND TBP.DELETE_SW = 'N');--				
	
--	raise notice 'vl_case_client_count%', vl_case_client_count	;
				
    OPEN  CASE_CLIENT;--
    <<CASE_CLIENT_LABEL>> 	
    WHILE vl_case_client_count > 0 LOOP
    FETCH  CASE_CLIENT INTO VL_CASE_CLIENT_ID, VL_CASE_PERSON_ID  ;--
		--	raise notice 'VL_CASE_CLIENT_ID%', VL_CASE_CLIENT_ID;
		--	raise notice 'VL_CASE_PERSON_ID%', VL_CASE_PERSON_ID;
            IF vl_case_client_count <= 0 THEN
                EXIT CASE_CLIENT_LABEL;--
            END IF;--
										
		    vl_case_client_count := vl_case_client_count -1 ;--
            IF vl_case_client_id  > 0 THEN
                    VL_CIS_CASE_CLIENT_ROWCOUNT := 0 ;--
		    
			BEGIN
					SELECT 	COUNT(*) 
					INTO 	VL_CIS_CASE_CLIENT_ROWCOUNT 
					FROM 	person
                    WHERE 	cjamspid =   vl_case_client_id 
							AND LENGTH(cisclientid) > 0
                            AND activeflag = 1;--
	                        
					EXCEPTION WHEN OTHERS THEN
                            VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
							VS_MESSAGE = 'SELECT  COUNT(*) FROM TB_CLIENT FAILED FOR CLIENT_ID:' || VL_CASE_CLIENT_ID::VARCHAR   || SQLERRM  ;--
							RETURN;
            END ;--
	
            IF VL_CIS_CASE_CLIENT_ROWCOUNT <= 0 THEN
                    IF VS_TRANSACTION_TYPE_CD = '45' THEN
	                
					BEGIN
							INSERT INTO csesoutboundtrigger	 (	csesoutboundtriggerid,
																old_id,
																fk_id,
																transactionon,
																transactiontypekey,
																statusflag,
																activeflag)
                            VALUES							(	gen_random_uuid(), 
																VL_CASE_ID,
																vl_case_client_id,
																CURRENT_TIMESTAMP,
																'45',
																'N',
																1);--
			                                                    
							EXCEPTION WHEN OTHERS THEN
									VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                                    VS_MESSAGE ='INSERT INTO TB_CSES_OUTBOUND_TRIGGER FAILED'   || SQLERRM  ;--
									RETURN;
                            END ;--
                            VS_INTERFACE_PROCESSED_FLAG := 'Y' ;--
					END IF;	--
            ELSIF  VL_CIS_CASE_CLIENT_ROWCOUNT > 0 THEN
			
                    IF LENGTH(VS_TRANSACTION_TYPE_CD) > 0 THEN
					
                        IF VS_TRANSACTION_TYPE_CD = '42' THEN
                            VL_PARENT_EXISTS := 0 ;--
	                        
							BEGIN
                                SELECT  COUNT(*) 
								INTO 	VL_PARENT_EXISTS
                                FROM 	actorrelationship acr, 
										person p  
								WHERE 	p.personid = acr.client2id 
                                        and p.cjamspid = VL_CASE_CLIENT_ID  
                                        --AND client1id :: uuid  = VL_CASE_PERSON_ID
                                        --AND relationshiptypekey IN ('3447','3449','BGCHLD') 
                                        AND relationshiptypekey IN ('1881','1885','BGFTHR','BGMTHR')
										AND acr.activeflag = 1 
										and p.activeflag = 1;--
                                        
						--	RAISE NOTICE 'VL_PARENT_EXISTS%', VL_PARENT_EXISTS;
							
							EXCEPTION WHEN OTHERS THEN
									VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                                    VS_MESSAGE = 'SELECT PARENT EXISTS COUNT FAILED FOR  TABLE TB_CLIENT_RELATIONSHIPS'   || SQLERRM  ;--
                                    RETURN;
							END ;--
							
                            IF VL_PARENT_EXISTS <= 0 THEN
                                    CONTINUE CASE_CLIENT_LABEL ;--
                            END IF ;--

                            VL_TRANSACTION_SEQUENCE := VL_TRANSACTION_SEQUENCE + 1 ;--
                            
					--		RAISE NOTICE 'X OUTBOUND BEFORE GEN DATA%', VL_CLIENT_ID;
							
							BEGIN 
								SELECT 	* 
								INTO 	VS_MESSAGE ,VL_OUTPUT_SQLCODE
								from   	sp_cses_outbound_interface_gen_data	(	VL_CASE_CLIENT_ID,
																				VL_CASE_ID,
																				VS_TRANSACTION_TYPE_CD,
																				VL_TRANSACTION_SEQUENCE,
																				VD_TRANSACTION_TS);
                                                 
                                EXCEPTION WHEN OTHERS THEN
										VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                                        VS_MESSAGE = 'FAILED TO GENERATE INTERFACE DATA FOR TRANSACTION_TYPE_CD:'||VS_TRANSACTION_TYPE_CD || ' AND CLIENT_ID:'||VL_CASE_CLIENT_ID::VARCHAR   || SQLERRM  ;--
                                        RETURN;
                            END ;
						ELSE
								VL_TRANSACTION_SEQUENCE := VL_TRANSACTION_SEQUENCE + 1 ;--
                         --       RAISE NOTICE 'Y OUTBOUND BEFORE GEN DATA%', VL_CLIENT_ID;
								
								BEGIN 
									SELECT 	* 
									INTO 	VS_MESSAGE ,VL_OUTPUT_SQLCODE
									from  	sp_cses_outbound_interface_gen_data(	VL_CASE_CLIENT_ID,
																					VL_CASE_ID,
																					VS_TRANSACTION_TYPE_CD,
																					VL_TRANSACTION_SEQUENCE,
																					VD_TRANSACTION_TS);
                                    EXCEPTION WHEN OTHERS THEN
                                        VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                                        VS_MESSAGE ='FAILED TO GENERATE INTERFACE DATA FOR TRANSACTION_TYPE_CD:'||VS_TRANSACTION_TYPE_CD || ' AND CLIENT_ID:'||VL_CASE_CLIENT_ID::VARCHAR   || SQLERRM  ;--
                                        RETURN; 
                                END  ;    	--
                        END IF;--
	
                        VS_INTERFACE_PROCESSED_FLAG := 'Y' ;--
	
           
	
                END IF;                 -- transaction_type_cd >0
            END IF;                         -- VL_CIS_CASE_CLIENT_ROWCOUNT<=0
		END IF;                                 --vl_case_client_id>0
                                       
        END LOOP;		--
        CLOSE CASE_CLIENT;--

        IF VL_OUTPUT_SQLCODE = '00000' AND VS_INTERFACE_PROCESSED_FLAG = 'Y' THEN
                                        
				BEGIN	
						UPDATE csesoutboundtrigger SET statusflag = 'P'
						WHERE CURRENT OF TRIGGER_OUTBOUND;--
                        
						EXCEPTION WHEN OTHERS THEN
								VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
                                VS_MESSAGE = 'UPDATE5 OF STATUS FAILED FOR  TABLE TB_CSES_OUTBOUND_TRIGGER'   || SQLERRM  ;--
                                RETURN ;--
				END;
                        VS_INTERFACE_PROCESSED_FLAG := 'N' ;--
        END IF;--
									
        VS_INTERFACE_PROCESSED_FLAG := 'N' ;--

        END IF;                                   -- VL_CASE_ID > 0
	END IF;    	                                        --vl_client_id > 0
	
		 
    END LOOP;		--
    CLOSE TRIGGER_OUTBOUND;--

          
	
	
	-- Add record to Interface Log
	
	--INSERT INTO TB_INTERFACES_RUNTIMES_LOG
	  --( RUN_ID,
	    --INTERFACE_TX,
	    --CURRENT_RUN_TS,
	    --PREVIOUS_RUN_TS,
	    --CREATE_TS,
	    --CREATE_USER_ID,
	    --UPDATE_TS,
	    --UPDATE_USER_ID,
	    --activeflag  )
	 --SELECT
	    --NEXTVAL FOR CHESSIE.SQ_INTERFACES_RUNTIMES_LOG,
	    --'CSES_OUTBOUND',
	    --vts_current_run_ts,
	    --vts_previous_run_ts,
	    --CURRENT TIMESTAMP,
	    --'batch',   							
	    --CURRENT TIMESTAMP,
	    --'batch',
	    --'N'
	 --FROM sysibm.sysdummy1 ;--
	
	--  VL_OUTPUT_SQLCODE  ;=  SQLCODE;--
	--IF SQLCODE <> 0 AND (SQLSTATE <> '00000')  THEN
	  -- VS_MESSAGE := 'INSERT INTO TB_INTERFACES_RUNTIMES_LOG FAILED'  ;--
	  --CONTINUE ERROR_SECTION ;--
	--END IF;--
	
	

	-- Success.
	--COMMIT;--

	 VL_OUTPUT_SQLCODE := '00000';--
	 VS_MESSAGE := 'THE RUN WAS SUCCESSFUL.';--
	-- a := vts_current_run_ts;--
	-- b :=  vts_previous_run_ts;--
	
	
	
	

END;
END;
$function$
;
