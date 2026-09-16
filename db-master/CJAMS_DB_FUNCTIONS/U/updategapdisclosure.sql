 CREATE OR REPLACE FUNCTION public.updategapdisclosure(v_gapid uuid)    
  RETURNS text                                                          
  LANGUAGE plpgsql                                                      
 AS $function$                                                          
                                                                        
 Begin                                                                  
                                                                        
 UPDATE  gapdisclosure  set  activeflag  =  0  where  gapid  =  v_gapid;
 Return  'Success';                                                     
                                                                        
 End;                                                                   
                                                                        
 $function$                                                             

