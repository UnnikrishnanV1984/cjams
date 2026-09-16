 CREATE OR REPLACE FUNCTION public.restitution_pmt_slip(p_intakenumber character varying, restitution_number integer)                                   
  RETURNS TABLE(youthname character varying, youth_parent character varying, restitution integer, amount_ordered numeric, petition_id character varying)
  LANGUAGE plpgsql                                                                                                                                      
 AS $function$                                                                                                                                        
 declare                                                                                                                                              
    restitution_no integer := restitution_number;                                                                                                     
 begin                                                                                                                                                
         return QUERY select                                                                                                                          
                 cast(yp.firstname || ' ' || yp.lastname as character varying) as youthname,                                                          
                 cast(ypp.firstname || ' ' || ypp.lastname as character varying) as youthparent,                                                      
                 restitution_no,                                                                                                                      
                 isr.payment,                                                                                                                         
                 isrp.petitionid                                                                                                                      
         from                                                                                                                                         
                 intakeserreqrestitution isr                                                                                                          
         left join (                                                                                                                                  
                 select                                                                                                                               
                         p.personid,                                                                                                                  
                         p.firstname,                                                                                                                 
                         p.lastname,                                                                                                                  
                         activeflag                                                                                                                   
                 from                                                                                                                                 
                         person p)yp on                                                                                                               
                 yp.personid = isr.youthpersonid                                                                                                      
                 and yp.activeflag = 1                                                                                                                
                 left join (                                                                                                                          
                 select                                                                                                                               
                         p.personid,                                                                                                                  
                         p.firstname,                                                                                                                 
                         p.lastname,                                                                                                                  
                         activeflag                                                                                                                   
                 from                                                                                                                                 
                         person p)ypp on                                                                                                              
                 ypp.personid = isr.liablepersonid                                                                                                    
                 and ypp.activeflag = 1                                                                                                               
         left join (                                                                                                                                  
                 select                                                                                                                               
                         max(paymentnumber) "paymentnumber",                                                                                          
                         intakeserreqrestitutionid                                                                                                    
                 from                                                                                                                                 
                         intakeserreqrestitutionpayment                                                                                               
                 group by                                                                                                                             
                         intakeserreqrestitutionid) isrpl on                                                                                          
                 isrpl.intakeserreqrestitutionid = isr.intakeserreqrestitutionid                                                                      
         left join intakeservicerequestpetition isrp on                                                                                               
                 isrp.intakenumber = isr.intakenumber                                                                                                 
         where                                                                                                                                        
             isr.activeflag = 1 and                                                                                                                   
             isr.approvestatus = 'RSTAPR' and                                                                                                         
                 isr.intakenumber = p_intakenumber ;                                                                                                  
 end;                                                                                                                                                 
                                                                                                                                                      
 $function$                                                                                                                                             

