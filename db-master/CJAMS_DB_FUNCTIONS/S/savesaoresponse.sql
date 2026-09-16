 CREATE OR REPLACE FUNCTION public.savesaoresponse(v_intakenumber character varying, jsondata json, v_securityuserid character varying)                                         
  RETURNS text                                                                                                                                                                  
  LANGUAGE plpgsql                                                                                                                                                              
 AS $function$                                                                                                                                                                  
                                                                                                                                                                                
 DECLARE                                                                                                                                                                        
                                                                                                                                                                                
 --v_date timestamp without time zone;                                                                                                                                          
 i_saoresponsecount int;                                                                                                                                                        
 v_intakejson json;                                                                                                                                                             
 j_saoresponse json;                                                                                                                                                            
 v_saoresponseid uuid;                                                                                                                                                          
                                                                                                                                                                                
 BEGIN                                                                                                                                                                          
                                                                                                                                                                                
 select count(1) into i_saoresponsecount from saoresponse where intakenumber = v_intakenumber and activeflag = 1;                                                               
 j_saoresponse := jsondata;                                                                                                                                                     
                                                                                                                                                                                
  -- SAO Response                                                                                                                                                               
                 IF (i_saoresponsecount = 0) THEN                                                                                                                               
                                                                                                                                                                                
                 v_saoresponseid :=   gen_random_uuid();                                                                                                                        
                                                                                                                                                                                
                 Insert Into saoresponse (saoresponseid, saoresponsedate, saoresponsestatustypekey, saoresponseconditiontypekey, intakenumber, activeflag, insertedby,updatedby)
                         values (v_saoresponseid,cast(j_saoresponse ->> 'saoresponsedate' as timestamp without time zone),                                                      
                         cast(j_saoresponse ->> 'saoresponsestatustypekey' as character varying),cast(j_saoresponse ->> 'saoresponseconditiontypekey' as character varying),    
                          v_intakenumber, 1, v_securityuserid, v_securityuserid);                                                                                               
                                                                                                                                                                                
                 END IF;                                                                                                                                                        
                                                                                                                                                                                
      Return 'Success';                                                                                                                                                         
                                                                                                                                                                                
 END;                                                                                                                                                                           
                                                                                                                                                                                
 $function$                                                                                                                                                                     

