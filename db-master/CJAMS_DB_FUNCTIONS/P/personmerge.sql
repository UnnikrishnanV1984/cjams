 CREATE OR REPLACE FUNCTION public.personmerge(p_primarypersonid_inp character, p_secondarypersonid_inp character, p_userid_inp character varying)                    
  RETURNS void                                                                                                                                                        
  LANGUAGE plpgsql                                                                                                                                                    
 AS $function$                                                                                                                                                        
                                                                                                                                                                      
                                                                                                                                                                      
   DECLARE                                                                                                                                                            
         p_primaryPersonId UUID ;                                                                                                                                     
         p_secondaryPersonId UUID;                                                                                                                                    
         p_UserId UUID ;                                                                                                                                              
                                                                                                                                                                      
                                                                                                                                                                      
 BEGIN                                                                                                                                                                
  /* SET QUOTED_IDENTIFIER ON */                                                                                                                                      
                                                                                                                                                                      
 p_primaryPersonId = p_primaryPersonId_inp;                                                                                                                           
 p_secondaryPersonId = p_secondaryPersonId_inp;                                                                                                                       
 p_UserId = p_UserId_inp;                                                                                                                                             
                                                                                                                                                                      
 /* CREATE TEMP TABLE  ActorMatch                                                                                                                                     
   (                                                                                                                                                                  
 PrimaryActorId CHAR(36)                                                                                                                                              
   , SecondaryActorId CHAR(36)                                                                                                                                        
   ) ;                                                                                                                                                                
        */                                                                                                                                                            
                                                                                                                                                                      
 CREATE TEMP TABLE  ActorMatch                                                                                                                                        
 (                                                                                                                                                                    
         PrimaryActorId UUID                                                                                                                                          
   , SecondaryActorId UUID                                                                                                                                            
 );                                                                                                                                                                   
                                                                                                                                                                      
                                                                                                                                                                      
                                                                                                                                                                      
                                                                                                                                                                      
   BEGIN                                                                                                                                                              
    IF (p_primaryPersonId IS NULL OR p_secondaryPersonId IS NULL)                                                                                                     
   THEN                                                                                                                                                               
    RAISE EXCEPTION 'Invalid Person Merge ,16,1';                                                                                                                     
   END IF;                                                                                                                                                            
                                                                                                                                                                      
   ----------------------------------------------------                                                                                                               
   -- objects([PersonId]) moved to Primary but marked as inactive                                                                                                     
   -- PersonDetail                                                                                                                                                    
   -- PersonAddress                                                                                                                                                   
   -- PersonIdentifier                                                                                                                                                
   -- PersonPhoneNumber                                                                                                                                               
   ----------------------------------------------------                                                                                                               
   UPDATE PersonDetail                                                                                                                                                
      SET PersonId = p_primaryPersonId                                                                                                                                
     , ExpirationDate = COALESCE(ExpirationDate, NOW())                                                                                                               
     ,updatedby = p_UserId,                                                                                                                                           
     updatedon = NOW()                                                                                                                                                
     --FROM PersonDetail                                                                                                                                              
    WHERE PersonDetail.PersonId = p_secondaryPersonId;                                                                                                                
                                                                                                                                                                      
                                                                                                                                                                      
  -- Mark any duplicates as expired                                                                                                                                   
  -- MIGRATION COMMENT                                                                                                                                                
 /* WITH cte AS ( SELECT  *   FROM   PersonAddress P )                                                                                                                
 UPDATE PersonAddress P                                                                                                                                               
  SET  PersonId = p_primaryPersonId                                                                                                                                   
     ,ExpirationDate = COALESCE(P.ExpirationDate, NOW())                                                                                                              
      ,updatedby = p_UserId,                                                                                                                                          
     updatedon = NOW()                                                                                                                                                
 FROM   cte PA1                                                                                                                                                       
 JOIN   cte PA2 ON PA2.PersonId = p_primaryPersonId                                                                                                                   
 AND PA2.PersonAddressTypeKey = PA1.PersonAddressTypeKey                                                                                                              
 WHERE PA1.PersonId = p_secondaryPersonId;                                                                                                                            
                                                                                                                                                                      
     */                                                                                                                                                               
                                                                                                                                                                      
   UPDATE PersonAddress                                                                                                                                               
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     --FROM PersonAddress                                                                                                                                             
    WHERE PersonId = p_secondaryPersonId;                                                                                                                             
                                                                                                                                                                      
   -- Mark any duplicates as expired                                                                                                                                  
    -- MIGRATION COMMENT                                                                                                                                              
 /*   UPDATE PI1                                                                                                                                                      
      SET PI1.PersonId = p_primaryPersonId                                                                                                                            
     , PI1.ExpirationDate = COALESCE(PI1.ExpirationDate, NOW())                                                                                                       
      ,updatedby = p_UserId,                                                                                                                                          
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM PersonIdentifier AS PI1                                                                                                                                     
     JOIN PersonIdentifier AS PI2 ON PI2.PersonId = p_primaryPersonId                                                                                                 
            AND PI2.PersonIdentifierTypeKey = PI1.PersonIdentifierTypeKey                                                                                             
    WHERE PI1.PersonId = p_secondaryPersonId;                                                                                                                         
    */                                                                                                                                                                
                                                                                                                                                                      
   UPDATE PersonIdentifier                                                                                                                                            
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
    -- FROM PersonIdentifier                                                                                                                                          
    WHERE PersonIdentifier.PersonId = p_secondaryPersonId;                                                                                                            
                                                                                                                                                                      
   -- Mark any duplicates as expired                                                                                                                                  
    -- MIGRATION COMMENT                                                                                                                                              
 /*   UPDATE PN1                                                                                                                                                      
      SET PN1.PersonId = p_primaryPersonId                                                                                                                            
     , PN1.ExpirationDate = COALESCE(PN1.ExpirationDate, NOW())                                                                                                       
      ,updatedby = p_UserId,                                                                                                                                          
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM PersonPhoneNumber AS PN1                                                                                                                                    
     JOIN PersonPhoneNumber AS PN2 ON PN2.PersonId = p_primaryPersonId                                                                                                
             AND PN2.PersonPhoneTypeKey = PN1.PersonPhoneTypeKey                                                                                                      
    WHERE PN1.PersonId = p_secondaryPersonId;                                                                                                                         
    */                                                                                                                                                                
   UPDATE PersonPhoneNumber                                                                                                                                           
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
    -- FROM PersonPhoneNumber                                                                                                                                         
    WHERE PersonPhoneNumber.PersonId = p_secondaryPersonId;                                                                                                           
                                                                                                                                                                      
   ----------------------------------------------------                                                                                                               
   -- objects([PersonId]) moved to Primary and remain in current state                                                                                                
   -- Alias                                                                                                                                                           
   -- Assessment                                                                                                                                                      
   -- IntakeServiceRequestPerson                                                                                                                                      
   -- CareGiver                                                                                                                                                       
   -- PersonEDLConfirmation                                                                                                                                           
   -- PersonEDLIncidents                                                                                                                                              
   -- ProviderEmployee                                                                                                                                                
   -- PersonFCSR                                                                                                                                                      
   -- PersonGCW                                                                                                                                                       
   -- PersonParticipationCode                                                                                                                                         
   -- PersonRaceTypeMap                                                                                                                                               
   -- ProfessionalRegistrationSearchDetail                                                                                                                            
   -- ProfessionalRegistrationSearchResult                                                                                                                            
   -- FederalExclusionSearchDetail                                                                                                                                    
   ----------------------------------------------------                                                                                                               
   UPDATE Alias                                                                                                                                                       
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     --FROM Alias                                                                                                                                                     
    WHERE Alias.PersonId = p_secondaryPersonId;                                                                                                                       
                                                                                                                                                                      
   UPDATE Assessment                                                                                                                                                  
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
    -- FROM Assessment                                                                                                                                                
    WHERE Assessment.PersonId = p_secondaryPersonId;                                                                                                                  
                                                                                                                                                                      
   UPDATE IntakeServiceRequestPerson                                                                                                                                  
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     --FROM IntakeServiceRequestPerson                                                                                                                                
    WHERE IntakeServiceRequestPerson.PersonId = p_secondaryPersonId;                                                                                                  
                                                                                                                                                                      
   UPDATE CareGiver                                                                                                                                                   
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     --FROM CareGiver                                                                                                                                                 
    WHERE CareGiver.PersonId = p_secondaryPersonId;                                                                                                                   
                                                                                                                                                                      
   UPDATE PersonEDLConfirmation                                                                                                                                       
      SET PersonId = p_primaryPersonId                                                                                                                                
                                                                                                                                                                      
     --FROM PersonEDLConfirmation                                                                                                                                     
    WHERE PersonEDLConfirmation.PersonId = p_secondaryPersonId;                                                                                                       
                                                                                                                                                                      
   UPDATE PersonEDLIncidents                                                                                                                                          
      SET PersonId = p_primaryPersonId                                                                                                                                
     --FROM PersonEDLIncidents                                                                                                                                        
    WHERE PersonEDLIncidents.PersonId = p_secondaryPersonId;                                                                                                          
                                                                                                                                                                      
   UPDATE ProviderEmployee                                                                                                                                            
      SET PersonId = p_primaryPersonId                                                                                                                                
    -- FROM ProviderEmployee                                                                                                                                          
    WHERE ProviderEmployee.PersonId = p_secondaryPersonId;                                                                                                            
                                                                                                                                                                      
   UPDATE PersonFCSR                                                                                                                                                  
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     -- FROM PersonFCSR                                                                                                                                               
    WHERE PersonFCSR.PersonId = p_secondaryPersonId;                                                                                                                  
                                                                                                                                                                      
   UPDATE PersonGCW                                                                                                                                                   
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
      --FROM PersonGCW                                                                                                                                                
    WHERE PersonGCW.PersonId = p_secondaryPersonId;                                                                                                                   
                                                                                                                                                                      
   UPDATE PersonParticipationCode                                                                                                                                     
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
      --FROM PersonParticipationCode                                                                                                                                  
    WHERE PersonParticipationCode.PersonId = p_secondaryPersonId;                                                                                                     
                                                                                                                                                                      
   UPDATE PersonRaceTypeMap                                                                                                                                           
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
      --FROM PersonRaceTypeMap                                                                                                                                        
    WHERE PersonRaceTypeMap.PersonId = p_secondaryPersonId;                                                                                                           
                                                                                                                                                                      
   UPDATE ProfessionalRegistrationSearchDetail                                                                                                                        
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
      --FROM ProfessionalRegistrationSearchDetail                                                                                                                     
    WHERE ProfessionalRegistrationSearchDetail.PersonId = p_secondaryPersonId;                                                                                        
                                                                                                                                                                      
   UPDATE ProfessionalRegistrationSearchResult                                                                                                                        
      SET PersonId = p_primaryPersonId                                                                                                                                
      --FROM ProfessionalRegistrationSearchResult                                                                                                                     
    WHERE ProfessionalRegistrationSearchResult.PersonId = p_secondaryPersonId;                                                                                        
                                                                                                                                                                      
   UPDATE FederalExclusionSearchDetail                                                                                                                                
      SET PersonId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
      --FROM FederalExclusionSearchDetail                                                                                                                             
    WHERE FederalExclusionSearchDetail.PersonId = p_secondaryPersonId;                                                                                                
                                                                                                                                                                      
   ----------------------------------------------------                                                                                                               
   -- objects([Actorid]) moved to Primary and remain in current state                                                                                                 
   -- IntakeServiceRequestActor [Actorid]                                                                                                                             
   -- ActorLivesWith [ActorId]                                                                                                                                        
   -- ActorRelationship [ActorId]                                                                                                                                     
   -- ActorSexOffenderRegistry [ActorId]                                                                                                                              
   -- ActorEDLConfirmation [ActorId]                                                                                                                                  
   -- ActorEDLIncidents [ActorId]                                                                                                                                     
   -- ProviderReviewClients [ActorId]                                                                                                                                 
   -- ActorCarePlanInfo [ActorId]                                                                                                                                     
   ----------------------------------------------------                                                                                                               
   INSERT INTO ActorMatch                                                                                                                                             
   SELECT PrimaryActor.ActorId , SecondaryActor.ActorId                                                                                                               
     FROM Actor AS PrimaryActor                                                                                                                                       
     JOIN Actor AS SecondaryActor ON PrimaryActor.ActorType = SecondaryActor.ActorType                                                                                
             AND SecondaryActor.PersonId = p_secondaryPersonId                                                                                                        
    WHERE PrimaryActor.PersonId  = p_primaryPersonId;                                                                                                                 
                                                                                                                                                                      
   UPDATE IntakeServiceRequestActor                                                                                                                                   
      SET ActorId = AC.PrimaryActorId                                                                                                                                 
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM IntakeServiceRequestActor AS INSRC                                                                                                                          
     JOIN ActorMatch AC ON INSRC.ActorId = AC.SecondaryActorId;                                                                                                       
   --  WHERE IntakeServiceRequestActor.ActorId = @secondaryActorId                                                                                                    
                                                                                                                                                                      
   UPDATE ActorLivesWith                                                                                                                                              
      SET ActorId = AC.PrimaryActorId                                                                                                                                 
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM ActorLivesWith AS ALW                                                                                                                                       
     JOIN ActorMatch AS AC ON ALW.ActorId = AC.SecondaryActorId;                                                                                                      
   -- WHERE ActorLivesWith.ActorId = @secondaryActorId                                                                                                                
                                                                                                                                                                      
   UPDATE ActorSexOffenderRegistry                                                                                                                                    
      SET ActorId = AC.PrimaryActorId                                                                                                                                 
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM ActorSexOffenderRegistry AS ASOR                                                                                                                            
     JOIN ActorMatch AC ON ASOR.ActorId = AC.SecondaryActorId;                                                                                                        
   --    WHERE ActorSexOffenderRegistry.ActorId = @secondaryActorId                                                                                                   
                                                                                                                                                                      
   UPDATE ActorEDLConfirmation                                                                                                                                        
      SET ActorId = AC.PrimaryActorId                                                                                                                                 
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM ActorEDLConfirmation AS AEDLC                                                                                                                               
     JOIN ActorMatch AS AC ON AEDLC.ActorId = AC.SecondaryActorId;                                                                                                    
   --  WHERE ActorEDLConfirmation.ActorId = @secondaryActorId                                                                                                         
                                                                                                                                                                      
   UPDATE ActorEDLIncidents                                                                                                                                           
      SET ActorId = AC.PrimaryActorId                                                                                                                                 
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM ActorEDLIncidents AS AEDLI                                                                                                                                  
     JOIN ActorMatch AS AC ON AEDLI.ActorId = AC.SecondaryActorId;                                                                                                    
   --    WHERE ActorEDLIncidents.ActorId = @secondaryActorId                                                                                                          
                                                                                                                                                                      
   UPDATE ProviderReviewClients                                                                                                                                       
      SET ActorId = AC.PrimaryActorId                                                                                                                                 
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM ProviderReviewClients AS PRC                                                                                                                                
     JOIN ActorMatch AS  AC ON PRC.ActorId = AC.SecondaryActorId;                                                                                                     
   --    WHERE ProviderReviewClients.ActorId = @secondaryActorId                                                                                                      
                                                                                                                                                                      
   UPDATE ActorCarePlanInfo                                                                                                                                           
      SET ActorId = AC.PrimaryActorId                                                                                                                                 
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM ActorCarePlanInfo AS ACPI                                                                                                                                   
     JOIN ActorMatch AS  AC ON ACPI.ActorId = AC.SecondaryActorId;                                                                                                    
   --    WHERE ActorCarePlanInfo.ActorId = @secondaryActorId                                                                                                          
                                                                                                                                                                      
   --------------------------------------------------------------------                                                                                               
   -- objects([Objectid]) moved to Primary and remain in current state                                                                                                
   -- DocumentProperties                                                                                                                                              
   -- AssessmentAssignment                                                                                                                                            
   --------------------------------------------------------------------                                                                                               
   UPDATE DocumentProperties                                                                                                                                          
      SET ObjectId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     --FROM DocumentProperties                                                                                                                                        
    WHERE DocumentProperties.ObjectTypeKey = 'Person'                                                                                                                 
      AND DocumentProperties.ObjectId = p_secondaryPersonId;                                                                                                          
                                                                                                                                                                      
   UPDATE AssessmentAssignment                                                                                                                                        
      SET ObjectId = p_primaryPersonId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     --FROM AssessmentAssignment                                                                                                                                      
    WHERE AssessmentAssignment.ObjectTypeKey = 'Person'                                                                                                               
      AND AssessmentAssignment.ObjectId = p_secondaryPersonId;                                                                                                        
                                                                                                                                                                      
   UPDATE DocumentProperties                                                                                                                                          
      SET ObjectId = AC.PrimaryActorId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM DocumentProperties AS DP                                                                                                                                    
     JOIN ActorMatch AS  AC ON DP.ObjectId = AC.SecondaryActorId                                                                                                      
    WHERE DP.ObjectTypeKey = 'Actor';                                                                                                                                 
   --  AND DocumentProperties.ObjectId = @secondaryActorId                                                                                                            
                                                                                                                                                                      
   UPDATE AssessmentAssignment                                                                                                                                        
      SET ObjectId = AC.PrimaryActorId                                                                                                                                
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM AssessmentAssignment AS ASSES                                                                                                                               
     JOIN ActorMatch AS  AC ON ASSES.ObjectId = AC.SecondaryActorId                                                                                                   
    WHERE ASSES.ObjectTypeKey = 'Actor';                                                                                                                              
   --AND AssessmentAssignment.ObjectId = @secondaryActorId                                                                                                            
                                                                                                                                                                      
   -----------------------------------------------------                                                                                                              
   -- Objects([EntityType]) moved to Primary and remain in current state                                                                                              
   -- ToDo_CC                                                                                                                                                         
   -- Allegation                                                                                                                                                      
   -- IntakeServiceRequestClearingData                                                                                                                                
   -- ProgressNote                                                                                                                                                    
   -----------------------------------------------------                                                                                                              
   UPDATE ToDo_CC                                                                                                                                                     
      SET EntityTypeId = p_primaryPersonId                                                                                                                            
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     --FROM ToDo_CC                                                                                                                                                   
    WHERE ToDo_CC.EntityType = 'Person'                                                                                                                               
   AND ToDo_CC.EntityTypeId  = p_secondaryPersonId :: VARCHAR;                                                                                                        
                                                                                                                                                                      
   --UPDATE Allegation                                                                                                                                                
   --   SET EntityTypeId = @primaryPersonId                                                                                                                           
   --  FROM Allegation                                                                                                                                                
   -- WHERE Allegation.EntityType = 'Person'                                                                                                                          
   --AND Allegation.EntityTypeId  = @secondaryPersonId                                                                                                                
                                                                                                                                                                      
   UPDATE IntakeServiceRequestClearingData                                                                                                                            
      SET EntityTypeId = p_primaryPersonId                                                                                                                            
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
    -- FROM IntakeServiceRequestClearingData                                                                                                                          
    WHERE IntakeServiceRequestClearingData.EntityType = 'Person'                                                                                                      
      AND IntakeServiceRequestClearingData.EntityTypeId  = p_secondaryPersonId :: VARCHAR;                                                                            
                                                                                                                                                                      
   UPDATE ProgressNote                                                                                                                                                
      SET EntityTypeId = p_primaryPersonId                                                                                                                            
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
    -- FROM ProgressNote                                                                                                                                              
    WHERE ProgressNote.EntityType = 'Person'                                                                                                                          
      AND ProgressNote.EntityTypeId  = p_secondaryPersonId :: VARCHAR;                                                                                                
                                                                                                                                                                      
                                                                                                                                                                      
                                                                                                                                                                      
 UPDATE ToDo_CC                                                                                                                                                       
      SET EntityTypeId = AC.PrimaryActorId                                                                                                                            
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM ToDo_CC AS TC                                                                                                                                               
     JOIN ActorMatch AS AC ON TC.EntityTypeId = AC.SecondaryActorId :: VARCHAR                                                                                        
    WHERE TC.EntityType = 'Actor' ;                                                                                                                                   
                                                                                                                                                                      
   --AND ToDo_CC.EntityTypeId  = @secondaryActorId                                                                                                                    
                                                                                                                                                                      
   --UPDATE Allegation                                                                                                                                                
   --   SET EntityTypeId = @primaryActorId                                                                                                                            
   --  FROM Allegation                                                                                                                                                
   -- WHERE Allegation.EntityType = 'Actor'                                                                                                                           
   --AND Allegation.EntityTypeId  = @secondaryActorId                                                                                                                 
                                                                                                                                                                      
   UPDATE IntakeServiceRequestClearingData                                                                                                                            
      SET EntityTypeId = AC.PrimaryActorId                                                                                                                            
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM  IntakeServiceRequestClearingData AS INSRC                                                                                                                  
     JOIN ActorMatch AS AC ON INSRC.EntityTypeId = AC.SecondaryActorId :: VARCHAR                                                                                     
    WHERE INSRC.EntityType = 'Actor';                                                                                                                                 
   -- AND IntakeServiceRequestClearingData.EntityTypeId  = @secondaryActorId                                                                                          
                                                                                                                                                                      
   UPDATE ProgressNote                                                                                                                                                
      SET EntityTypeId = AC.PrimaryActorId                                                                                                                            
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM ProgressNote AS PN                                                                                                                                          
     JOIN ActorMatch AS AC ON PN.EntityTypeId = AC.SecondaryActorId :: VARCHAR                                                                                        
    WHERE PN.EntityType = 'Actor';                                                                                                                                    
   --AND ProgressNote.EntityTypeId  = @secondaryActorId                                                                                                               
                                                                                                                                                                      
 -- MIGRATION COMMENT                                                                                                                                                 
                                                                                                                                                                      
  /* UPDATE PrimaryPerson                                                                                                                                             
      SET principalIdent = COALESCE( NULLIF( RTRIM( PrimaryPerson.principalIdent ), '' ), NULLIF( RTRIM( SecondaryPerson.principalIdent ), '' ) )                     
     , salutation = COALESCE( NULLIF( RTRIM( PrimaryPerson.salutation ), '' ), NULLIF( RTRIM( SecondaryPerson.salutation), '' )  )                                    
     , DangerLevel = COALESCE( NULLIF( PrimaryPerson.DangerLevel, 0 ), NULLIF( SecondaryPerson.DangerLevel, 0 ) )                                                     
     , DangerReason = COALESCE( NULLIF( RTRIM( PrimaryPerson.DangerReason ), '' ), NULLIF( RTRIM( SecondaryPerson.DangerReason ), '' ) )                              
     , DOB = COALESCE( PrimaryPerson.DOB, SecondaryPerson.DOB )                                                                                                       
     , ReligionTypeKey = COALESCE( PrimaryPerson.ReligionTypeKey, SecondaryPerson.ReligionTypeKey )                                                                   
     , MaritalStatusTypeKey = COALESCE( PrimaryPerson.MaritalStatusTypeKey, SecondaryPerson.MaritalStatusTypeKey )                                                    
     , GenderTypeKey = COALESCE( PrimaryPerson.GenderTypeKey, SecondaryPerson.GenderTypeKey )                                                                         
     , RaceTypeKey = COALESCE( PrimaryPerson.RaceTypeKey , SecondaryPerson.RaceTypeKey )                                                                              
     , DeceasedDate = COALESCE( PrimaryPerson.DeceasedDate, SecondaryPerson.DeceasedDate )                                                                            
     , EthnicGroupTypeKey = COALESCE( PrimaryPerson.EthnicGroupTypeKey, SecondaryPerson.EthnicGroupTypeKey )                                                          
     , IncomeTypeKey = COALESCE( PrimaryPerson.IncomeTypeKey, SecondaryPerson.IncomeTypeKey )                                                                         
      ,updatedby = p_UserId,                                                                                                                                          
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM Person AS PrimaryPerson                                                                                                                                     
     JOIN ( SELECT p_primaryPersonId AS PrimaryPersonId                                                                                                               
        , principalIdent                                                                                                                                              
        , salutation                                                                                                                                                  
        , DangerLevel                                                                                                                                                 
        , DangerReason                                                                                                                                                
        , DOB                                                                                                                                                         
        , ReligionTypeKey                                                                                                                                             
        , MaritalStatusTypeKey                                                                                                                                        
        , GenderTypeKey                                                                                                                                               
        , RaceTypeKey                                                                                                                                                 
        , DeceasedDate                                                                                                                                                
        , EthnicGroupTypeKey                                                                                                                                          
        , IncomeTypeKey                                                                                                                                               
        FROM Person                                                                                                                                                   
       WHERE Person.PersonId = p_secondaryPersonId                                                                                                                    
       ) AS SecondaryPerson ON SecondaryPerson.PrimaryPersonId = PrimaryPerson.PersonId                                                                               
    WHERE PrimaryPerson.PersonId = p_primaryPersonId;    */                                                                                                           
                                                                                                                                                                      
                                                                                                                                                                      
 -- MORE CONFUSION HERE . CHECK WITH MANIVANNAN                                                                                                                       
                                                                                                                                                                      
 WITH SecondaryPerson AS                                                                                                                                              
    ( SELECT p_primaryPersonId AS PrimaryPersonId                                                                                                                     
        , principalIdent                                                                                                                                              
        , salutation                                                                                                                                                  
        , DangerLevel                                                                                                                                                 
        , DangerReason                                                                                                                                                
        , DOB                                                                                                                                                         
        , ReligionTypeKey                                                                                                                                             
        , MaritalStatusTypeKey                                                                                                                                        
        , GenderTypeKey                                                                                                                                               
        , RaceTypeKey                                                                                                                                                 
        , DeceasedDate                                                                                                                                                
        , EthnicGroupTypeKey                                                                                                                                          
        , IncomeTypeKey                                                                                                                                               
        FROM Person                                                                                                                                                   
       WHERE PersonId = p_secondaryPersonId                                                                                                                           
    )                                                                                                                                                                 
    UPDATE Person                                                                                                                                                     
          SET principalIdent = COALESCE( NULLIF( RTRIM( principalIdent ), '' ),principalIdent )                                                                       
     , salutation = COALESCE( NULLIF( RTRIM( salutation ), '' ),salutation)                                                                                           
     , DangerLevel = COALESCE( NULLIF( DangerLevel, 0 ),DangerLevel)                                                                                                  
     , DangerReason = COALESCE( NULLIF( RTRIM( DangerReason ), '' ),DangerReason)                                                                                     
     , DOB = COALESCE( DOB, DOB )                                                                                                                                     
     , ReligionTypeKey = COALESCE( ReligionTypeKey, ReligionTypeKey )                                                                                                 
     , MaritalStatusTypeKey = COALESCE( MaritalStatusTypeKey, MaritalStatusTypeKey )                                                                                  
     , GenderTypeKey = COALESCE( GenderTypeKey, GenderTypeKey )                                                                                                       
     , RaceTypeKey = COALESCE( RaceTypeKey , RaceTypeKey )                                                                                                            
     , DeceasedDate = COALESCE( DeceasedDate, DeceasedDate )                                                                                                          
     , EthnicGroupTypeKey = COALESCE( EthnicGroupTypeKey, EthnicGroupTypeKey )                                                                                        
     , IncomeTypeKey = COALESCE( IncomeTypeKey, IncomeTypeKey )                                                                                                       
     , updatedby = p_UserId                                                                                                                                           
         , updatedon = NOW()                                                                                                                                          
     FROM SecondaryPerson                                                                                                                                             
         WHERE  PersonId = p_primaryPersonId;                                                                                                                         
                                                                                                                                                                      
                                                                                                                                                                      
                                                                                                                                                                      
                                                                                                                                                                      
   --UPDATE PrimaryActor                                                                                                                                              
   --      SET DangerLevel    = COALESCE( NULLIF( PrimaryActor.DangerLevel, 0 ), NULLIF( SecondaryActor.DangerLevel, 0 ) )                                            
   --  , DangerReason    = COALESCE( NULLIF( RTRIM( PrimaryActor.DangerReason ), '' ), NULLIF( RTRIM( SecondaryActor.DangerReason ), '' ) )                           
   --  , PrimaryLanguageId  = COALESCE( PrimaryActor.PrimaryLanguageId, SecondaryActor.PrimaryLanguageId )                                                            
   --  , SecondaryLanguageId  = COALESCE( PrimaryActor.SecondaryLanguageId, SecondaryActor.SecondaryLanguageId )                                                      
   --  , EmployeeTypeID   = COALESCE( PrimaryActor.EmployeeTypeID, SecondaryActor.EmployeeTypeID )                                                                    
   --  , EmployeeTypeName   = COALESCE( NULLIF( RTRIM( PrimaryActor.EmployeeTypeName ), '' ), NULLIF( RTRIM( SecondaryActor.EmployeeTypeName ), '' ) )                
   --  , MedicaidEligibility  = COALESCE( NULLIF( PrimaryActor.MedicaidEligibility, 0 ), NULLIF( SecondaryActor.MedicaidEligibility, 0 ) )                            
   --  , BlockGrantEligibility = COALESCE( NULLIF( PrimaryActor.BlockGrantEligibility, 0 ), NULLIF( SecondaryActor.BlockGrantEligibility, 0 ) )                       
   --  , RecipientStatus   = COALESCE( NULLIF( PrimaryActor.RecipientStatus, 0 ), NULLIF( SecondaryActor.RecipientStatus, 0 ) )                                       
   --  , LivingArrangementTypeKey = COALESCE( PrimaryActor.LivingArrangementTypeKey, SecondaryActor.LivingArrangementTypeKey )                                        
   --  , InterpreterRequired  = COALESCE( NULLIF( PrimaryActor.InterpreterRequired , 0 ), NULLIF( SecondaryActor.InterpreterRequired, 0 ) )                           
   --  , GuardianName    = COALESCE( ISNULL( RTRIM( PrimaryActor.GuardianName ), '' ) , NULLIF( RTRIM( SecondaryActor.GuardianName ), '' ) )                          
   --  , GuardianInfo    = COALESCE( NULLIF( RTRIM( PrimaryActor.GuardianInfo ), '' ), NULLIF( RTRIM( SecondaryActor.GuardianInfo ), '' ) )                           
   --  , RAMentalHealth   = COALESCE( NULLIF( PrimaryActor.RAMentalHealth, 0 ), NULLIF( SecondaryActor.RAMentalHealth, 0 ) )                                          
   --  , RAMentalRetarted   = COALESCE( NULLIF( PrimaryActor.RAMentalRetarted, 0 ), NULLIF( SecondaryActor.RAMentalRetarted, 0 ) )                                    
   --  , RAMentalRetartedType  = COALESCE( NULLIF( RTRIM( PrimaryActor.RAMentalRetartedType ), '' ) , NULLIF( RTRIM( SecondaryActor.RAMentalRetartedType ), '' ) )    
   --    FROM Actor AS PrimaryActor                                                                                                                                   
   --       JOIN @ActorMatch AC ON AC.PrimaryActorId  = PrimaryActor.ActorId                                                                                          
   --       JOIN Actor AS SecondaryActor ON SecondaryActor.ActorId = AC.SecondaryActorId                                                                              
   --   WHERE                                                                                                                                                         
   --    JOIN ( SELECT @primaryActorId AS PrimaryActorid                                                                                                              
   --     , DangerLevel                                                                                                                                               
   --     , DangerReason                                                                                                                                              
   --     , PrimaryLanguageId                                                                                                                                         
   --     , SecondaryLanguageId                                                                                                                                       
   --     , EmployeeTypeID                                                                                                                                            
   --     , EmployeeTypeName                                                                                                                                          
   --     , MedicaidEligibility                                                                                                                                       
   --     , BlockGrantEligibility                                                                                                                                     
   --     , RecipientStatus                                                                                                                                           
   --     , LivingArrangementTypeKey                                                                                                                                  
   --     , InterpreterRequired                                                                                                                                       
   --     , GuardianName                                                                                                                                              
   --     , GuardianInfo                                                                                                                                              
   --     , RAMentalHealth                                                                                                                                            
   --     , RAMentalRetarted                                                                                                                                          
   --     , RAMentalRetartedType                                                                                                                                      
   --     , ActorType                                                                                                                                                 
   --       FROM Actor                                                                                                                                                
   --     WHERE Actor.ActorId = @secondaryActorId                                                                                                                     
   --    ) AS SecondaryActor                                                                                                                                          
   --    ON SecondaryActor.PrimaryActorid = PrimaryActor.ActorId                                                                                                      
   --  WHERE PrimaryActor.ActorId = @primaryActorId   AND PrimaryActor.ActorType  = SecondaryActor.ActorType                                                          
                                                                                                                                                                      
   UPDATE Actor                                                                                                                                                       
      SET  PersonId = p_primaryPersonId                                                                                                                               
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM Actor AC                                                                                                                                                    
     JOIN ActorMatch ACM ON AC.ActorId <> ACM.SecondaryActorId                                                                                                        
    WHERE AC.PersonId = p_secondaryPersonId;                                                                                                                          
                                                                                                                                                                      
   ------------------------------------------------                                                                                                                   
   --       SET Person and ActorId to inactive                                                                                                                        
   -------------------------------------------------                                                                                                                  
   UPDATE Person                                                                                                                                                      
      SET ExpirationDate = NOW()                                                                                                                                      
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
    -- FROM Person                                                                                                                                                    
    WHERE Person.PersonId = p_secondaryPersonId;                                                                                                                      
                                                                                                                                                                      
   UPDATE Actor                                                                                                                                                       
      SET ExpirationDate = NOW()                                                                                                                                      
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM Actor AS AC                                                                                                                                                 
     JOIN ActorMatch AS ACM ON AC.ActorId = ACM.SecondaryActorId;                                                                                                     
   -- WHERE Actor.ActorId = @secondaryActorId                                                                                                                         
                                                                                                                                                                      
     UPDATE Actor                                                                                                                                                     
      SET  PersonId = p_primaryPersonId                                                                                                                               
       ,updatedby = p_UserId,                                                                                                                                         
     updatedon = NOW()                                                                                                                                                
                                                                                                                                                                      
     FROM Actor AS AC                                                                                                                                                 
     LEFT JOIN ActorMatch AS ACM ON AC.ActorId = ACM.SecondaryActorId                                                                                                 
     WHERE AC.PersonId = p_secondaryPersonId AND ACM.SecondaryActorId IS NULL;                                                                                        
   -- WHERE Actor.ActorId = @secondaryActorId                                                                                                                         
                                                                                                                                                                      
    INSERT INTO PersonMergeLog                                                                                                                                        
    (                                                                                                                                                                 
    PrimaryPersonId,                                                                                                                                                  
         SecondaryPersonId,                                                                                                                                           
         InsertedOn,                                                                                                                                                  
         InsertedBy                                                                                                                                                   
 )                                                                                                                                                                    
                                                                                                                                                                      
   SELECT p_primaryPersonId,                                                                                                                                          
           p_secondaryPersonId,                                                                                                                                       
           NOW(),                                                                                                                                                     
           p_UserId;                                                                                                                                                  
                                                                                                                                                                      
  END;                                                                                                                                                                
  BEGIN                                                                                                                                                               
  -- DECLARE v_ErrorMessage VARCHAR(4000)                                                                                                                             
    --  ; v_ErrorSeverity INT                                                                                                                                         
    --  ; v_ErrorState INT;                                                                                                                                           
   -- commented as discussed. below 3 function @ 04 Jan 2018                                                                                                          
   -- v_ErrorMessage := ERROR_MESSAGE()                                                                                                                               
    -- , v_ErrorSeverity := ERROR_SEVERITY()                                                                                                                          
    -- , v_ErrorState := ERROR_STATE()                                                                                                                                
                                                                                                                                                                      
    -- Use RAISERROR inside the CATCH block to return error                                                                                                           
    -- information about the original error that caused                                                                                                               
    -- execution to jump to the CATCH block.                                                                                                                          
  -- RAISERROR;                                                                                                                                                       
   -- ( v_ErrorMessage -- Message text.                                                                                                                               
   -- , v_ErrorSeverity -- Severity.                                                                                                                                  
  --  , v_ErrorState -- State.                                                                                                                                        
   -- )                                                                                                                                                               
                                                                                                                                                                      
   /* ROLLBACK */                                                                                                                                                     
   --RETURN;                                                                                                                                                          
  END;                                                                                                                                                                
                                                                                                                                                                      
  /* COMMIT */                                                                                                                                                        
  RETURN;                                                                                                                                                             
 DROP TABLE ActorMatch ;                                                                                                                                              
 END;                                                                                                                                                                 
                                                                                                                                                                      
                                                                                                                                                                      
                                                                                                                                                                      
 $function$                                                                                                                                                           

