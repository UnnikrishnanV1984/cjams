 CREATE OR REPLACE FUNCTION public.addupdatecaseplancaseevaluationclients(caseevaluation json)                                             
  RETURNS text                                                                                                                             
  LANGUAGE plpgsql                                                                                                                         
 AS $function$                                                                                                                           
                                                                                                                                         
         DECLARE                                                                                                                         
         v_caseevaluation json;                                                                                                          
         v_date timestamp without time zone;                                                                                             
     v_evaluationdate timestamp without time zone;                                                                                       
                                                                                                                                         
         BEGIN                                                                                                                           
                                                                                                                                         
                 v_caseevaluation := caseevaluation;                                                                                     
                 v_date:= now() at time zone 'utc';                                                                                      
             IF (LENGTH(v_caseevaluation->>'caseevaluationclientid')>1 ) THEN                                                            
                  UPDATE caseplancaseevaluationclients                                                                                   
                                   SET                                                                                                   
                                         caseevaluationid=(v_caseevaluation->>'caseevaluationid')::uuid,                                 
                                         personid=(v_caseevaluation->>'personid')::uuid,                                                 
                                         serviceparticipatetypekey =v_caseevaluation->>'serviceparticipatetypekey',                      
                                         serviceparticipatetx =v_caseevaluation->>'serviceparticipatetx',                                
                                         serviceplansigntypekey =v_caseevaluation->>'serviceplansigntypekey',                            
                                         servicetypekey = v_caseevaluation->>'servicetypekey',                                           
                                         serviceplansigntx = v_caseevaluation->>'serviceplansigntx',                                     
                                         datavalidflag =(v_caseevaluation->>'datavalidflag')::int,                                       
                                         insertedby=     v_caseevaluation->>'insertedby',                                                
                                         insertedon=     (v_caseevaluation->>'insertedon')::  DATE,                                      
                                         updatedby=      v_caseevaluation->>'updatedby',                                                 
                                         updatedon=      (v_caseevaluation->>'updatedon')::  DATE,                                       
                                         clientmergeid =(v_caseevaluation->>'clientmergeid')::uuid,                                      
                                         old_id = v_caseevaluation->>'old_id'                                                            
                                   WHERE  caseevaluationid = (v_caseevaluation->>'caseevaluationclientid')::uuid;                        
             ELSE                                                                                                                        
                      INSERT INTO caseplancaseevaluationclients                                                                          
                    (caseevaluationid,                                                                                                   
                                         personid,                                                                                       
                                         serviceparticipatetypekey,                                                                      
                                         serviceparticipatetx,                                                                           
                                         serviceplansigntypekey,                                                                         
                                         servicetypekey,                                                                                 
                                         serviceplansigntx,                                                                              
                                         datavalidflag,                                                                                  
                                         insertedby,                                                                                     
                                         insertedon,                                                                                     
                                         updatedby,                                                                                      
                                         updatedon,                                                                                      
                                         clientmergeid,                                                                                  
                                         old_id                                                                                          
                     )                                                                                                                   
                     VALUES(                                                                                                             
                             (v_caseevaluation->>'caseevaluationid')::uuid,                                                              
                                                 (v_caseevaluation->>'personid')::uuid,                                                  
                                                 v_caseevaluation->>'serviceparticipatetypekey',                                         
                                                 v_caseevaluation->>'serviceparticipatetx',                                              
                                                 v_caseevaluation->>'serviceplansigntypekey',                                            
                                                  v_caseevaluation->>'servicetypekey',                                                   
                                                  v_caseevaluation->>'serviceplansigntx',                                                
                                                 (v_caseevaluation->>'datavalidflag')::int,                                              
                                                 v_caseevaluation->>'insertedby',                                                        
                                                 (v_caseevaluation->>'insertedon')::  DATE,                                              
                                                         v_caseevaluation->>'updatedby',                                                 
                                                         (v_caseevaluation->>'updatedon')::  DATE,                                       
                                                 (v_caseevaluation->>'clientmergeid')::uuid,                                             
                                                  v_caseevaluation->>'old_id'                                                            
                     );                                                                                                                  
                                                                                                                                         
                                                                                                                                         
                                                                                                                                         
                 END IF;                                                                                                                 
                                                                                                                                         
                                                                                                                                         
                                                                                                                                         
     return 'Success';                                                                                                                   
         END;                                                                                                                            
                                                                                                                                         
 $function$                                                                                                                                

