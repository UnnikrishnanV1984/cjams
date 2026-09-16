DROP FUNCTION IF EXISTS cjams.getytpchildrenlist(uuid, uuid, text);

CREATE OR REPLACE FUNCTION cjams.getytpchildrenlist(
    p_clientid        UUID,
    p_servicecaseid   UUID,
    p_approvalstatus  TEXT DEFAULT 'Approved'
)
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 11/03/2025 Anil Kumar Dharni - Foster Care Guardianship Checklist(B-186271) SP to fetch the list of all children who has their youth transition created in a service case
------------------------------------------------------------------------------------------------------------	
RETURNS TABLE (
    youthtransitionplanid    UUID,
    clientid                 UUID,
    clientname               VARCHAR,
    dob                      DATE,
    gendertype               VARCHAR,
    newfcgschecklistjson     JSONB,
    caseworkerid             UUID,
    caseworkername           VARCHAR,
    caseworkeremail          VARCHAR,
    caseworkerphonenumber    VARCHAR,
    supervisorworkername     VARCHAR,
    supervisorid             UUID,
    supervisoremail          VARCHAR,
    supervisorphonenumber    VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
      ytp.youthtransitionplanid,
      ytp.clientid,
      p.firstname                           AS clientname,
      p.dob::DATE                           AS dob,
      gt.typedescription                    AS gendertype,
      ytp.newfcgschecklistjson,
      u1.securityusersid::UUID              AS caseworkerid,  
      ytp.caseworkername,
      u1.email                              AS caseworkeremail,
      uph1.phonenumber                      AS caseworkerphonenumber,
      ytp.supervisorworkername,
      u2.securityusersid::UUID              AS supervisorid,
      u2.email                              AS supervisoremail,
      uph2.phonenumber                      AS supervisorphonenumber
  FROM cjams.youthtransitionplan ytp
  INNER JOIN cjams.person p
    ON p.personid   = ytp.clientid
   AND p.activeflag = 1
  INNER JOIN cjams.gendertype gt
    ON gt.gendertypekey = p.gendertypekey
   AND gt.activeflag    = 1
  INNER JOIN cjams.userprofile u1
    ON u1.displayname = ytp.caseworkername
   AND u1.activeflag  = 1
  INNER JOIN cjams.userprofile u2
    ON u2.displayname = ytp.supervisorworkername
   AND u2.activeflag  = 1
  INNER JOIN cjams.userprofilephonenumber uph1
    ON uph1.securityusersid   = u1.securityusersid
   AND uph1.userprofiletypekey = 'Cell'
   AND uph1.activeflag         = 1
  INNER JOIN cjams.userprofilephonenumber uph2
    ON uph2.securityusersid   = u2.securityusersid
   AND uph2.userprofiletypekey = 'Cell'
   AND uph2.activeflag         = 1
  WHERE ytp.clientid             = p_clientid
    AND ytp.intakeserviceid::UUID = p_servicecaseid
    AND ytp.approvalstatuskey     = p_approvalstatus;
END;
$$;