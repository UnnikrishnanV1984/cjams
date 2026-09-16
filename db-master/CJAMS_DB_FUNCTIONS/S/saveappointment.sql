 CREATE OR REPLACE FUNCTION public.saveappointment(j_appointments json, v_intakeserviceid uuid, v_intakenumber character varying, v_securityuserid character varying)                               
  RETURNS text                                                                                                                                                                                      
  LANGUAGE plpgsql                                                                                                                                                                                  
 AS $function$                                                                                                                                                                                      
                                                                                                                                                                                                    
 DECLARE                                                                                                                                                                                            
                                                                                                                                                                                                    
 v_date timestamp without time zone;                                                                                                                                                                
 v_intakejson json;                                                                                                                                                                                 
 arr_appointments json;                                                                                                                                                                             
 i json;                                                                                                                                                                                            
 j json;                                                                                                                                                                                            
 k json;                                                                                                                                                                                            
 ischanged bool;                                                                                                                                                                                    
 v_servreqaptmtid uuid;                                                                                                                                                                             
 v_servreqaptmtscheduleid uuid;                                                                                                                                                                     
 v_servreqaptmtscheduleactorid uuid;                                                                                                                                                                
 v_servreqaptmt_historyid uuid;                                                                                                                                                                     
 v_isractorid uuid;                                                                                                                                                                                 
 v_appointmentdate timestamp without time zone;                                                                                                                                                     
 vh_appointmentdate timestamp without time zone;                                                                                                                                                    
 BEGIN                                                                                                                                                                                              
 v_date:= now() at time zone 'utc';                                                                                                                                                                 
                                                                                                                                                                                                    
 ischanged:= true;                                                                                                                                                                                  
                                                                                                                                                                                                    
 -- select jsondata into v_intakejson from intakedastaging where intakenumber = v_intakenumber and activeflag = 1;                                                                                  
                                                                                                                                                                                                    
 arr_appointments := j_appointments;                                                                                                                                                                
                                                                                                                                                                                                    
  -- Notification for Interviews                                                                                                                                                                    
                                                                                                                                                                                                    
         FOR i IN SELECT * FROM json_array_elements(arr_appointments)                                                                                                                               
         LOOP                                                                                                                                                                                       
                 v_servreqaptmtid :=   gen_random_uuid();                                                                                                                                           
                 v_appointmentdate := i ->>'appointmentDate';                                                                                                                                       
                 Insert Into servicerequestappointment (servreqaptmtid, intakeserviceid, title, appointmentstatus, notes, activeflag, insertedby, appointmentdate, appointmentworkerid)             
                         values (v_servreqaptmtid, v_IntakeServiceId, i ->> 'title', i ->> 'status', i ->>'notes', 1,  v_securityuserid, v_appointmentdate, (i ->>'intakeWorkerId')::uuid);         
                                                                                                                                                                                                    
                 For j in Select * from json_array_elements((i ->> 'history')::json)                                                                                                                
                 LOOP                                                                                                                                                                               
                         vh_appointmentdate := i ->>'appointmentDate';                                                                                                                              
                         v_servreqaptmt_historyid :=   gen_random_uuid();                                                                                                                           
                         Insert Into servicerequestappointment (servreqaptmtid, intakeserviceid, title, appointmentstatus, notes, activeflag, insertedby, appointmentdate, appointmentworkerid)     
                         values (v_servreqaptmt_historyid, v_IntakeServiceId, j ->> 'title', j ->> 'status', j ->>'notes', 0,  v_securityuserid, vh_appointmentdate, (j ->>'intakeWorkerId')::uuid);
                                                                                                                                                                                                    
                         For k in Select * from json_array_elements((j ->> 'actors')::json)                                                                                                         
                         LOOP                                                                                                                                                                       
                                 v_servreqaptmtscheduleactorid :=   gen_random_uuid();                                                                                                              
                                                                                                                                                                                                    
                                 --select isra.intakeservicerequestactorid into v_isractorid from intakeservicerequestactor isra                                                                    
                                 select p.personid into v_isractorid from intakeservicerequestactor isra                                                                                            
                                         join actor a on a.actorid = isra.actorid                                                                                                                   
                                         join person p on p.personid = a.personid                                                                                                                   
                                         where isra.intakeserviceid = v_IntakeServiceId and                                                                                                         
                                         --(p.personid = (k ->> 'actorid')::uuid or (p.firstname = k ->> 'firstname' and p.lastname = k ->> 'lastname'))                                            
                                         (CASE WHEN k->>'actorid' not like 'temp%' THEN p.personid = (k->>'actorid')::uuid ELSE (p.firstname = k->>'firstName'                                      
                                         and p.lastname = k->>'lastName') end);                                                                                                                     
                                                                                                                                                                                                    
                                 Insert Into servicerequestappointmentactor (servreqappointmentactorid, servreqaptmtid, intakeservicerequestactorid, isoptional, activeflag, insertedby)            
                                 values (v_servreqaptmtscheduleactorid, v_servreqaptmt_historyid, v_isractorid, (k ->> 'isoptional')::boolean, 0,  v_securityuserid);                               
                                                                                                                                                                                                    
                         END LOOP;                                                                                                                                                                  
                                                                                                                                                                                                    
                 END LOOP;                                                                                                                                                                          
                                                                                                                                                                                                    
                 For k in Select * from json_array_elements((i ->> 'actors')::json)                                                                                                                 
                 LOOP                                                                                                                                                                               
                         v_servreqaptmtscheduleactorid :=   gen_random_uuid();                                                                                                                      
                                                                                                                                                                                                    
                         --select isra.intakeservicerequestactorid into v_isractorid from intakeservicerequestactor isra                                                                            
                         select p.personid into v_isractorid from intakeservicerequestactor isra                                                                                                    
                                 join actor a on a.actorid = isra.actorid                                                                                                                           
                                 join person p on p.personid = a.personid                                                                                                                           
                                 where isra.intakeserviceid = v_IntakeServiceId and                                                                                                                 
                                 --(p.personid = (k ->> 'actorid')::uuid or (p.firstname = k ->> 'firstname' and p.lastname = k ->> 'lastname'));                                                   
                                 (CASE WHEN k->>'actorid' not like 'temp%' THEN p.personid = (k->>'actorid')::uuid ELSE (p.firstname = k->>'firstName'                                              
                                         and p.lastname = k->>'lastName') end);                                                                                                                     
                                                                                                                                                                                                    
                                                                                                                                                                                                    
                         Insert Into servicerequestappointmentactor (servreqappointmentactorid, servreqaptmtid, intakeservicerequestactorid, isoptional, activeflag, insertedby)                    
                         values (v_servreqaptmtscheduleactorid, v_servreqaptmtid, v_isractorid, (k ->> 'isoptional')::boolean, 1,  v_securityuserid);                                               
                                                                                                                                                                                                    
                 END LOOP;                                                                                                                                                                          
                                                                                                                                                                                                    
         End LOOP;                                                                                                                                                                                  
                                                                                                                                                                                                    
         Return 'Success';                                                                                                                                                                          
                                                                                                                                                                                                    
 END;                                                                                                                                                                                               
                                                                                                                                                                                                    
 $function$                                                                                                                                                                                         

