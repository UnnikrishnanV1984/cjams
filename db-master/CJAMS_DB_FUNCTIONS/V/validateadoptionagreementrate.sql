 CREATE OR REPLACE FUNCTION public.validateadoptionagreementrate(v_adoptionagreementid uuid, v_startdate timestamp without time zone, v_enddate timestamp without time zone)
  RETURNS TABLE(statuscode integer, status_description character varying)                                                                                                   
  LANGUAGE plpgsql                                                                                                                                                          
 AS $function$                                                                                                                                                            
                                                                                                                                                                          
                                                                                                                                                                          
 DECLARE                                                                                                                                                                  
 l_count int;                                                                                                                                                             
 statuscode integer;                                                                                                                                                      
 status_description character varying;                                                                                                                                    
 v_dob date;                                                                                                                                                              
                                                                                                                                                                          
 BEGIN                                                                                                                                                                    
                                                                                                                                                                          
 IF (v_adoptionagreementid is not null) THEN                                                                                                                              
                                                                                                                                                                          
         SELECT (ps.dob :: date + interval '18 year') :: date INTO v_dob FROM adoptionagreement aa                                                                        
         INNER JOIN adoptionplanning ap  ON  aa.adoptionplanningid = ap.adoptionplanningid AND ap.activeflag =1                                                           
         INNER JOIN intakeservicerequestactor isr ON isr.intakeserviceid = ap.intakeserviceid  AND isr.intakeservicerequestpersontypekey = 'RC'                           
         INNER JOIN person ps  ON isr.personid = ps.personid and ps.activeflag =1                                                                                         
         WHERE aa.adoptionagreementid = v_adoptionagreementid                                                                                                             
         AND aa.activeflag = 1;                                                                                                                                           
                                                                                                                                                                          
         SELECT count(1) into l_count FROM adoptionagreementrate where adoptionagreementid = v_adoptionagreementid                                                        
         AND activeflag = 1                                                                                                                                               
         AND(startdate::date, enddate::date) OVERLAPS (v_startdate::date, v_enddate::date)                                                                                
         AND enddate::date < v_dob ;                                                                                                                                      
                                                                                                                                                                          
 END IF;                                                                                                                                                                  
                                                                                                                                                                          
 IF (l_count >= 1) THEN                                                                                                                                                   
                                                                                                                                                                          
         statuscode:= 500;                                                                                                                                                
         status_description := 'Invalid date selection';                                                                                                                  
                                                                                                                                                                          
                                                                                                                                                                          
 ELSE                                                                                                                                                                     
         statuscode:= 200;                                                                                                                                                
         status_description := 'Valid Date';                                                                                                                              
                                                                                                                                                                          
 END IF;                                                                                                                                                                  
                                                                                                                                                                          
 RETURN  QUERY                                                                                                                                                            
                                                                                                                                                                          
 SELECT statuscode,status_description;                                                                                                                                    
                                                                                                                                                                          
 END;                                                                                                                                                                     
                                                                                                                                                                          
                                                                                                                                                                          
 $function$                                                                                                                                                                 

