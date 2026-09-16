 CREATE OR REPLACE FUNCTION public.getactorroles(p_actorpersonid uuid)                              
  RETURNS character varying                                                                         
  LANGUAGE plpgsql                                                                                  
 AS $function$                                                                                      
     Declare cur CURSOR FOR                                                                         
         SELECT DISTINCT ACT.ActorType                                                              
         FROM Actor AS ACT                                                                          
         WHERE ACT.PersonId = p_ActorPersonId;                                                      
     v_RolesList varchar(100);                                                                      
 BEGIN                                                                                              
                                                                                                    
     v_RolesList := '';                                                                             
                                                                                                    
    --select STRING_AGG(actortype, ',') into v_RolesList from actor where personid = p_ActorPersonId
                                                                                                    
    select STRING_AGG(actortype, ',') into v_RolesList from (                                       
         select distinct actortype from actor where personid = p_ActorPersonId                      
    ) a;                                                                                            
 --group by personid;                                                                               
                                                                                                    
     RETURN v_RolesList;                                                                            
 END;                                                                                               
 $function$                                                                                         

