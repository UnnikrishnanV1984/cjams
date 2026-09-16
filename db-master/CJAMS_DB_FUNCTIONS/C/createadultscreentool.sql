 CREATE OR REPLACE FUNCTION public.createadultscreentool(j_adultscreentoolobj json, intakeserviceid uuid, securityuserid character varying)
  RETURNS text                                                                                                                             
  LANGUAGE plpgsql                                                                                                                         
 AS $function$                                                                                                                             
                                                                                                                                           
 DECLARE                                                                                                                                   
                                                                                                                                           
                                                                                                                                           
                         v_intakeserviceid uuid;                                                                                           
                     v_securityuserid character varying(50);                                                                               
                         v_adultscreentooljsondata json;                                                                                   
                         v_adultscreentoolholdObj json;                                                                                    
                     v_intakeservreqadultscreentoolid character varying(50);                                                               
                         i json;                                                                                                           
                         s_adultscreenholdOBJ json;                                                                                        
                     result character varying(50);                                                                                         
                                                                                                                                           
                                                                                                                                           
                                                                                                                                           
 begin                                                                                                                                     
                                                                                                                                           
                     v_intakeserviceid=intakeserviceid;                                                                                    
                     v_securityuserid=securityuserid;                                                                                      
                         v_adultscreentooljsondata := j_adultscreentoolObj->>'adultScreenTool';                                            
                                                                                                                                           
                                                                                                                                           
         if(v_adultscreentooljsondata is not null) then                                                                                    
                                                                                                                                           
                                                                                                                                           
                 INSERT INTO intakeservreqadultscreentool                                                                                  
 (                                                                                                                                         
                 intakeserviceid,astdate,intakeworker,countyid, referralname, referralphone, referraladdress1,                             
                 referraladdress2, referralremainanonymous, referralrelationship, clientinfoname,                                          
                 clientinfodob,clientinfoage, gendertypekey, racetypekey,                                                                  
                 ethnicitytypekey, clientinfoaddress1, clientinfoaddress2,                                                                 
                 clientinfophone, maritalstatuskey, monthlyincome, monthlyincomesource, totalassets,                                       
                 totalassetssource, additionalinfo, riskaggrpets, riskhomehazards, riskfireharms, riskpsychiatric,                         
                 riskcdsabuse, riskmedical, riskdomviolence, riskother, riskcomments, detailsofreferralcomments,                           
                 healthcarekey, transportationkey, cluttertypekey, foodtypekey, housingtypekey,                                            
                 supervisiontypekey, individualvulnerable, eatingfeedingkey, takingmedicationkey,                                          
                 walkingkey, bathingkey, dressingkey, toiletkey, physicalrisksnotes, dementiakey, thoughtdisorderskey,                     
                 substanceabusekey, mooddisorderskey, behavioralissueskey, mentalchallengesnotes, supportnetworkkey,                       
                 supportnetworknotes, riskscore, risklevel, intakerecommendation,                                                          
                 updatedby,insertedby                                                                                                      
 )                                                                                                                                         
                                                                                                                                           
 values                                                                                                                                    
 (                                                                                                                                         
                                 v_intakeserviceid::uuid,                                                                                  
                                 (v_adultscreentooljsondata->> 'astdate')::date,                                                           
                                 v_adultscreentooljsondata->> 'intakeworker',                                                              
                                 (v_adultscreentooljsondata->> 'countyid')::uuid,                                                          
                                 v_adultscreentooljsondata->> 'referralname',                                                              
                                 v_adultscreentooljsondata->> 'referralphone',                                                             
                                 v_adultscreentooljsondata->> 'referraladdress1',                                                          
                                 v_adultscreentooljsondata->> 'referraladdress2',                                                          
                                 v_adultscreentooljsondata->> 'referralremainanonymous',                                                   
                                 v_adultscreentooljsondata->> 'referralrelationship',                                                      
                                 v_adultscreentooljsondata->> 'clientinfoname',                                                            
                                 (v_adultscreentooljsondata->> 'clientinfodob')::date,                                                     
                                 v_adultscreentooljsondata->> 'clientinfoage',                                                             
                                 v_adultscreentooljsondata->> 'gendertypekey',                                                             
                                 v_adultscreentooljsondata->> 'racetypekey',                                                               
                                 v_adultscreentooljsondata->> 'ethnicitytypekey',                                                          
                                 v_adultscreentooljsondata->> 'clientinfoaddress1',                                                        
                                 v_adultscreentooljsondata->> 'clientinfoaddress2',                                                        
                                 v_adultscreentooljsondata->> 'clientinfophone',                                                           
                                 v_adultscreentooljsondata->> 'maritalstatuskey',                                                          
                                 v_adultscreentooljsondata->> 'monthlyincome',                                                             
                                 v_adultscreentooljsondata->> 'monthlyincomesource',                                                       
                                 v_adultscreentooljsondata->> 'totalassets',                                                               
                                 v_adultscreentooljsondata->> 'totalassetssource',                                                         
                                 v_adultscreentooljsondata->> 'additionalinfo',                                                            
                                 v_adultscreentooljsondata->> 'riskaggrpets',                                                              
                                 v_adultscreentooljsondata->> 'riskhomehazards',                                                           
                                 v_adultscreentooljsondata->> 'riskfireharms',                                                             
                                 v_adultscreentooljsondata->> 'riskpsychiatric',                                                           
                                 v_adultscreentooljsondata->> 'riskcdsabuse',                                                              
                                 v_adultscreentooljsondata->> 'riskmedical',                                                               
                                 v_adultscreentooljsondata->> 'riskdomviolence',                                                           
                                 v_adultscreentooljsondata->> 'riskother',                                                                 
                                 v_adultscreentooljsondata->> 'riskcomments',                                                              
                                 v_adultscreentooljsondata->> 'detailsofreferralcomments',                                                 
                                 v_adultscreentooljsondata->> 'healthcarekey',                                                             
                                 v_adultscreentooljsondata->> 'transportationkey',                                                         
                                 v_adultscreentooljsondata->> 'cluttertypekey',                                                            
                                 v_adultscreentooljsondata->> 'foodtypekey',                                                               
                                 v_adultscreentooljsondata->> 'housingtypekey',                                                            
                                 v_adultscreentooljsondata->> 'supervisiontypekey',                                                        
                                 v_adultscreentooljsondata->> 'individualvulnerable',                                                      
                                 v_adultscreentooljsondata->> 'eatingfeedingkey',                                                          
                                 v_adultscreentooljsondata->> 'takingmedicationkey',                                                       
                                 v_adultscreentooljsondata->> 'walkingkey',                                                                
                                 v_adultscreentooljsondata->> 'bathingkey',                                                                
                                 v_adultscreentooljsondata->> 'dressingkey',                                                               
                                 v_adultscreentooljsondata->> 'toiletkey',                                                                 
                                 v_adultscreentooljsondata->> 'physicalrisksnotes',                                                        
                                 v_adultscreentooljsondata->> 'dementiakey',                                                               
                                 v_adultscreentooljsondata->> 'thoughtdisorderskey',                                                       
                                 v_adultscreentooljsondata->> 'substanceabusekey',                                                         
                                 v_adultscreentooljsondata->> 'mooddisorderskey',                                                          
                                 v_adultscreentooljsondata->> 'behavioralissueskey',                                                       
                                 v_adultscreentooljsondata->> 'mentalchallengesnotes',                                                     
                                 v_adultscreentooljsondata->> 'supportnetworkkey',                                                         
                                 v_adultscreentooljsondata->> 'supportnetworknotes',                                                       
                                 v_adultscreentooljsondata->> 'riskscore',                                                                 
                                 v_adultscreentooljsondata->> 'risklevel',                                                                 
                                 v_adultscreentooljsondata->> 'intakerecommendation',                                                      
                                 v_securityuserid,v_securityuserid                                                                         
  )                                                                                                                                        
                                                                                                                                           
                            RETURNING "intakeservreqadultscreentoolid" into v_intakeservreqadultscreentoolid;                              
                                                                                                                                           
                                                                                                                                           
  FOR i IN SELECT * FROM json_array_elements                                                                                               
                                                                                                                                           
  ((j_adultscreentoolObj->'adultScreenTool'->>'adultscreentoolhouseholdconfig')::json)                                                     
                                                                                                                                           
                         loop                                                                                                              
                                                                                                                                           
                                 INSERT INTO intakeservreqadultscreentoolhouseholdconfig                                                   
                                 ( intakeservreqadultscreentoolid, "name", relationship, phoneno,updatedby,insertedby)                     
                                                                                                                                           
                                 SELECT v_intakeservreqadultscreentoolid::uuid, i->>'name',                                                
                                                                                                                                           
                                 i->>'relationship',i->>'phone' , v_securityuserid,v_securityuserid;                                       
                                                                                                                                           
                  End LOOP;                                                                                                                
                                                                                                                                           
         result =v_intakeservreqadultscreentoolid;                                                                                         
         Return v_intakeservreqadultscreentoolid;                                                                                          
                                                                                                                                           
         end if;                                                                                                                           
                                                                                                                                           
         return 'fail';                                                                                                                    
                                                                                                                                           
 END;                                                                                                                                      
                                                                                                                                           
 $function$                                                                                                                                

