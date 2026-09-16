 CREATE OR REPLACE FUNCTION public.sp_interfaceafsvendoroutbound()                                                                                                                       
  RETURNS void                                                                                                                                                                           
  LANGUAGE plpgsql                                                                                                                                                                       
 AS $function$                                                                                                                                                                           
                                                                                                                                                                                         
 DECLARE Vs_insert_count integer DEFAULT 0;                                                                                                                                              
 DECLARE Vs_update_count integer DEFAULT 0;                                                                                                                                              
 DECLARE Vs_interfacelog_count integer DEFAULT 0;                                                                                                                                        
 DECLARE Vs_lastrun_ts  timestamp without time zone;                                                                                                                                     
 DECLARE Vs_current_ts timestamp without time zone;                                                                                                                                      
 BEGIN                                                                                                                                                                                   
                                                                                                                                                                                         
 SELECT MAX (current_run_ts) INTO Vs_lastrun_ts  FROM TB_INTERFACES_RUNTIMES_LOG WHERE interface_tx = 'AFS';                                                                             
 RAISE NOTICE '%', Vs_lastrun_ts;                                                                                                                                                        
                                                                                                                                                                                         
                                                                                                                                                                                         
 INSERT INTO interfaceafsvendoroutbound                                                                                                                                                  
                          (                                                                                                                                                              
                                  "Vendor account"                                                                                                                                       
                                 ,"Alternate vendor number"                                                                                                                              
                                 ,"Type"                                                                                                                                                 
                                 ,"Name"                                                                                                                                                 
                                 ,"Search name"                                                                                                                                          
                                 ,"Group"                                                                                                                                                
                                 ,"Address Location ID"                                                                                                                                  
                                 ,"Address Name"                                                                                                                                         
                                 ,"Address Purpose"                                                                                                                                      
                                 ,"Address Country/Region"                                                                                                                               
                                 ,"Address Zip/Postal code"                                                                                                                              
                                 ,"Address Street"                                                                                                                                       
                                 ,"Address City"                                                                                                                                         
                                 ,"Address State"                                                                                                                                        
                                 ,"Contact Location ID"                                                                                                                                  
                                 ,"Contact Description"                                                                                                                                  
                                 ,"Contact type"                                                                                                                                         
                                 ,"Contact number"                                                                                                                                       
                                 ,"Primary"                                                                                                                                              
                                 ,"Currency"                                                                                                                                             
                                 ,"Terms of Payment"                                                                                                                                     
                                 ,"1099 Reportable"                                                                                                                                      
                                 ,"Federal Tax ID"                                                                                                                                       
                                 ,"Tax ID type"                                                                                                                                          
                         )                                                                                                                                                               
                          SELECT                                                                                                                                                         
                             ''                   --this is from D 365                                                                                                                   
                          ,TBPR.provider_id                                                                                                                                              
                          ,'Organization'      --default                                                                                                                                 
                          ,TBPR.provider_nm                                                                                                                                              
                          ,'                             '                                                                                                                               
                          ,'20'                --not default yet to be confirmed                                                                                                         
                          ,TBPA.adr_county_cd      --(tb)/ adr_county_cd                                                                                                                 
                          ,TBPR.provider_nm                      --same as provider name                                                                                                 
                          ,case when TBPA.adr_type_cd = '31'   then 'HOME'                                                                                                               
                                    when TBPA.adr_type_cd = '3356'   then 'PROVIDER PAYMENT'                                                                                             
                                    when TBPA.adr_type_cd = '3356'   then 'PROVIDER LOCATION'                                                                                            
                                    when TBPA.adr_type_cd = '35'   then 'BUSINESS'                                                                                                       
                                    when TBPA.adr_type_cd = '3359'   then 'WORK'                                                                                                         
                          END            --Business/Home/remit --picklisttable (chechk to find) adr_type_cd (PA) --we have the multpile codes in the picklist which one need to be picked
                          ,'USA'               --default                                                                                                                                 
                          ,TBPA.adr_zip5_no                                                                                                                                              
                          ,TBPA.adr_street_nm                                                                                                                                            
                          ,TBPA.adr_city_nm                                                                                                                                              
                          ,TBPA.adr_state_cd                                                                                                                                             
                          ,'                                '                                                                                                                            
                          ,'                             '                                                                                                                               
                          ,'                             '                                                                                                                               
                          ,'                             '                                                                                                                               
                          ,'                             '                                                                                                                               
                          ,'USD'                           --Default                                                                                                                     
                          ,'N00'                           --Default                                                                                                                     
                          ,TBPR.indicator_1099_sw                                                                                                                                        
                          ,TBPR.tax_id_no                                                                                                                                                
                          ,TBPR.prov_tax_type_cd   --                                                                                                                                    
                                                                                                                                                                                         
                          FROM TB_PROVIDER TBPR                                                                                                                                          
                          INNER JOIN TB_PROVIDER_ADDRESSES TBPA ON TBPR.provider_id::INTEGER = TBPA.parent_key_id::INTEGER                                                               
                          WHERE TBPR.update_ts > Vs_lastrun_ts:: varchar                                                                                                                 
                          AND   TBPR.provider_category_cd = '3304';                                                                                                                      
                                                                                                                                                                                         
                                                                                                                                                                                         
                                                                                                                                                                                         
  /*                                                                                                                                                                                     
  raise notice '% before count >>>>>>>>>>>>>>>>>>>>>>>',Vs_insert_count;                                                                                                                 
         SELECT COUNT(*) INTO Vs_insert_count FROM  public.tb_provider where create_ts = update_ts and provider_category_cd = '3304';                                                    
                                                                                                                                                                                         
                                                                                                                                                                                         
                                  raise notice '% before if >>>>>>>>>>>>>>>>>>>>>>>',Vs_insert_count;                                                                                    
                                                                                                                                                                                         
                  IF Vs_insert_count > 0 THEN                                                                                                                                            
                          raise notice '%  >>>>>>>>>>>>>>>>>>>>>>>',Vs_insert_count;                                                                                                     
                          INSERT INTO interfaceafsvendoroutbound                                                                                                                         
                          (                                                                                                                                                              
                                  "Vendor account"                                                                                                                                       
                                 ,"Alternate vendor number"                                                                                                                              
                                 ,"Type"                                                                                                                                                 
                                 ,"Name"                                                                                                                                                 
                                 ,"Search name"                                                                                                                                          
                                 ,"Group"                                                                                                                                                
                                 ,"Address Location ID"                                                                                                                                  
                                 ,"Address Name"                                                                                                                                         
                                 ,"Address Purpose"                                                                                                                                      
                                 ,"Address Country/Region"                                                                                                                               
                                 ,"Address Zip/Postal code"                                                                                                                              
                                 ,"Address Street"                                                                                                                                       
                                 ,"Address City"                                                                                                                                         
                                 ,"Address State"                                                                                                                                        
                                 ,"Contact Location ID"                                                                                                                                  
                                 ,"Contact Description"                                                                                                                                  
                                 ,"Contact type"                                                                                                                                         
                                 ,"Contact number"                                                                                                                                       
                                 ,"Primary"                                                                                                                                              
                                 ,"Currency"                                                                                                                                             
                                 ,"Terms of Payment"                                                                                                                                     
                                 ,"1099 Reportable"                                                                                                                                      
                                 ,"Federal Tax ID"                                                                                                                                       
                                 ,"Tax ID type"                                                                                                                                          
                         )                                                                                                                                                               
                          SELECT                                                                                                                                                         
                             ''                   --this is from D 365                                                                                                                   
                          ,TBPR.provider_id                                                                                                                                              
                          ,'Organization'      --default                                                                                                                                 
                          ,TBPR.provider_nm                                                                                                                                              
                          ,'must be modified'                                                                                                                                            
                          ,'20'                --not default yet to be confirmed                                                                                                         
                          ,TBPA.adr_county_cd      --(tb)/ adr_county_cd                                                                                                                 
                          ,TBPR.provider_nm                      --same as provider name                                                                                                 
                          ,case when TBPA.adr_type_cd = '31'   then 'HOME'                                                                                                               
                                    when TBPA.adr_type_cd = '3356'   then 'PROVIDER PAYMENT'                                                                                             
                                    when TBPA.adr_type_cd = '3356'   then 'PROVIDER LOCATION'                                                                                            
                                    when TBPA.adr_type_cd = '35'   then 'BUSINESS'                                                                                                       
                                    when TBPA.adr_type_cd = '3359'   then 'WORK'                                                                                                         
                          END            --Business/Home/remit --picklisttable (chechk to find) adr_type_cd (PA) --we have the multpile codes in the picklist which one need to be picked
                          ,'USA'               --default                                                                                                                                 
                          ,TBPA.adr_zip5_no                                                                                                                                              
                          ,TBPA.adr_street_nm                                                                                                                                            
                          ,TBPA.adr_city_nm                                                                                                                                              
                          ,TBPA.adr_state_cd                                                                                                                                             
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'USD'                           --Default                                                                                                                     
                          ,'N00'                           --Default                                                                                                                     
                          ,TBPR.indicator_1099_sw                                                                                                                                        
                          ,TBPR.tax_id_no                                                                                                                                                
                          ,TBPR.prov_tax_type_cd   --                                                                                                                                    
                                                                                                                                                                                         
                          FROM TB_PROVIDER TBPR                                                                                                                                          
                          INNER JOIN TB_PROVIDER_ADDRESSES TBPA ON TBPR.provider_id::INTEGER = TBPA.parent_key_id::INTEGER                                                               
                          WHERE TBPR.create_ts = TBPR.update_ts                                                                                                                          
                          AND   TBPR.provider_category_cd = '3304';                                                                                                                      
         END IF;                                                                                                                                                                         
                                                                                                                                                                                         
         SELECT COUNT(*) INTO Vs_update_count FROM  public.tb_provider where create_ts < update_ts and provider_category_cd = '3304';                                                    
                                                                                                                                                                                         
                                                                                                                                                                                         
                                                                                                                                                                                         
                  IF Vs_update_count > 0 THEN                                                                                                                                            
                          raise notice '%   kkkkkkkkkkkkkkkkk',Vs_update_count;                                                                                                          
                          INSERT INTO interfaceafsvendoroutbound                                                                                                                         
                          (                                                                                                                                                              
                                  "Vendor account"                                                                                                                                       
                                 ,"Alternate vendor number"                                                                                                                              
                                 ,"Type"                                                                                                                                                 
                                 ,"Name"                                                                                                                                                 
                                 ,"Search name"                                                                                                                                          
                                 ,"Group"                                                                                                                                                
                                 ,"Address Location ID"                                                                                                                                  
                                 ,"Address Name"                                                                                                                                         
                                 ,"Address Purpose"                                                                                                                                      
                                 ,"Address Country/Region"                                                                                                                               
                                 ,"Address Zip/Postal code"                                                                                                                              
                                 ,"Address Street"                                                                                                                                       
                                 ,"Address City"                                                                                                                                         
                                 ,"Address State"                                                                                                                                        
                                 ,"Contact Location ID"                                                                                                                                  
                                 ,"Contact Description"                                                                                                                                  
                                 ,"Contact type"                                                                                                                                         
                                 ,"Contact number"                                                                                                                                       
                                 ,"Primary"                                                                                                                                              
                                 ,"Currency"                                                                                                                                             
                                 ,"Terms of Payment"                                                                                                                                     
                                 ,"1099 Reportable"                                                                                                                                      
                                 ,"Federal Tax ID"                                                                                                                                       
                                 ,"Tax ID type"                                                                                                                                          
                         )                                                                                                                                                               
                          SELECT                                                                                                                                                         
                             '1234'                   --this is from D 365       given data is test  data here                                                                           
                          ,TBPR.provider_id                                                                                                                                              
                          ,'Organization'      --default                                                                                                                                 
                          ,TBPR.provider_nm                                                                                                                                              
                          ,'must be modified'                                                                                                                                            
                          ,'20'                --not default yet to be confirmed                                                                                                         
                          ,TBPA.adr_county_cd      --(tb)/ adr_county_cd                                                                                                                 
                          ,TBPR.provider_nm                      --same as provider name                                                                                                 
                          ,case when TBPA.adr_type_cd = '31'   then 'HOME'                                                                                                               
                                    when TBPA.adr_type_cd = '3356'   then 'PROVIDER PAYMENT'                                                                                             
                                    when TBPA.adr_type_cd = '3356'   then 'PROVIDER LOCATION'                                                                                            
                                    when TBPA.adr_type_cd = '35'   then 'BUSINESS'                                                                                                       
                                    when TBPA.adr_type_cd = '3359'   then 'WORK'                                                                                                         
                          END            --Business/Home/remit --picklisttable (chechk to find) adr_type_cd (PA) --we have the multpile codes in the picklist which one need to be picked
                          ,'USA'               --default                                                                                                                                 
                          ,TBPA.adr_zip5_no                                                                                                                                              
                          ,TBPA.adr_street_nm                                                                                                                                            
                          ,TBPA.adr_city_nm                                                                                                                                              
                          ,TBPA.adr_state_cd                                                                                                                                             
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'USD'                           --Default                                                                                                                     
                          ,'N00'                           --Default                                                                                                                     
                          ,TBPR.indicator_1099_sw                                                                                                                                        
                          ,TBPR.tax_id_no                                                                                                                                                
                          ,TBPR.prov_tax_type_cd   --                                                                                                                                    
                                                                                                                                                                                         
                          FROM TB_PROVIDER TBPR                                                                                                                                          
                          INNER JOIN TB_PROVIDER_ADDRESSES TBPA ON TBPR.provider_id::INTEGER = TBPA.parent_key_id::INTEGER                                                               
                          WHERE TBPR.create_ts < TBPR.update_ts                                                                                                                          
                          AND   TBPR.provider_category_cd = '3304';                                                                                                                      
         END IF;                                                                                                                                                                         
                                                                                                                                                                                         
         SELECT MAX(create_ts) into Vs_create_ts  FROM public.tb_provider;                                                                                                               
         SELECT MAX(currentruntimestamp) INTO Vs_current_ts FROM public.interfacesruntimeslog;                                                                                           
                                                                                                                                                                                         
         IF create_ts < currentruntimestamp THEN                                                                                                                                         
                          INSERT INTO interfaceafsvendoroutbound                                                                                                                         
                          (                                                                                                                                                              
                                  "Vendor account"                                                                                                                                       
                                 ,"Alternate vendor number"                                                                                                                              
                                 ,"Type"                                                                                                                                                 
                                 ,"Name"                                                                                                                                                 
                                 ,"Search name"                                                                                                                                          
                                 ,"Group"                                                                                                                                                
                                 ,"Address Location ID"                                                                                                                                  
                                 ,"Address Name"                                                                                                                                         
                                 ,"Address Purpose"                                                                                                                                      
                                 ,"Address Country/Region"                                                                                                                               
                                 ,"Address Zip/Postal code"                                                                                                                              
                                 ,"Address Street"                                                                                                                                       
                                 ,"Address City"                                                                                                                                         
                                 ,"Address State"                                                                                                                                        
                                 ,"Contact Location ID"                                                                                                                                  
                                 ,"Contact Description"                                                                                                                                  
                                 ,"Contact type"                                                                                                                                         
                                 ,"Contact number"                                                                                                                                       
                                 ,"Primary"                                                                                                                                              
                                 ,"Currency"                                                                                                                                             
                                 ,"Terms of Payment"                                                                                                                                     
                                 ,"1099 Reportable"                                                                                                                                      
                                 ,"Federal Tax ID"                                                                                                                                       
                                 ,"Tax ID  type"                                                                                                                                         
                         )                                                                                                                                                               
                          SELECT                                                                                                                                                         
                             ''                   --this is from D 365                                                                                                                   
                          ,TBPR.provider_id                                                                                                                                              
                          ,'Organization'      --default                                                                                                                                 
                          ,TBPR.provider_nm                                                                                                                                              
                          ,'must be modified'                                                                                                                                            
                          ,'20'                --not default yet to be confirmed                                                                                                         
                          ,TBPA.adr_county_cd      --(tb)/ adr_county_cd                                                                                                                 
                          ,TBPR.provider_nm                      --same as provider name                                                                                                 
                          ,case when TBPA.adr_type_cd = '31'   then 'HOME'                                                                                                               
                                    when TBPA.adr_type_cd = '3356'   then 'PROVIDER PAYMENT'                                                                                             
                                    when TBPA.adr_type_cd = '3356'   then 'PROVIDER LOCATION'                                                                                            
                                    when TBPA.adr_type_cd = '35'   then 'BUSINESS'                                                                                                       
                                    when TBPA.adr_type_cd = '3359'   then 'WORK'                                                                                                         
                          END            --Business/Home/remit --picklisttable (chechk to find) adr_type_cd (PA) --we have the multpile codes in the picklist which one need to be picked
                          ,'USA'               --default                                                                                                                                 
                          ,TBPA.adr_zip5_no                                                                                                                                              
                          ,TBPA.adr_street_nm                                                                                                                                            
                          ,TBPA.adr_city_nm                                                                                                                                              
                          ,TBPA.adr_state_cd                                                                                                                                             
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'must be modified'                                                                                                                                            
                          ,'USD'                           --Default                                                                                                                     
                          ,'N00'                           --Default                                                                                                                     
                          ,TBPR.indicator_1099_sw                                                                                                                                        
                          ,TBPR.tax_id_no                                                                                                                                                
                          ,TBPR.prov_tax_type_cd   --                                                                                                                                    
                                                                                                                                                                                         
                          FROM TB_PROVIDER TBPR                                                                                                                                          
                          INNER JOIN TB_PROVIDER_ADDRESSES TBPA ON TBPR.provider_id::INTEGER = TBPA.parent_key_id::INTEGER                                                               
                          WHERE TBPR.create_ts < Vs_current_ts AND  TBPR.create_ts > Vs_create_ts                                                                                        
                          AND   TBPR.provider_category_cd = '3304';                                                                                                                      
         END IF;                                                                                                                                                                         
         */                                                                                                                                                                              
                                                                                                                                                                                         
 END;                                                                                                                                                                                    
 $function$                                                                                                                                                                              

