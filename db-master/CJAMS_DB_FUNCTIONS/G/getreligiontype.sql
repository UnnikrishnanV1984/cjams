 CREATE OR REPLACE FUNCTION public.getreligiontype(v_teamtypekey character varying)                                                                                         
  RETURNS TABLE(sequencenumber integer, religiontypekey character varying, typedescription character varying, activeflag integer, effectivedate timestamp without time zone)
  LANGUAGE plpgsql                                                                                                                                                          
 AS $function$                                                                                                                                                            
                                                                                                                                                                          
 BEGIN                                                                                                                                                                    
                                                                                                                                                                          
 RETURN Query                                                                                                                                                             
                                                                                                                                                                          
         SELECT                                                                                                                                                           
     rt.sequencenumber,rt.religiontypekey,rt.typedescription,rt.activeflag,rt.effectivedate                                                                               
         FROM religiontype rt                                                                                                                                             
         INNER JOIN religionagencytypeconfig rta ON rt.religiontypekey = rta.religiontypekey AND rta.activeflag =1                                                        
         WHERE rta.teamtypekey = v_teamtypekey AND rt.activeflag =1                                                                                                       
         ORDER BY rt.typedescription;                                                                                                                                     
                                                                                                                                                                          
 END;                                                                                                                                                                     
                                                                                                                                                                          
 $function$                                                                                                                                                                 

