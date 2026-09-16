 DROP FUNCTION  IF EXISTS getcasesubtype(text, uuid);
 CREATE OR REPLACE FUNCTION  getcasesubtype(allegationids text, v_intakeservreqtypeid uuid)                                                          
  RETURNS TABLE(servicerequestsubtypeid uuid, classkey character varying, description character varying, datavalues integer)                               
  LANGUAGE plpgsql                                                                                                                                         
 AS $function$                                                                                                                                           
                                                                                                                                                         
 DECLARE                                                                                                                                                 
                                                                                                                                                         
 v_allegationids text[];                                                                                                                                 
 v_count bigint;                                                                                                                                         
                                                                                                                                                         
 BEGIN                                                                                                                                                   
                                                                                                                                                         
 v_allegationids :=allegationids;                                                                                                                        
                                                                                                                                                         
                  CREATE TEMP TABLE temp_offense (                                                                                                       
                                                         subtypeid uuid,                                                                                 
                             datavalues int                                                                                                              
                                             );                                                                                                          
                                                                                                                                                         
                  INSERT INTO temp_offense(subtypeid,datavalues)                                                                                         
                 (SELECT srts.servicerequestsubtypeid,CASE  srts.classkey WHEN  'Delinquency'  THEN 1                                                    
                 WHEN  'CINS' THEN 2
		         WHEN 'Citation'  THEN 3                                                                                                                  
                  END                                                                                                                                    
                  FROM servicerequestsubtype srts                                                                                                        
                  WHERE srts.activeflag =1 AND srts.classkey IN ('Delinquency','Citation','CINS') AND srts.intakeservreqtypeid = v_intakeservreqtypeid); 
                                                                                                                                                         
                                                                                                                                                         
                  SELECT count(*) INTO v_count                                                                                                           
                  FROM allegation ag                                                                                                                     
          WHERE  ag.allegationid = ANY( v_allegationids::uuid[]) AND  ag.activeflag=1                                                                    
                  AND ag.offensecategory IS NOT NULL;                                                                                                    
                                                                                                                                                         
  IF  v_count > 0 THEN                                                                                                                                   
                                                                                                                                                         
         RETURN QUERY                                                                                                                                    
                                                                                                                                                         
          SELECT                                                                                                                                         
                 DISTINCT al.intakeservicereqsubtypeid,                                                                                                  
                 (SELECT st.classkey FROM servicerequestsubtype st WHERE st.servicerequestsubtypeid = al.intakeservicereqsubtypeid                       
                 AND st.activeflag =1 LIMIT 1 ),                                                                                                         
             (SELECT st.description FROM servicerequestsubtype st WHERE st.servicerequestsubtypeid = al.intakeservicereqsubtypeid                        
                 AND st.activeflag =1 LIMIT 1 ) ,                                                                                                        
                 tpf.datavalues                                                                                                                          
       FROM allegation al                                                                                                                                
       INNER JOIN (SELECT max(ag.offensecategory) as offensecategory,ag.allegationid                                                                     
       FROM allegation ag WHERE ag.activeflag=1 AND  ag.allegationid = ANY( v_allegationids::uuid[])                                                     
           AND ag.offensecategory IS NOT NULL                                                                                                            
       GROUP BY ag.allegationid,ag.offensecategory                                                                                                       
       )alle ON alle.allegationid =al.allegationid AND alle.offensecategory = al.offensecategory                                                         
           INNER JOIN temp_offense tpf ON tpf.subtypeid = al.intakeservicereqsubtypeid                                                                   
       WHERE al.allegationid = ANY( v_allegationids::uuid[])                                                                                             
       ORDER BY tpf.datavalues ASC LIMIT 1;                                                                                                              
 ELSE                                                                                                                                                    
      RETURN QUERY                                                                                                                                       
                                                                                                                                                         
          SELECT ss.servicerequestsubtypeid, ss.classkey, ss.description,1                                                                               
          FROM  servicerequestsubtype ss                                                                                                                 
          INNER JOIN servicerequesttypeconfig tpf ON tpf.servicerequestsubtypeid = ss.servicerequestsubtypeid AND tpf.activeflag =1                      
          WHERE ss.activeflag =1 AND ss.intakeservreqtypeid = v_intakeservreqtypeid                                                                      
          ORDER BY classkey asc;                                                                                                                         
                                                                                                                                                         
                                                                                                                                                         
 END IF;                                                                                                                                                 
                                                                                                                                                         
 DROP TABLE temp_offense;                                                                                                                                
 END;                                                                                                                                                    
                                                                                                                                                         
 $function$                                                                                                                                                

