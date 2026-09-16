DROP FUNCTION IF EXISTS cjams.getytpchilddetails(UUID, UUID);

CREATE OR REPLACE FUNCTION cjams.getytpchilddetails(
    p_clientid UUID,
    p_youthtransitionplanid UUID DEFAULT NULL
)
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 11/03/2025 Anil Kumar Dharni - Foster Care Guardianship Checklist (B-186271)
-- SP to fetch the list of Youth Transition Plans created for the child
------------------------------------------------------------------------------------------------------------
RETURNS TABLE (
    youthtransitionplanid UUID,
    summary_json JSONB,
    youththoughts_json JSONB,
    sracc_json JSONB,
    health_json JSONB,
    moneymanagement_json JSONB,
    housing_json JSONB,
    education_json JSONB,
    employment_json JSONB,
    documentation_json JSONB,
    clientid UUID,
    intakeserviceid UUID,                
    sevicecaseid UUID,                 
    insertedby VARCHAR,
    updatedby VARCHAR,
    insertedon TIMESTAMP,
    updatedon TIMESTAMP,
    approvaldate TIMESTAMP,
    approvalstatuskey VARCHAR,
    completiondate TIMESTAMP,
    assessmentcompletiondate TIMESTAMP,
    nextduedate TIMESTAMP,
    rejectionnote VARCHAR,            
    returnreason VARCHAR,
    caseworkername VARCHAR,
    supervisorworkername VARCHAR,
    new_summary_json JSONB,
    new_education_json JSONB,
    new_employ_json JSONB,
    new_transportation_json JSONB,
    new_documentation_json JSONB,
    new_financial_empowerment_json JSONB,
    new_housing_json JSONB,
    new_community_json JSONB,
    new_health_json JSONB,
    new_connections_json JSONB,
    new_meeting_json JSONB,
    copyofplanjson JSONB,
    startdate TIMESTAMP,              
    enddate TIMESTAMP       
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
      ytp.youthtransitionplanid,
      ytp.summary_json,
      ytp.youththoughts_json,
      ytp.sracc_json,
      ytp.health_json,
      ytp.moneymanagement_json,
      ytp.housing_json,
      ytp.education_json,
      ytp.employment_json,
      ytp.documentation_json,
      ytp.clientid,
      ytp.intakeserviceid,
      ytp.sevicecaseid,
      ytp.insertedby,
      ytp.updatedby,
      ytp.insertedon,
      ytp.updatedon,
      ytp.approvaldate,
      ytp.approvalstatuskey,
      ytp.completiondate,
      ytp.assessmentcompletiondate,
      ytp.nextduedate,
      ytp.rejectionnote,
      ytp.returnreason,
      ytp.caseworkername,
      ytp.supervisorworkername,
      ytp.new_summary_json,
      ytp.new_education_json,
      ytp.new_employ_json,
      ytp.new_transportation_json,
      ytp.new_documentation_json,
      ytp.new_financial_empowerment_json,
      ytp.new_housing_json,
      ytp.new_community_json,
      ytp.new_health_json,
      ytp.new_connections_json,
      ytp.new_meeting_json,
      ytp.copyofplanjson,
      ytp.startdate,
      ytp.enddate
  FROM cjams.youthtransitionplan ytp
  WHERE ytp.clientid = p_clientid
    AND (p_youthtransitionplanid IS NULL OR ytp.youthtransitionplanid = p_youthtransitionplanid);
END;
$$;