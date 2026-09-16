 CREATE OR REPLACE FUNCTION public.getccurestitution(from_date character varying, too_date character varying, p_pagesize integer, p_pageoffset integer, nolimit boolean)                 
  RETURNS TABLE(reccoount bigint, area character varying, restitutions json)                                                                                                             
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
          execute 'select count(*) over() reccoount,b.* from (                                                                                                                         
         select  a.accountarea "area",(select json_agg(restitutions) from (select                                                                                                      
                         isr.restitutionno "casenumber",                                                                                                                               
                         isr.payment::text "amount",                                                                                                                                   
                         isr.youthpersonid ,                                                                                                                                           
                         yp.firstname||'' ''||yp.lastname "offendername",                                                                                                              
                         ids.submitteddate "referraldate",                                                                                                                             
                         isr.liablepersonid ,                                                                                                                                          
                         lp.firstname||'' ''||lp.lastname "primarydebtor",                                                                                                             
                         null "secondarydebtor",                                                                                                                                       
                         isr.ccuapprovedate "ccuaccepteddate"                                                                                                                          
                 from intakeserreqrestitution isr                                                                                                                                      
                 join intakeserreqrestitutionpayment isrp on isrp.intakeserreqrestitutionid = isr.intakeserreqrestitutionid                                                            
                 join intakedastatus ids on ids.intakenumber = isr.intakenumber                                                                                                        
                 left join person yp on yp.personid = isr.youthpersonid                                                                                                                
                 left join person lp on lp.personid = isr.liablepersonid                                                                                                               
                 where isrp.accountarea = a.accountarea                                                                                                                                
                 and TO_dATE( to_char(isr.insertedon,''YYYY-MM-DD''),''YYYY-MM-DD'') between to_Date('''||from_date||''',''YYYY-MM-DD'') and to_Date('''||Too_date||''',''YYYY-MM-DD'')
                 and isr.isccu = true                                                                                                                                                  
                 )restitutions)                                                                                                                                                        
                 from (select accountarea from intakeserreqrestitutionpayment group by accountarea) a                                                                                  
         )b where b.json_agg is not null'||limitstring;                                                                                                                                
                                                                                                                                                                                       
                                                                                                                                                                                       
 END;                                                                                                                                                                                  
 $function$                                                                                                                                                                              

