 CREATE OR REPLACE FUNCTION public.fostercarevacancyupdate(v_provider_id integer, v_contract_program_id integer)                                                            
  RETURNS text                                                                                                                                                              
  LANGUAGE plpgsql                                                                                                                                                          
 AS $function$                                                                                                                                                              
                                                                                                                                                                            
 DECLARE                                                                                                                                                                    
                                                                                                                                                                            
         v_provider_category_cd VARCHAR(50);                                                                                                                                
                                                                                                                                                                            
                                                                                                                                                                            
 Begin                                                                                                                                                                      
                                                                                                                                                                            
 select provider_category_cd into v_provider_category_cd from tb_provider where provider_id = v_provider_id;                                                                
                                                                                                                                                                            
 IF v_provider_category_cd = '1783' THEN                                                                                                                                    
 UPDATE  tb_provider  set  vacancy_no  =  (vacancy_no - 1)  where  provider_id = v_provider_id;                                                                             
                                                                                                                                                                            
 Return  'Success';                                                                                                                                                         
 ELSE                                                                                                                                                                       
 UPDATE  tb_contract_program  set  vacancy_no  =  (vacancy_no - 1)  where program_id = v_contract_program_id;                                                               
 --UPDATE  tb_contract_program  set  vacancy_no  =  (vacancy_no - 1)  where contract_id in(select contract_id from tb_provider_contracts where provider_id = v_provider_id);
 Return  'Success';                                                                                                                                                         
 END IF;                                                                                                                                                                    
 End;                                                                                                                                                                       
                                                                                                                                                                            
 $function$                                                                                                                                                                 

