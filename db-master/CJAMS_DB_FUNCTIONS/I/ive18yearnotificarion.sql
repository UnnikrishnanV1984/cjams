 CREATE OR REPLACE FUNCTION public.ive18yearnotificarion()                                                                                                                              
  RETURNS character varying                                                                                                                                                             
  LANGUAGE plpgsql                                                                                                                                                                      
 AS $function$                                                                                                                                                                        
                                                                                                                                                                                      
 DECLARE                                                                                                                                                                              
                                                                                                                                                                                      
 v_actorid uuid;                                                                                                                                                                      
 v_tousersid Record;                                                                                                                                                                  
 v_msgs character varying;                                                                                                                                                            
 v_notIFystatus character varying;                                                                                                                                                    
 BEGIN                                                                                                                                                                                
                                                                                                                                                                                      
                                                                                                                                                                                      
         FOR v_tousersid IN                                                                                                                                                           
                                 select r.tosecurityusersid,concat(p.firstname,p.middlename,p.lastname) as childname,pro.providername  from placement pl                              
 join intakeservicerequestactor ina on ina.intakeservicerequestactorid = pl.intakeservicerequestactorid and ina.activeflag=1                                                          
 join actor a on a.actorid = ina.actorid and a.activeflag=1                                                                                                                           
 join person p on p.personid = a.personid and p.activeflag =1                                                                                                                         
 join routing r on r.objectid = pl.placementid :: character varying                                                                                                                   
 left join provider pro on pro.providerid = pl.providerid                                                                                                                             
 where pl.activeflag =1 and r.toroleid ='IVESV' and r.fromroleid = 'CWSP'                                                                                                             
 and (p.dob:: date + interval '18 year'  - interval '1 month') = now() limit 1                                                                                                        
           loop                                                                                                                                                                       
 --        SELECT COALESCE(lastname,'')||', '|| COALESCE(firstname,'')into v_username                                                                                                 
 --              FROM userprofile WHERE securityusersid = v_securityuserid;                                                                                                           
           --v_msg:=  v_notIFymsg || ' by ';                                                                                                                                          
         --  v_msgs:= COALESCE(v_msg ,'') ||COALESCE( v_username,'');                                                                                                                 
         v_msgs :='test 18 year';                                                                                                                                                     
          raise notice 'v_tousersid.securityusersid %',v_tousersid.tosecurityusersid;                                                                                                 
                                   SELECT send_notIFication INTO v_notIFystatus FROM send_notIFication( v_tousersid.tosecurityusersid,v_securityuserid, v_tousersid.tosecurityusersid,
                                 'System', 'High', v_msgs,                                                                                                                            
                                  v_msgs , v_objectid);                                                                                                                               
                                  end loop;                                                                                                                                           
                                                                                                                                                                                      
     RETURN    'SUCCESS';                                                                                                                                                             
 END;                                                                                                                                                                                 
                                                                                                                                                                                      
 $function$                                                                                                                                                                             

