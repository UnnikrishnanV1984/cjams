 CREATE OR REPLACE FUNCTION public.personsearchfolders(searchkey character varying)                                                                             
  RETURNS TABLE(personid uuid, lastname character varying, firstname character varying, cjamspid bigint, assistpid character varying, userphoto text)           
  LANGUAGE plpgsql                                                                                                                                              
 AS $function$                                                                                                                                                  
                                                                                                                                                                
                                                                                                                                                                
                                                                                                                                                                
 declare v_searchkey character varying = null;                                                                                                                  
 BEGIN                                                                                                                                                          
         v_searchkey:= searchkey;                                                                                                                               
                                                                                                                                                                
         Return Query                                                                                                                                           
         select P.personid, P.lastname, P.firstname,P.cjamspid,P.old_id as assistpid,p.userphoto from Person as P                                               
         where (CASE WHEN v_searchkey is NOT NULL THEN (p.old_id = v_searchkey or p.cjamspid = v_searchkey::bigint) ELSE TRUE end) And P.activeflag = 1 limit 1;
                                                                                                                                                                
   end;                                                                                                                                                         
                                                                                                                                                                
 $function$                                                                                                                                                     

