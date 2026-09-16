 CREATE OR REPLACE FUNCTION public.getplacementrelease()                                                                                                           
  RETURNS TABLE(releasecategory json, whereabouts json, transfertootherfacility json, releasereason json, cdunsuccessful json, releasereasonstatus json)           
  LANGUAGE plpgsql                                                                                                                                                 
 AS $function$                                                                                                                                                     
                                                                                                                                                                   
 begin                                                                                                                                                             
         RETURN query                                                                                                                                              
 select (select json_agg(a) from (select ref_key as value_text,description from referencevalues where referencetypeid='1' and activeflag=1) a)                     
 as releasecategory,                                                                                                                                               
 (select json_agg(a) from (select ref_key as value_text,description from referencevalues where referencetypeid='2' and activeflag=1) a) as whereabouts,            
 (select json_agg(a) from (select ref_key as value_text,description from referencevalues where referencetypeid='7' and activeflag=1) a) as transfertootherfacility,
 (select json_agg(a) from (select ref_key as value_text,description from referencevalues where referencetypeid='3' and activeflag=1) a) as releasereason,          
 (select json_agg(a) from (select ref_key as value_text,description from referencevalues where referencetypeid='6' and activeflag=1) a) as cdunsuccessful,         
 (select json_agg(a) from (select ref_key as value_text,description from referencevalues where referencetypeid='4' and activeflag=1) a) as releasereasonstatus     
 --from referencevalues limit 1                                                                                                                                    
 ;                                                                                                                                                                 
 end;                                                                                                                                                              
                                                                                                                                                                   
 $function$                                                                                                                                                        

