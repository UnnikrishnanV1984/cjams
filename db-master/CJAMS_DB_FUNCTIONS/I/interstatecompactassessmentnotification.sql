 CREATE OR REPLACE FUNCTION public.interstatecompactassessmentnotification(v_assessmentid uuid, v_securityusersid character varying)                                   
  RETURNS character varying                                                                                                                                            
  LANGUAGE plpgsql                                                                                                                                                     
 AS $function$                                                                                                                                                         
                                                                                                                                                                       
 DECLARE                                                                                                                                                               
 v_status character varying;                                                                                                                                           
 v_msg character varying;                                                                                                                                              
 i_notifywhencompletecount int;                                                                                                                                        
 v_icjrcsecurityusersid uuid;                                                                                                                                          
 v_intakeserviceid uuid;                                                                                                                                               
 v_servicerequestnumber character varying;                                                                                                                             
 v_username character varying;                                                                                                                                         
                                                                                                                                                                       
 BEGIN                                                                                                                                                                 
 /* DJS Assessment after complete Notification send ICJ Case Worker to ICJ Regional Coordinator -  Quarterly Progress, Violation, or Absconder Report */               
 select count(1) into i_notifywhencompletecount from assessmenttemplate as AMT                                                                                         
 JOIN assessment as AM ON AM.assessmenttemplateid = AMT.assessmenttemplateid and AMT.activeflag = 1                                                                    
 where AM.assessmentid = v_assessmentid and AM.activeflag = 1 and AMT.notifywhencomplete=true limit 1;                                                                 
                                                                                                                                                                       
                                                                                                                                                                       
 IF (i_notifywhencompletecount >= 1) THEN                                                                                                                              
                                                                                                                                                                       
 select TMA2.securityusersid into v_icjrcsecurityusersid from teammemberassignment TMA                                                                                 
 join teammember TM on TM.teammemberid = TMA.teammemberid                                                                                                              
 join teammember TM2 on TM.teamid = TM2.teamid and TM2.roletypekey like'%JSRC'                                                                                         
 join teammemberassignment TMA2 on TM2.teammemberid = TMA2.teammemberid                                                                                                
 where TMA.securityusersid = v_securityusersid limit 1;                                                                                                                
                                                                                                                                                                       
 /*SELECT coalesce(lastname,'')||', '|| coalesce(firstname,'')into v_username                                                                                          
 FROM userprofile WHERE securityusersid = v_securityuserid; */                                                                                                         
                                                                                                                                                                       
 select ISR.intakeserviceid, ISR.servicerequestnumber into v_intakeserviceid, v_servicerequestnumber from assessment as A                                              
 Join intakeservicerequest as ISR ON ISR.intakeserviceid = A.objectid                                                                                                  
 JOIN assessmenttemplate as AMT ON AMT.assessmenttemplateid = A.assessmenttemplateid and AMT.activeflag = 1                                                            
 where A.assessmentid = v_assessmentid order by A.insertedon desc limit 1;                                                                                             
                                                                                                                                                                       
                                                                                                                                                                       
 v_msg:=   'Assessments Completed (Quarterly Progress, Violation, or Absconder Report). Case ('|| v_servicerequestnumber ||').';                                       
                                                                                                                                                                       
 SELECT send_notification INTO v_status FROM send_notification(v_icjrcsecurityusersid::character varying, v_securityusersid, v_icjrcsecurityusersid::character varying,
 'System', 'High', v_msg, v_msg , v_intakeserviceid::character varying);                                                                                               
                                                                                                                                                                       
 END IF;                                                                                                                                                               
 RETURN 'Success';                                                                                                                                                     
                                                                                                                                                                       
 END;                                                                                                                                                                  
                                                                                                                                                                       
                                                                                                                                                                       
 $function$                                                                                                                                                            

