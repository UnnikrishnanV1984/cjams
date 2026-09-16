 CREATE OR REPLACE FUNCTION public.checkprotectivesupervision()                                                                                                                                 
  RETURNS character varying                                                                                                                                                                     
  LANGUAGE plpgsql                                                                                                                                                                              
 AS $function$                                                                                                                                                                                  
                                                                                                                                                                                                
 --------------to get the data for sending daily activity task for protective supervision-----                                                                                                  
                                                                                                                                                                                                
 DECLARE                                                                                                                                                                                        
                                                                                                                                                                                                
 v_intakeserviceid uuid;                                                                                                                                                                        
 v_intakeservreqtypeid uuid;                                                                                                                                                                    
 v_intakeservicerequestclassid uuid;                                                                                                                                                            
 v_investigationid uuid;                                                                                                                                                                        
 v_securityusersid character varying;                                                                                                                                                           
 v_status character varying;                                                                                                                                                                    
 v_activity  record;                                                                                                                                                                            
                                                                                                                                                                                                
 BEGIN                                                                                                                                                                                          
                                                                                                                                                                                                
 FOR  v_activity  IN                                                                                                                                                                            
                                                                                                                                                                                                
  select distinct isr.intakeserviceid   ,intakeservreqtypeid ,intakeservicerequestclassid ,inv.investigationid ,                                                                                
  rd.tosecurityusersid                                                                                                                                                                          
  from intakeservicerequest isr                                                                                                                                                                 
 inner join investigation inv on inv.intakeserviceid=isr.intakeserviceid and inv.activeflag=1                                                                                                   
 inner join routing rd on  rd.objectid =( isr.intakeserviceid:: character varying) and rd.activeflag=1 and toroleid like '%CW'                                                                  
 inner join intakeservicerequestcourtaction ica on  isr.intakeserviceid=ica.intakeservicerequestid and ica.expirationdate <= now()::timestamp or ica.expirationdate is null and ica.activeflag=1
 where foldertypekey='PS' and isr.activeflag=1                                                                                                                                                  
                                                                                                                                                                                                
   LOOP                                                                                                                                                                                         
 select createinvestigationps into v_status from createinvestigationps(v_activity.intakeservreqtypeid,v_activity.intakeservicerequestclassid,                                                   
 v_activity.investigationid,v_activity.tosecurityusersid,'CW','DJS'                                                                                                                             
 );                                                                                                                                                                                             
 END  LOOP;                                                                                                                                                                                     
                                                                                                                                                                                                
 RETURN                                                                                                                                                                                         
                                                                                                                                                                                                
           'Success';                                                                                                                                                                           
                                                                                                                                                                                                
 END;                                                                                                                                                                                           
                                                                                                                                                                                                
 $function$                                                                                                                                                                                     

