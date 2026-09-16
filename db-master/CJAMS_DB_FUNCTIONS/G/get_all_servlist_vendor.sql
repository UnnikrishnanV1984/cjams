/*
-- 08-17-2026 Veera N To fix 400 Bad Request error CIDM-11600
*/
 CREATE OR REPLACE FUNCTION cjams.get_all_servlist_vendor()
  RETURNS TABLE(service_id integer, service_nm character varying)                                                                          
  LANGUAGE plpgsql                                                                                                                         
 AS $function$                                                                                                                           
                                                                                                                                         
 BEGIN                                                                                                                                   
 RETURN QUERY                                                                                                                            
                                                                                                                                         
 SELECT CASE WHEN TSR.service_id IS NOT NULL THEN TSR.service_id END AS "service_id"                                                     
           ,CASE WHEN TSR.service_nm IS NOT NULL THEN TSR.service_nm END AS "service_nm"                                                 
                                                                                                                                         
 FROM prov.tb_services TSR
 ;                                                                                                                                       
                                                                                                                                         
 END                                                                                                                                     
                                                                                                                                         
 $function$;

