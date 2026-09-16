 CREATE OR REPLACE FUNCTION public.closealertgbc()                                                               
  RETURNS character varying                                                                                      
  LANGUAGE plpgsql                                                                                               
 AS $function$                                                                                                   
                                                                                                                 
 --------------getting data for peace order closure of alerts based on court order expiration date-----          
 DECLARE                                                                                                         
                                                                                                                 
 v_activity  record;                                                                                             
                                                                                                                 
 BEGIN                                                                                                           
                                                                                                                 
 FOR  v_activity  IN                                                                                             
                                                                                                                 
 select distinct ica.intakenumber from intakeservicerequestcourtaction ica                                       
 inner join intakeservicerequestevaluation ire on ire.intakenumber = ica.intakenumber and ire.ispeaceorder='true'
 where cast(ica.expirationdate as date) <= now()                                                                 
                                                                                                                 
   LOOP                                                                                                          
 update personalert set status='Inactive',enddatetime=now()::timestamp                                           
 where notes like '%'||v_activity.intakenumber||'%' and alerttype='POBC';                                        
 END  LOOP;                                                                                                      
                                                                                                                 
                                                                                                                 
 RETURN                                                                                                          
                                                                                                                 
           'Success';                                                                                            
 END;                                                                                                            
                                                                                                                 
 $function$                                                                                                      

