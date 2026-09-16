 CREATE OR REPLACE FUNCTION public.getloadnumberassigneduserbydate(p_sid character varying, p_insertedon timestamp without time zone)
  RETURNS TABLE(title character varying, loadnumber character varying)                                                               
  LANGUAGE plpgsql                                                                                                                   
 AS $function$                                                                                                                       
                                                                                                                                     
 BEGIN                                                                                                                               
                                                                                                                                     
     RETURN QUERY                                                                                                                    
 SELECT COALESCE(TM.RoleTypeKey,'') AS RoleTypeKey, COALESCE(TM.LoadNumber,'') AS LoadNumber                                         
 FROM TeamMemberAssignment TMA                                                                                                       
   JOIN TeamMember TM ON TMA.TeamMemberId = TM.TeamMemberId                                                                          
 WHERE TMA.SecurityUsersId = p_sid                                                                                                   
       AND p_insertedOn >= TMA.EffectiveDate AND p_insertedOn <= COALESCE(TMA.ExpirationDate,NOW()  )  limit 1;                      
                                                                                                                                     
                                                                                                                                     
 END;                                                                                                                                
 $function$                                                                                                                          

