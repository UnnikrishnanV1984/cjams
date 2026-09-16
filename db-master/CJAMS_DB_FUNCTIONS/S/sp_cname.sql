 CREATE OR REPLACE FUNCTION public.sp_cname(varclntid integer, OUT varout character varying)
  RETURNS character varying                                                                 
  LANGUAGE plpgsql                                                                          
 AS $function$                                                                              
 BEGIN                                                                                      
                                                                                            
                                                                                            
  /*varout = (select coalesce(F_PDESC("TB_CLIENT"."PREFIX_CD", 150),'')||' '||              
                coalesce(first_nm ,'')||' '||                                               
                coalesce(middle_nm,'')||' '||                                               
                coalesce(last_nm,'')||' '||                                                 
                coalesce(F_PDESC("TB_CLIENT"."SUFFIX_CD", 214),'')                          
                from tb_client where client_id = varclntid);--*/                            
                                                                                            
 varout := (select coalesce(F_PDESC("person"."prefx", 150),'')||' '||                       
                coalesce(firstname ,'')||' '||                                              
                coalesce(middlename,'')||' '||                                              
                coalesce(lastname,'')||' '||                                                
                coalesce(F_PDESC("person"."suffix", 214),'')                                
                from person where cjamspid = varclntid);                                    
 END;                                                                                       
 $function$                                                                                 

