 CREATE OR REPLACE FUNCTION public.saverestitutionccuconfig(v_restitution json, securityuserid character varying)                                                                  
  RETURNS text                                                                                                                                                                     
  LANGUAGE plpgsql                                                                                                                                                                 
 AS $function$                                                                                                                                                                   
                                                                                                                                                                                 
 DECLARE                                                                                                                                                                         
                                                                                                                                                                                 
         v_youthpersonid uuid;                                                                                                                                                   
         v_ccuno int;                                                                                                                                                            
         v_restitutionno integer;                                                                                                                                                
         v_ccunotes text;                                                                                                                                                        
         i_restitutionccuconfigcount int;                                                                                                                                        
         v_youthpersonname character varying;                                                                                                                                    
         restitution json;                                                                                                                                                       
         v_countyid uuid;                                                                                                                                                        
         v_securityuserid character varying;                                                                                                                                     
         v_restitutionccuconfigid uuid;                                                                                                                                          
         v_date timestamp without time zone;                                                                                                                                     
         j_restitutionccuconfig json;                                                                                                                                            
 BEGIN                                                                                                                                                                           
                                                                                                                                                                                 
         v_securityuserid := securityuserid;                                                                                                                                     
                                                                                                                                                                                 
                                                                                                                                                                                 
         v_restitutionno:= v_restitution ->>'restitutionno';                                                                                                                     
         v_ccunotes := v_restitution->>'ccunotes';                                                                                                                               
         v_date:= now() at time zone 'utc';                                                                                                                                      
                                                                                                                                                                                 
         RAISE NOTICE ' v_restitutionno:  %',v_restitutionno;                                                                                                                    
                                                                                                                                                                                 
         select count(1) into i_restitutionccuconfigcount from restitutionccuconfig where restitutionno = v_restitutionno::integer and lower(status) = 'open' and activeflag = 1;
                                                                                                                                                                                 
         IF (i_restitutionccuconfigcount = 0) THEN                                                                                                                               
                                                                                                                                                                                 
         SELECT MAX(ccuno)+1 INTO v_ccuno FROM restitutionccuconfig WHERE activeflag = 1;                                                                                        
                                                                                                                                                                                 
         IF v_ccuno IS NULL THEN                                                                                                                                                 
                 v_ccuno := 1000000;                                                                                                                                             
         END IF;                                                                                                                                                                 
         v_restitutionccuconfigid := gen_random_uuid();                                                                                                                          
                                                                                                                                                                                 
         Insert into restitutionccuconfig(restitutionccuconfigid, restitutionno, ccuno, status, ccunotes, activeflag, insertedby, updatedby, insertedon, updatedon)              
         Values(v_restitutionccuconfigid, v_restitutionno, v_ccuno, 'Open', v_ccunotes, 1, v_securityuserid, v_securityuserid, v_date, v_date);                                  
                                                                                                                                                                                 
         ELSE                                                                                                                                                                    
                                                                                                                                                                                 
          Update restitutionccuconfig set ccunotes = v_ccunotes, updatedon = v_date where restitutionno = v_restitutionno and lower(status) = 'open' and activeflag = 1;         
                                                                                                                                                                                 
         END IF;                                                                                                                                                                 
                                                                                                                                                                                 
                                                                                                                                                                                 
                                                                                                                                                                                 
 RETURN                                                                                                                                                                          
           'Success';                                                                                                                                                            
 END;                                                                                                                                                                            
                                                                                                                                                                                 
                                                                                                                                                                                 
 $function$                                                                                                                                                                        

