 CREATE OR REPLACE FUNCTION public.sp_ive_eligibility_details_info(v_transactionid uuid)                                                                  
  RETURNS json                                                                                                                                            
  LANGUAGE plpgsql                                                                                                                                        
 AS $function$                                                                                                                                          
                                                                                                                                                        
 declare                                                                                                                                                
                                                                                                                                                        
 v_counter json;                                                                                                                                        
 v_start_dt date;                                                                                                                                       
 v_end_dt date;                                                                                                                                         
 v_eligibility_status_cd varchar(50);                                                                                                                   
 v_client_id bigint;                                                                                                                                    
 v_removal_id bigint;                                                                                                                                   
 v_auditperiodid integer;                                                                                                                               
 v_picklist_value_cd varchar(10);                                                                                                                       
 returnStatus text;                                                                                                                                     
 response json;                                                                                                                                         
                                                                                                                                                        
                                                                                                                                                        
 begin                                                                                                                                                  
         returnStatus := 'Success';                                                                                                                     
                                                                                                                                                        
  select json_agg(x) from (SELECT *  FROM tb_audit_periods where transactionid = v_transactionid) as X  into response;                                  
                                                                                                                                                        
 --raise notice '%s',  response;                                                                                                                        
                                                                                                                                                        
 for v_counter in select * from json_array_elements(response)                                                                                           
 loop                                                                                                                                                   
                                                                                                                                                        
 --raise notice '%s',  v_counter;                                                                                                                       
                                                                                                                                                        
                 v_start_dt := v_counter ->> 'start_dt';                                                                                                
                 v_end_dt := v_counter ->> 'end_dt';                                                                                                    
                 v_eligibility_status_cd := v_counter ->> 'fostercareeligibilitystatus';                                                                
                 v_client_id := v_counter ->> 'cjamspid';                                                                                               
                 v_removal_id := v_counter ->> 'removalid';                                                                                             
                 v_auditperiodid := v_counter ->> 'auditperiodid';                                                                                      
                                                                                                                                                        
                 select tpv.picklist_value_cd into v_picklist_value_cd                                                                                  
                 from tb_picklist_values tpv                                                                                                            
                 where tpv.picklist_type_id = 262                                                                                                       
                         and tpv.value_tx = v_eligibility_status_cd;                                                                                    
                                                                                                                                                        
                 insert into tb_client_eligibility(eligibility_id, start_dt, end_dt, eligibility_type_cd, eligibility_status_cd, client_id, removal_id, 
                 create_user_id, update_user_id, auditperiodid, transactionid)                                                                          
                 values(nextval('tb_client_eligibility_eligibility_id_seq'::regclass), v_start_dt, v_end_dt, NULL, v_picklist_value_cd,                 
                 v_client_id,v_removal_id, 'admin',      'admin', v_auditperiodid, v_transactionid);                                                    
          END LOOP;                                                                                                                                     
 --RETURN format('%s ', response);                                                                                                                      
                                                                                                                                                        
 return response;                                                                                                                                       
                                                                                                                                                        
 end;                                                                                                                                                   
                                                                                                                                                        
                                                                                                                                                        
 $function$                                                                                                                                               

