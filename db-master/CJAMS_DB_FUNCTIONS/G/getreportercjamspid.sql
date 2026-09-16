 CREATE OR REPLACE FUNCTION public.getreportercjamspid(objecttypekey character varying, objectid character varying, roletype character varying)
  RETURNS bigint                                                                                                                               
  LANGUAGE plpgsql                                                                                                                             
 AS $function$                                                                                                                               
 DECLARE   l_personcjamspid bigint;                                                                                                          
 BEGIN                                                                                                                                       
                                                                                                                                             
         SELECT   PN.cjamspid INTO l_personcjamspid                                                                                          
     FROM  intakeservicerequestactor   ISRA                                                                                                  
                 INNER  JOIN  person  as  PN  ON  PN.personid=ISRA.personid  AND  PN.activeflag  =  1                                        
         WHERE  intakeservicerequestpersontypekey  IN  ('CLI','CHILD','BIOCHILD','OTHERCHILD','RC','RA','Youth','2085','PA')                 
     AND  ISRA.activeflag  =1    AND ISRA.intakeserviceid:: character varying = objectid LIMIT 1;                                            
                                                                                                                                             
  RETURN l_personcjamspid;                                                                                                                   
 END;                                                                                                                                        
 $function$                                                                                                                                    

