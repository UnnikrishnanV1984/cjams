 CREATE OR REPLACE FUNCTION public.getcpahomeprovidername(v_provider_parent_id integer)                                                                           
  RETURNS TABLE(totalcount bigint, provider_id integer, provider_parent_id integer, providername character varying)                                               
  LANGUAGE plpgsql                                                                                                                                                
 AS $function$                                                                                                                                                    
                                                                                                                                                                  
 BEGIN                                                                                                                                                            
                                                                                                                                                                  
 RETURN QUERY                                                                                                                                                     
 select count(1) over(),TBP.provider_id,TBP.affiliate_provider_id,                                                                                                
 (CASE WHEN TBP.provider_nm !='' THEN TBP.provider_nm                                                                                                             
 WHEN TBP.provider_nm is null THEN (CAST(INITCAP(TRIM(TBP.provider_first_nm)||' '||TRIM(TBP.provider_last_nm) || CASE WHEN TBP.provider_middle_nm IS NOT NULL AND 
 TRIM(TBP.provider_middle_nm) != '' THEN ', ' || TRIM(TBP.provider_middle_nm)ELSE '' END)as  character varying)) ELSE TBP.provider_nm  END) as providername       
 from tb_provider as TBP where TBP.affiliate_provider_id = v_provider_parent_id                                                                                   
                                                                                                                                                                  
 order by TBP.provider_nm ASC ;                                                                                                                                   
                                                                                                                                                                  
 END;                                                                                                                                                             
                                                                                                                                                                  
                                                                                                                                                                  
 $function$                                                                                                                                                       

