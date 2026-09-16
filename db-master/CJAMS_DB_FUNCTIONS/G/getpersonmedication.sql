 CREATE OR REPLACE FUNCTION public.getpersonmedication(v_personid uuid, pagenumber bigint, pagesize bigint)                                                                                 
  RETURNS json                                                                                                                                                                              
  LANGUAGE plpgsql                                                                                                                                                                          
 AS $function$                                                                                                                                                                              
                                                                                                                                                                                            
 DECLARE                                                                                                                                                                                    
         v_pageoffset  int;                                                                                                                                                                 
         v_pagenumber  int;                                                                                                                                                                 
         l_medications json;                                                                                                                                                                
                                                                                                                                                                                            
 BEGIN                                                                                                                                                                                      
         v_pagenumber := pagenumber-1;                                                                                                                                                      
         v_pageoffset = v_pagenumber * pagesize;                                                                                                                                            
                                                                                                                                                                                            
      SELECT json_agg(e) INTO l_medications FROM(                                                                                                                                           
         SELECT                                                                                                                                                                             
                         (SELECT rv1.description FROM referencevalues rv1 WHERE rv1.ref_key=pm.mdinfoprovidedtypekey AND rv1.activeflag=1) AS mdinfoprovideddescription,                    
                         (SELECT rv2.description FROM referencevalues rv2 WHERE rv2.ref_key=pm.infoclienttypekey AND rv2.activeflag=1) AS infoclientdescription,                            
                         (SELECT rv3.description FROM referencevalues rv3 WHERE rv3.ref_key=pm.adrtypekey AND rv3.activeflag=1) AS adrdescription,                                          
                         (SELECT rv4.description FROM referencevalues rv4 WHERE rv4.ref_key=pm.adrformattypekey AND rv4.activeflag=1) AS adrformatdescription,                              
                         (SELECT rv5.description FROM referencevalues rv5 WHERE rv5.ref_key=pm.adrpredirtypekey AND rv5.activeflag=1) AS adrpredirdescription,                              
                         (SELECT rv6.description FROM referencevalues rv6 WHERE rv6.ref_key=pm.adrstreetsuffixtypekey AND rv6.activeflag=1) AS adrstreetsuffixdescription,                  
                         (SELECT rv7.description FROM referencevalues rv7 WHERE rv7.ref_key=pm.adrpostdirtypekey AND rv7.activeflag=1) AS adrpostdirdescription,                            
                         (SELECT rv8.description FROM referencevalues rv8 WHERE rv8.ref_key=pm.adrunittypetypekey AND rv8.activeflag=1) AS adrunittypedescription,                          
                         (SELECT rv9.description FROM referencevalues rv9 WHERE rv9.ref_key=pm.adrcountytypekey AND rv9.activeflag=1) AS adrcountydescription,                              
                         (SELECT rv10.description FROM referencevalues rv10 WHERE rv10.ref_key=pm.adrstatetypekey AND rv10.activeflag=1) AS adrstatedescription,                            
                         (SELECT rv11.description FROM referencevalues rv11 WHERE rv11.ref_key=pm.infoprovidedbyrelationtypekey AND rv11.activeflag=1) AS infoprovidedbyrelationdescription,
                         pm.*                                                                                                                                                               
                 FROM                                                                                                                                                                       
                 personmedications pm                                                                                                                                                       
                 WHERE pm.activeflag=1 AND pm.personid=v_personid                                                                                                                           
             LIMIT pagesize OFFSET v_pageoffset                                                                                                                                             
       )e ;                                                                                                                                                                                 
                                                                                                                                                                                            
 RETURN l_medications;                                                                                                                                                                      
                                                                                                                                                                                            
 END;                                                                                                                                                                                       
                                                                                                                                                                                            
 $function$                                                                                                                                                                                 

