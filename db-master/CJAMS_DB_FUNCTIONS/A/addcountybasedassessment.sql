 CREATE OR REPLACE FUNCTION public.addcountybasedassessment(intakeobj json, p_intakeserviceid uuid, p_securityuserid character varying)
  RETURNS text                                                                                                                         
  LANGUAGE plpgsql                                                                                                                     
 AS $function$                                                                                                                       
                                                                                                                                     
 declare                                                                                                                             
 returnStatus text;                                                                                                                  
 v_assessmentid uuid;                                                                                                                
 i    json;                                                                                                                          
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 BEGIN                                                                                                                               
                                                                                                                                     
 FOR  i  in  Select  *  from  json_array_elements((intakeobj->'assessment')::json)                                                   
         LOOP                                                                                                                        
                                                                                                                                     
                                                                                                                                     
                 IF  (p_intakeserviceid  is  not  null)  then                                                                        
                                                                                                                                     
                 v_assessmentid :=    i->>'assessmentid';                                                                            
                                                                                                                                     
         RAISE  NOTICE  '  v_assessmentid  %',v_assessmentid;                                                                        
                                                                                                                                     
                 INSERT INTO assessment                                                                                              
 ( assessmenttemplateid, personid, agencyid, securityusersid, assessmentstatustypekey, activeflag,                                   
 insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", objectid,                                 
 objectname, disposition, executerules, requiredind, submissionid, score, intakenumber, submissiondata,                              
 ischildsafe, old_id, ismigrated, assessmentsubmissiontypekey, intakeservicerequestactorid, servicecaseid)                           
                                                                                                                                     
 select  assessmenttemplateid, personid, agencyid, securityusersid, assessmentstatustypekey, activeflag,                             
 p_securityuserid, now(), p_securityuserid,  now(),  now(), expirationdate, "timestamp", p_intakeserviceid,                          
 objectname, disposition, executerules, requiredind, submissionid, score, '', submissiondata,                                        
 ischildsafe, old_id, ismigrated, assessmentsubmissiontypekey, intakeservicerequestactorid, servicecaseid                            
 from assessment where assessmentid=v_assessmentid limit 1;                                                                          
                                                                                                                                     
                                                                                                                                     
             END  IF;                                                                                                                
         END  LOOP;                                                                                                                  
                                                                                                                                     
                                                                                                                                     
 returnStatus:= 'Success';                                                                                                           
                                                                                                                                     
 RETURN returnStatus;                                                                                                                
                                                                                                                                     
 END;                                                                                                                                
                                                                                                                                     
 $function$                                                                                                                            

