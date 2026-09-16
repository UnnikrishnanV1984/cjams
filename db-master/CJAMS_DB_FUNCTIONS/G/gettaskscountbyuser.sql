 CREATE OR REPLACE FUNCTION public.gettaskscountbyuser(userid character varying)                                                                                                        
  RETURNS TABLE(totalcount bigint, opened bigint, closed bigint, cancelled bigint)                                                                                                      
  LANGUAGE plpgsql                                                                                                                                                                      
 AS $function$                                                                                                                                                                          
                                                                                                                                                                                        
                                                                                                                                                                                        
 BEGIN                                                                                                                                                                                  
                                                                                                                                                                                        
  RETURN QUERY                                                                                                                                                                          
 SELECT count(*) as TotalCount                                                                                                                                                          
      ,COUNT(CASE WHEN atst.typedescription != 'Closed' AND atst.typedescription != 'Cancelled' THEN 1 END) as OpenTask                                                                 
         ,COUNT(CASE WHEN atst.typedescription = 'Closed' THEN 1 END) as ClosedTask                                                                                                     
         ,COUNT(CASE WHEN atst.typedescription = 'Cancelled' THEN 1 END) as CancelledTask                                                                                               
 FROM intakeservicerequest AS ISR                                                                                                                                                       
 INNER JOIN AreaTeamMemberServiceRequest  AS ATSR  ON  ATSR.IntakeServiceId   = ISR.IntakeServiceId AND   ATSR.ActiveFlag = 1                                                           
 INNER JOIN TeamMember AS TM  ON  ATSR.TeamMemberId   = TM.TeamMemberId                                                                                                                 
 INNER JOIN TeamMemberAssignment   AS TMA  ON  TMA.TeamMemberId   = ATSR.TeamMemberId     AND TMA.ActiveFlag = 1                                                                        
 --INNER JOIN muser muser ON muser.securityusersid=TMA.securityusersid and muser.activeflag=1                                                                                           
 INNER JOIN Investigation invst ON ISR.intakeserviceid=invst.intakeserviceid and invst.activeflag=1                                                                                     
 INNER JOIN Activity act on invst.investigationid = act.objectid and act.activeflag=1                                                                                                   
 INNER JOIN Activitytask acttask on act.activityid = acttask.activityid  and acttask.activeflag = 1 and act.activeflag = 1                                                              
 inner join activitytaskstatustype atst on acttask.activitytaskstatustypekey = atst.activitytaskstatustypekey                                                                           
 and atst.activeflag=1 and acttask.activeflag=1                                                                                                                                         
 --and muser.id=userid;                                                                                                                                                                 
 and TMA.securityusersid = userid;                                                                                                                                                      
                                                                                                                                                                                        
   END;                                                                                                                                                                                 
                                                                                                                                                                                        
 $function$                                                                                                                                                                             

