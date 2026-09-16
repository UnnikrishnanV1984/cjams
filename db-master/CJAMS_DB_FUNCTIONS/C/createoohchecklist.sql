 CREATE OR REPLACE FUNCTION public.createoohchecklist(l_servicecaseid uuid, v_userid character varying, v_assignedto character varying, v_personid uuid)                                          
  RETURNS character varying                                                                                                                                                                       
  LANGUAGE plpgsql                                                                                                                                                                                
 AS $function$                                                                                                                                                                                    
 DECLARE         l_servreqtypeid uuid;                                                                                                                                                            
                         l_servreqsubtypeid uuid;                                                                                                                                                 
                         l_programkey character varying;                                                                                                                                          
                         l_subprogramkey character varying;                                                                                                                                       
             l_response character varying;
             l_ppareferenceid uuid;
             l_record RECORD;                                                                                                                                                        
 BEGIN                                                                                                                                                                                            
                                                                                                                                                                                                  
 /*DA Type and Sub type taken for Servicecase */                                                                                                                                                  
      SELECT  intakeservreqtypeid INTO l_servreqtypeid  FROM intakeservicerequesttype WHERE LOWER(intakeservreqtypekey) ='servicecase' AND activeflag =1 LIMIT 1;                                 
      SELECT  servicerequestsubtypeid INTO l_servreqsubtypeid FROM servicerequestsubtype  WHERE LOWER(classkey) =LOWER('ohm') AND activeflag =1 AND intakeservreqtypeid = l_servreqtypeid LIMIT 1;
                                                                                                                                                                                                  
      /*Get Program area and Sub program Area*/                                                                                                                                                   
         SELECT programkey, subprogramkey INTO l_programkey, l_subprogramkey FROM programareaconfig WHERE LOWER(servicerequestsubtypekey) =   'ohm'  AND isdefault =1 ;                           


        CREATE TEMP TABLE IF NOT EXISTS
        Temp_insert_person_program_area (
        personprogramid uuid
        );
                                                                                                                                                                                         
  /*Request info added */                                                                                                                                                                         
          IF NOT EXISTS (SELECT 1 FROM servicecaserequest WHERE servicecaseid = l_servicecaseid                                                                                                   
                                                                                                 AND intakeservreqtypeid= l_servreqtypeid                                                         
                                                                                                 AND servicerequestsubtypeid= l_servreqsubtypeid                                                  
                                                                                                 ) THEN                                                                                           
                 INSERT INTO servicecaserequest                                                                                                                                                   
                             (servicecaseid,                                                                                                                                                      
                              intakeservreqtypeid,                                                                                                                                                
                              servicerequestsubtypeid,                                                                                                                                            
                              programkey,                                                                                                                                                         
                              subprogramkey,                                                                                                                                                      
                              insertedby,                                                                                                                                                         
                              updatedby)                                                                                                                                                          
                 VALUES      (l_servicecaseid,                                                                                                                                                    
                              l_servreqtypeid,                                                                                                                                                    
                              l_servreqsubtypeid,                                                                                                                                                 
                              l_programkey,                                                                                                                                                       
                              l_subprogramkey,                                                                                                                                                    
                              v_userid,                                                                                                                                                           
                              v_userid);                                                                                                                                                          
                                                                                                                                                                                                  
             /*Update end date for Personprogram area*/                                                                                                                                           
              WITH temp_ids AS (UPDATE personprogramarea SET enddate = now()::date,updatedon = now(), updatedby =v_userid, datatransferflag='U'                                                                                          
              WHERE personid IN                                                                                                                                                                   
              (SELECT personid FROM actor   WHERE servicecaseid = l_servicecaseid  AND activeflag =1 AND personid =v_personid)
              RETURNING personprogramid into l_ppareferenceid)
              INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;

                FOR l_record IN (select * from Temp_insert_person_program_area)
                LOOP
                        INSERT INTO auditlog(referenceid, logtypekey, description, metadata, insertedon, insertedby)
                        VALUES(l_record.personprogramid,'PRGMAREA','systemupdate04',
                                                (SELECT row_to_json(personprogramarea) FROM personprogramarea WHERE personprogramid = l_record.personprogramid), now(), v_userid);
                END LOOP;

                DROP TABLE Temp_insert_person_program_area;                                                                    
                                                                                                                                                                                                  
              SELECT createfcchecklist INTO l_response FROM createfcchecklist(l_servicecaseid,l_servreqtypeid,l_servreqsubtypeid,v_assignedto, 'CW');                                             
                                                                                                                                                                                                  
         END IF;                                                                                                                                                                                  
                 /*Insert program Area and Sub programarea*/                                                                                                                                      
         INSERT INTO personprogramarea                                                                                                                                                            
                     (personid,                                                                                                                                                                   
                      programkey,                                                                                                                                                                 
                      subprogramkey,                                                                                                                                                              
                      objecttypekey,                                                                                                                                                              
                      objectid,                                                                                                                                                                   
                      startdate,                                                                                                                                                                  
                      insertedby,                                                                                                                                                                 
                      updatedby,
                      sourcetype)                                                                                                                                                                  
         VALUES( v_personid,                                                                                                                                                                      
                l_programkey,                                                                                                                                                                     
                l_subprogramkey,                                                                                                                                                                  
                'servicecase',                                                                                                                                                                    
                l_servicecaseid,                                                                                                                                                                  
                Now() :: DATE,                                                                                                                                                                    
                v_userid,                                                                                                                                                                         
                v_userid,                                                                                                                                                                         
                'CW')
        RETURNING personprogramid into l_ppareferenceid;

        IF l_ppareferenceid IS NOT NULL THEN
        INSERT INTO auditlog(referenceid, logtypekey, description, metadata, insertedon, insertedby)
        VALUES(l_ppareferenceid,'PRGMAREA','systemupdate05',
                                (SELECT row_to_json(personprogramarea) FROM personprogramarea WHERE personprogramid = l_ppareferenceid), now(), v_userid);
        END IF;
		                                                                                                                                                                
                                                                                                                                                                                                  
 return 'success';                                                                                                                                                                                
                                                                                                                                                                                                  
 END;                                                                                                                                                                                             
 $function$                                                                                                                                                                                       

