 CREATE OR REPLACE FUNCTION public.getservicecaseattachments(v_objectid uuid, _page integer, _limit integer)                     
  RETURNS json                                                                                                                   
  LANGUAGE plpgsql                                                                                                               
 AS $function$      

 -----------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 04/12/2023 Umasankar - Adding "other" column to the documentproperties table-- CIDM-6863
------------------------------------------------------------------------------------------------------------                                                                                                           
                                                                                                                               
 DECLARE                                                                                                                       
                                                                                                                               
 l_attachments json;                                                                                                           
 _offset    integer;                                                                                                           
                                                                                                                               
 BEGIN                                                                                                                         
 _offset  :=  (_page  -  1)  *  _limit;                                                                                        
                                                                                                                               
 SELECT json_agg(attachments) INTO l_attachments FROM(                                                                         
 SELECT dp.documentpropertiesid ,dp.title, dp.documenttypekey,                                                                 
        dp.insertedon, dp.updatedon, dp.insertedby, dp.updatedby,                                                              
            dp.documentdate, dp.mime, dp.s3bucketpathname,dp.description, dp.other,                                                     
            dp.filename, dp.numberofbytes, dp.originalfilename,                                                                
 (SELECT json_agg(x) AS documentattachment FROM(                                                                               
                 SELECT                                                                                                        
                 dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.assessmenttemplateid
                 from documentattachment dat                                                                                   
                 WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                      
         )  x),                                                                                                                
 (SELECT json_agg(y) AS userprofile FROM(                                                                                      
                 SELECT                                                                                                        
                 up.securityusersid, up.firstname, up.lastname, up.displayname                                                 
                 from userprofile up                                                                                           
                 WHERE up.securityusersid = dp.insertedby                                                                      
         )  y),                                                                                                                
 (SELECT json_agg(z) AS updateduserprofile FROM(                                                                               
                 SELECT                                                                                                        
                 uup.securityusersid, uup.firstname, uup.lastname, uup.displayname                                             
                 from userprofile uup                                                                                          
                 WHERE uup.securityusersid = dp.updatedby                                                                      
         )  z)                                                                                                                 
                                                                                                                               
 FROM documentproperties dp                                                                                                    
 INNER JOIN intakeservicerequest isr on isr.intakeserviceid = dp.servicerequestid AND isr.activeflag = 1 AND dp.activeflag =1  
 WHERE isr.servicecaseid = V_objectid                                                                                          
 LIMIT _limit OFFSET _offset                                                                                                   
 ) AS attachments;                                                                                                             
 RETURN l_attachments;                                                                                                         
 end;                                                                                                                          
                                                                                                                               
 $function$                                                                                                                      
