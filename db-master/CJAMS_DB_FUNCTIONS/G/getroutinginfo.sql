 CREATE OR REPLACE FUNCTION public.getroutinginfo(v_objectid character varying, v_eventcode character varying)                                           
  RETURNS TABLE(status text, remarks text, fromsecurityusersid character varying, fromusename text, tosecurityusersid character varying, tousername text)
  LANGUAGE plpgsql                                                                                                                                       
 AS $function$                                                                                                                                           
                                                                                                                                                         
 DECLARE                                                                                                                                                 
                                                                                                                                                         
 BEGIN                                                                                                                                                   
                                                                                                                                                         
 RETURN  query                                                                                                                                           
 SELECT                                                                                                                                                  
         rs.typedescription  AS  status,                                                                                                                 
         r.remarks,                                                                                                                                      
         r.fromsecurityusersid,                                                                                                                          
         uf.firstname  ||'  '||  uf.lastname  fromusename,                                                                                               
         r.tosecurityusersid,                                                                                                                            
         up.firstname  ||'  '||  up.lastname  tousername                                                                                                 
 FROM  routing  r                                                                                                                                        
 INNER  JOIN  userprofile  up  ON  up.securityusersid  =  r.tosecurityusersid  AND  up.activeflag  =1                                                    
 INNER  JOIN  userprofile  uf  ON  uf.securityusersid  =  r.fromsecurityusersid  AND  uf.activeflag  =1                                                  
 INNER  JOIN  routingstatustype  rs  ON  r.routingstatustypeid  =  rs.sequencenumber  AND  rs.activeflag  =1                                             
 WHERE  r.objectid  =  v_objectid                                                                                                                        
 AND  r.eventcode  =  v_eventcode                                                                                                                        
 AND  r.activeflag=1;                                                                                                                                    
                                                                                                                                                         
 END;                                                                                                                                                    
                                                                                                                                                         
 $function$                                                                                                                                              

