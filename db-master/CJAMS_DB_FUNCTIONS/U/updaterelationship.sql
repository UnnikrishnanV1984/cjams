 CREATE OR REPLACE FUNCTION public.updaterelationship(v_intakeservicerequestactorid uuid, v_relationshiptypekey character varying)                                                
  RETURNS text                                                                                                                                                                    
  LANGUAGE plpgsql                                                                                                                                                                
 AS $function$                                                                                                                                                                  
                                                                                                                                                                                
 DECLARE                                                                                                                                                                        
                                                                                                                                                                                
 BEGIN                                                                                                                                                                          
                                                                                                                                                                                
         UPDATE  actorrelationship  SET  relationshiptypekey  =v_relationshiptypekey , updatedon = now() WHERE    intakeservicerequestactorid  =  v_intakeservicerequestactorid;
                                                                                                                                                                                
                                                                                                                                                                                
 RETURN  'Success';                                                                                                                                                             
                                                                                                                                                                                
 END;                                                                                                                                                                           
                                                                                                                                                                                
 $function$                                                                                                                                                                       

