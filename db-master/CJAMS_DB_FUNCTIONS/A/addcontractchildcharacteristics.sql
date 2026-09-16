 CREATE OR REPLACE FUNCTION public.addcontractchildcharacteristics(insertedtlsobj json)                                                                      
  RETURNS text                                                                                                                                               
  LANGUAGE plpgsql                                                                                                                                           
 AS $function$                                                                                                                                               
                                                                                                                                                             
 DECLARE                                                                                                                                                     
 returnStatus text;                                                                                                                                          
 providerId numeric;                                                                                                                                         
 programId numeric;                                                                                                                                          
 services json;                                                                                                                                              
 picklistTypeId text;                                                                                                                                        
 picklistValueCode text;                                                                                                                                     
 currentRow json;                                                                                                                                            
                                                                                                                                                             
 BEGIN                                                                                                                                                       
                                                                                                                                                             
 providerId=insertedtlsobj->>'provider_id';                                                                                                                  
 programId =insertedtlsobj->>'program_id';                                                                                                                   
 services = insertedtlsobj->>'services';                                                                                                                     
                                                                                                                                                             
 --picklistTypeId= insertedtlsobj->>'picklist_type_id';                                                                                                      
 --picklistValueCode= insertedtlsobj->>'picklist_value_cd';                                                                                                  
                                                                                                                                                             
 for currentRow IN SELECT * FROM json_array_elements(services)                                                                                               
 loop                                                                                                                                                        
 insert into tb_provider_picklist (provider_id, program_id,picklist_type_id,picklist_value_cd, value_desc, create_ts,create_user_id,update_ts,update_user_id)
 values                                                                                                                                                      
 (providerId, programId, (currentRow->>'picklist_type_id')::numeric, currentRow->>'picklist_value_cd', currentRow->>'value_tx',                              
 insertedtlsobj->>'create_ts', insertedtlsobj->>'create_user_id', insertedtlsobj->>'update_ts', insertedtlsobj->>'update_user_id');                          
 END LOOP;                                                                                                                                                   
                                                                                                                                                             
 returnStatus:= 'Success';                                                                                                                                   
                                                                                                                                                             
 RETURN returnStatus;                                                                                                                                        
                                                                                                                                                             
 END;                                                                                                                                                        
                                                                                                                                                             
 $function$                                                                                                                                                  

