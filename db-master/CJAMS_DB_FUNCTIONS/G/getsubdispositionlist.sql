 CREATE OR REPLACE FUNCTION public.getsubdispositionlist(v_servicerequesttypeconfigiddispostionid uuid)                
  RETURNS TABLE(servicerequestdispositionsubtypeconfigid uuid, ref_key character varying, value_text character varying)
  LANGUAGE plpgsql                                                                                                     
 AS $function$                                                                                                         
                                                                                                                       
 BEGIN                                                                                                                 
                                                                                                                       
 RETURN query                                                                                                          
                                                                                                                       
 select src.servicerequestdispositionsubtypeconfigid,rv.ref_key,rv.value_text                                          
 from servicerequestdispositionsubtypeconfig src                                                                       
 left join referencevalues rv on rv.ref_key = dispositioncode and rv.referencetypeid=14                                
 where servicerequesttypeconfigiddispostionid=v_servicerequesttypeconfigiddispostionid and src.activeflag=1            
 order by rv.ref_key;                                                                                                  
                                                                                                                       
 END;                                                                                                                  
                                                                                                                       
 $function$                                                                                                            

