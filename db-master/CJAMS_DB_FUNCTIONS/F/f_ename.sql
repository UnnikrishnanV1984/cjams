 CREATE OR REPLACE FUNCTION public.f_ename(as_type_cd character varying, ai_key_id integer, as_report character varying)
  RETURNS character varying                                                                                             
  LANGUAGE plpgsql                                                                                                      
 AS $function$                                                                                                          
                                                                                                                        
 DECLARE                                                                                                                
    declare outtx varchar(200);                                                                                         
 BEGIN                                                                                                                  
                                                                                                                        
  SELECT f_sp_ename3(AS_TYPE_CD,AI_KEY_ID,AS_REPORT) INTO outtx;                                                        
  RETURN outtx;                                                                                                         
 END;                                                                                                                   
                                                                                                                        
                                                                                                                        
 $function$                                                                                                             

