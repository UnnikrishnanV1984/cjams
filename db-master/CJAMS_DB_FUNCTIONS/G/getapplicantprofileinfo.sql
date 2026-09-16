 CREATE OR REPLACE FUNCTION public.getapplicantprofileinfo(appid character varying)                                                                                                            
  RETURNS json                                                                                                                                                                                 
  LANGUAGE plpgsql                                                                                                                                                                             
 AS $function$                                                                                                                                                                                 
 declare                                                                                                                                                                                       
 v_providerid character varying;                                                                                                                                                               
 v_applicantprofileid uuid;                                                                                                                                                                    
 v_address json;                                                                                                                                                                               
                                                                                                                                                                                               
 begin                                                                                                                                                                                         
                                                                                                                                                                                               
 --select provider_id, applicant_profile_id into v_providerid , v_applicantprofileid from tb_provider_applicant  where applicant_id = appid;                                                   
 select provider_applicant_profile_id into v_applicantprofileid from tb_provider_applicant_profile where provider_id = appid::int;                                                             
                                                                                                                                                                                               
 select row_to_json(t)                                                                                                                                                                         
         from (                                                                                                                                                                                
                 select pap.provider_applicant_nm,pap.provider_applicant_first_nm, pap.provider_applicant_last_nm, pap.tax_id_no,pap.adr_url_tx,pap.dba_name,pap.provider_applicant_profile_id,
                     (                                                                                                                                                                         
                       select array_to_json(array_agg(row_to_json(d)))                                                                                                                         
                       from (                                                                                                                                                                  
                         select * from tb_provider_address_mapping  pam                                                                                                                        
                         join tb_provider_applicant_addresses paa on paa.address_id = pam.address_id where pam.object_id = (v_applicantprofileid)::character varying                           
                       ) d                                                                                                                                                                     
                     ) as addresses,                                                                                                                                                           
                     (                                                                                                                                                                         
                       select array_to_json(array_agg(row_to_json(d)))                                                                                                                         
                       from (                                                                                                                                                                  
                         select * from tb_provider_applicant_email  pae where object_id = (v_applicantprofileid)::character varying                                                            
                       ) d                                                                                                                                                                     
                     ) as emails,                                                                                                                                                              
                     (                                                                                                                                                                         
                       select array_to_json(array_agg(row_to_json(d)))                                                                                                                         
                       from (                                                                                                                                                                  
                         select * from tb_provider_applicant_phone  pae where object_id = (v_applicantprofileid)::character varying                                                            
                       ) d                                                                                                                                                                     
                     ) as phones                                                                                                                                                               
                 from tb_provider_applicant_profile pap                                                                                                                                        
                 where pap.provider_applicant_profile_id = v_applicantprofileid                                                                                                                
         ) t into v_address;                                                                                                                                                                   
                                                                                                                                                                                               
 return v_address;                                                                                                                                                                             
                                                                                                                                                                                               
 end                                                                                                                                                                                           
                                                                                                                                                                                               
 $function$                                                                                                                                                                                    

