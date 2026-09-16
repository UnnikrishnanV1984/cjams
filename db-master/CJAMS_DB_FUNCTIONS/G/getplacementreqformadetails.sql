 DROP FUNCTION IF EXISTS cjams.getplacementreqformadetails(v_objectid character varying, v_templatename character varying, pagenumber bigint, pagesize bigint);
 CREATE OR REPLACE FUNCTION cjams.getplacementreqformadetails(v_objectid character varying, v_templatename character varying, pagenumber bigint, pagesize bigint)                                                                                     
  RETURNS TABLE(externaltemplateid character varying, assessmenttemplatename text, submissionid character varying, submissiondata json, ischildsafe boolean, assessmentstatustypekey character varying, intakeservicerequestactorid uuid)
  LANGUAGE plpgsql                                                                                                                                                                                                                       
 AS $function$ 
 ------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Smitha Somasekharan
-- Date Created : 06/11/2024 

-- Stored Procedure to get the placement request form A data -
-- Revision(s)
--06/11/2023 -Smitha Somasekharan --CIDM-8661-to get placement request form A data
------------------------------------------------------------------------                                                                                                                                                                                                                          
                                                                                                                                                                                                                                         
 Declare        v_pageoffset    int;                                                                                                                                                                                                     
                                     v_pagenumber    int;                                                                                                                                                                                
                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                         
 Begin                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                         
                 v_pagenumber    :=    pagenumber-1;                                                                                                                                                                                     
                 v_pageoffset    =    v_pagenumber    *    pagesize;                                                                                                                                                                     
                                                                                                                                                                                                                                         
 Return    query                                                                                                                                                                                                                         
                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                         
 SELECT        at.external_templateid,at.name,a.submissionid,(a.submissiondata    ::    json),    coalesce(a.ischildsafe,false),a.assessmentstatustypekey,a.intakeservicerequestactorid    from    assessment    a                       
 JOIN        assessmenttemplate    at                                                                                                                                                                                                    
 on    a.assessmenttemplateid    =    at.assessmenttemplateid                                                                                                                                                                            
 and    a.activeflag    =1    and    at.activeflag    =    1   
 where    a.objectid    =    (    v_objectid::    uuid)                                                                                                                                                                                  
 and    lower(at.name)=    lower(v_templatename)    
 and  a.assessmentstatustypekey  ='Accepted'                                                                                                                                                                          
 order    by    a.insertedon        desc                                                                                                                                                                                                 
                                                                                                                                                                                                                          
     ;                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                         
 END;                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                         
 $function$                                                                                                                                                                                                                            

