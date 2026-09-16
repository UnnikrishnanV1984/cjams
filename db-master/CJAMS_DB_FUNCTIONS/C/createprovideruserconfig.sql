 CREATE OR REPLACE FUNCTION public.createprovideruserconfig(v_provider_referral_id text, v_securityuserid text, v_providerid text)
  RETURNS text                                                                                                                    
  LANGUAGE plpgsql                                                                                                                
 AS $function$                                                                                                                  
                                                                                                                                
 declare                                                                                                                        
                                                                                                                                
 v_ReqReferralId text;                                                                                                          
 returnStatus text;                                                                                                             
                                                                                                                                
 applicant_id int;                                                                                                              
                                                                                                                                
                                                                                                                                
                                                                                                                                
 begin                                                                                                                          
         --select * from tb_prov_ref_program_type where referral_id='R201900400069'                                             
                                                                                                                                
 select count (*) into applicant_id  from tb_provider_applicant  TPA where TPA.provider_id = v_providerid;                      
                                                                                                                                
                                                                                                                                
                                                                                                                                
 IF (applicant_id > 0)                                                                                                          
 then                                                                                                                           
                                                                                                                                
 INSERT INTO tb_provider_userconfig                                                                                             
 ( provider_id, applicant_id, securityusers_id, activeflag)                                                                     
                                                                                                                                
 select (TPA.provider_id)::int,TPA.applicant_id,(v_securityuserid)::uuid,1  from  tb_provider_applicant TPA                     
                                                                                                                                
 where TPA.provider_id = v_providerid;                                                                                          
                                                                                                                                
 RAISE NOTICE 'v_providerid:%', v_providerid;                                                                                   
                                                                                                                                
                                                                                                                                
 end if;                                                                                                                        
                                                                                                                                
 RETURN 'Sucess';                                                                                                               
                                                                                                                                
 END;                                                                                                                           
                                                                                                                                
 $function$                                                                                                                       

