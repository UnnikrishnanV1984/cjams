 CREATE OR REPLACE FUNCTION public.updatepetition(v_petitionid uuid)                                                      
  RETURNS text                                                                                                            
  LANGUAGE plpgsql                                                                                                        
 AS $function$                                                                                                            
                                                                                                                          
 Begin                                                                                                                    
                                                                                                                          
 UPDATE  Intakeservicerequestpetitionactor  set  activeflag  =  0  where  intakeservicerequestpetitionid  =  v_petitionid;
 Return  'Success';                                                                                                       
                                                                                                                          
 End;                                                                                                                     
                                                                                                                          
 $function$                                                                                                               

