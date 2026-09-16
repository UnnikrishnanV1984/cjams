 CREATE OR REPLACE FUNCTION public.get_servicenot_received()                                             
  RETURNS TABLE(reason_service_not_received character varying, service_not_received_cd character varying)
  LANGUAGE plpgsql                                                                                       
 AS $function$                                                                                           
                                                                                                         
         --SELECT * FROM tb_picklist_values                                                              
 BEGIN                                                                                                   
                                                                                                         
 return query                                                                                            
                                                                                                         
 SELECT --TPV.picklist_type_id AS "picklist_type_id"                                                     
        TPV.value_tx AS "reason_service_not_received"                                                    
           ,TPV.picklist_value_cd "service_not_received_cd"                                              
 FROM tb_picklist_values AS TPV                                                                          
 WHERE TPV.picklist_type_id = 167;                                                                       
                                                                                                         
 END;                                                                                                    
                                                                                                         
 $function$                                                                                              

