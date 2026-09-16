 CREATE OR REPLACE FUNCTION getchildfatality(objectid character varying, objecttypekey character varying)         
  RETURNS TABLE(childfatality integer, fatalityinfo json)                                                                
  LANGUAGE plpgsql                                                                                                       
 AS $function$      
 DECLARE v_objectid CHARACTER VARYING;
 BEGIN    
 v_objectid := objectid;
 RETURN QUERY                                                                                                            
         SELECT  CASE WHEN MAX(prs.dateofdeath)  IS  NOT NULL THEN  1 ELSE 0 END  childfatality,  json_agg(              
                                 json_build_object('personname',(COALESCE(prs.firstname,'')||COALESCE(prs.lastname,'')) ,
                                                   'Dateofbirth', prs.dob,                                               
                                                   'Dateofdeath',prs.dateofdeath) ) fatalityinfo                         
     FROM  intakeservicerequestactor  israc1                                                                             
         INNER  JOIN  person  prs    ON  prs.personid  =israc1.personid  AND    prs.activeflag  =1                       
         AND  prs.dateofdeath  IS  NOT NULL  AND  EXTRACT(year  FROM  age(now(),prs.dob))= 18                            
     WHERE  israc1.activeflag  =1 AND  israc1.intakeserviceid :: character varying = v_objectid ;                          
 END;                                                                                                                    
  $function$                                                                                                             

