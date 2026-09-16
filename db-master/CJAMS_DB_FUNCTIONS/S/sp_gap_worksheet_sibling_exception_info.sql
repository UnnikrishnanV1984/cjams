 CREATE OR REPLACE FUNCTION public.sp_gap_worksheet_sibling_exception_info(al_client_id bigint)                                                           
  RETURNS TABLE(client_id bigint, siblinginfo json)                                                                                                       
  LANGUAGE plpgsql                                                                                                                                        
 AS $function$                                                                                                                                          
                                                                                                                                                        
 DECLARE                                                                                                                                                
                 vs_Procedure_nm                                                         VARCHAR(100) DEFAULT 'sp_gap_worksheet_sibling_exception_info';
                 vn_ive_siblng_info                                                      JSON;                                                          
                                                                                                                                                        
                                                                                                                                                        
                                                                                                                                                        
  BEGIN                                                                                                                                                 
 CREATE TEMP TABLE IF NOT EXISTS                                                                                                                        
 Temp_worksheet_sibling_info (                                                                                                                          
                 client_id                                                                       BIGINT,                                                
                 siblinginfo                                                                     JSON                                                   
         );                                                                                                                                             
                                                                                                                                                        
 SELECT json_agg(json_build_object(                                                                                                                     
         'siblingclientid', isi.siblingclientid ,                                                                                                       
         'siblingclientname', isi.siblingclientname,                                                                                                    
         'siblingguardianid', isi.siblingguardianid,                                                                                                    
         'siblingguardianname', isi.siblingguardianname,                                                                                                
         'siblinggapeligibility', isi.siblinggapeligibility,                                                                                            
         'ivesiblinginfoid', isi.ivesiblinginfoid,                                                                                                      
         'clientid', isi.toclientid                                                                                                                     
 ))                                                                                                                                                     
         INTO vn_ive_siblng_info                                                                                                                        
         FROM ivesiblinginfo isi                                                                                                                        
 WHERE isi.toclientid::BIGINT = al_client_id AND isi.activeflag = 1;                                                                                    
                                                                                                                                                        
 INSERT INTO Temp_worksheet_sibling_info                                                                                                                
 SELECT                                                                                                                                                 
                 al_client_id,                                                                                                                          
                 vn_ive_siblng_info;                                                                                                                    
                                                                                                                                                        
 RETURN QUERY SELECT *                                                                                                                                  
                FROM Temp_worksheet_sibling_info;                                                                                                       
                                                                                                                                                        
 DROP TABLE Temp_worksheet_sibling_info;                                                                                                                
                                                                                                                                                        
    END                                                                                                                                                 
     $function$                                                                                                                                           

