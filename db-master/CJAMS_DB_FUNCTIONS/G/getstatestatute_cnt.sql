 CREATE OR REPLACE FUNCTION public.getstatestatute_cnt(name character varying)                                       
  RETURNS SETOF bigint                                                                                               
  LANGUAGE plpgsql                                                                                                   
 AS $function$                                                                                                       
                                                                                                                     
 BEGIN                                                                                                               
                                                                                                                     
    RETURN QUERY EXECUTE                                                                                             
                                                                                                                     
                                                                                                                     
 'SELECT Count(*) as cnt                                                                                             
 FROM StateStatutes AS A                                                                                             
 WHERE ((position('''||name||''' in A.StateStatutesKey)) > 0) OR ((position('''||name||''' in A.Description) ) > 0)';
                                                                                                                     
 END;                                                                                                                
 $function$                                                                                                          

