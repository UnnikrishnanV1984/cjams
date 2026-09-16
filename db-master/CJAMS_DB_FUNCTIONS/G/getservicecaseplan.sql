 CREATE OR REPLACE FUNCTION public.getservicecaseplan(v_objectid uuid, v_lipagenumber bigint, v_lipagesize bigint)                                                                   
  RETURNS json                                                                                                                                                                       
  LANGUAGE plpgsql                                                                                                                                                                   
 AS $function$                                                                                                                                                                     
                                                                                                                                                                                   
 DECLARE                                                                                                                                                                           
 v_pagenumber int;                                                                                                                                                                 
 v_pageoffset int;                                                                                                                                                                 
 l_serviceplanlist json;                                                                                                                                                           
                                                                                                                                                                                   
 BEGIN                                                                                                                                                                             
                                                                                                                                                                                   
 SELECT                                                                                                                                                                            
         json_agg(e) INTO l_serviceplanlist                                                                                                                                        
 FROM                                                                                                                                                                              
 (                                                                                                                                                                                 
         SELECT                                                                                                                                                                    
                 spg.serviceplangoalid,                                                                                                                                            
                 isr.servicerequestnumber,                                                                                                                                         
                 isr.intakeserviceid,                                                                                                                                              
                 spg.goaldate plandate,                                                                                                                                            
                 spg.goal,                                                                                                                                                         
                 up.firstname || ' '|| up.lastname supervisor,                                                                                                                     
                 (                                                                                                                                                                 
                         SELECT json_agg(e) FROM                                                                                                                                   
                         (                                                                                                                                                         
                                 SELECT                                                                                                                                            
                                         f1.servicetypedescription,                                                                                                                
                                         e1.servicesubtypedescription,                                                                                                             
                                         spa1.serviceplanactivityid,                                                                                                               
                                         spa1.responsibleperson associatedworker,                                                                                                  
                                         ss1.description AS serviceplanactivitystatustypedescription,                                                                              
                                         spa1.completiondate,                                                                                                                      
                                         spa1.activity,                                                                                                                            
                                         spa1.servicesubtypekey,                                                                                                                   
                                         spa1.servicetypekey,                                                                                                                      
                                         spa1.personinvolved,                                                                                                                      
                                         spa1.serviceplanactivitystatustypekey,                                                                                                    
                                         spa1.reevaluationdate,                                                                                                                    
                                         spa1.insertedby AS activitydate,                                                                                                          
                                         spa1.responsibleperson                                                                                                                    
                                 FROM serviceplanactivity spa1                                                                                                                     
                                 INNER JOIN servicetype f1 ON f1.servicetypekey = spa1.servicetypekey AND f1.activeflag = 1                                                        
                                 INNER JOIN servicesubtype e1 ON e1.servicesubtypekey = spa1.servicesubtypekey AND e1.activeflag = 1                                               
                                 INNER JOIN serviceplanactivitystatustype ss1 ON spa1.serviceplanactivitystatustypekey = ss1.serviceplanactivitystatustypekey AND ss1.activeflag =1
                                 WHERE spa1.serviceplangoalid = spg.serviceplangoalid AND spa1.activeflag=1 AND spa1.objectid :: uuid = isr.intakeserviceid                        
                         ) e                                                                                                                                                       
                 ) :: json AS activities                                                                                                                                           
         FROM serviceplangoal spg                                                                                                                                                  
         INNER JOIN intakeservicerequest isr ON isr.intakeserviceid = spg.objectid :: uuid AND isr.activeflag =1                                                                   
         INNER JOIN serviceplanactivity spa ON spa.serviceplangoalid = spg.serviceplangoalid AND spa.activeflag =1 AND spa.objectid :: uuid = isr.intakeserviceid                  
         INNER JOIN userprofile up ON up.securityusersid = isr.insertedby AND up.activeflag =1                                                                                     
         WHERE isr.servicecaseid= v_objectid AND spg.activeflag =1                                                                                                                 
         GROUP BY spg.serviceplangoalid,isr.servicerequestnumber,isr.intakeserviceid,spg.goaldate,spg.goal,supervisor                                                              
         LIMIT v_liPageSize OFFSET v_pageoffset                                                                                                                                    
 ) e;                                                                                                                                                                              
                                                                                                                                                                                   
 RETURN l_serviceplanlist;                                                                                                                                                         
 END;                                                                                                                                                                              
                                                                                                                                                                                   
 $function$                                                                                                                                                                          

