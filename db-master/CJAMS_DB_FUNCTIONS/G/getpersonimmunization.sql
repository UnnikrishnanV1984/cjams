 CREATE OR REPLACE FUNCTION public.getpersonimmunization(v_personid uuid, pagenumber bigint, pagesize bigint)                                                                         
  RETURNS json                                                                                                                                                                        
  LANGUAGE plpgsql                                                                                                                                                                    
 AS $function$                                                                                                                                                                        
                                                                                                                                                                                      
 DECLARE                                                                                                                                                                              
         v_pageoffset  int;                                                                                                                                                           
         v_pagenumber  int;                                                                                                                                                           
         l_immunization json;                                                                                                                                                         
                                                                                                                                                                                      
 BEGIN                                                                                                                                                                                
         v_pagenumber := pagenumber-1;                                                                                                                                                
         v_pageoffset = v_pagenumber * pagesize;                                                                                                                                      
                                                                                                                                                                                      
      SELECT json_agg(e) INTO l_immunization FROM(                                                                                                                                    
         SELECT                                                                                                                                                                       
                         (SELECT rv1.description FROM referencevalues rv1 WHERE rv1.ref_key=pimm.immunizationtypekey AND rv1.activeflag=1) AS immunizationdescription,                
                         (SELECT rv2.statename                                                                                                                                        
                         FROM state rv2                                                                                                                                               
                         WHERE rv2.stateid=pimm.statetypekey AND rv2.activeflag=1) AS statedescription,                                                                               
                         (SELECT rv3.description FROM referencevalues rv3 WHERE rv3.ref_key=pimm.unittypekey AND rv3.activeflag=1) AS unitdescription,                                
                         (SELECT rv4.description FROM referencevalues rv4 WHERE rv4.ref_key=pimm.postdirtypekey AND rv4.activeflag=1) AS postdirdescription,                          
                         (SELECT rv5.description FROM referencevalues rv5 WHERE rv5.ref_key=pimm.streetsuffixtypekey AND rv5.activeflag=1) AS streetsuffixdescription,                
                         (SELECT rv6.description FROM referencevalues rv6 WHERE rv6.ref_key=pimm.predirtypekey AND rv6.activeflag=1) AS predirdescription,                            
                         (SELECT rv7.countyname                                                                                                                                       
                         FROM county rv7                                                                                                                                              
                         WHERE rv7.countyid=pimm.countytypekey AND rv7.activeflag=1) AS countydescription,                                                                            
                         (SELECT rv8.description FROM referencevalues rv8 WHERE rv8.ref_key=pimm.formattypekey AND rv8.activeflag=1) AS formatdescription,                            
                         (SELECT rv9.description FROM referencevalues rv9 WHERE rv9.ref_key=pimm.iminfoprovidedtypekey AND rv9.activeflag=1) AS iminfoprovideddescription,            
                         (SELECT rv10.description FROM referencevalues rv10 WHERE rv10.ref_key=pimm.infoclienttypekey AND rv10.activeflag=1) AS infoclientdescription,                
                         (SELECT rv11.description FROM referencevalues rv11 WHERE rv11.ref_key=pimm.addresstypekey AND rv11.activeflag=1) AS addressdescription,                      
                         (SELECT rv12.description FROM referencevalues rv12 WHERE rv12.ref_key=pimm.providedbyrelationtypekey AND rv12.activeflag=1) AS providedbyrelationdescription,
                         pimm.*                                                                                                                                                       
                 FROM                                                                                                                                                                 
                 personimmunization pimm                                                                                                                                              
                 WHERE pimm.activeflag=1 AND pimm.personid=v_personid                                                                                                                 
             LIMIT pagesize OFFSET v_pageoffset                                                                                                                                       
       )e ;                                                                                                                                                                           
                                                                                                                                                                                      
 RETURN l_immunization;                                                                                                                                                               
                                                                                                                                                                                      
 END;                                                                                                                                                                                 
                                                                                                                                                                                      
 $function$                                                                                                                                                                           

