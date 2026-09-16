 CREATE OR REPLACE FUNCTION public.srunacknowledgedwork_rptcnt()                                                                                                                                    
  RETURNS SETOF bigint                                                                                                                                                                              
  LANGUAGE plpgsql                                                                                                                                                                                  
 AS $function$                                                                                                                                                                                      
 BEGIN                                                                                                                                                                                              
 RETURN QUERY                                                                                                                                                                                       
 select Count(*) as cnt from                                                                                                                                                                        
 (SELECT Distinct ISR.ServiceRequestNumber AS DANumber,                                                                                                                                             
                 ISRT.IntakeServReqTypeKey AS DAType,                                                                                                                                               
                 COALESCE(ISRC.ClassKey,'') AS DASubType,                                                                                                                                           
                 COALESCE(ISR.insertedon,NOW()) AS ReportedDate,                                                                                                                                    
                 T.teamname AS Team,                                                                                                                                                                
                cast(  DATE_PART('day',now()- ISR.insertedon)as int)AS OverDue,                                                                                                                     
               CASE WHEN ( Cast (PA.ZipCode As Int)) > 1 THEN                                                                                                                                       
                 (SELECT C.APSRegion FROM County C                                                                                                                                                  
                         WHERE Cast (PA.ZipCode as int) = C.ZipCode)                                                                                                                                
                 ELSE '0' END AS Region                                                                                                                                                             
 FROM IntakeServiceRequest ISR                                                                                                                                                                      
         JOIN IntakeSerReqStatusType ISRST on (ISR.IntakeSerReqStatusTypeId = ISRST.IntakeSerReqStatusTypeId                                                                                        
                         AND ISRST.IntakeSerReqStatusTypeKey not in ('CLOSED', 'Cancelled'))                                                                                                        
         JOIN IntakeServiceRequestType ISRT on ISR.IntakeServReqTypeId = ISRT.IntakeServReqTypeId                                                                                                   
         JOIN AreaTeamMemberServiceRequest ATMSR on ISR.IntakeServiceId = ATMSR.IntakeServiceId and ATMSR.RoutingStatusTypeKey <> 'Acc' and ATMSR.ActiveFlag = 1                                    
         join ServiceRequestTypeConfig as srtc on (srtc.IntakeServReqTypeId = isrt.IntakeServReqTypeId AND srtc.ActiveFlag = '1' AND srtc.ServiceRequestSubTypeId = ISR.IntakeServiceRequestClassId)
         LEFT JOIN IntakeServiceRequestActor ISRACT on ISR.IntakeServiceId = ISRACT.IntakeServiceId and ISRACT.IntakeServiceRequestPersonTypeKey = 'RA'                                             
         LEFT JOIN Actor A on ISRACT.ActorId = A.ActorId and a.ActiveFlag = 1                                                                                                                       
         LEFT JOIN Person P on A.PersonId = P.PersonId and p.ActiveFlag = 1                                                                                                                         
         LEFT JOIN PersonAddress AS PA on (P.PersonId = PA.PersonId and PA.ActiveFlag = 1 AND PA.PersonAddressId = ISRACT.RoutingAddressId )                                                        
         LEFT JOIN ServiceRequestSubType ISRC on ISR.IntakeServiceRequestClassId = ISRC.ServiceRequestSubTypeId                                                                                     
         LEFT JOIN TeamMember TM on ATMSR.TeamMemberId = TM.TeamMemberId                                                                                                                            
         LEFT JOIN Team T on T.TeamId = TM.TeamId                                                                                                                                                   
         LEFT JOIN TeamMemberAssignment TMA ON TMA.TeamMemberId = ATMSR.TeamMemberId and TMA.ActiveFlag = 1                                                                                         
         LEFT JOIN UserProfileAddress UPA ON TMA.SecurityUsersId = UPA.SecurityUsersId and UPA.ActiveFlag = 1 and UPA.UserProfileAddressTypeKey = 'P'                                               
                                                                                                                                                                                                    
         WHERE ISR.IntakeSerReqStatusTypeId = ISRST.IntakeSerReqStatusTypeId                                                                                                                        
         --GROUP BY DANumber,DAType,DASubType,COALESCE(ISR.insertedon,NOW()),Team,OverDue,C.APSRegion,PA.ZipCode                                                                                    
         ORDER BY ReportedDate desc) as A;                                                                                                                                                          
                                                                                                                                                                                                    
 END;                                                                                                                                                                                               
 $function$                                                                                                                                                                                         

