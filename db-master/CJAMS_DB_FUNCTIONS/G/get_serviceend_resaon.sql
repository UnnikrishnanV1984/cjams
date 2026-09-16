 CREATE OR REPLACE FUNCTION public.get_serviceend_resaon()                                    
  RETURNS TABLE(service_end_reason character varying, service_end_reason_cd character varying)
  LANGUAGE plpgsql                                                                            
 AS $function$                                                                                
                                                                                              
                                                                                              
                                                                                              
 BEGIN                                                                                        
                                                                                              
 return query                                                                                 
                                                                                              
 SELECT --TPV.picklist_type_id AS "picklist_type_id"                                          
        TPV.value_tx AS "service_end_reason"                                                  
           ,Trim(TPV.picklist_value_cd):: character varying "service_end_reason_cd"           
 FROM tb_picklist_values AS TPV                                                               
 WHERE TPV.picklist_type_id = 164;                                                            
                                                                                              
 END;                                                                                         
                                                                                              
 $function$                                                                                   

