 CREATE OR REPLACE FUNCTION public.cdprelimconsent(i_evalutionid uuid)                                                                                                                               
  RETURNS TABLE(currentdate character varying, youthname character varying, youthid character varying, guardianname character varying, policename character varying, provider_name character varying)
  LANGUAGE plpgsql                                                                                                                                                                                   
 AS $function$                                                                                                                                                                                     
    BEGIN                                                                                                                                                                                          
         RETURN QUERY                                                                                                                                                                              
 (select                                                                                                                                                                                           
       CAST(to_char(now(),'MM/DD/YYYY') as character varying) as currentdate,                                                                                                                      
           cast(p.firstname ||' '|| p.lastname as character varying) as youthname,                                                                                                                 
           cast (p.cjamspid as character varying)as youthid,                                                                                                                                       
       CAST((select person.firstname||' '||person.lastname from person                                                                                                                             
                                 where person.personid IN (select a.actorid                                                                                                                        
                               from actor a join intakeservicerequestactor insa                                                                                                                    
                               on a.actorid=insa.actorid and insa.activeflag=1                                                                                                                     
                               join actorrelationship ar on ar.intakeservicerequestactorid=insa.intakeservicerequestactorid and ar.activeflag=1                                                    
                               where  ar.relationshiptypekey='guardian' and a.personid=p.personid))as character varying)  as guardianname,                                                         
                                                           CAST(es.firstname ||' '|| es.lastname as character varying) as policename ,                                                             
                 cast(pr.providername as character varying)  as provider_name                                                                                                                      
        from                                                                                                                                                                                       
        intakeservicerequestevaluation inve                                                                                                                                                        
       left join evaluationsource es on es.evaluationsourceid=inve.evaluationsourceid and es.activeflag=1                                                                                          
       join intakeservicerequest ins on ins.intakenumber=inve.intakenumber                                                                                                                         
       left join intakeservicerequestdispositioncode itsdc on ins.intakeserviceid =itsdc.intakeserviceid and itsdc.activeflag=1                                                                    
        left join intakeservicerequestactor INSRA on INSRA.intakeserviceid=ins.intakeserviceid and INSRA.activeflag=1                                                                              
            left join actor ACC on ACC.actorid=INSRA.actorid and ACC.activeflag=1 and ACC.actortype='Youth'                                                                                        
            join person p on ACC.personid=p.personid and p.activeflag=1                                                                                                                            
            left join placement pl on ins.intakeserviceid =pl.intakeserviceid and pl.activeflag=1                                                                                                  
            left JOIN provider pr ON pl.providerid = pr.providerid AND pr.activeflag=1                                                                                                             
            where  inve.intakeservicerequestevaluationid = i_evalutionid   limit 1) ;                                                                                                              
            end;                                                                                                                                                                                   
   $function$                                                                                                                                                                                        

