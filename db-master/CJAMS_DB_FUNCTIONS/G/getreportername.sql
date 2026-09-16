 CREATE OR REPLACE FUNCTION getreportername(objecttypekey character varying, objectid character varying, roletype character varying)                                                                                                
  RETURNS character varying                                                                                                                                                                                                                
  LANGUAGE plpgsql                                                                                                                                                                                                                         
 AS $function$                                                                                                                                                                                                                           
 DECLARE   l_personname character  varying;     
 DECLARE   v_objectid character  varying;
 BEGIN                                                                                                                                                                                                                                   
                   
		v_objectid := objectid;																																																								 
         SELECT   cast(INITCAP(TRIM(coalesce(PN.lastname,''))|| CASE WHEN PN.suffix is not null THEN ' ' ELSE '' END  || TRIM(coalesce(PN.suffix,'')) || ', ' ||TRIM(coalesce(PN.firstname,''))) as  character varying) INTO l_personname
     FROM  intakeservicerequestactor   ISRA                                                                                                                                                                                              
                 INNER  JOIN  person  as  PN  ON  PN.personid=ISRA.personid  AND  PN.activeflag  =  1                                                                                                                                    
         WHERE  intakeservicerequestpersontypekey  IN  ('CLI','CHILD','BIOCHILD','OTHERCHILD','RC','RA','Youth','2085','PA')                                                                                                             
     AND  ISRA.activeflag  =1    AND ISRA.intakeserviceid = v_objectid::uuid LIMIT 1;                                                                                                                                        
                                                                                                                                                                                                                                         
  RETURN l_personname;                                                                                                                                                                                                                   
 END;                                                                                                                                                                                                                                    
 $function$ ;                                                                                                                                                                                                                     

