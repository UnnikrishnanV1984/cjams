 CREATE OR REPLACE FUNCTION public.getnewcasereport(from_date character varying, too_date character varying, p_pagesize integer, p_pageoffset integer, nolimit boolean)                                    
  RETURNS TABLE(reccoount bigint, area character varying, restitutions json, totalamount text, totalcase bigint)                                                                                           
  LANGUAGE plpgsql                                                                                                                                                                                         
 AS $function$                                                                                                                                                                                           
                                                                                                                                                                                                         
 DECLARE                                                                                                                                                                                                 
         limitstring character varying(1000);                                                                                                                                                            
 BEGIN                                                                                                                                                                                                   
                                                                                                                                                                                                         
         limitstring = '';                                                                                                                                                                               
         if (nolimit = false) then                                                                                                                                                                       
                 limitstring = ' LIMIT '||p_pagesize||' OFFSET '||p_pageoffset;                                                                                                                          
         end if ;                                                                                                                                                                                        
                                                                                                                                                                                                         
      RETURN QUERY                                                                                                                                                                                       
                 execute 'select count(*) over(),a.accountarea "area",(select json_agg(newcase) from                                                                                                     
                         (                                                                                                                                                                               
                                 select                                                                                                                                                                  
                                         isrp.accountarea "area",                                                                                                                                        
                                         isr.payment::text "amount",                                                                                                                                     
                                         isr.restitutionno "acctnumber",                                                                                                                                 
                                         isr.youthpersonid ,                                                                                                                                             
                                         yp.firstname||'' ''||yp.lastname "offendername",                                                                                                                
                                         isr.insertedon "initialentrydate"                                                                                                                               
                                 from intakeserreqrestitution isr                                                                                                                                        
                                 join (select distinct intakeserreqrestitutionid,accountarea from intakeserreqrestitutionpayment ) isrp on isrp.intakeserreqrestitutionid = isr.intakeserreqrestitutionid
                                 join person yp on yp.personid = isr.youthpersonid                                                                                                                       
                                 where TO_dATE( to_char(isr.insertedon,''YYYY-MM-DD''),''YYYY-MM-DD'') between to_Date('''||from_date||''',''YYYY-MM-DD'') and to_Date('''||Too_date||''',''YYYY-MM-DD'')
                                 and isrp.accountarea = a.accountarea                                                                                                                                    
                         ) newcase),                                                                                                                                                                     
                         oq.totalamount::text "totalamount",                                                                                                                                             
                         oq.totalcase "totalcase"                                                                                                                                                        
                         from (select accountarea from intakeserreqrestitutionpayment group by accountarea)a                                                                                             
                         join (select isrp.accountarea ,sum(isr.payment) "totalamount",count(*) "totalcase"                                                                                              
                                 from intakeserreqrestitution isr                                                                                                                                        
                                 join (select distinct intakeserreqrestitutionid,accountarea from intakeserreqrestitutionpayment) isrp on isrp.intakeserreqrestitutionid = isr.intakeserreqrestitutionid 
                                 where TO_dATE( to_char(isr.insertedon,''YYYY-MM-DD''),''YYYY-MM-DD'') between to_Date('''||from_date||''',''YYYY-MM-DD'') and to_Date('''||Too_date||''',''YYYY-MM-DD'')
                                 group by isrp.accountarea)oq on a.accountarea = oq.accountarea '||limitstring;                                                                                          
                                                                                                                                                                                                         
                                                                                                                                                                                                         
 END;                                                                                                                                                                                                    
 $function$                                                                                                                                                                                                

