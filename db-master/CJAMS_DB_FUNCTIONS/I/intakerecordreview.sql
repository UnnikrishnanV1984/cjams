 CREATE OR REPLACE FUNCTION public.intakerecordreview(i_intakenumber character varying)                                                                       
  RETURNS TABLE(currentdate character varying, youthname character varying, youthid character varying, foldertypekey character varying, dob character varying)
  LANGUAGE plpgsql                                                                                                                                            
 AS $function$                                                                                                                                              
    BEGIN                                                                                                                                                   
         RETURN QUERY                                                                                                                                       
           (select distinct CAST(to_char(now(),'MM/DD/YYYY') as character varying) as currentdate,                                                          
           cast(p.firstname ||' '|| p.lastname as character varying) as youthname,                                                                          
           cast (p.cjamspid as character varying)as youthid,                                                                                                
          ins.intakenumber as foldertypekey,                                                                                                                
           cast(to_char(p.dob,'MM/DD/YYYY') as character varying) as DOB                                                                                    
        from                                                                                                                                                
      intakeservicerequest ins                                                                                                                              
        left join intakeservicerequestactor INSRA on INSRA.intakeserviceid=ins.intakeserviceid and INSRA.activeflag=1                                       
            left join actor ACC on ACC.actorid=INSRA.actorid and ACC.activeflag=1 and ACC.actortype='Youth'                                                 
            join person p on ACC.personid=p.personid and p.activeflag=1                                                                                     
        where  ins.intakenumber= i_intakenumber limit 1) ;                                                                                                  
    end;                                                                                                                                                    
   $function$                                                                                                                                                 

