 DROP FUNCTION public.get_servlist_names();
 CREATE OR REPLACE FUNCTION get_servlist_names()              
  RETURNS TABLE("SERVICE_ID" integer, "SERVICE_NM" character varying)
  LANGUAGE plpgsql                                                   
 AS $function$                                                       
                                                                     
 BEGIN                                                               
 RETURN QUERY                                                        
 SELECT SERVICE_ID AS "SERVICE_ID"                                   
       ,SERVICE_NM AS "SERVICE_NM"                                   
 FROM TB_SERVICES --AS S                                             
 WHERE   STRUCTURE_SERVICE_CD='S'                                    
 AND paid_non_paid_cd = '6090' 
 order by SERVICE_NM asc;                                     
 END                                                                 
                                                                     
 $function$                                                          

