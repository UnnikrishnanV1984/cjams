 CREATE OR REPLACE FUNCTION public.getintakeda_cnt(p_author integer)                                                                                                    
  RETURNS SETOF bigint                                                                                                                                                  
  LANGUAGE plpgsql                                                                                                                                                      
 AS $function$                                                                                                                                                          
                                                                                                                                                                        
   DECLARE v_Role VARCHAR(50);                                                                                                                                          
   v_Team VARCHAR(50);                                                                                                                                                  
   v_Region VARCHAR(50);                                                                                                                                                
                                                                                                                                                                        
   v_UserSID character varying;                                                                                                                                         
 BEGIN                                                                                                                                                                  
                                                                                                                                                                        
         SELECT securityusersid into v_UserSID FROM muser where id = p_author;                                                                                          
                                                                                                                                                                        
   SELECT UPPER(name) into v_Role                                                                                                                                       
   FROM role r                                                                                                                                                          
        JOIN rolemapping rm ON rm.roleid = r.id                                                                                                                         
   WHERE  rm.principalid::int = p_author; --FIELD                                                                                                                       
                                                                                                                                                                        
   IF (v_Role = 'CRU' OR v_Role = 'FIELD')                                                                                                                              
   THEN                                                                                                                                                                 
   RETURN QUERY EXECUTE                                                                                                                                                 
         'SELECT  COUNT(*) as cnt FROM IntakeDAStaging IDAS WHERE IDAS.InsertedBy = '''|| v_UserSID ||''' AND lower(IDAS.Status) = ''pending'' AND IDAS.Activeflag = 1';
   ELSEIF (v_Role = 'APCS')                                                                                                                                             
   THEN                                                                                                                                                                 
   --APCS                                                                                                                                                               
                                                                                                                                                                        
   SELECT tm.TeamId INTO v_Team                                                                                                                                         
   FROM TeamMemberAssignment TMA                                                                                                                                        
   JOIN TeamMember TM ON TMA.TeamMemberId = TM.TeamMemberId                                                                                                             
   WHERE TMA.SecurityUsersId = v_UserSID                                                                                                                                
         AND TMA.ActiveFlag = 1;                                                                                                                                        
                                                                                                                                                                        
    RETURN QUERY EXECUTE                                                                                                                                                
         'SELECT  COUNT(*) as CNT FROM IntakeDAStaging IDAS                                                                                                             
         JOIN TeamMemberAssignment TMA ON IDAS.InsertedBy = TMA.SecurityUsersId AND TMA.ActiveFlag = 1                                                                  
         JOIN TeamMember TM ON TMA.TeamMemberId = TM.TeamMemberId AND TM.ActiveFlag = 1                                                                                 
         WHERE TM.TeamId = '''|| v_Team ||''' AND lower(IDAS.Status) = ''pending'' AND IDAS.Activeflag = 1';                                                            
                                                                                                                                                                        
   ELSEIF (v_Role = 'Region_Mgr')                                                                                                                                       
   --Region_Mgr                                                                                                                                                         
   THEN                                                                                                                                                                 
                                                                                                                                                                        
   SELECT T.TeamId INTO v_Region                                                                                                                                        
   FROM TeamMemberAssignment TMA                                                                                                                                        
   JOIN TeamMember TM ON TMA.TeamMemberId = TM.TeamMemberId                                                                                                             
   JOIN Team T on TM.TeamId = T.TeamId                                                                                                                                  
   WHERE TMA.SecurityUsersId = v_UserSID                                                                                                                                
         AND TMA.ActiveFlag = 1;                                                                                                                                        
                                                                                                                                                                        
    RETURN QUERY EXECUTE                                                                                                                                                
         'SELECT COUNT(*) AS CNT                                                                                                                                        
         FROM IntakeDAStaging IDAS                                                                                                                                      
         JOIN TeamMemberAssignment TMA ON IDAS.InsertedBy = TMA.SecurityUsersId                                                                                         
                         AND TMA.ActiveFlag = 1                                                                                                                         
                 JOIN TeamMember TM ON TMA.TeamMemberId = TM.TeamMemberId                                                                                               
                         AND TM.ActiveFlag = 1                                                                                                                          
                 JOIN Team T on TM.TeamId = T.TeamId                                                                                                                    
         WHERE (T.ParentTeamId = '''|| v_Region ||''' or t.TeamId = '''|| v_Region ||''')                                                                               
               AND lower(IDAS.Status) = ''pending'' AND IDAS.Activeflag = 1';                                                                                           
   ELSE                                                                                                                                                                 
   --ALL                                                                                                                                                                
   RETURN QUERY EXECUTE                                                                                                                                                 
        'SELECT  COUNT(*) as CNT                                                                                                                                        
         FROM IntakeDAStaging IDAS                                                                                                                                      
         WHERE   lower(IDAS.Status) = ''pending'' AND IDAS.Activeflag = 1';                                                                                             
   END IF;                                                                                                                                                              
                                                                                                                                                                        
 END;                                                                                                                                                                   
 $function$                                                                                                                                                             

