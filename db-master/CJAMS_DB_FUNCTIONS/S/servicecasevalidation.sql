 CREATE OR REPLACE FUNCTION cjams.servicecasevalidation(l_intakeserviceid uuid)                                          
  RETURNS bigint                                                                                                          
  LANGUAGE plpgsql                                                                                                        
 AS $function$                                                                                                          
                                                                                                                        
                                                                                                                        
 DECLARE                                                                                                                
         l_count bigint;                                                                                                
                                                                                                                        
 BEGIN                                                                                                                  
                                                                                                                        
 --        SELECT intakeserviceid INTO l_intakeserviceid                                                                
 --         FROM intakeservicerequestactor WHERE intakeservicerequestactorid= v_personid                                
 --        AND activeflag =1 AND intakeservicerequestpersontypekey IN('RC','BIOCHILD','CHILD');                         
                                                                                                                        
        SELECT COUNT(*) INTO l_count                                                                                    
            FROM actor ac join servicecase sc on ac.servicecaseid =sc.servicecaseid and sc.activeflag = 1                                                                                                 
            WHERE ac.personid IN (SELECT personid FROM intakeservicerequestactor WHERE intakeserviceid= l_intakeserviceid  
                            AND activeflag =1 ) AND ac.activeflag =1 AND ac.ishouseholdmember =1                              
            AND ac.servicecaseid IS NOT NULL ;                                                                             
                                                                                                                        
    RETURN l_count;                                                                                                     
 END;                                                                                                                   
                                                                                                                        
                                                                                                                        
 $function$                                                                                                               

