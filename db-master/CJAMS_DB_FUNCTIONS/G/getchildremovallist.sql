 CREATE OR REPLACE FUNCTION public.getchildremovallist(v_intakeserviceid uuid, pagenumber bigint, pagesize bigint)                                                         
  RETURNS TABLE(totalcount bigint, removaldate timestamp without time zone, childname character varying, removedfrom text, removedby character varying, removalreason json)
  LANGUAGE plpgsql                                                                                                                                                         
 AS $function$                                                                                                                                                             
                                                                                                                                                                           
 DECLARE                                                                                                                                                                   
         v_pageoffset  int;                                                                                                                                                
         v_pagenumber  int;                                                                                                                                                
         totalcount  int;                                                                                                                                                  
 BEGIN                                                                                                                                                                     
         v_pagenumber  :=  pagenumber-1;                                                                                                                                   
         v_pageoffset  =  v_pagenumber  *  pagesize;                                                                                                                       
                                                                                                                                                                           
 RETURN  query                                                                                                                                                             
                                                                                                                                                                           
         SELECT                                                                                                                                                            
                 COUNT(1)OVER(),                                                                                                                                           
                 icr.removaldate,                                                                                                                                          
                 (  person.firstname  ||  '  '||person.lastname)::  character  varying  childname,                                                                         
                 CASE  coalesce(icr.rmvdfrmisractorid  ::  character  varying,'')  WHEN  ''                                                                                
                 THEN  icr.rmvdfrmpersonname  ELSE    rmvf.personname      END  AS  removedfrom  ,                                                                         
                 up.fullname  as  removedby,                                                                                                                               
                 (                                                                                                                                                         
                         SELECT  json_agg(item)                                                                                                                            
                         FROM  (                                                                                                                                           
                             SELECT  rrt.description  AS  description,  rrt.removalreasontypekey  AS  key                                                                  
                             FROM  removalreasontype  rrt  WHERE    rrt.removalreasontypeid  =  icr.removalreasontypeid                                                    
                         )  item                                                                                                                                           
                     )  AS  removalreason                                                                                                                                  
         FROM  Intakeservreqchildremoval  icr                                                                                                                              
         INNER  JOIN  intakeservicerequestactor  isra  ON  isra.intakeservicerequestactorid=icr.intakeservicerequestactorid  AND  isra.activeflag=1                        
         INNER  JOIN  actor  ON  isra.actorid=actor.actorid  AND  actor.activeflag=1                                                                                       
         INNER  JOIN  person  ON  person.personid=actor.personid  AND  person.activeflag=1                                                                                 
         LEFT  JOIN  (SELECT  intakeservicerequestactorid,  (person.firstname  ||',  '  ||  person.lastname  )    personname                                               
                                 FROM  intakeservicerequestactor  isra                                                                                                     
                                 INNER  JOIN  person  ON  person.personid=isra.personid  AND  person.activeflag=1                                                          
                                 WHERE  isra.activeflag  =1)  rmvf  on  rmvf.intakeservicerequestactorid  =  icr.rmvdfrmisractorid                                         
         INNER  JOIN  userprofile  up  ON  up.securityusersid=icr.insertedby  AND  up.activeflag=1                                                                         
         WHERE  icr.intakeserviceid=v_intakeserviceid  AND  icr.activeflag=1                                                                                               
         LIMIT  pagesize  OFFSET  v_pageoffset;                                                                                                                            
                                                                                                                                                                           
 END;                                                                                                                                                                      
                                                                                                                                                                           
 $function$                                                                                                                                                                

