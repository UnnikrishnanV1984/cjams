 CREATE OR REPLACE FUNCTION public.serviceplanlog(splanid uuid)                                                                             
  RETURNS TABLE(servicelog json)                                                                                                            
  LANGUAGE plpgsql                                                                                                                          
 AS $function$                                                                                                                            
                                                                                                                                          
                                                                                                                                          
 declare dayscount integer;                                                                                                               
                 skipdays integer;                                                                                                        
                 countperdays integer;                                                                                                    
                 totalsessions integer;                                                                                                   
 begin                                                                                                                                    
                                                                                                                                          
 select count(1) into dayscount from                                                                                                      
 (select to_char(generate_series(sp.startdate, sp.enddate, '1 day'),'day') AS days                                                        
 from serviceplanlog sp                                                                                                                   
 where serviceplanlogid=splanid and activeflag=1 ) A where TRIM(A.days) in                                                                
 (select r.description from serviceplanlogrepeat sr                                                                                       
 inner join repeatdaytype r on sr.repeatdaytypekey = r.repeatdaytypekey                                                                   
 where serviceplanlogid=splanid and sr.activeflag=1);                                                                                     
                                                                                                                                          
 select count(1) into skipdays from serviceplanlogscheduleexemption                                                                       
 where serviceplanlogid=splanid and activeflag=1;                                                                                         
                                                                                                                                          
 select noofoccurence into countperdays from serviceplanlog where serviceplanlogid=splanid and activeflag=1;                              
                                                                                                                                          
 select (dayscount * countperdays) - (skipdays * countperdays) into totalsessions;                                                        
                                                                                                                                          
 return query                                                                                                                             
                                                                                                                                          
 select row_to_json(item.*) as servicelog from                                                                                            
 (select s.serviceplanlogid, s.rate as amount, s.objectid intakeservicerequestid, s.insertedon as requestdate,                            
 '' as servicereqid, '' as authorizationid, '' as fedid,                                                                                  
 s.providerid, s.providercontracttypekey, s.providercontractrateid,                                                                       
 s.startdate, s.enddate, s.isrepeats, s.noofoccurence,                                                                                    
 s.reason,                                                                                                                                
 --s.serviceplanstatustypekey,                                                                                                            
 provinfo.rate, (totalsessions * provinfo.rate) as costestimate,                                                                          
 provinfo.servicetypedescription, provinfo.servicesubtypedescription,                                                                     
 row_to_json(provinfo.*) as providerinfo,                                                                                                 
 row_to_json(ldss.*) as LDSS,                                                                                                             
                                                                                                                                          
 i.servicerequestnumber, a.actortype,                                                                                                     
 concat(per.firstname,' ',per.lastname) as clientname,'' as casename, '' as cisid, '' as clientid,                                        
 concat(up.firstname,' ',up.lastname) as requestorname,                                                                                   
 upphone.phonenumber as requestorphone, upphone.phoneextension as requestorphoneextn                                                      
                                                                                                                                          
 FROM public.serviceplanlog s                                                                                                             
                                                                                                                                          
 inner join public.provider p on s.providerid = p.providerid                                                                              
                                                                                                                                          
 inner join(                                                                                                                              
 select up.securityusersid, up.fullname, up.email, up.orgname, up.orgnumber,                                                              
 upa.address, upa.city, upa.country, upa.county, upa.zipcode, upa.zipcodeplus,                                                            
 upphone.phonenumber, upphone.phoneextension                                                                                              
 from public.userprofile up                                                                                                               
 left join public.userprofileaddress upa on upa.securityusersid = up.securityusersid and upa.userprofileaddresstypekey = 'P'              
 left join public.userprofilephonenumber upphone on upphone.securityusersid = up.securityusersid and upphone.userprofiletypekey = 'office'
 where up.activeflag = 1) as ldss on s.insertedby = ldss.securityusersid                                                                  
                                                                                                                                          
 inner join(                                                                                                                              
 select p.providerid, p.providercode, p.providercategorytypekey, p.providername,                                                          
 p.prefix, p.firstname, p.middlename, p.lastname,                                                                                         
 paddr.provideraddresstypekey, paddr.buildingno, paddr.addressline1, paddr.addressline2,                                                  
 paddr.city, paddr.countyid, coun.countyname, paddr.state, coun.zipcode,                                                                  
 pcinfo.phonenumber, pcinfo.phoneextension, pcinfo.ismobile, pcinfo.email,                                                                
 pconttype.providercontracttypekey, pconttype.providercontracttypename, pcontrate.rate,                                                   
 sr.servicename,                                                                                                                          
 stype.servicetypedescription, ssubtype.servicesubtypedescription                                                                         
 from public.provider p                                                                                                                   
 left join public.provideraddress paddr on p.providerid = paddr.providerid                                                                
 left join public.providercontactinfo pcinfo on p.providerid = pcinfo.providerid and pcinfo.providercontactinfotypekey = 'P'              
 left join public.providercontract pcont on p.providerid = pcont.providerid                                                               
 left join public.providercontracttype pconttype on pcont.programstatuskey = pconttype.providercontracttypekey                            
 left join public.providercontractrate pcontrate on pcontrate.providercontractid = pcont.providercontractid                               
 left join public.providerservice pserv on p.providerid = pserv.providerid                                                                
 left join public.service sr on sr.serviceid = pserv.serviceid                                                                            
 left join public.servicetype stype on sr.servicetypekey = stype.servicetypekey                                                           
 left join public.servicesubtype ssubtype on sr.serviceid = ssubtype.serviceid                                                            
 left join public.county coun on paddr.countyid = coun.countyid                                                                           
 where p.activeflag=1) as provinfo on s.providerid = provinfo.providerid                                                                  
                                                                                                                                          
 inner join public.intakeservicerequest i on s.objectid = i.intakeserviceid::character varying                                            
 inner join public.intakeservicerequestactor ia on ia.intakeserviceid = i.intakeserviceid                                                 
 inner join public.actor a on ia.actorid = a.actorid and a.actortype = 'RC'                                                               
 inner join public.person per on a.personid = per.personid                                                                                
 inner join public.userprofile up on s.insertedby = up.securityusersid                                                                    
 left join public.userprofilephonenumber upphone on upphone.securityusersid = up.securityusersid                                          
 and upphone.userprofiletypekey = 'office' and up.activeflag = 1                                                                          
                                                                                                                                          
 where s.serviceplanlogid = splanid) item;-- limit 1;                                                                                     
                                                                                                                                          
 end;                                                                                                                                     
                                                                                                                                          
                                                                                                                                          
 $function$                                                                                                                                 

