 CREATE OR REPLACE FUNCTION public.updateactivitytask(v_submissionid character varying, v_intakeserviceid uuid)                                             
  RETURNS text                                                                                                                                              
  LANGUAGE plpgsql                                                                                                                                          
 AS $function$                                                                                                                                              
                                                                                                                                                            
 Begin                                                                                                                                                      
                                                                                                                                                            
             UPDATE activitytask set completeddate = now() at time zone 'utc',assessmentid = v_intakeserviceid, activitytaskstatustypekey='InvClosed' where 
             activitytaskid In (SELECT avt.activitytaskid                                                                                                   
                         FROM assessment asm                                                                                                                
                         JOIN investigation ivg ON ivg.intakeserviceid=asm.objectid AND asm.activeflag=1 AND ivg.activeflag=1                               
                         JOIN activity av ON av.objectid=ivg.investigationid AND av.activeflag=1                                                            
                         JOIN activitytask avt ON avt.assessmenttemplateid=asm.assessmenttemplateid AND av.activityid=avt.activityid AND avt.activeflag=1   
                         where asm.submissionid=v_submissionid);                                                                                            
                                                                                                                                                            
                 Return 'Success';                                                                                                                          
                                                                                                                                                            
 End                                                                                                                                                        
                                                                                                                                                            
 $function$                                                                                                                                                 

