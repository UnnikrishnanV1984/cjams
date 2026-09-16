 CREATE OR REPLACE FUNCTION cjams.updatefostercarerate(searchobj json)              
  RETURNS text                                                                       
  LANGUAGE plpgsql                                                                   
 AS $function$                                                                       
                                                                                     
                                                                                     
 DECLARE                                                                             
 v_rate_id int;                                                                      
 v_service_id int;                                                                   
 v_rate_type_cd bpchar;                                                              
 v_start_dt date;                                                                    
 v_end_dt date;                                                                      
 v_min_age_no int;                                                                   
 v_max_age_no int;                                                                   
 v_monthly_rate_no numeric;                                                          
 v_max_clothing_no numeric;                                                          
 v_per_diem_rate_no numeric;                                                         
 v_monthly_stipend_no numeric;                                                       
 v_monthly_differential_no numeric;                                                  
 v_emergency_bed_fee numeric;                                                        
 v_dirty_status int;                                                                  
                                                                                     
 BEGIN                                                                               
 v_rate_id := searchobj ->> 'rate_id';                                               
 v_service_id := searchobj ->> 'service_id';                                         
 v_rate_type_cd := searchobj ->> 'rate_type_cd';                                     
 v_start_dt := searchobj ->> 'start_dt';                                             
 v_end_dt := searchobj ->> 'end_dt';                                                 
 v_min_age_no := searchobj ->> 'min_age_no';                                         
 v_max_age_no := searchobj ->> 'max_age_no';                                         
 v_monthly_rate_no := searchobj ->> 'monthly_rate_no';                               
 v_max_clothing_no := searchobj ->> 'max_clothing_no';                               
 v_per_diem_rate_no := searchobj ->> 'per_diem_rate_no';                             
 v_monthly_stipend_no := searchobj ->> 'monthly_stipend_no';                         
 v_monthly_differential_no := searchobj ->> 'monthly_differential_no';               
 v_emergency_bed_fee := searchobj ->> 'emergency_bed_fee';                           
 v_dirty_status := searchobj ->> 'dirty_status';
                                                                                     
 raise notice'max_clothing_no%',v_max_clothing_no;                                   
                                                                                     
                                                                                     
 update tb_foster_care_rate set                                                      
 service_id=coalesce(v_service_id,service_id),                                       
 rate_type_cd=coalesce(v_rate_type_cd,rate_type_cd),                                 
 start_dt=coalesce(v_start_dt,start_dt),                                             
 end_dt=coalesce(v_end_dt,end_dt),                                                   
 min_age_no=coalesce(v_min_age_no,min_age_no),                                       
 max_age_no =coalesce(v_max_age_no,max_age_no),                                      
 monthly_rate_no=coalesce(v_monthly_rate_no,monthly_rate_no),                        
 max_clothing_no=coalesce(v_max_clothing_no,max_clothing_no),                        
 per_diem_rate_no=coalesce(v_per_diem_rate_no,per_diem_rate_no),                     
 monthly_stipend_no=coalesce(v_monthly_stipend_no,monthly_stipend_no),               
 monthly_differential_no=coalesce(v_monthly_differential_no,monthly_differential_no),
 emergency_bed_fee=coalesce(v_emergency_bed_fee,emergency_bed_fee),                   
 dirty_status=coalesce(v_dirty_status,dirty_status)
                                                                                     
 where rate_id=v_rate_id;                                                            
                                                                                     
 return 'Success';                                                                   
                                                                                     
 END;                                                                                
                                                                                     
                                                                                     
 $function$                                                                          
;
