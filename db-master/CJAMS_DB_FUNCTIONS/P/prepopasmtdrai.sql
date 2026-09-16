 CREATE OR REPLACE FUNCTION public.prepopasmtdrai(rv_personid character varying, loginsecurityuserid character varying)                                                               
  RETURNS json                                                                                                                                                                        
  LANGUAGE plpgsql                                                                                                                                                                    
 AS $function$                                                                                                                                                                      
                                                                                                                                                                                    
                                                                                                                                                                                    
 DECLARE                                                                                                                                                                            
                                                                                                                                                                                    
 v_count_pend_category1 INT;                                                                                                                                                        
 v_count_pend_category2 INT;                                                                                                                                                        
 v_count_pend_category3 INT;                                                                                                                                                        
 v_count_pend_category4 INT;                                                                                                                                                        
 v_count_pend_category5 INT;                                                                                                                                                        
                                                                                                                                                                                    
 v_count_sust_category1 INT;                                                                                                                                                        
 v_count_sust_category2 INT;                                                                                                                                                        
 v_count_sust_category3 INT;                                                                                                                                                        
 v_count_sust_category4 INT;                                                                                                                                                        
 v_count_sust_category5 INT;                                                                                                                                                        
                                                                                                                                                                                    
 v_courtorder_supervision1 BOOLEAN;                                                                                                                                                 
 v_courtorder_supervision2 BOOLEAN;                                                                                                                                                 
 v_courtorder_supervision3 BOOLEAN;                                                                                                                                                 
 v_courtorder_supervision4 BOOLEAN;                                                                                                                                                 
                                                                                                                                                                                    
 v_value1 INT;                                                                                                                                                                      
 v_value2 INT;                                                                                                                                                                      
 v_value3 INT;                                                                                                                                                                      
 v_value4 INT;                                                                                                                                                                      
 v_value5 INT;                                                                                                                                                                      
 v_value6 INT;                                                                                                                                                                      
                                                                                                                                                                                    
 retJson JSON;                                                                                                                                                                      
                                                                                                                                                                                    
 BEGIN                                                                                                                                                                              
                                                                                                                                                                                    
 DROP TABLE IF EXISTS sp_temp_evalids;                                                                                                                                              
 DROP TABLE IF EXISTS sp_temp_draiprepoppendadj;                                                                                                                                    
 DROP TABLE IF EXISTS sp_temp_draiprepopCourtActions;                                                                                                                               
 DROP TABLE IF EXISTS sp_temp_draiprepopcompdisp;                                                                                                                                   
 DROP TABLE IF EXISTS sp_temp_draiprepopFTAadj;                                                                                                                                     
                                                                                                                                                                                    
 CREATE TEMP TABLE sp_temp_evalids(personid UUID, intakenumber CHARACTER VARYING, evaluationid UUID);                                                                               
 CREATE TEMP TABLE sp_temp_draiprepoppendadj(personid UUID, offensecategory INT, categorycount INT, adjtype varchar(10));                                                           
 CREATE TEMP TABLE sp_temp_draiprepopCourtActions(evaluationid UUID, courtactionid UUID, courtorderdatetime timestamp without time zone, hearingtypekey varchar(50));               
 CREATE TEMP TABLE sp_temp_draiprepopcompdisp(personid UUID, courtordertypekey VARCHAR(50));                                                                                        
 CREATE TEMP TABLE sp_temp_draiprepopFTAadj(personid UUID, courtactiontypekey VARCHAR(50));                                                                                         
                                                                                                                                                                                    
 IF LEFT(rv_personid,6) = 'tempid' then                                                                                                                                             
         rv_personid := '00000000-0000-0000-0000-000000000000';                                                                                                                     
 END IF;                                                                                                                                                                            
                                                                                                                                                                                    
 -- Evaluation IDs                                                                                                                                                                  
 INSERT INTO sp_temp_evalids (personid, intakenumber, evaluationid)                                                                                                                 
 SELECT ar.personid, isr.intakenumber, isre.intakeservicerequestevaluationid FROM intakeservicerequest isr                                                                          
 JOIN intakeservicerequestactor isra ON isra.intakeserviceid = isr.intakeserviceid AND isra.activeflag = 1                                                                          
         AND isra.intakeservicerequestpersontypekey = 'Youth'                                                                                                                       
 JOIN actor ar ON ar.actorid = isra.actorid AND ar.activeflag = 1                                                                                                                   
 JOIN intakeservicerequestdispositioncode isrdc ON isr.intakeserviceid = isrdc.intakeserviceid AND isrdc.activeflag = 1                                                             
 JOIN servicerequesttypeconfigdispositioncode srtcdc ON isrdc.servicerequesttypeconfigiddispostionid = srtcdc.servicerequesttypeconfigiddispostionid AND srtcdc.activeflag = 1      
 JOIN intakeservicerequestevaluation isre ON isre.intakenumber = isr.intakenumber AND isre.activeflag = 1                                                                           
 WHERE isr.activeflag = 1 AND ar.personid = (rv_personid :: UUID) AND srtcdc.dispositioncode = 'FPTSAO';                                                                            
                                                                                                                                                                                    
 -- Adjudication Pending                                                                                                                                                            
 INSERT INTO sp_temp_draiprepoppendadj (personid, offensecategory, categorycount, adjtype)                                                                                          
 SELECT isre.personid, a.offensecategory, COUNT(1) categorycount, 'PENDING' AS adjtype FROM sp_temp_evalids isre                                                                    
 JOIN intakeservicerequestevaluationconfig isrec ON isrec.intakeservicerequestevaluationid = isre.evaluationid and isrec.activeflag = 1                                             
 JOIN allegation a ON a.allegationid = isrec.allegationid and a.activeflag = 1                                                                                                      
 WHERE isre.intakenumber NOT IN (                                                                                                                                                   
 SELECT DISTINCT isrch.intakenumber from intakeservicerequestcourthearing isrch                                                                                                     
 JOIN intakeservicerequestcourtaction isrca ON isrca.intakeservicerequestcourthearingid = isrch.intakeservicerequestcourthearingid AND isrca.activeflag = 1                         
 WHERE isrch.activeflag = 1 AND isrch.hearingtypekey = 'Adjudi' AND isrch.intakenumber = isre.intakenumber                                                                          
 )                                                                                                                                                                                  
 GROUP BY isre.personid, a.offensecategory                                                                                                                                          
 ORDER BY isre.personid, a.offensecategory;                                                                                                                                         
                                                                                                                                                                                    
 -- Adjudication Sustained                                                                                                                                                          
 INSERT INTO sp_temp_draiprepoppendadj (personid, offensecategory, categorycount, adjtype)                                                                                          
 SELECT isre.personid, a.offensecategory, COUNT(1) categorycount, 'SUSTAINED' AS adjtype FROM sp_temp_evalids isre                                                                  
 JOIN intakeservicerequestevaluationconfig isrec ON isrec.intakeservicerequestevaluationid = isre.evaluationid and isrec.activeflag = 1                                             
 JOIN allegation a ON a.allegationid = isrec.allegationid and a.activeflag = 1                                                                                                      
 WHERE a.allegationid IN (                                                                                                                                                          
 SELECT DISTINCT caac.allegationid from intakeservicerequestcourthearing isrch                                                                                                      
 JOIN intakeservicerequestcourtaction isrca ON isrca.intakeservicerequestcourthearingid = isrch.intakeservicerequestcourthearingid AND isrca.activeflag = 1                         
 JOIN courtactionallegationconfig caac ON caac.intakeservicerequestevaluationconfigid = isrca.intakeservicerequestcourtactionid AND caac.activeflag = 1                             
 WHERE isrch.activeflag = 1 AND isrch.hearingtypekey = 'Adjudi' AND isrch.intakenumber = isre.intakenumber AND caac.adjudicateddecisiontypekey = 'S'                                
 )                                                                                                                                                                                  
 AND isre.evaluationid NOT IN (                                                                                                                                                     
 SELECT DISTINCT isrepc.intakeservicerequestevaluationid FROM intakeservreqevalpetitionconfig isrepc                                                                                
 JOIN intakeservicerequestpetition isrp ON isrp.intakeservicerequestpetitionid = isrepc.intakeservicerequestpetitionid AND isrp.activeflag = 1                                      
 JOIN intakeservreqpetitionhearingconfig isrphc ON isrphc.intakeservicerequestpetitionid = isrp.intakeservicerequestpetitionid AND isrphc.activeflag = 1                            
 JOIN intakeservicerequestcourthearing isrch ON isrch.intakeservicerequestcourthearingid = isrphc.intakeservicerequestcourthearingid AND isrch.activeflag = 1                       
 WHERE isrch.hearingtypekey = 'Disp' AND isrepc.intakeservicerequestevaluationid = isre.evaluationid AND isrepc.activeflag = 1                                                      
 ) AND isre.personid = (rv_personid :: UUID)                                                                                                                                        
 GROUP BY isre.personid, a.offensecategory                                                                                                                                          
 ORDER BY isre.personid, a.offensecategory;                                                                                                                                         
                                                                                                                                                                                    
                                                                                                                                                                                    
 -- Populate Court action ids in temp table                                                                                                                                         
 INSERT INTO sp_temp_draiprepopCourtActions (evaluationid, courtactionid, courtorderdatetime, hearingtypekey)                                                                       
 SELECT DISTINCT isre.evaluationid, isrca.intakeservicerequestcourtactionid, isrca.courtorderdatetime, isrch.hearingtypekey FROM sp_temp_evalids isre                               
 JOIN intakeservreqevalpetitionconfig isrepc ON isrepc.intakeservicerequestevaluationid = isre.evaluationid AND isrepc.activeflag = 1                                               
 JOIN intakeservicerequestpetition isrp ON isrp.intakeservicerequestpetitionid = isrepc.intakeservicerequestpetitionid AND isrp.activeflag = 1                                      
 JOIN intakeservreqpetitionhearingconfig isrphc ON isrphc.intakeservicerequestpetitionid = isrp.intakeservicerequestpetitionid AND isrphc.activeflag = 1                            
 JOIN intakeservicerequestcourthearing isrch ON isrch.intakeservicerequestcourthearingid = isrphc.intakeservicerequestcourthearingid AND isrch.activeflag = 1                       
 JOIN intakeservicerequestcourtaction isrca ON isrca.intakeservicerequestcourthearingid = isrch.intakeservicerequestcourthearingid AND isrca.activeflag = 1                         
 WHERE isre.personid = (rv_personid :: UUID);                                                                                                                                       
                                                                                                                                                                                    
 -- Disposition with Supervisor                                                                                                                                                     
 INSERT INTO sp_temp_draiprepopcompdisp (personid, courtordertypekey)                                                                                                               
 SELECT DISTINCT isre.personid, isrcotc.courtordertypekey FROM sp_temp_evalids isre                                                                                                 
 -- JOIN intakeservreqevalpetitionconfig isrepc ON isrepc.intakeservicerequestevaluationid = isre.evaluationid AND isrepc.activeflag = 1                                            
 -- JOIN intakeservicerequestpetition isrp ON isrp.intakeservicerequestpetitionid = isrepc.intakeservicerequestpetitionid AND isrp.activeflag = 1                                   
 -- JOIN intakeservreqpetitionhearingconfig isrphc ON isrphc.intakeservicerequestpetitionid = isrp.intakeservicerequestpetitionid AND isrphc.activeflag = 1                         
 -- JOIN intakeservicerequestcourthearing isrch ON isrch.intakeservicerequestcourthearingid = isrphc.intakeservicerequestcourthearingid AND isrch.activeflag = 1                    
 -- JOIN intakeservicerequestcourtaction isrca ON isrca.intakeservicerequestcourthearingid = isrch.intakeservicerequestcourthearingid AND isrca.activeflag = 1                      
 JOIN sp_temp_draiprepopCourtActions tca ON tca.evaluationid = isre.evaluationid                                                                                                    
 JOIN courtactionallegationconfig caac ON caac.intakeservicerequestevaluationconfigid = tca.courtactionid AND caac.activeflag = 1                                                   
 JOIN Intakeservicerequestcourtordertypeconfig isrcotc ON isrcotc.courtactionallegationconfigid = caac.courtactionallegationconfigid AND isrcotc.activeflag = 1                     
 WHERE tca.hearingtypekey = 'Disp' AND isrcotc.courtordertypekey in ('PB', 'PDS', 'ATD', 'PS', 'SC') AND isre.personid = (rv_personid :: UUID);                                     
                                                                                                                                                                                    
                                                                                                                                                                                    
 INSERT INTO sp_temp_draiprepopFTAadj(personid, courtactiontypekey)                                                                                                                 
 SELECT DISTINCT isre.personid, isrcatc.courtactiontypekey FROM sp_temp_evalids isre                                                                                                
 JOIN sp_temp_draiprepopCourtActions tca ON tca.evaluationid = isre.evaluationid                                                                                                    
 JOIN courtactionallegationconfig caac ON caac.intakeservicerequestevaluationconfigid = tca.courtactionid AND caac.activeflag = 1                                                   
 JOIN intakeservicerequestcourtactiontype isrcatc ON isrcatc.courtactionallegationconfigid = caac.courtactionallegationconfigid AND isrcatc.activeflag = 1                          
 WHERE tca.hearingtypekey = 'Adj' AND isrcatc.courtactiontypekey = 'FTA' AND isre.personid = (rv_personid :: UUID) AND (tca.courtorderdatetime >= CURRENT_DATE - INTERVAL '1 year');
                                                                                                                                                                                    
                                                                                                                                                                                    
 SELECT T.categorycount INTO v_count_pend_category1 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'PENDING' and T.offensecategory = 1;                                         
 SELECT T.categorycount INTO v_count_pend_category2 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'PENDING' and T.offensecategory = 2;                                         
 SELECT T.categorycount INTO v_count_pend_category3 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'PENDING' and T.offensecategory = 3;                                         
 SELECT T.categorycount INTO v_count_pend_category4 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'PENDING' and T.offensecategory = 4;                                         
 SELECT T.categorycount INTO v_count_pend_category5 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'PENDING' and T.offensecategory = 5;                                         
                                                                                                                                                                                    
 SELECT T.categorycount INTO v_count_sust_category1 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'SUSTAINED' and T.offensecategory = 1;                                       
 SELECT T.categorycount INTO v_count_sust_category2 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'SUSTAINED' and T.offensecategory = 2;                                       
 SELECT T.categorycount INTO v_count_sust_category3 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'SUSTAINED' and T.offensecategory = 3;                                       
 SELECT T.categorycount INTO v_count_sust_category4 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'SUSTAINED' and T.offensecategory = 4;                                       
 SELECT T.categorycount INTO v_count_sust_category5 FROM sp_temp_draiprepoppendadj T WHERE T.adjtype = 'SUSTAINED' and T.offensecategory = 5;                                       
                                                                                                                                                                                    
 SELECT count(1) > 0 INTO v_courtorder_supervision1 FROM sp_temp_draiprepopcompdisp T WHERE T.courtordertypekey = 'PB'; -- Probation supervision                                    
 SELECT count(1) > 0 INTO v_courtorder_supervision2 FROM sp_temp_draiprepopcompdisp T WHERE T.courtordertypekey IN ('PDS', 'ATD'); -- Precourt or ATD supervision                   
 SELECT count(1) > 0 INTO v_courtorder_supervision3 FROM sp_temp_draiprepopcompdisp T WHERE T.courtordertypekey = 'PS'; -- Intensive supervision                                    
 SELECT count(1) > 0 INTO v_courtorder_supervision4 FROM sp_temp_draiprepopcompdisp T WHERE T.courtordertypekey = 'SC'; -- Aftercare supervision                                    
                                                                                                                                                                                    
 --SELECT                                                                                                                                                                           
                                                                                                                                                                                    
 --SELECT T.intakenumber, T.offensecategory, T.categorycount FROM sp_temp_draiprepoppendadj T;                                                                                      
                                                                                                                                                                                    
 IF (v_count_pend_category1 >=2 OR v_count_pend_category2 >=2) THEN                                                                                                                 
         v_value1 := 1;                                                                                                                                                             
 ELSIF (v_count_pend_category3 >=1 OR v_count_pend_category4 >=1 OR v_count_pend_category5 >=1) THEN                                                                                
         v_value1 := 2;                                                                                                                                                             
 ELSIF (v_count_pend_category1 >=1 OR v_count_pend_category2 >=1) THEN                                                                                                              
         v_value1 := 3;                                                                                                                                                             
 ELSE                                                                                                                                                                               
         v_value1 := 4;                                                                                                                                                             
 END IF;                                                                                                                                                                            
                                                                                                                                                                                    
 IF ((v_count_sust_category3 = 1 OR v_count_sust_category4 = 1) OR v_courtorder_supervision1) THEN                                                                                  
         v_value2 := 1;                                                                                                                                                             
 ELSIF (v_count_sust_category5 >= 1 OR v_courtorder_supervision2) THEN                                                                                                              
         v_value2 := 2;                                                                                                                                                             
 ELSIF ((v_count_sust_category1 >=1 OR v_count_sust_category2 >= 1) OR v_courtorder_supervision3) THEN                                                                              
         v_value2 := 3;                                                                                                                                                             
 ELSIF ((v_count_sust_category3 >= 2 OR v_count_sust_category4 >= 2) OR v_courtorder_supervision4) THEN                                                                             
         v_value2 := 4;                                                                                                                                                             
 ELSE                                                                                                                                                                               
         v_value2 := 5;                                                                                                                                                             
 END IF;                                                                                                                                                                            
                                                                                                                                                                                    
 SELECT CASE WHEN COUNT(1) > 0 THEN 1 ELSE 2 END INTO v_value3 FROM sp_temp_draiprepopFTAadj;                                                                                       
                                                                                                                                                                                    
                                                                                                                                                                                    
 SELECT CASE WHEN COUNT(1) > 0 THEN 1 ELSE 2 END INTO v_value4 FROM personalert where activeflag = 1 AND personid = (rv_personid :: UUID) AND alerttype = 'AWOL'                    
 AND status = 'Active' AND (startdatetime >= CURRENT_DATE - INTERVAL '1 year');                                                                                                     
                                                                                                                                                                                    
 select CASE WHEN COUNT(1) > 0 THEN 1 ELSE 2 END INTO v_value5 from placement pl join provider pr on pl.providerid = pr.providerid                                                  
 join intakeservicerequestactor isra on isra.intakeserviceid = pl.intakeserviceid and isra.activeflag = 1                                                                           
 join actor a on a.actorid = isra.actorid and a.activeflag = 1                                                                                                                      
 where pr.placementadmissiontypekey = 'DET' AND a.personid = (rv_personid :: UUID)                                                                                                  
 and pl.addate >= current_date - interval '6 months';                                                                                                                               
                                                                                                                                                                                    
 SELECT CASE WHEN isre2.yearsofage <= 16 THEN 1 ELSE 2 END INTO v_value6 FROM sp_temp_evalids isre                                                                                  
 JOIN intakeservicerequestevaluationconfig isrec ON isrec.intakeservicerequestevaluationid = isre.evaluationid and isrec.activeflag = 1                                             
 JOIN allegation a ON a.allegationid = isrec.allegationid AND a.activeflag = 1                                                                                                      
 JOIN intakeservicerequestevaluation isre2 ON isre2.intakeservicerequestevaluationid = isre.evaluationid AND isre2.activeflag = 1                                                   
 WHERE a.felony = TRUE ORDER BY isre2.complaintreceiveddate LIMIT 1;                                                                                                                
                                                                                                                                                                                    
 DROP TABLE IF EXISTS sp_temp_evalids;                                                                                                                                              
 DROP TABLE IF EXISTS sp_temp_draiprepoppendadj;                                                                                                                                    
 DROP TABLE IF EXISTS sp_temp_draiprepopCourtActions;                                                                                                                               
 DROP TABLE IF EXISTS sp_temp_draiprepopcompdisp;                                                                                                                                   
 DROP TABLE IF EXISTS sp_temp_draiprepopFTAadj;                                                                                                                                     
                                                                                                                                                                                    
                                                                                                                                                                                    
 SELECT json_agg(x) INTO retJson FROM (SELECT                                                                                                                                       
 CASE WHEN v_value1 IS NOT NULL THEN v_value1 ELSE 4 END AS pend_adj,                                                                                                               
 CASE WHEN v_value2 IS NOT NULL THEN v_value2 ELSE 5 END AS sus_adj_sup,                                                                                                            
 CASE WHEN v_value3 IS NOT NULL THEN v_value3 ELSE 2 END AS fta,                                                                                                                    
 CASE WHEN v_value4 IS NOT NULL THEN v_value4 ELSE 2 END AS awol,                                                                                                                   
 CASE WHEN v_value5 IS NOT NULL THEN v_value5 ELSE 2 END AS prior_det,                                                                                                              
 CASE WHEN v_value6 IS NOT NULL THEN v_value6 ELSE 2 END AS age_felony                                                                                                              
 ) AS x;                                                                                                                                                                            
                                                                                                                                                                                    
 RETURN retJson;                                                                                                                                                                    
                                                                                                                                                                                    
 END;                                                                                                                                                                               
                                                                                                                                                                                    
                                                                                                                                                                                    
 $function$                                                                                                                                                                           

