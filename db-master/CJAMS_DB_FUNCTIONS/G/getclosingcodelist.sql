 CREATE OR REPLACE FUNCTION public.getclosingcodelist(v_intakeserreqstatustypeid uuid, v_servicerequesttypeconfigid uuid DEFAULT NULL::uuid)               
  RETURNS TABLE(servicerequestdispositionsubtypeconfigid uuid, closingcodetypeid uuid, closingcodetypekey character varying, description character varying)
  LANGUAGE plpgsql                                                                                                                                         
 AS $function$                                                                                                                                           
                                                                                                                                                         
 BEGIN                                                                                                                                                   
                                                                                                                                                         
 RETURN query                                                                                                                                            
                                                                                                                                                         
 select src.servicerequestdispositionsubtypeconfigid,src.closingcodetypeid,c.closingcodetypekey,c.description                                            
 from servicerequestdispositionsubtypeconfig src                                                                                                         
                                                                                                                                                         
 left join closingcodetype c on c.closingcodetypeid=src.closingcodetypeid and c.activeflag=1                                                             
 where src.intakeserreqstatustypeid=v_intakeserreqstatustypeid                                                                                           
  AND  src.servicerequesttypeconfigid = v_servicerequesttypeconfigid                                                                                     
 and src.activeflag=1                                                                                                                                    
 order by c.description;                                                                                                                                 
                                                                                                                                                         
 END;                                                                                                                                                    
                                                                                                                                                         
 $function$                                                                                                                                                

