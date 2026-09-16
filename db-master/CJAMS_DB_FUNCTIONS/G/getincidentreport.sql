 CREATE OR REPLACE FUNCTION public.getincidentreport(incidentno character varying)                                                                   
  RETURNS json                                                                                                                                       
  LANGUAGE plpgsql                                                                                                                                   
 AS $function$                                                                                                                                       
 DECLARE                                                                                                                                             
 v_uir json;                                                                                                                                         
 v_incidentno character varying;                                                                                                                     
                                                                                                                                                     
 BEGIN                                                                                                                                               
 v_incidentno := incidentno;                                                                                                                         
                                                                                                                                                     
 select row_to_json(t)                                                                                                                               
 from (                                                                                                                                              
 select *,                                                                                                                                           
     (                                                                                                                                               
       select array_to_json(array_agg(row_to_json(d)))                                                                                               
       from (                                                                                                                                        
         select * from providerincidenttypes pit where pit.incident_no = (v_incidentno)::character varying                                           
       ) d                                                                                                                                           
     ) as incident_types,                                                                                                                            
     (                                                                                                                                               
           select array_to_json(array_agg(row_to_json(d)))                                                                                           
           from (                                                                                                                                    
         select * from provideryouthinfo pyi join  tb_provider_address_mapping  pam on pyi.youth_id = (pam.object_id)::int                           
                 join tb_provider_applicant_addresses paa on paa.address_id = pam.address_id where pyi.object_id = (v_incidentno)::character varying 
       ) d                                                                                                                                           
     ) as youth_info,                                                                                                                                
     (                                                                                                                                               
       select array_to_json(array_agg(row_to_json(d)))                                                                                               
       from (                                                                                                                                        
         select * from tb_provider_applicant_email  pae where object_id = (v_incidentno)::character varying                                          
       ) d                                                                                                                                           
     ) as emails,                                                                                                                                    
     (                                                                                                                                               
       select array_to_json(array_agg(row_to_json(d)))                                                                                               
       from (                                                                                                                                        
         select * from tb_provider_applicant_phone  pae where object_id = (v_incidentno)::character varying                                          
       ) d                                                                                                                                           
     ) as phones                                                                                                                                     
   from providerincident pi                                                                                                                          
  where pi.incident_no = (v_incidentno)::character varying                                                                                           
 ) t into v_uir;                                                                                                                                     
                                                                                                                                                     
 return v_uir;                                                                                                                                       
                                                                                                                                                     
 end;                                                                                                                                                
 $function$                                                                                                                                          

