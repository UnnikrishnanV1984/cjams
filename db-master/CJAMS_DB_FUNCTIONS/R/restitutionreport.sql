 CREATE OR REPLACE FUNCTION public.restitutionreport(i_balance integer)                                                                                                                                    
  RETURNS TABLE(youthname character varying, youthid character varying, startdate character varying, paydate character varying, payamount character varying, payaccount character varying, balance numeric)
  LANGUAGE plpgsql                                                                                                                                                                                         
 AS $function$                                                                                                                                                                                           
    BEGIN                                                                                                                                                                                                
         RETURN QUERY                                                                                                                                                                                    
           (select                                                                                                                                                                                       
        CAST(p.firstname||' '||p.lastname as character varying)  as youthname,                                                                                                                           
        CAST(p.cjamspid as character varying) as youthid,                                                                                                                                                
        CAST(to_char(ir.paymentstartdate,'MM/DD/YYYY') as character varying)  as startdate,                                                                                                              
        CAST(to_char(irp.paymentdate,'MM/DD/YYYY') as character varying)  as paydate,                                                                                                                    
        CAST(irp.paymentamount as character varying)  as payamount,                                                                                                                                      
        CAST(irp.paymentnumber as character varying)  as payaccount,                                                                                                                                     
        rpff.balanceamount   as balance --,                                                                                                                                                              
        --sum(rpff.balanceamount) as total_balance                                                                                                                                                       
        from intakeserreqrestitution ir                                                                                                                                                                  
        join person p on p.personid=ir.youthpersonid and p.activeflag=1                                                                                                                                  
        join intakeserreqrestitutionpayment irp on irp.intakeserreqrestitutionid=ir.intakeserreqrestitutionid and irp.activeflag=1                                                                       
        join restitutionpaymentflatfilecontent rpff on irp.restitutionpaymentflatfilecontentid=rpff.restitutionpaymentflatfilecontentid and rpff.activeflag=1                                            
       -- group by youthname,youthid,startdate,paydate,payamount,payaccount,balance                                                                                                                      
        where  rpff.balanceamount >i_balance) ;                                                                                                                                                          
    end;                                                                                                                                                                                                 
   $function$                                                                                                                                                                                              

