 CREATE OR REPLACE FUNCTION public.getusersbyrole(roletypekey character varying)                                                                                           
  RETURNS TABLE(userid character varying, teamname character varying, username character varying, agencykey character varying, userrole text, loadnumber character varying)
  LANGUAGE plpgsql                                                                                                                                                         
 AS $function$                                                                                                                                                             
                                                                                                                                                                           
 declare v_roletypekey character varying;                                                                                                                                  
 BEGIN                                                                                                                                                                     
         v_roletypekey:= roletypekey;                                                                                                                                      
                                                                                                                                                                           
     Return Query                                                                                                                                                          
         Select UP.securityusersid as userid, T.teamname, UP.fullname as username, TMRT.teamtypekey as agencykey                                                           
         , replace(TMRT.description, ',' || TMRT.teamtypekey,'') userrole, TM.loadnumber                                                                                   
                                                                                                                                                                           
         From Team T Join TeamMember TM on TM.teamid = T.teamid                                                                                                            
         Join TeamMemberAssignment TMA On TMA.teammemberId  = TM.teammemberid                                                                                              
         Left Join TeamMemberRoleType TMRT On TMRT.roletypekey = TM.roletypekey                                                                                            
         left join TeamType TTY on TTY.teamtypekey = TMRT.teamtypekey                                                                                                      
         Join UserProfile UP On UP.securityusersid = TMA.securityusersid                                                                                                   
         Where TM.roletypekey = v_roletypekey                                                                                                                              
         And T.activeflag = 1 And TM.activeflag = 1 And TMA.activeflag = 1                                                                                                 
     And TMRT.activeflag = 1 And UP.activeflag = 1                                                                                                                         
      order by T.teamname, UP.fullname;                                                                                                                                    
                                                                                                                                                                           
                                                                                                                                                                           
   end;                                                                                                                                                                    
                                                                                                                                                                           
 $function$                                                                                                                                                                

