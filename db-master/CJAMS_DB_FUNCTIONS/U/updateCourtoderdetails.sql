 DROP FUNCTION IF EXISTS cjams.updateCourtoderdetails(v_intakeservreqcourtorderid uuid);
 CREATE OR REPLACE FUNCTION cjams.updateCourtoderdetails(v_intakeservreqcourtorderid uuid)
  RETURNS text                                                                                   
  LANGUAGE plpgsql                                                                               
 AS $function$                                                                                   
                                                                                                 
 Begin                                                                                           
                                                                                                 
             UPDATE Intakeservreqcohearingoutcome set activeflag = 0 where                      
             intakeservreqcourtorderid = v_intakeservreqcourtorderid;                                  
             UPDATE intakeservreqcourtorderdetails set activeflag = 0 where                        
             intakeservreqcourtorderid = v_intakeservreqcourtorderid;                                  
                                                                                                 
                                                                                                 
                 Return 'Success';                                                               
                                                                                                 
 End;                                                                                            
                                                                                                 
 $function$                                                                                      

