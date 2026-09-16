 CREATE OR REPLACE FUNCTION public.listdastatus(datype uuid, dasubtype uuid)                                                                  
  RETURNS TABLE(intakeserreqstatustypeid uuid, intakeserreqstatustypekey character varying, description text, servicerequesttypeconfigid uuid)
  LANGUAGE plpgsql                                                                                                                            
 AS $function$                                                                                                                                
 BEGIN                                                                                                                                        
 RETURN QUERY                                                                                                                                 
                                                                                                                                              
 select distinct a.intakeserreqstatustypeid, a.intakeserreqstatustypekey, a.description,b.servicerequesttypeconfigid from                     
 intakeserreqstatustype AS a JOIN servicerequesttypeconfigdispositioncode AS b ON a.intakeserreqstatustypeid=b.intakeserreqstatustypeid       
         where b.servicerequesttypeconfigid IN(                                                                                               
                 select c.servicerequesttypeconfigid from servicerequesttypeconfig as c                                                       
                 where c.intakeservreqtypeid=datype and                                                                                       
                 c.servicerequestsubtypeid=dasubtype)                                                                                         
         and b.activeflag=1;                                                                                                                  
                                                                                                                                              
 END;                                                                                                                                         
 $function$                                                                                                                                   

