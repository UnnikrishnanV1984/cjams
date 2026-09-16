 CREATE OR REPLACE FUNCTION public.getpersonexamination(v_personid uuid, pagenumber bigint, pagesize bigint)                     
  RETURNS json                                                                                                                   
  LANGUAGE plpgsql                                                                                                               
 AS $function$  
                                                                                                                              
 DECLARE                                                                                                                         
         v_pageoffset  int;                                                                                                      
         v_pagenumber  int;                                                                                                      
         l_examination json;                                                                                                     
 BEGIN                                                                                                                           
         v_pagenumber  :=  pagenumber-1;                                                                                         
         v_pageoffset  =  v_pagenumber  *  pagesize;                                                                             
                                                                                                                                 
      SELECT json_agg(e) INTO l_examination FROM(                                                                                
         SELECT                                                                                                                  
                                 pe.appointkeptflag,                                                                             
                                 pe.appoinmentdate,                                                                              
                                 pe.nextappointmentdate,                                                                         
                                 pe.examinationtypekey,                                                                          
                                 (SELECT rv.description                                                                          
                                  FROM referencevalues rv                                                                        
                                  WHERE rv.ref_key =pe.examinationtypekey )examinationtypedescription,                           
                                  pe.comments,                                                                                   
                                  pe.specialityexamtypekey,                                                                      
                                  (SELECT rv1.description                                                                        
                                  FROM referencevalues rv1                                                                       
                                  WHERE rv1.ref_key =pe.specialityexamtypekey  )specialitytypedescription,                       
                                  pe.labtesttypekey,                                                                             
                                  (SELECT rv2.description                                                                        
                                  FROM referencevalues rv2                                                                       
                                  WHERE rv2.ref_key =pe.labtesttypekey  ) labtesttypedescription,                                
                                  pe.hivconsentflag,                                                                             
                                  pe.recommendations,                                                                            
                                  pe.providerid,                                                                                 
                                  pe.motherflag,                                                                                 
                                  pe.fatherflag,                                                                                 
                                  pe.otherflag,                                                                                  
                                  pe.othernotes,                                                                                 
                                  pe.infocomments,                                                                               
                                  pe.providerid,                                                                                 
                                 (SELECT  pp.providername                                                                        
                                 FROM provider pp                                                                                
                                 WHERE pp.activeflag =1 AND pp.providerid =pe.providerid                                         
                                  LIMIT 1                                                                                        
                                  )providername,                                                                                 
                                  pe.exprovidedtypekey,                                                                          
                                  pe.providedbyclientid,                                                                         
                                  pe.collateralid,                                                                               
                                  pe.infoclienttypekey,                                                                          
                                  pe.physicianname,                                                                              
                                  pe.physicianspeciality,                                                                        
                                  pe.affiliateorg,                                                                               
                                  pe.addresstypekey,                                                                             
                                  pe.formattypekey,                                                                              
                                  pe.streetnumber,                                                                               
                                  pe.boxnumber,                                                                                  
                                  pe.predirtypekey,                                                                              
                                  pe.streetname,                                                                                 
                                  pe.streetsuffixtypekey,                                                                        
                                  pe.postdirtypekey,                                                                             
                                  pe.unittypekey,                                                                                
                                  pe.unitnumbertx,                                                                               
                                  pe.cityname,                                                                                   
                                  pe.countytypekey,                                                                              
                                  pe.statetypekey,                                                                               
                                  pe.zip5no,                                                                                     
                                  pe.zip4no,                                                                                     
                                  pe.direction,                                                                                  
                                  pe.foreignaddress,                                                                             
                                  pe.workphone,                                                                                  
                                  pe.workextn,                                                                                   
                                  pe.homephone,                                                                                  
                                  pe.pager,                                                                                      
                                  pe.email,                                                                                      
                                  pe.fax,                                                                                        
                                  pe.mobile,                                                                                     
                                  pe.url,                                                                                        
                                  pe.othercontacts,                                                                              
                                  pe.foreignstate,                                                                               
                                  pe.country,                                                                                    
                                  pe.postalcode,                                                                                 
                                  pe.streetnotes,                                                                                
                                  pe.providedbynotes,                                                                            
                                  pe.providedbyrelationtypekey,                                                                  
                                  pe.expungementflag,                                                                            
                                  pe.datavalidflag                                                                               
                 FROM personexamination pe                                                                                       
                 WHERE pe.activeflag =1 AND pe.personid =v_personid                                                              
             LIMIT  pagesize  OFFSET  v_pageoffset                                                                               
       )e ;                                                                                                                      
 RETURN l_examination;                                                                                                           
 END;                                                                                                                            
                                                                                                                                 
 $function$                                                                                                                      

