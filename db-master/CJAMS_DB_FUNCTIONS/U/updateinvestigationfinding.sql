 CREATE OR REPLACE FUNCTION public.updateinvestigationfinding(v_investigationallegationid uuid)                                  
  RETURNS text                                                                                                                   
  LANGUAGE plpgsql                                                                                                               
 AS $function$                                                                                                                   
 
 Begin                       
              with investigation_find_id as (
              		select investigationfindingid 
              		from Investigationfinding                              
					where  investigationallegationid = v_investigationallegationid
              ), update_investion_finding as (
	             UPDATE investigationfinding set activeflag = 0 
	             where investigationallegationid = v_investigationallegationid                                                            
              )
	          
              UPDATE investigationfindingassessors set activeflag = 0 where                                                   
	          investigationfindingid IN (select investigationfindingid from investigation_find_id);
                                                                                                                                 
              Return 'Success';                                                                                               
                                                                                                                                 
 End;                                                                                                                            
                                                                                                                                 
 $function$   

