 CREATE OR REPLACE FUNCTION public.getintakeprior(v_intakenumber character varying)                                                                                              
  RETURNS json                                                                                                                                                                   
  LANGUAGE plpgsql                                                                                                                                                               
 AS $function$                                                                                                                                                                   
                                                                                                                                                                                 
 DECLARE                                                                                                                                                                         
                                                                                                                                                                                 
 jsondata  json;                                                                                                                                                                 
 BEGIN                                                                                                                                                                           
                                                                                                                                                                                 
 SELECT  Json_agg(a)  INTO      jsondata  FROM      (                                                                                                                            
                                                                                                                                                                                 
                 SELECT          p.personid,                                                                                                                                     
                                                           p.firstname,                                                                                                          
                                                           p.lastname,                                                                                                           
                                                           p.dob,                                                                                                                
                                                           p.gendertypekey,                                                                                                      
                                                           p.dateofdeath,                                                                                                        
                                                           p.cjamspid,                                                                                                           
                                                           (  SELECT  typedescription  FROM      actortype  WHERE    actortype  =  data2  ->>'Role')  AS  role,                  
                                                           (  SELECT  Json_agg(a)    FROM      (  SELECT  *    FROM      Getpersonpriorcase(p.personid)  )a)  AS  servicecases,  
                                                           (  SELECT  Json_agg(x)    FROM      (  SELECT  *    FROM      Getpersonpriorfindings(p.personid)  )x)  AS  cpsfindings
                                     FROM              intakedastatus  ia,                                                                                                       
                                                           Json_array_elements((ia.jsondata::json)->'persons')  data2                                                            
                                                                                                                                                                                 
                                     INNER  JOIN  (    SELECT      personid    FROM  intakeservicerequestactor                                                                   
                                     WHERE    activeflag  =1  GROUP  BY  personid)  isra                                                                                         
                                     ON    isra.personid::character  VARYING  =  data2  ->>'Pid'                                                                                 
                                     INNER  JOIN  person  p    ON    p.personid  =  isra.personid                                                                                
                                     WHERE            data2  ->>'Pid'  IS  NOT  NULL                                                                                             
                                     AND                ia.intakenumber  =  v_intakenumber  )  a;                                                                                
                                                                                                                                                                                 
 RETURN  jsondata;                                                                                                                                                               
 END;                                                                                                                                                                            
                                                                                                                                                                                 
 $function$                                                                                                                                                                      

