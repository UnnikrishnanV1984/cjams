 CREATE OR REPLACE FUNCTION public.getgroupinglist(page integer, size integer, _order character varying, _first_name character varying, _last_name character varying, _position_code character varying)
  RETURNS json                                                                                                                                                                                         
  LANGUAGE plpgsql                                                                                                                                                                                     
 AS $function$                                                                                                                                                                                         
 DECLARE result json;                                                                                                                                                                                  
 DECLARE totalcount integer;                                                                                                                                                                           
 --DECLARE usrnotificationgroupid uuid;                                                                                                                                                                
 DECLARE first_name character varying;                                                                                                                                                                 
 DECLARE last_name character varying;                                                                                                                                                                  
 DECLARE position_code character varying;                                                                                                                                                              
 DECLARE orderby character varying;                                                                                                                                                                    
 BEGIN                                                                                                                                                                                                 
                                                                                                                                                                                                       
                                                                                                                                                                                                       
      /* IF _usrnotificationgroupid = 'undefined' THEN                                                                                                                                                 
            usrnotificationgroupid = null;                                                                                                                                                             
       ELSE                                                                                                                                                                                            
            usrnotificationgroupid = CAST(_usrnotificationgroupid AS UUID);                                                                                                                            
       END IF;*/                                                                                                                                                                                       
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
       IF _order = 'undefined' THEN                                                                                                                                                                    
          orderby = '''displayname asc''';                                                                                                                                                             
       ELSE                                                                                                                                                                                            
          orderby = _order;                                                                                                                                                                            
       END IF;                                                                                                                                                                                         
 RAISE NOTICE 'order%',orderby;                                                                                                                                                                        
       totalcount := 0;                                                                                                                                                                                
                                                                                                                                                                                                       
       IF page = 1 THEN                                                                                                                                                                                
                                                                                                                                                                                                       
         SELECT count(*) into totalcount FROM teammember A, teammemberassignment B, userprofile C                                                                                                      
         WHERE A.teammemberid = B.teammemberid AND B.SecurityUsersId = C.SecurityUsersId                                                                                                               
         AND CASE WHEN first_name is null THEN TRUE ELSE C.firstname ILIKE first_name || '%' END                                                                                                       
         AND CASE WHEN last_name is  null THEN  TRUE ELSE C.lastname  ILIKE last_name || '%'  END                                                                                                      
         AND CASE WHEN position_code is null THEN TRUE ELSE A.positioncode LIKE position_code || '%' END                                                                                               
          ORDER BY orderby;                                                                                                                                                                            
                                                                                                                                                                                                       
       END IF;                                                                                                                                                                                         
       RAISE NOTICE '%', 'HELLO';                                                                                                                                                                      
                                                                                                                                                                                                       
      select array_to_json(array_agg(e)) from                                                                                                                                                          
       (SELECT array_to_json(array_agg(row_to_json(d))) as "data",totalcount as "count" from (                                                                                                         
       SELECT A.teammemberid,A.positioncode,A.roletypekey,A.displayname FROM                                                                                                                           
       (SELECT A.teammemberid,A.positioncode,A.roletypekey,C.displayname FROM teammember A, teammemberassignment B, userprofile C                                                                      
         WHERE A.teammemberid = B.teammemberid                                                                                                                                                         
           AND B.SecurityUsersId = C.SecurityUsersId                                                                                                                                                   
                   AND CASE WHEN first_name is null THEN TRUE ELSE C.firstname ILIKE first_name || '%' END                                                                                             
         AND CASE WHEN last_name is null THEN  TRUE ELSE C.lastname  ILIKE last_name || '%'  END                                                                                                       
         AND CASE WHEN position_code is null THEN TRUE ELSE A.positioncode LIKE position_code || '%' END) A                                                                                            
          -- LEFT OUTER JOIN usernotificationgroupdetail D ON A.teammemberid = D.teammemberid                                                                                                          
           --and D.usernotificationgroupid = usrnotificationgroupid                                                                                                                                    
           group by A.teammemberid,A.positioncode,A.roletypekey,A.displayname                                                                                                                          
           --AND CASE WHEN usernotificationgroupid is null THEN usernotificationgroupid = usrnotificationgroupid ELSE TRUE END                                                                         
           ORDER BY orderby                                                                                                                                                                            
           LIMIT size OFFSET  (page - 1) * size)d)e INTO result;                                                                                                                                       
                                                                                                                                                                                                       
                                                                                                                                                                                                       
 RETURN COALESCE(result,'[]');                                                                                                                                                                         
                                                                                                                                                                                                       
 END; $function$                                                                                                                                                                                       

