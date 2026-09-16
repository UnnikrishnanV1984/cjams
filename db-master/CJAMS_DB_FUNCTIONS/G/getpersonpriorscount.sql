 CREATE OR REPLACE FUNCTION public.getpersonpriorscount(_personid uuid)           
  RETURNS SETOF bigint                                                            
  LANGUAGE plpgsql                                                                
 AS $function$                                                                  
 BEGIN                                                                          
 RETURN QUERY                                                                   
 SELECT COUNT(*) FROM intakeservicerequest as A                                 
 JOIN  intakeservicerequestactor as B  ON A.intakeserviceid = B.intakeserviceid 
 JOIN  actor as C on C.ActorId = B.ActorId                                      
 JOIN person as D ON C.personid=D.personid                                      
 WHERE A.activeflag=1 AND C.activeflag=1 AND D.personid=_personid;              
                                                                                
  END;                                                                          
 $function$                                                                       

