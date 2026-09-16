 CREATE OR REPLACE FUNCTION public.externalentity(v_intakeserviceid uuid, v_securityusersid character varying)                                   
  RETURNS character varying                                                                                                                      
  LANGUAGE plpgsql                                                                                                                               
 AS $function$                                                                                                                                   
                                                                                                                                                 
 DECLARE                                                                                                                                         
 v_agencyid character varying;                                                                                                                   
 v_agencyname character varying;                                                                                                                 
 v_agencytype character varying;                                                                                                                 
 v_danumber character varying;                                                                                                                   
 v_notifystatus character varying;                                                                                                               
 v_auditlog character varying;                                                                                                                   
 v_metadata json;                                                                                                                                
 v_agencyid_rec RECORD;                                                                                                                          
 v_securityusersid_rec RECORD;                                                                                                                   
 v_securityid character varying;                                                                                                                 
 BEGIN                                                                                                                                           
                                                                                                                                                 
  FOR v_agencyid_rec IN  SELECT agencyid   FROM intakeservicerequestagency                                                                       
 where intakeserviceid = v_intakeserviceid and agencyroletypekey='ALMA'                                                                          
 LOOP                                                                                                                                            
         v_agencyid = v_agencyid_rec.agencyid;                                                                                                   
                                                                                                                                                 
    RAISE NOTICE ' result %', v_agencyid;                                                                                                        
         SELECT agencyname,agencytypekey  FROM  agency where agencyid = v_agencyid::uuid  and activeflag = 1 INTO v_agencyname,v_agencytype;     
                                                                                                                                                 
         SELECT servicerequestnumber from intakeservicerequest where  intakeserviceid = v_intakeserviceid INTO v_danumber;                       
                                                                                                                                                 
         /*Notification*/                                                                                                                        
     SELECT send_notification into v_notifystatus from send_notification(v_securityusersid,v_securityusersid, v_securityusersid,                 
                 'System', 'High', v_agencyname,v_agencytype, v_danumber,true);                                                                  
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
     FOR v_securityusersid_rec IN                                                                                                                
           SELECT   up.securityusersid                                                                                                           
         FROM  userprofile up                                                                                                                    
         JOIN teammemberassignment tma on up.securityusersid = tma.securityusersid                                                               
         AND tma.activeflag = 1 AND up.activeflag = 1                                                                                            
         JOIN teammember  tm on  tma.teammemberid = tm.teammemberid and tm.activeflag = 1                                                        
         JOIN teammemberroletype  tmr on tm.roletypekey = tmr.roletypekey and tmr.activeflag = 1                                                 
         AND isupervisor = true                                                                                                                  
     and tma.securityusersid not in (v_securityusersid)                                                                                          
     LOOP                                                                                                                                        
         v_securityid = v_securityusersid_rec.securityusersid;                                                                                   
                                                                                                                                                 
          RAISE NOTICE ' result %', v_securityid;                                                                                                
                                                                                                                                                 
         SELECT send_notification into v_notifystatus FROM                                                                                       
           send_notification(v_securityid,v_securityusersid, v_securityid,                                                                       
                 'System', 'High', v_agencyname,v_agencytype, v_danumber,true);                                                                  
                                                                                                                                                 
                                                                                                                                                 
     END LOOP;                                                                                                                                   
                                                                                                                                                 
         /*Audit Log*/                                                                                                                           
         SELECT json_agg(e) from (select v_agencyname  agencyname,v_agencytype  agencytype, v_danumber danumber)e INTO v_metadata;               
                                                                                                                                                 
         SELECT auditlog into v_auditlog from auditlog                                                                                           
             ('IE', v_agencyname||' added to DA#'||v_danumber ,null,v_danumber,v_intakeserviceid,                                                
              v_securityusersid,                                                                                                                 
              v_metadata,                                                                                                                        
              null,                                                                                                                              
              true,false,false);                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
 end loop;                                                                                                                                       
 RETURN 'success' ;                                                                                                                              
                                                                                                                                                 
 END;                                                                                                                                            
                                                                                                                                                 
 $function$                                                                                                                                      

