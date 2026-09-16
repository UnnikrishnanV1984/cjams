 CREATE OR REPLACE FUNCTION public.createpersonhealthnewtest1(personjson json, v_personid uuid, securityuserid character varying)                                                   
  RETURNS text                                                                                                                                                                      
  LANGUAGE plpgsql                                                                                                                                                                  
 AS $function$                                                                                                                                                                    
                                                                                                                                                                                  
 DECLARE                                                                                                                                                                          
                                                                                                                                                                                  
                         persondata json;                                                                                                                                         
                         p_Personid uuid;                                                                                                                                         
                         v_securityuserid character varying;                                                                                                                      
                         s_examinationObj json;                                                                                                                                   
                         s_personmedicalconditionObj json;                                                                                                                        
                         s_personbehavioralhealthObj json;                                                                                                                        
                         s_personabusehistoryObj json;                                                                                                                            
                         s_personabusesubstanceObj json;                                                                                                                          
                         s_physicianInfoObj json;                                                                                                                                 
                         s_healthInsuranceObj json;                                                                                                                               
                         s_medicationPhyscotropicObj json;                                                                                                                        
                         s_DentalinfoObj json;                                                                                                                                    
                         l_Status character varying;                                                                                                                              
                         i json;                                                                                                                                                  
                         v_date timestamp without time zone;                                                                                                                      
                                                                                                                                                                                  
 BEGIN                                                                                                                                                                            
                                                                                                                                                                                  
                         persondata := personjson;                                                                                                                                
                         p_Personid := v_personid;                                                                                                                                
                         v_date:= now() at time zone 'utc';                                                                                                                       
                         v_securityuserid := securityuserid;                                                                                                                      
                                                                                                                                                                                  
  CREATE TEMP TABLE temp_sp_Create_Temp_personhealthexamination  (                                                                                                                
                                   personhealthexaminationid character varying,                                                                                                   
                                   personid character varying,                                                                                                                    
                                   healthexamname character varying,                                                                                                              
                                   practitionername character varying,                                                                                                            
                                   outcomeresults  character varying,                                                                                                             
                                   healthdomaintypekey character varying,                                                                                                         
                                   healthassessmenttypekey character varying,                                                                                                     
                                   healthprofessiontypekey character varying,                                                                                                     
                                   assessmentdate date,                                                                                                                           
                                   notes character varying,                                                                                                                       
                                   isNew int default 0);                                                                                                                          
                                                                                                                                                                                  
                                                                                                                                                                                  
  CREATE TEMP TABLE temp_sp_Create_Temp_personmedicalconditions  (                                                                                                                
                                                                                                                                                                                  
                                 personmedicalconditionid character varying,                                                                                                      
                                 personid character varying,                                                                                                                      
                                 begindate date,                                                                                                                                  
                                 enddate date,                                                                                                                                    
                                 recordedby character varying,                                                                                                                    
                                 medicalconditiontypekey character varying,                                                                                                       
                     medicalconditionother character varying,                                                                                                                     
                                 isNew int default 0     );                                                                                                                       
                                                                                                                                                                                  
                                                                                                                                                                                  
 CREATE TEMP TABLE temp_sp_Create_Temp_personbehavioralhealths  (                                                                                                                 
                                                                                                                                                                                  
                                 personbehavioralhealthid character varying,                                                                                                      
                             personid character varying,                                                                                                                          
                             clinicianname character varying,                                                                                                                     
                             currentdiagnoses character varying,                                                                                                                  
                             phone character varying,                                                                                                                             
                             address1 character varying,                                                                                                                          
                             address2 character varying,                                                                                                                          
                             reportname character varying,                                                                                                                        
                             reportpath character varying,                                                                                                                        
                             city character varying,                                                                                                                              
                             state character varying,                                                                                                                             
                             countyid uuid,                                                                                                                                       
                             zip character varying,                                                                                                                               
                     isbehavioralhealth bool,                                                                                                                                     
                     personservicetypekey character varying,                                                                                                                      
                                 isNew int default 0);                                                                                                                            
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
 CREATE TEMP TABLE temp_sp_Create_Temp_personabusehistorys  (                                                                                                                     
                                 personabusehistoryid character varying,                                                                                                          
                             personid character varying,                                                                                                                          
                             isneglect bool,                                                                                                                                      
                             isphysicalabuse bool,                                                                                                                                
                             isemotionalabuse bool,                                                                                                                               
                             issexualabuse bool,                                                                                                                                  
                             neglectnotes character varying,                                                                                                                      
                             physicalnotes character varying,                                                                                                                     
                             emotionalnotes character varying,                                                                                                                    
                             sexualnotes character varying,                                                                                                                       
                                 isNew int default 0);                                                                                                                            
                                                                                                                                                                                  
                                                                                                                                                                                  
 CREATE TEMP TABLE temp_sp_Create_Temp_personabusesubstances  (                                                                                                                   
                                 personabusesubstanceid character varying,                                                                                                        
                                 personid character varying,                                                                                                                      
                                 isusetobacco bool,                                                                                                                               
                                 isusedrugoralcohol bool,                                                                                                                         
                                 isusedrug bool,                                                                                                                                  
                                 isusealcohol bool,                                                                                                                               
                                 drugfrequencydetails character varying,                                                                                                          
                                 drugageatfirstuse character varying,                                                                                                             
                                 alcoholfrequencydetails character varying,                                                                                                       
                                 alcoholageatfirstuse character varying,                                                                                                          
                                 drugoralcoholproblems character varying,                                                                                                         
                                 isNew int default 0     );                                                                                                                       
                                                                                                                                                                                  
                                                                                                                                                                                  
 CREATE TEMP TABLE temp_sp_Create_Temp_PhysicianInfos  (                                                                                                                          
                                 personphycisianinfoid character varying,                                                                                                         
                                 personid character varying,                                                                                                                      
                                 isprimaryphycisian bool,                                                                                                                         
                                 name character varying,                                                                                                                          
                                 facility character varying,                                                                                                                      
                                 phone character varying,                                                                                                                         
                                 email character varying,                                                                                                                         
                                 address1 character varying,                                                                                                                      
                                 address2 character varying,                                                                                                                      
                                 city character varying,                                                                                                                          
                                 state character varying,                                                                                                                         
                                 countyid uuid,                                                                                                                                   
                                 zip character varying,                                                                                                                           
                                 startdate date,                                                                                                                                  
                                 enddate date,                                                                                                                                    
                     physicianspecialtytypekey character varying,                                                                                                                 
                                 isNew int default 0     );                                                                                                                       
                                                                                                                                                                                  
 CREATE TEMP TABLE temp_sp_Create_Temp_PersonHealthInsurances (                                                                                                                   
                                 personhealthinsuranceid character varying,                                                                                                       
                                 personid character varying,                                                                                                                      
                                 ismedicaidmedicare bool,                                                                                                                         
                                 providertype character varying,                                                                                                                  
                                 policyholdername character varying,                                                                                                              
                                 address1 character varying,                                                                                                                      
                                 address2 character varying,                                                                                                                      
                                 city character varying,                                                                                                                          
                                 state character varying,                                                                                                                         
                                 countyid uuid,                                                                                                                                   
                                 zip character varying,                                                                                                                           
                                 providerphone character varying,                                                                                                                 
                                 patientpolicyholderrelation character varying,                                                                                                   
                                 policyname character varying,                                                                                                                    
                                 groupnumber character varying,                                                                                                                   
                     providertypeother character varying,                                                                                                                         
                     insurancetype character varying,                                                                                                                             
                                 isNew int default 0     );                                                                                                                       
                                                                                                                                                                                  
                                                                                                                                                                                  
 CREATE TEMP TABLE temp_sp_Create_Temp_personmedicpshychotropics  (                                                                                                               
                                 personmedicpshychotropicid character varying,                                                                                                    
                                 personid character varying,                                                                                                                      
                                 medicationname character varying,                                                                                                                
                                 medicationeffectivedate date,                                                                                                                    
                                 medicationexpirationdate date,                                                                                                                   
                                 dosage character varying,                                                                                                                        
                                 frequency character varying,                                                                                                                     
                                 prescribingdoctor character varying,                                                                                                             
                                 lastdosetakendate date,                                                                                                                          
                                 medicationcomments character varying,                                                                                                            
                                 prescriptionreasontypekey character varying,                                                                                                     
                                 informationsourcetypekey character varying,                                                                                                      
                                 startdate date,                                                                                                                                  
                                 enddate date,                                                                                                                                    
                                 compliant int,                                                                                                                                   
                                 reportedby character varying,                                                                                                                    
                                 medicationtypekey character varying,                                                                                                             
                                 isNew int default 0     );                                                                                                                       
                                                                                                                                                                                  
 CREATE TEMP TABLE temp_sp_Create_Temp_PersonDentalinfos  (                                                                                                                       
                                 persondentalinfoid character varying,                                                                                                            
                                 personid character varying,                                                                                                                      
                                 isdentalinfo bool,                                                                                                                               
                                 dentistname character varying,                                                                                                                   
                                 dentalspecialtytypekey character varying,                                                                                                        
                                 phone character varying,                                                                                                                         
                                 email character varying,                                                                                                                         
                                 address1 character varying,                                                                                                                      
                                 address2 character varying,                                                                                                                      
                                 city character varying,                                                                                                                          
                                 state character varying,                                                                                                                         
                                 countyid uuid,                                                                                                                                   
                                 zip character varying,                                                                                                                           
                                 isNew int default 0     );                                                                                                                       
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         FOR i IN SELECT * FROM json_array_elements(personjson)                                                                                                                   
         LOOP                                                                                                                                                                     
                                                                                                                                                                                  
    s_examinationObj:= i->>'personhealthexam';                                                                                                                                    
                                                                                                                                                                                  
    insert into temp_sp_Create_Temp_personhealthexamination                                                                                                                       
         select   * from json_to_recordset(s_examinationObj ) as x("personhealthexaminationid" character varying,                                                                 
                                   "personid" character varying,                                                                                                                  
                                   "healthexamname" character varying,                                                                                                            
                                   "practitionername" character varying,                                                                                                          
                                   "outcomeresults"  character varying,                                                                                                           
                                   "healthdomaintypekey" character varying,                                                                                                       
                                   "healthassessmenttypekey" character varying,                                                                                                   
                                   "healthprofessiontypekey" character varying,                                                                                                   
                                   "assessmentdate" date,                                                                                                                         
                                   "notes" character varying);                                                                                                                    
                                                                                                                                                                                  
                                                                                                                                                                                  
         s_personmedicalconditionObj:= i->>'personmedicalcondition';                                                                                                              
         insert into temp_sp_Create_Temp_personmedicalconditions                                                                                                                  
         select   * from json_to_recordset(s_personmedicalconditionObj ) as x("personmedicalconditionid" character varying,                                                       
                                         "personid" character varying,                                                                                                            
                                         "begindate" date,                                                                                                                        
                                         "enddate" date,                                                                                                                          
                                         "recordedby" character varying,                                                                                                          
                                         "medicalconditiontypekey" character varying,                                                                                             
                                         "medicalconditionother" character varying       );                                                                                       
                                                                                                                                                                                  
                                                                                                                                                                                  
         s_personbehavioralhealthObj := i->>'personbehavioralhealth';                                                                                                             
         insert into temp_sp_Create_Temp_personbehavioralhealths                                                                                                                  
         select   * from json_to_recordset(s_personbehavioralhealthObj ) as x("personbehavioralhealthid" character varying,                                                       
                                         "personid" character varying,                                                                                                            
                                         "clinicianname" character varying,                                                                                                       
                                         "currentdiagnoses" character varying,                                                                                                    
                                         "phone" character varying,                                                                                                               
                                         "address1" character varying,                                                                                                            
                                         "address2" character varying,                                                                                                            
                                         "reportname" character varying,                                                                                                          
                                         "reportpath" character varying,                                                                                                          
                                         "city" character varying,                                                                                                                
                                         "state" character varying,                                                                                                               
                                         "countyid" uuid,                                                                                                                         
                                         "zip" character varying,                                                                                                                 
                                         "isbehavioralhealth" bool,                                                                                                               
                         "personservicetypekey" character varying                                                                                                                 
                                         );                                                                                                                                       
                                                                                                                                                                                  
 /*                                                                                                                                                                               
                                                                                                                                                                                  
         s_personabusehistoryObj := i->>'personabusehistory';                                                                                                                     
         insert into temp_sp_Create_Temp_personabusehistorys                                                                                                                      
          select * from json_to_recordset(s_personabusehistoryObj ) as x(                                                                                                         
                                 "personabusehistoryid" character varying,                                                                                                        
                             "personid" character varying,                                                                                                                        
                             "isneglect" bool,                                                                                                                                    
                             "isphysicalabuse" bool,                                                                                                                              
                             "isemotionalabuse" bool,                                                                                                                             
                             "issexualabuse" bool,                                                                                                                                
                             "neglectnotes" character varying,                                                                                                                    
                             "physicalnotes" character varying,                                                                                                                   
                             "emotionalnotes" character varying,                                                                                                                  
                             "sexualnotes" character varying      );                                                                                                              
                                                                                                                                                                                  
                 */                                                                                                                                                               
                                                                                                                                                                                  
                                                                                                                                                                                  
                 s_personabusehistoryObj := i->>'personabusehistory';                                                                                                             
                                                                                                                                                                                  
                 insert into temp_sp_Create_Temp_personabusehistorys  (                                                                                                           
                        personabusehistoryid,                                                                                                                                     
                             personid,                                                                                                                                            
                             isneglect,                                                                                                                                           
                             isphysicalabuse,                                                                                                                                     
                             isemotionalabuse,                                                                                                                                    
                             issexualabuse,                                                                                                                                       
                             neglectnotes,                                                                                                                                        
                             physicalnotes,                                                                                                                                       
                             emotionalnotes,                                                                                                                                      
                             sexualnotes                                                                                                                                          
          ) values                                                                                                                                                                
          ((s_personabusehistoryObj ->> 'personabusehistoryid'),                                                                                                                  
                           (s_personabusehistoryObj ->> 'personid'),                                                                                                              
                           (s_personabusehistoryObj ->> 'isneglect')::bool,                                                                                                       
                           (s_personabusehistoryObj ->> 'isphysicalabuse')::bool,                                                                                                 
                           (s_personabusehistoryObj ->> 'isemotionalabuse')::bool,                                                                                                
                           (s_personabusehistoryObj ->> 'issexualabuse')::bool,                                                                                                   
                           (s_personabusehistoryObj ->> 'neglectnotes'),                                                                                                          
                           (s_personabusehistoryObj ->> 'physicalnotes'),                                                                                                         
                           (s_personabusehistoryObj ->> 'emotionalnotes'),                                                                                                        
                           (s_personabusehistoryObj ->> 'sexualnotes')                                                                                                            
                          );                                                                                                                                                      
                                                                                                                                                                                  
                                                                                                                                                                                  
 /*                                                                                                                                                                               
                                                                                                                                                                                  
         s_personabusesubstanceObj := i->>'personabusesubstance';                                                                                                                 
           insert into temp_sp_Create_Temp_personabusesubstances                                                                                                                  
         select * from json_to_recordset(s_personabusesubstanceObj ) as x(                                                                                                        
                                 "personabusesubstanceid" character varying,                                                                                                      
                             "personid" character varying,                                                                                                                        
                             "isusetobacco" bool,                                                                                                                                 
                             "isusedrugoralcohol" bool,                                                                                                                           
                             "isusedrug" bool,                                                                                                                                    
                             "isusealcohol" bool,                                                                                                                                 
                             "drugfrequencydetails" character varying,                                                                                                            
                             "drugageatfirstuse" character varying,                                                                                                               
                             "alcoholfrequencydetails" character varying,                                                                                                         
                             "alcoholageatfirstuse" character varying,                                                                                                            
                             "drugoralcoholproblems" character varying           );                                                                                               
                                                                                                                                                                                  
                                                                                                                                                                                  
         */                                                                                                                                                                       
                                                                                                                                                                                  
                                                                                                                                                                                  
                 s_personabusesubstanceObj := i->>'personabusesubstance';                                                                                                         
                                                                                                                                                                                  
          insert into temp_sp_Create_Temp_personabusesubstances (                                                                                                                 
                                         personabusesubstanceid,                                                                                                                  
                                         personid,                                                                                                                                
                                         isusetobacco,                                                                                                                            
                                         isusedrugoralcohol,                                                                                                                      
                                         isusedrug,                                                                                                                               
                                         isusealcohol,                                                                                                                            
                                         drugfrequencydetails,                                                                                                                    
                                         alcoholageatfirstuse,                                                                                                                    
                                         drugoralcoholproblems                                                                                                                    
          ) values                                                                                                                                                                
                                                                                                                                                                                  
          (s_personabusesubstanceObj ->> 'personabusesubstanceid',                                                                                                                
           (s_personabusesubstanceObj ->> 'personid'),                                                                                                                            
           (s_personabusesubstanceObj ->> 'isusetobacco')::bool,                                                                                                                  
           (s_personabusesubstanceObj ->> 'isusedrugoralcohol')::bool,                                                                                                            
          (s_personabusesubstanceObj ->> 'isusedrug')::bool,                                                                                                                      
           (s_personabusesubstanceObj ->> 'isusealcohol')::bool,                                                                                                                  
           (s_personabusesubstanceObj ->> 'drugfrequencydetails'),                                                                                                                
          (s_personabusesubstanceObj ->> 'alcoholageatfirstuse'),                                                                                                                 
           (s_personabusesubstanceObj ->> 'drugoralcoholproblems'));                                                                                                              
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         s_physicianInfoObj:= i->>'physicianinfo';                                                                                                                                
          insert into temp_sp_Create_Temp_PhysicianInfos                                                                                                                          
         select   * from json_to_recordset(s_physicianInfoObj) as x("personphycisianinfoid" character varying,                                                                    
                                 "personid" character varying,                                                                                                                    
                                 "isprimaryphycisian" bool,                                                                                                                       
                                 "name" character varying,                                                                                                                        
                                 "facility" character varying,                                                                                                                    
                                 "phone" character varying,                                                                                                                       
                                 "email" character varying,                                                                                                                       
                                 "address1" character varying,                                                                                                                    
                                 "address2" character varying,                                                                                                                    
                                 "city" character varying,                                                                                                                        
                                 "state" character varying,                                                                                                                       
                                 "countyid" uuid,                                                                                                                                 
                                 "zip" character varying,                                                                                                                         
                                 "startdate" date,                                                                                                                                
                                 "enddate" date,                                                                                                                                  
                                 "physicianspecialtytypekey" character varying                                                                                                    
                                 );                                                                                                                                               
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         s_healthInsuranceObj:= i->>'healthinsurance';                                                                                                                            
           insert into temp_sp_Create_Temp_PersonHealthInsurances                                                                                                                 
         select   * from json_to_recordset(s_healthInsuranceObj ) as x("personhealthinsuranceid" character varying,                                                               
                                 "personid" character varying,                                                                                                                    
                                 "ismedicaidmedicare" bool,                                                                                                                       
                                 "providertype" character varying,                                                                                                                
                                 "policyholdername" character varying,                                                                                                            
                                 "address1" character varying,                                                                                                                    
                                 "address2" character varying,                                                                                                                    
                                 "city" character varying,                                                                                                                        
                                 "state" character varying,                                                                                                                       
                                 "countyid" uuid,                                                                                                                                 
                                 "zip" character varying,                                                                                                                         
                                 "providerphone" character varying,                                                                                                               
                                 "patientpolicyholderrelation" character varying,                                                                                                 
                                 "policyname" character varying,                                                                                                                  
                                 "groupnumber" character varying,                                                                                                                 
                                 "providertypeother" character varying,                                                                                                           
                             "insurancetype" character varying                                                                                                                    
                                 );                                                                                                                                               
                                                                                                                                                                                  
         s_medicationPhyscotropicObj:= i->>'personmedicationphyscotropic';                                                                                                        
            insert into temp_sp_Create_Temp_personmedicpshychotropics                                                                                                             
                 select   * from json_to_recordset(s_medicationPhyscotropicObj ) as x(                                                                                            
                                 "personmedicpshychotropicid" character varying,                                                                                                  
                                 "personid" character varying,                                                                                                                    
                                 "medicationname" character varying,                                                                                                              
                                 "medicationeffectivedate" date,                                                                                                                  
                            "medicationexpirationdate" date,                                                                                                                      
                                 "dosage" character varying,                                                                                                                      
                                 "frequency" character varying,                                                                                                                   
                                 "prescribingdoctor" character varying,                                                                                                           
                                 "lastdosetakendate" date,                                                                                                                        
                                 "medicationcomments" character varying,                                                                                                          
                                 "prescriptionreasontypekey" character varying,                                                                                                   
                                 "informationsourcetypekey" character varying,                                                                                                    
                                 "startdate" date,                                                                                                                                
                                 "enddate" date,                                                                                                                                  
                                 "compliant" int,                                                                                                                                 
                                 "reportedby" character varying,                                                                                                                  
                                 "medicationtypekey" character varying   );                                                                                                       
                                                                                                                                                                                  
 s_DentalinfoObj:= i->>'persondentalinfo';                                                                                                                                        
                                                                                                                                                                                  
  insert into temp_sp_Create_Temp_PersonDentalinfos                                                                                                                               
         select   * from json_to_recordset(s_DentalinfoObj) as x("persondentalinfoid" character varying,                                                                          
                                 "personid" character varying,                                                                                                                    
                                 "isdentalinfo" bool,                                                                                                                             
                                 "dentistname" character varying,                                                                                                                 
                                 "dentalspecialtytypekey" character varying,                                                                                                      
                                 "phone" character varying,                                                                                                                       
                                 "email" character varying,                                                                                                                       
                                 "address1" character varying,                                                                                                                    
                                 "address2" character varying,                                                                                                                    
                                 "city" character varying,                                                                                                                        
                                 "state" character varying,                                                                                                                       
                                 "countyid" uuid,                                                                                                                                 
                                 "zip" character varying                                                                                                                          
                                 );                                                                                                                                               
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         update temp_sp_Create_Temp_personhealthexamination set  isNew =1 where coalesce(personhealthexaminationid,'') ='';                                                       
                                                                                                                                                                                  
         UPDATE personhealthexamination SET activeflag=0, updatedby = v_securityuserid, updatedon = v_date                                                                        
         WHERE personhealthexaminationid  in (select personhealthexaminationid::uuid from temp_sp_Create_Temp_personhealthexamination where isnew=0);                             
                                                                                                                                                                                  
                           INSERT INTO personhealthexamination( personid, healthexamname, practitionername,                                                                       
                                                    outcomeresults, healthdomaintypekey, healthassessmenttypekey, healthprofessiontypekey, assessmentdate,                        
                                                    notes, activeflag,insertedby, updatedby, insertedon, updatedon)                                                               
                                                                                                                                                                                  
                   SELECT p_Personid::uuid,healthexamname, practitionername, outcomeresults, healthdomaintypekey,healthassessmenttypekey, healthprofessiontypekey,assessmentdate, 
                                         notes,1,v_securityuserid,v_securityuserid, v_date, v_date FROM   temp_sp_Create_Temp_personhealthexamination WHERE isNew=1;              
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
 update temp_sp_Create_Temp_personmedicalconditions  set  isNew =1 where coalesce(personmedicalconditionid,'') ='';                                                               
                                                                                                                                                                                  
 UPDATE personmedicalcondition SET activeflag=0, updatedby = v_securityuserid, updatedon = v_date                                                                                 
 WHERE personmedicalconditionid  in (select personmedicalconditionid::uuid from                                                                                                   
                                                                         temp_sp_Create_Temp_personmedicalconditions where isnew=0);                                              
                                                                                                                                                                                  
                                 insert into personmedicalcondition( personid, begindate, enddate,                                                                                
                                                    recordedby, medicalconditiontypekey,medicalconditionother,                                                                    
                                                         activeflag,insertedby, updatedby, insertedon, updatedon)                                                                 
                                                                                                                                                                                  
                    SELECT p_Personid::uuid,begindate, enddate, recordedby, medicalconditiontypekey,medicalconditionother,                                                        
                         1,v_securityuserid,v_securityuserid, v_date, v_date FROM   temp_sp_Create_Temp_personmedicalconditions WHERE isNew=1;                                    
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         update temp_sp_Create_Temp_personbehavioralhealths set  isNew =1 where coalesce(personbehavioralhealthid,'') ='';                                                        
                                                                                                                                                                                  
         UPDATE personbehavioralhealth SET activeflag=0, updatedby = v_securityuserid, updatedon = v_date                                                                         
         WHERE personbehavioralhealthid  in (select personbehavioralhealthid::uuid from temp_sp_Create_Temp_personbehavioralhealths where isnew=0);                               
                                                                                                                                                                                  
                                                                                                                                                                                  
                                 INSERT INTO personbehavioralhealth(personid, clinicianname, currentdiagnoses, phone, address1, address2,                                         
                                         reportname, city, state, countyid, zip,reportpath,isbehavioralhealth,personservicetypekey,                                               
                                         activeflag, updatedby,insertedby, updatedon, insertedon)                                                                                 
                                                                                                                                                                                  
                                  SELECT p_Personid::uuid, clinicianname, currentdiagnoses, phone, address1, address2,                                                            
                                         reportname, city, state, countyid::uuid, zip,reportpath,isbehavioralhealth,personservicetypekey,                                         
                       1,v_securityuserid,v_securityuserid, v_date, v_date FROM                                                                                                   
                                   temp_sp_Create_Temp_personbehavioralhealths WHERE isNew=1;                                                                                     
                                                                                                                                                                                  
                                                                                                                                                                                  
         update temp_sp_Create_Temp_personabusehistorys set  isNew =1 where coalesce(personabusehistoryid,'') ='';                                                                
                                                                                                                                                                                  
         UPDATE personabusehistory SET activeflag=0, updatedby = v_securityuserid, updatedon = v_date                                                                             
         WHERE personabusehistoryid  in (select personabusehistoryid::uuid from temp_sp_Create_Temp_personabusehistorys where isnew=0);                                           
                                                                                                                                                                                  
                                                                                                                                                                                  
                         insert into personabusehistory(personid,isneglect,isemotionalabuse,isphysicalabuse,issexualabuse,                                                        
                                                  neglectnotes,physicalnotes,emotionalnotes,sexualnotes,                                                                          
                                         activeflag, updatedby,insertedby, updatedon, insertedon )                                                                                
                                                                                                                                                                                  
                                         SELECT p_Personid::uuid, isneglect::bool,isemotionalabuse::bool,                                                                         
                                         isphysicalabuse::bool,issexualabuse::bool,                                                                                               
                                                  neglectnotes,physicalnotes,emotionalnotes,sexualnotes,                                                                          
                       1,v_securityuserid,v_securityuserid, v_date, v_date FROM                                                                                                   
                                   temp_sp_Create_Temp_personabusehistorys WHERE isNew=1;                                                                                         
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         update temp_sp_Create_Temp_personabusesubstances set  isNew =1 where coalesce(personabusesubstanceid,'') ='';                                                            
                                                                                                                                                                                  
         UPDATE personabusesubstance SET activeflag=0, updatedby = v_securityuserid, updatedon = v_date                                                                           
         WHERE personabusesubstanceid  in (select personabusesubstanceid::uuid from                                                                                               
                                                                           temp_sp_Create_Temp_personabusesubstances where isnew=0);                                              
                                                                                                                                                                                  
                                 insert into personabusesubstance(personid,isusetobacco,isusedrugoralcohol,isusedrug,isusealcohol,                                                
                                                  drugageatfirstuse, drugfrequencydetails, alcoholageatfirstuse,                                                                  
                                                  alcoholfrequencydetails,drugoralcoholproblems,                                                                                  
                                         activeflag, updatedby,insertedby, updatedon, insertedon )                                                                                
                                                                                                                                                                                  
                                         SELECT p_Personid::uuid, isusetobacco,isusedrugoralcohol,isusedrug,isusealcohol,                                                         
                                                  drugageatfirstuse, drugfrequencydetails, alcoholageatfirstuse,                                                                  
                                                  alcoholfrequencydetails,drugoralcoholproblems,                                                                                  
                       1,v_securityuserid,v_securityuserid, v_date, v_date FROM                                                                                                   
                                   temp_sp_Create_Temp_personabusesubstances WHERE isNew=1;                                                                                       
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         update temp_sp_Create_Temp_PhysicianInfos set  isNew =1 where coalesce(personphycisianinfoid,'') ='';                                                                    
                                                                                                                                                                                  
         UPDATE personphycisianinfo SET activeflag=0, updatedby = v_securityuserid, updatedon = v_date                                                                            
         WHERE personphycisianinfoid  in (select personphycisianinfoid::uuid from temp_sp_Create_Temp_PhysicianInfos where isnew=0);                                              
                                                                                                                                                                                  
                                                                                                                                                                                  
                 INSERT INTO personphycisianinfo( personid, isprimaryphycisian, name,                                                                                             
                                  facility, phone, email,                                                                                                                         
                                  address1, address2, city, state, countyid, zip,                                                                                                 
                                  startdate, enddate,physicianspecialtytypekey,                                                                                                   
                                 activeflag, insertedby, updatedby, insertedon, updatedon)                                                                                        
                                                                                                                                                                                  
                                 SELECT p_Personid::uuid, isprimaryphycisian, name,                                                                                               
                                  facility, phone, email,                                                                                                                         
                                  address1, address2, city, state, countyid::uuid, zip,                                                                                           
                                  startdate, enddate,physicianspecialtytypekey,                                                                                                   
                       1,v_securityuserid,v_securityuserid, v_date, v_date FROM                                                                                                   
                                   temp_sp_Create_Temp_PhysicianInfos WHERE isNew=1;                                                                                              
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         update temp_sp_Create_Temp_PersonHealthInsurances set  isNew =1 where coalesce(personhealthinsuranceid,'') ='';                                                          
                                                                                                                                                                                  
         UPDATE personhealthinsurance SET activeflag=0, updatedby = v_securityuserid, updatedon = v_date                                                                          
         WHERE personhealthinsuranceid  in (select personhealthinsuranceid::uuid from temp_sp_Create_Temp_PersonHealthInsurances where isnew=0);                                  
                                                                                                                                                                                  
              INSERT INTO personhealthinsurance( personid, ismedicaidmedicare, providertype, policyholdername,                                                                    
                                 address1, address2, city, state, countyid, zip,                                                                                                  
                                 providerphone, patientpolicyholderrelation, policyname, groupnumber,providertypeother, insurancetype,                                            
                                 activeflag, insertedby, updatedby, insertedon, updatedon)                                                                                        
                                                                                                                                                                                  
                         SELECT p_Personid::uuid, ismedicaidmedicare::bool, providertype, policyholdername,                                                                       
                                 address1, address2, city, state, countyid::uuid, zip,                                                                                            
                                 providerphone, patientpolicyholderrelation, policyname, groupnumber,providertypeother,insurancetype,                                             
                                 1, v_securityuserid,v_securityuserid, v_date, v_date                                                                                             
                         FROM   temp_sp_Create_Temp_PersonHealthInsurances WHERE isnew=1;                                                                                         
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         update temp_sp_Create_Temp_personmedicpshychotropics set  isNew =1 where coalesce(personmedicpshychotropicid,'') ='';                                                    
                                                                                                                                                                                  
         UPDATE personmedicpshychotropic SET activeflag=0, updatedby = v_securityuserid, updatedon = v_date                                                                       
         WHERE personmedicpshychotropicid  in (select personmedicpshychotropicid::uuid from                                                                                       
                                                                                   temp_sp_Create_Temp_personmedicpshychotropics where isnew=0);                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
         INSERT INTO personmedicpshychotropic( personid, medicationname, medicationeffectivedate,                                                                                 
                                                  medicationexpirationdate, dosage, frequency, prescribingdoctor,lastdosetakendate,                                               
                                                  medicationcomments, prescriptionreasontypekey, informationsourcetypekey,                                                        
                                                 startdate,enddate,compliant,reportedby,medicationtypekey,                                                                        
                                                 activeflag, insertedby, updatedby, insertedon, updatedon)                                                                        
                                                                                                                                                                                  
                         SELECT p_Personid::uuid, medicationname, medicationeffectivedate,                                                                                        
                                                  medicationexpirationdate, dosage, frequency, prescribingdoctor,lastdosetakendate,                                               
                                                  medicationcomments, prescriptionreasontypekey, informationsourcetypekey,                                                        
                                                  startdate,enddate,compliant,reportedby,medicationtypekey,                                                                       
                                                 1, v_securityuserid,v_securityuserid, v_date, v_date                                                                             
                         FROM   temp_sp_Create_Temp_personmedicpshychotropics WHERE isNew=1;                                                                                      
                                                                                                                                                                                  
 update temp_sp_Create_Temp_PersonDentalinfos set  isNew =1 where coalesce(persondentalinfoid,'') ='';                                                                            
                                                                                                                                                                                  
         UPDATE persondentalinfo SET activeflag=0, updatedby = v_securityuserid, updatedon = v_date                                                                               
         WHERE persondentalinfoid  in (select persondentalinfoid::uuid from temp_sp_Create_Temp_PersonDentalinfos where isnew=0);                                                 
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
                                 INSERT INTO persondentalinfo( personid, isdentalinfo, dentistname,                                                                               
                                 dentalspecialtytypekey, phone, email, address1,                                                                                                  
                                 address2, city, state, countyid, zip,                                                                                                            
                         activeflag, insertedby, updatedby, insertedon, updatedon)                                                                                                
                                                                                                                                                                                  
                                                                                                                                                                                  
                                 SELECT p_Personid::uuid, isdentalinfo, dentistname,                                                                                              
                                  dentalspecialtytypekey, phone, email,                                                                                                           
                                  address1, address2, city, state, countyid::uuid, zip,                                                                                           
                       1,v_securityuserid,v_securityuserid, v_date, v_date FROM                                                                                                   
                                   temp_sp_Create_Temp_PersonDentalinfos WHERE isNew=1;                                                                                           
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
 END LOOP;                                                                                                                                                                        
                                                                                                                                                                                  
                                                                                                                                                                                  
 l_Status := 'SUCCESS';                                                                                                                                                           
                                                                                                                                                                                  
 DROP TABLE temp_sp_Create_Temp_personhealthexamination;                                                                                                                          
 DROP TABLE temp_sp_Create_Temp_personmedicalconditions;                                                                                                                          
 DROP TABLE temp_sp_Create_Temp_personbehavioralhealths;                                                                                                                          
 DROP TABLE temp_sp_Create_Temp_personabusehistorys;                                                                                                                              
 DROP TABLE temp_sp_Create_Temp_personabusesubstances;                                                                                                                            
 DROP TABLE temp_sp_Create_Temp_PhysicianInfos;                                                                                                                                   
 DROP TABLE temp_sp_Create_Temp_PersonHealthInsurances;                                                                                                                           
 DROP TABLE temp_sp_Create_Temp_personmedicpshychotropics;                                                                                                                        
 DROP TABLE temp_sp_Create_Temp_PersonDentalinfos;                                                                                                                                
                                                                                                                                                                                  
 return l_Status;                                                                                                                                                                 
                                                                                                                                                                                  
 END                                                                                                                                                                              
                                                                                                                                                                                  
 $function$                                                                                                                                                                         

