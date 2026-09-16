 CREATE OR REPLACE FUNCTION public.getpersoneducation(v_personid uuid, pagenumber bigint, pagesize bigint)                       
  RETURNS json                                                                                                                   
  LANGUAGE plpgsql                                                                                                               
 AS $function$                                                                                                                   
                                                                                                                                 
 DECLARE                                                                                                                         
         v_pageoffset  int;                                                                                                      
         v_pagenumber  int;                                                                                                      
         l_education json;                                                                                                       
 BEGIN                                                                                                                           
         v_pagenumber  :=  pagenumber-1;                                                                                         
         v_pageoffset  =  v_pagenumber  *  pagesize;                                                                             
                                                                                                                                 
      SELECT json_agg(e) INTO l_education FROM(                                                                                  
         SELECT                                                                                                                  
        (SELECT et.typedescription FROM educationtype  et                                                                        
            WHERE et.educationtypekey = pe.educationtypekey AND et.activeflag =1                                                 
                 LIMIT 1)educationtypedescription,                                                                               
            (SELECT c.countyname FROM county c                                                                                   
             WHERE c.countyid =pe.countyid AND c.activeflag=1 LIMIT 1) countyname,                                               
            (SELECT s.statename FROM state s                                                                                     
             WHERE s.stateabbr =pe.statecode AND s.activeflag=1 LIMIT 1 ) statename,                                             
                 (SELECT g.gradetypekey FROM gradetype g                                                                         
             WHERE g.gradetypekey =pe.lastgradetypekey AND g.activeflag=1                                                        
                 LIMIT 1) lastgradedescription,                                                                                  
                 (SELECT g1.gradetypekey FROM gradetype g1                                                                       
             WHERE g1.gradetypekey =pe.currentgradetypekey AND g1.activeflag=1                                                   
                 LIMIT 1) currentgradetypedescription,                                                                           
                 (SELECT rv1.description                                                                                         
                                  FROM referencevalues rv1                                                                       
                                  WHERE rv1.ref_key =pe.schoolsettingtypekey                                                     
                 AND rv1.activeflag =1 LIMIT 1 )schoolsettingdescription,                                                        
                         (SELECT rv2.description                                                                                 
                                  FROM referencevalues rv2                                                                       
                                  WHERE rv2.ref_key =pe.statustypekey                                                            
                 AND rv2.activeflag =1 LIMIT 1 )statusdescription,                                                               
                   (SELECT rv3.description                                                                                       
                                  FROM referencevalues rv3                                                                       
                                  WHERE rv3.ref_key =pe.adrpredirtypekey                                                         
                 AND rv3.activeflag =1 LIMIT 1 )adrpredirdescription,                                                            
                  (SELECT rv4.description                                                                                        
                                  FROM referencevalues rv4                                                                       
                                  WHERE rv4.ref_key =pe.adrstreetsuffixtypekey                                                   
                 AND rv4.activeflag =1 LIMIT 1 )adrstreetsuffixdescription,                                                      
                 (SELECT rv5.description                                                                                         
                                  FROM referencevalues rv5                                                                       
                                  WHERE rv5.ref_key =pe.adrpostdirtypekey                                                        
                 AND rv5.activeflag =1 LIMIT 1 )adrpostdirdescription,                                                           
                 (SELECT rv5.description                                                                                         
                                  FROM referencevalues rv5                                                                       
                                  WHERE rv5.ref_key =pe.adrunittypetypekey                                                       
                 AND rv5.activeflag =1 LIMIT 1 )adrunitdescription,                                                              
                 pe.*                                                                                                            
                 FROM personeducation pe                                                                                         
                 WHERE pe.activeflag =1 AND pe.personid =v_personid                                                              
             LIMIT  pagesize  OFFSET  v_pageoffset                                                                               
       )e ;                                                                                                                      
 RETURN l_education;                                                                                                             
 END;                                                                                                                            
                                                                                                                                 
 $function$                                                                                                                      

