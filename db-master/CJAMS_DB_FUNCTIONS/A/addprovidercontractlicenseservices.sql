 CREATE OR REPLACE FUNCTION public.addprovidercontractlicenseservices(insertedtlsobj json)                                                                 
  RETURNS text                                                                                                                                             
  LANGUAGE plpgsql                                                                                                                                         
 AS $function$                                                                                                                                             
                                                                                                                                                           
 DECLARE                                                                                                                                                   
 returnStatus text;                                                                                                                                        
 providerId numeric;                                                                                                                                       
 programId numeric;                                                                                                                                        
 serviceCategory numeric;                                                                                                                                  
 serviceCost numeric;                                                                                                                                      
 serviceDescription text;                                                                                                                                  
 serviceId numeric;                                                                                                                                        
 servicePaidBy text;                                                                                                                                       
 stdate date;                                                                                                                                              
 enddate date;                                                                                                                                             
 serviceClassification text;                                                                                                                               
 providerServiceId numeric;                                                                                                                                
 serviceUnit text;                                                                                                                                         
                                                                                                                                                           
                                                                                                                                                           
                                                                                                                                                           
 BEGIN                                                                                                                                                     
                                                                                                                                                           
 providerId=insertedtlsobj->>'provider_id';                                                                                                                
 programId =insertedtlsobj->>'program_id';                                                                                                                 
 serviceCategory =insertedtlsobj->>'service_category';                                                                                                     
 serviceCost =insertedtlsobj->>'service_cost';                                                                                                             
 serviceDescription =insertedtlsobj->>'service_description';                                                                                               
 serviceId= insertedtlsobj->>'service_id';                                                                                                                 
 stdate=insertedtlsobj->>'start_dt';                                                                                                                       
 enddate= insertedtlsobj->>'end_dt';                                                                                                                       
 servicePaidBy= insertedtlsobj->>'service_paid_by';                                                                                                        
 serviceUnit= insertedtlsobj->>'service_unit';                                                                                                             
 serviceClassification= insertedtlsobj->>'service_classification';                                                                                         
 providerServiceId= insertedtlsobj->>'provider_service_id';                                                                                                
                                                                                                                                                           
 IF providerServiceId>0                                                                                                                                    
 then                                                                                                                                                      
 update tb_provider_services set service_status='Expired' where provider_service_id=providerServiceId;                                                     
 END IF;                                                                                                                                                   
                                                                                                                                                           
                                                                                                                                                           
 insert into tb_provider_services (provider_id, program_id,service_category,service_cost, service_description,                                             
 service_id,service_paid_by,service_unit, service_classification,start_dt, end_dt, service_status,                                                         
 create_ts,create_user_id,update_ts,update_user_id)                                                                                                        
 values                                                                                                                                                    
 (providerId,programId,serviceCategory,serviceCost,serviceDescription,serviceId,servicePaidBy,serviceUnit, serviceClassification,stdate ,enddate, 'Active',
 insertedtlsobj->>'create_ts', insertedtlsobj->>'create_user_id', insertedtlsobj->>'update_ts', insertedtlsobj->>'update_user_id');                        
                                                                                                                                                           
                                                                                                                                                           
 returnStatus:= 'Success';                                                                                                                                 
                                                                                                                                                           
 RETURN returnStatus;                                                                                                                                      
                                                                                                                                                           
 END;                                                                                                                                                      
                                                                                                                                                           
 $function$                                                                                                                                                

