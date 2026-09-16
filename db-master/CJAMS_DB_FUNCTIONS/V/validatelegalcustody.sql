 CREATE OR REPLACE FUNCTION public.validatelegalcustody(v_permanencyplanid uuid, v_legalcustodyid uuid, v_fromdate timestamp without time zone, v_todate timestamp without time zone)
  RETURNS TABLE(statuscode integer, status_description character varying)                                                                                                            
  LANGUAGE plpgsql                                                                                                                                                                   
 AS $function$                                                                                                                                                                     
                                                                                                                                                                                   
 DECLARE                                                                                                                                                                           
 l_count int;                                                                                                                                                                      
 statuscode integer;                                                                                                                                                               
 status_description character varying;                                                                                                                                             
                                                                                                                                                                                   
 BEGIN                                                                                                                                                                             
                                                                                                                                                                                   
 IF (v_legalcustodyid is not null) THEN                                                                                                                                            
                                                                                                                                                                                   
         SELECT count(1) into l_count FROM legalcustody where permanencyplanid = v_permanencyplanid AND  legalcustodyid != v_legalcustodyid                                        
         AND activeflag = 1                                                                                                                                                        
         AND(fromdate::date, todate::date) OVERLAPS (v_fromdate::date, v_todate::date);                                                                                            
                                                                                                                                                                                   
 ELSIF (v_permanencyplanid is not null) THEN                                                                                                                                       
                                                                                                                                                                                   
         SELECT count(1) into l_count FROM legalcustody WHERE permanencyplanid = v_permanencyplanid                                                                                
         AND activeflag = 1                                                                                                                                                        
         AND(fromdate::date, todate::date) OVERLAPS (v_fromdate::date, v_todate::date);                                                                                            
                                                                                                                                                                                   
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

