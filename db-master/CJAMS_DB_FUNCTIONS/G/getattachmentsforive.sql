 CREATE OR REPLACE FUNCTION cjams.getattachmentsforive(v_objectid uuid, _page integer, _limit integer)                     
  RETURNS json                                                                                                                   
  LANGUAGE plpgsql                                                                                                               
 AS $function$   
 -- 06/21/2023 Manasa Kasula -- CIDM-7337 Changes to show the person updated by and updated on correctly                                                                                                              
                                                                                                                               
 DECLARE                                                                                                                       
                                                                                                                               
 l_attachments json;                                                                                                           
 _offset    integer;                                                                                                           
                                                                                                                               
 BEGIN                                                                                                                         
 _offset  :=  (_page  -  1)  *  _limit;                                                                                        
                                                                                                                               
 SELECT json_agg(attachments) INTO l_attachments FROM(                                                                         
 SELECT dp.documentpropertiesid, dp.ecmsdocumentid, dp.objecttypekey ,dp.title, dp.documenttypekey,                                                                 
        dp.insertedon, dp.updatedon, (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), dp.updatedby,                                                              
            dp.documentdate, dp.mime, dp.s3bucketpathname,dp.description, dp.filename,                                                      
            dp.filename, dp.numberofbytes, dp.originalfilename,                                                                
 (SELECT json_agg(x) AS documentattachment FROM(                                                                               
                 SELECT                                                                                                        
                 dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey,dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid, dat.attachmentdate
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
 WHERE dp.objectid = V_objectid AND dp.activeflag = 1                                                                                         
 ) AS attachments;                                                                                                             
 RETURN l_attachments;                                                                                                         
 end;                                                                                                                          
                                                                                                                               
 $function$                                                                                                                      

