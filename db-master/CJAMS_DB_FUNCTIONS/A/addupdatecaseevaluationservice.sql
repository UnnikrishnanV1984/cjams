 CREATE OR REPLACE FUNCTION public.addupdatecaseevaluationservice(caseevaluation json)                                                     
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
             IF (LENGTH(v_caseevaluation->>'caseevaluationserviceid')>1 ) THEN                                                           
                  UPDATE caseevaluationservice                                                                                           
                                   SET                                                                                                   
                                         caseevaluationid=(v_caseevaluation->>'caseevaluationid')::uuid,                                 
                                         servicelogid=(v_caseevaluation->>'servicelogid')::uuid,                                         
                                         activeflag =(v_caseevaluation->>'activeflag')::int,                                             
                                         personid =(v_caseevaluation->>'personid')::uuid,                                                
                                         servicetypekey = v_caseevaluation->>'servicetypekey',                                           
                                         startdate = (v_caseevaluation->>'startdate')::  DATE,                                           
                                         enddate = (v_caseevaluation->>'enddate')::  DATE,                                               
                                         datavalidflag =(v_caseevaluation->>'datavalidflag')::int,                                       
                                         insertedby=     v_caseevaluation->>'insertedby',                                                
                                         insertedon=     (v_caseevaluation->>'insertedon')::  DATE,                                      
                                         updatedby=      v_caseevaluation->>'updatedby',                                                 
                                         updatedon=      (v_caseevaluation->>'updatedon')::  DATE,                                       
                                         clientmergeid =(v_caseevaluation->>'clientmergeid')::uuid,                                      
                                         old_id = v_caseevaluation->>'old_id'                                                            
                                   WHERE  caseevaluationserviceid = (v_caseevaluation->>'caseevaluationserviceid')::uuid;                
             ELSE                                                                                                                        
                      INSERT INTO caseevaluationservice                                                                                  
                    (caseevaluationid,servicelogid,activeflag,                                                                           
                                         personid,servicetypekey,startdate,enddate,                                                      
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
                                                 (v_caseevaluation->>'servicelogid')::uuid,                                              
                                                 (v_caseevaluation->>'activeflag')::int,                                                 
                                                 (v_caseevaluation->>'personid')::uuid,                                                  
                                                 v_caseevaluation->>'servicetypekey',                                                    
                                                 (v_caseevaluation->>'startdate')::  DATE,                                               
                                                 (v_caseevaluation->>'enddate')::  DATE,                                                 
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

