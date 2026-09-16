DROP FUNCTION IF EXISTS cjams.getassessmentdetails(character varying, uuid, boolean, character varying);
DROP FUNCTION IF EXISTS cjams.getassessmentdetails(character varying, uuid, boolean, character varying,integer, character varying);
DROP FUNCTION IF EXISTS cjams.getassessmentdetails(character varying, uuid, boolean, character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.getassessmentdetails(objectsid character varying, lassessmenttemplateid uuid, iscaseworker boolean, v_roletypecode character varying DEFAULT ''::character varying, v_servicerequestnumber character varying DEFAULT NULL)
RETURNS json                                                                                                                                                                                        
LANGUAGE plpgsql                                                                                                                                                                                    
AS $function$                                                                                                                                                                                        
-------------------------------------------------------------------------------------------
--Revision(s)
--07/25/2022 - Vijaya Laxmi Devunoori - CDM-23745
-- ISR.servicerequestnumber as servicerequestnumber
-- 12/27/2023 Palani/Manasa - Query optimization changes(CIDM-8258)
-------------------------------------------------------------------------------------------                                                                                                                                                                                                     
DECLARE 
l_assment json;        
v_isexpunged integer;                                                                                                                                                                      
BEGIN                

        SELECT json_agg(astmp) INTO l_assment
        FROM (SELECT AST.assessmentTextPositionTypeKey
                , AST.assessmentscoresetupid
                , AST.assessmenttemplateid
                , AST.calculationmethod
                , AST.datamappingenabled
                , AST.description
                , AST.effectivedate
                , AST.enableassessmentscore
                , AST.expirationdate
                , AST.external_templateid
                , AST.helptext
                , AST.instructions
                , AST.isvisible
                , AST.name
                , AST.scoringname
                , AST.titleheadertext
                , AST.version
                , a.submissionid
                , a.submissiondata
                , coalesce(A.score,0) score 
                , A.assessmentstatustypekey
                , A.assessmentid
                , a.updatedon updateddate                                                                                                                                                       
                , CASE coalesce(A.ismigrated,0)  WHEN 1 THEN  'Migrated' ELSE coalesce(up.lastname,'')||', ' ||coalesce(up.firstname,'') END  as username
                , a.insertedon as createddate
                , AC.comments
                , coalesce(A.ismigrated,0) ismigration
                , A.assessmentsubmissiontypekey  
                , (case when v_servicerequestnumber is not null then v_servicerequestnumber else (SELECT ISR.servicerequestnumber FROM intakeservicerequest ISR where ISR.intakeserviceid=A.objectid::uuid and activeflag = 1 limit 1)end) as servicerequestnumber                                                                                                                                               
        FROM   assessment A
        INNER JOIN  assessmenttemplate AST ON AST.assessmenttemplateid = A.assessmenttemplateid AND A.activeflag =1                                                                                                                                                                          
                AND A.assessmenttemplateid =lassessmenttemplateid                                                                                                                                    
        LEFT JOIN assessmentcomments AC on AC.assessmentid = A.assessmentid AND ac.activeflag =1                                                                                                                                       
        LEFT JOIN userprofile up on up.securityusersid = a.insertedby                                                                                                                            
        WHERE  coalesce(A.intakenumber ,'')= CASE iscaseworker  WHEN false THEN objectsid ELSE coalesce(A.intakenumber ,'') END                                                                       
                AND A.objectid = CASE iscaseworker WHEN true THEN objectsid::uuid ELSE A.objectid END                                                                                                                                            
        AND lower(A.assessmentstatustypekey) Not in ( CASE coalesce(v_roletypecode,'')  WHEN '' then 'inprocess' ELSE '' END)                                                        
        ORDER BY a.updatedon DESC
        ) as astmp;                                                                                                                                                
                                                                                                                                                                                                      
RETURN l_assment;                                                                                                                                                                                    
END;                                                                                                                                                                                                 
                                                                                                                                                                                                      
$function$;                                                                                                                                                                                       

