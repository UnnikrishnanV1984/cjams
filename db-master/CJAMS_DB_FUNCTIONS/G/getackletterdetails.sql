 CREATE OR REPLACE FUNCTION public.getackletterdetails(v_intakenumber character varying)                              
  RETURNS SETOF json                                                                                                  
  LANGUAGE plpgsql                                                                                                    
 AS $function$                                                                                                        
                                                                                                                      
 declare                                                                                                              
                                                                                                                      
 Begin                                                                                                                
                                                                                                                      
   return  query                                                                                                      
                                                                                                                      
                                 select  (SELECT  json_agg(e)  as  routinginfo                                        
                                 from  (select    UP.lastname  ||',  '||  up.firstname  as  screenername,             
                 upto.lastname  ||',  '||  upto.firstname  as  supervisorname,                                        
                   RT.roletypename  as  fromrole,    RT1.roletypename  as  torole,up.title,                           
                   (select  upa.address  from    userprofileaddress    upa                                            
                   inner  join  userprofileaddresstype  upat                                                          
                   on  upa.userprofileaddresstypekey=upat.userprofileaddresstypekey                                   
                   where  upa.userprofileaddresstypekey='P'  and  upa.activeflag=1                                    
                   and  upa.securityusersid=up.securityusersid  limit  1                                              
                   ),                                                                                                 
                   (select  uppn.phonenumber  from    userprofilephonenumber    uppn                                  
                   inner  join  userprofilephonetype  uppt                                                            
                   on  uppn.userprofiletypekey=uppt.userprofiletypekey                                                
                   where  uppn.userprofiletypekey='office'  and  uppn.activeflag=1                                    
                   and  uppn.securityusersid=up.securityusersid  limit  1                                             
                   ),ISR.reporteddate,  ISR.reporterfirstname  ||  '  '  ||ISR.reporterlastname  as  reportername     
                                                                                                                      
                   from    routing  R                                                                                 
                 inner  join  routingstatustype  RST  on  RST.sequencenumber  =  R.routingstatustypeid                
                 inner  join    userprofile  UP  on  UP.securityusersid  =  R.fromsecurityusersid                     
                 inner  join  userprofile  upto  on  upto.securityusersid  =  r.tosecurityusersid                     
                 inner  join  (select  rt.*,  rtt.roletypename  from  role    RT                                      
                 inner  join  roletype  rtt  on  rtt.shortname  =  rt.name  )  RT  on  R.fromroleid  =  RT.roletypekey
                 inner  join  (select  rt.*,  rtt.roletypename  from  role    RT                                      
                 inner  join  roletype  rtt  on  rtt.shortname  =  rt.name  )  RT1  on  R.toroleid  =  RT1.roletypekey
                 where  R.objectid  in  (ISR.intakenumber,ISR.intakeserviceid::character  varying)                    
                 order  by  r.updatedon  asc    )e)::json  from  intakeservicerequest  ISR                            
                 where  ISR.intakenumber  =  v_intakenumber                                                           
                 order  by  ISR.insertedon  desc  ;                                                                   
                                                                                                                      
 end;                                                                                                                 
                                                                                                                      
 $function$                                                                                                           

