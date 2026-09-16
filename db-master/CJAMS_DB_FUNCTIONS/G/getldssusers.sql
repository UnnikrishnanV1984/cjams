 CREATE OR REPLACE FUNCTION public.getldssusers(v_servicerequestid uuid)                                                                                                       
  RETURNS TABLE(caseworkerdetails json, supervisordetails json)                                                                                                                
  LANGUAGE plpgsql                                                                                                                                                             
 AS $function$                                                                                                                                                               
                                                                                                                                                                             
 DECLARE                                                                                                                                                                     
                                                                                                                                                                             
 BEGIN                                                                                                                                                                       
                                                                                                                                                                             
 RETURN query                                                                                                                                                                
                                                                                                                                                                             
 SELECT                                                                                                                                                                      
 (SELECT json_agg(casew) FROM (SELECT cw.firstname ||' ' || cw.lastname caseworkername,cw.email,cw.address,cw.zipcode,cw.city,cw.state,cw.userprofiletypekey,cw.phonenumber) 
 as casew):: json caseworkerdetails,                                                                                                                                         
 (SELECT json_agg(super) FROM (SELECT sp.firstname ||' ' || sp.lastname supervisorname,sp.email,sp.address,sp.zipcode,sp.city,sp.state,sp.userprofiletypekey,sp.phonenumber) 
 as super):: json supervisordetails                                                                                                                                          
                                                                                                                                                                             
 FROM intakeservicerequest ISR                                                                                                                                               
 INNER JOIN routing R on R.objectid = ISR.intakeserviceid::character varying                                                                                                 
 INNER JOIN (SELECT up.firstname, up.lastname,up.email,upa.address,upa.zipcode,upa.city,upa.state,up.securityusersid,up.activeflag,upp.userprofiletypekey,upp.phonenumber    
         FROM userprofile up  LEFT JOIN userprofileaddress upa on upa.securityusersid = up.securityusersid                                                                   
         and upa.activeflag =1                                                                                                                                               
         LEFT JOIN userprofilephonenumber upp on upp.securityusersid = up.securityusersid                                                                                    
         and upp.activeflag=1                                                                                                                                                
         )cw on cw.securityusersid = r.tosecurityusersid and cw.activeflag =1                                                                                                
                                                                                                                                                                             
 INNER JOIN (SELECT up.firstname, up.lastname,up.email, upa.address,upa.zipcode,upa.city,upa.state,up.securityusersid,up.activeflag,upp.userprofiletypekey,upp.phonenumber   
 FROM userprofile up  LEFT JOIN userprofileaddress upa on upa.securityusersid = up.securityusersid                                                                           
            and upa.activeflag =1                                                                                                                                            
            LEFT JOIN userprofilephonenumber upp on upp.securityusersid = up.securityusersid                                                                                 
            and upp.activeflag=1                                                                                                                                             
            ) sp on sp.securityusersid = r.fromsecurityusersid and sp.activeflag =1                                                                                          
                                                                                                                                                                             
 WHERE isr.intakeserviceid = v_servicerequestid  and routingstatustypeid =4 ;                                                                                                
 END;                                                                                                                                                                        
                                                                                                                                                                             
 $function$                                                                                                                                                                    

