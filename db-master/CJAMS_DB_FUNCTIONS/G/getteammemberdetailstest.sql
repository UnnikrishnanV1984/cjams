 CREATE OR REPLACE FUNCTION public.getteammemberdetailstest(_position_code character varying, _role_type character varying, _first_name character varying, _last_name character varying)
  RETURNS json                                                                                                                                                                          
  LANGUAGE plpgsql                                                                                                                                                                      
 AS $function$                                                                                                                                                                          
 DECLARE result json;                                                                                                                                                                   
 DECLARE position_code character varying;                                                                                                                                               
 DECLARE role_type character varying;                                                                                                                                                   
 DECLARE first_name character varying;                                                                                                                                                  
 DECLARE last_name character varying;                                                                                                                                                   
                                                                                                                                                                                        
 BEGIN                                                                                                                                                                                  
                                                                                                                                                                                        
       IF _first_name = 'undefined' THEN                                                                                                                                                
            first_name = null;                                                                                                                                                          
       ELSE                                                                                                                                                                             
            first_name = _first_name;                                                                                                                                                   
       END IF;                                                                                                                                                                          
       IF _last_name = 'undefined' THEN                                                                                                                                                 
           last_name = null;                                                                                                                                                            
       ELSE                                                                                                                                                                             
           last_name = _last_name;                                                                                                                                                      
       END IF;                                                                                                                                                                          
       IF _position_code = 'undefined' THEN                                                                                                                                             
          position_code = null;                                                                                                                                                         
       ELSE                                                                                                                                                                             
          position_code = _position_code;                                                                                                                                               
       END IF;                                                                                                                                                                          
                                                                                                                                                                                        
         IF _role_type = 'undefined' THEN                                                                                                                                               
          role_type = null;                                                                                                                                                             
       ELSE                                                                                                                                                                             
          role_type = _role_type;                                                                                                                                                       
       END IF;                                                                                                                                                                          
                                                                                                                                                                                        
          IF (length(first_name)>0 OR length(last_name)>0 OR length(position_code)>0 OR length(role_type)>0) THEN                                                                       
                                                                                                                                                                                        
                                                                                                                                                                                        
          select array_to_json(array_agg(e)) from                                                                                                                                       
         (SELECT array_to_json(array_agg(row_to_json(d))) as "data" from (                                                                                                              
         SELECT A.* FROM (SELECT A.teammemberid,A.positioncode,A.roletypekey,C.displayname FROM teammember A, teammemberassignment B, userprofile C                                     
         WHERE A.teammemberid = B.teammemberid AND B.SecurityUsersId = C.SecurityUsersId                                                                                                
         AND CASE WHEN length(first_name)>0 THEN lower(C.firstname) LIKE first_name || '%' ELSE TRUE END                                                                                
         AND CASE WHEN length(last_name)>0 THEN  lower(C.lastname)  LIKE last_name || '%' ELSE TRUE END                                                                                 
         AND CASE WHEN length(position_code)>0 THEN A.positioncode LIKE position_code || '%' ELSE TRUE END                                                                              
         AND CASE WHEN length(role_type)>0 THEN lower(A.roletypekey) LIKE role_type || '%' ELSE TRUE END                                                                                
         ) A                                                                                                                                                                            
        -- LEFT OUTER JOIN usernotificationgroupdetail D ON A.teammemberid = D.teammemberid                                                                                             
         GROUP BY A.teammemberid,A.positioncode,A.roletypekey,A.displayname                                                                                                             
         ORDER BY A.displayname ASC )d)e INTO result;                                                                                                                                   
                                                                                                                                                                                        
         RAISE NOTICE '----1111111--------->>>>>>>%',result;                                                                                                                            
                                                                                                                                                                                        
 RETURN COALESCE(result,'[]');                                                                                                                                                          
                                                                                                                                                                                        
                                                                                                                                                                                        
 ELSE                                                                                                                                                                                   
                                                                                                                                                                                        
  select array_to_json(array_agg(e)) from                                                                                                                                               
         (SELECT array_to_json(array_agg(row_to_json(d))) as "data" from (                                                                                                              
         SELECT A.* FROM (SELECT A.teammemberid,A.positioncode,A.roletypekey,C.displayname FROM teammember A, teammemberassignment B, userprofile C                                     
         WHERE A.teammemberid = B.teammemberid AND B.SecurityUsersId = C.SecurityUsersId                                                                                                
         ) A                                                                                                                                                                            
        -- LEFT OUTER JOIN usernotificationgroupdetail D ON A.teammemberid = D.teammemberid                                                                                             
         GROUP BY A.teammemberid,A.positioncode,A.roletypekey,A.displayname                                                                                                             
         ORDER BY A.displayname ASC )d)e INTO result;                                                                                                                                   
                                                                                                                                                                                        
 RAISE NOTICE '----2222222--------->>>>>>>%',result;                                                                                                                                    
                                                                                                                                                                                        
 RETURN COALESCE(result,'[]');                                                                                                                                                          
                                                                                                                                                                                        
 END IF;                                                                                                                                                                                
                                                                                                                                                                                        
 END;                                                                                                                                                                                   
  $function$                                                                                                                                                                            

