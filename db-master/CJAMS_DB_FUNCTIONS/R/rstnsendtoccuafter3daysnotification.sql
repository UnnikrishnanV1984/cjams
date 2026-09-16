 CREATE OR REPLACE FUNCTION public.rstnsendtoccuafter3daysnotification()                                                                                                                             
  RETURNS character varying                                                                                                                                                                          
  LANGUAGE plpgsql                                                                                                                                                                                   
 AS $function$                                                                                                                                                                                     
                                                                                                                                                                                                   
 DECLARE                                                                                                                                                                                           
                                                                                                                                                                                                   
 v_intakeserviceid uuid;                                                                                                                                                                           
 v_securityusersid character varying;                                                                                                                                                              
 v_status character varying;                                                                                                                                                                       
 v_status1 character varying;                                                                                                                                                                      
 v_restitution3daysrecord  record;                                                                                                                                                                 
 v_msg character varying;                                                                                                                                                                          
                                                                                                                                                                                                   
 BEGIN                                                                                                                                                                                             
                                                                                                                                                                                                   
  FOR  v_restitution3daysrecord  IN                                                                                                                                                                
                                                                                                                                                                                                   
         select tma.securityusersid as tosecurityusersid,isrr.restitutionno,rccuc.ccunotes                                                                                                         
         from teammemberassignment tma                                                                                                                                                             
         join teammember tm on tm.teammemberid = tma.teammemberid and  tm.activeflag = 1                                                                                                           
         join team t on t.teamid = tm.teamid and t.activeflag = 1                                                                                                                                  
         join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1                                                                                                             
         join rolemapping rm on rm.principalid::int=mu.id and rm.activeflag=1                                                                                                                      
         join role r on r.id = rm.roleid :: int and r.activeflag = 1                                                                                                                               
         join intakeserreqrestitution as isrr on isrr.countyid = t.countyid::uuid and isrr.activeflag = 1 and isrr.status='Active'                                                                 
         join restitutionccuconfig as rccuc  on rccuc.restitutionno = isrr.restitutionno and lower(rccuc.status) = 'open' and rccuc.activeflag=1                                                   
         where R.roletypekey ilike'%JSRTS%' and tma.activeflag = 1 and                                                                                                                             
         isrr.ccuapprovedate::date = now()::date - '3 day'::interval                                                                                                                               
         group by tma.securityusersid,isrr.restitutionno,rccuc.ccunotes                                                                                                                            
                                                                                                                                                                                                   
         LOOP                                                                                                                                                                                      
                                                                                                                                                                                                   
         IF coalesce(v_restitution3daysrecord.ccunotes,'')!= '' THEN                                                                                                                               
                                                                                                                                                                                                   
         -- Case Worker has responded for CCU Notification of Restitution A/C # xxxxxxxxx and added Restitution Notes. Please proceed with approval.                                               
                                                                                                                                                                                                   
         v_msg:=   'Case Worker has responded for CCU Notification of Restitution A/C ('|| v_restitution3daysrecord.restitutionno ||') and added Restitution Notes. Please proceed with approval.';
                                                                                                                                                                                                   
         SELECT send_notification INTO v_status FROM send_notification(v_restitution3daysrecord.tosecurityusersid, 'System'::character varying, v_restitution3daysrecord.tosecurityusersid,        
         'System', 'High', v_msg, v_msg , v_restitution3daysrecord.restitutionno::character varying);                                                                                              
                                                                                                                                                                                                   
         ELSE                                                                                                                                                                                      
                                                                                                                                                                                                   
         -- Case Worker has not responded for CCU Notification of Restitution A/C # xxxxxxxxx. Please proceed with approval.                                                                       
                                                                                                                                                                                                   
         v_msg:=   'Case Worker has not responded for CCU Notification of Restitution A/C ('|| v_restitution3daysrecord.restitutionno ||') Please proceed with approval.';                         
                                                                                                                                                                                                   
         SELECT send_notification INTO v_status1 FROM send_notification(v_restitution3daysrecord.tosecurityusersid, 'System'::character varying, v_restitution3daysrecord.tosecurityusersid,       
         'System', 'High', v_msg, v_msg , v_restitution3daysrecord.restitutionno::character varying);                                                                                              
                                                                                                                                                                                                   
         END IF;                                                                                                                                                                                   
                                                                                                                                                                                                   
     END LOOP;                                                                                                                                                                                     
 RETURN                                                                                                                                                                                            
                                                                                                                                                                                                   
 'Success';                                                                                                                                                                                        
                                                                                                                                                                                                   
 END;                                                                                                                                                                                              
                                                                                                                                                                                                   
                                                                                                                                                                                                   
 $function$                                                                                                                                                                                          

