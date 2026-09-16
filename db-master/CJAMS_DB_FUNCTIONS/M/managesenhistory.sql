DROP FUNCTION IF EXISTS cjams.managesenhistory(UUID, UUID, VARCHAR, TIMESTAMP, BOOLEAN, VARCHAR, TEXT, TEXT, TEXT, TEXT, UUID, VARCHAR, SMALLINT, VARCHAR, VARCHAR); 
DROP FUNCTION IF EXISTS cjams.managesenhistory(
  UUID,
  UUID,
  VARCHAR,
  TIMESTAMP,
  BOOLEAN,
  VARCHAR,
  TEXT,
  TEXT,
  TEXT,
  TEXT,
  UUID,
  UUID,
  VARCHAR,
  SMALLINT,
  VARCHAR,
  VARCHAR
);

CREATE OR REPLACE FUNCTION cjams.managesenhistory(
  p_id UUID,
  p_personid UUID,
  p_requestedby VARCHAR,
  p_requestedon TIMESTAMP,
  p_senstatus BOOLEAN,
  p_approvalstatus VARCHAR,
  p_reasons TEXT,
  p_otherreason TEXT,
  p_actions TEXT,
  p_substanceclasses TEXT,
  p_sencriteria VARCHAR,
  p_birthinghospital VARCHAR,
  p_othersubstances VARCHAR,
  p_servicecaseid UUID,
  p_intakeserviceid UUID,
  p_approvedby VARCHAR,
  p_activeflag SMALLINT,
  p_denialreasonkey VARCHAR,
  p_denialreasondesc VARCHAR
)
RETURNS TABLE(
  return_id UUID,
  success BOOLEAN,
  message VARCHAR,
  operation VARCHAR
)
LANGUAGE plpgsql
AS $function$

/*
--Revision(s)
-- 01-06-2026 - Veera Nadimpalli -- CIDM-10982 - To save Sen Criteria Identification
-- 01-30-2026 - Sushma Bade -- CIDM-10982 -- othersubstances in Sen history
-- 04-17-2026 - Veera - CDM-44800 - Fix for Sen removal notification

*/

DECLARE
  v_id UUID;
  v_objectid UUID;
  v_supervisorid UUID;
  v_requestnumber character varying;
  v_casetype character varying;
  v_reasons TEXT[];
  v_actions TEXT[];
  v_substanceclasses TEXT[];
  v_op VARCHAR := 'none';
  vs_notification_txt varchar(500); 
  v_personname varchar(1000); 
  v_usernotificationid uuid;
  v_from_securityusersid uuid;
  v_to_securityusersid uuid;
  v_supervisorname VARCHAR(500);
BEGIN
  -- Parse arrays
  IF p_reasons IS NOT NULL THEN
    SELECT array_agg(value) INTO v_reasons FROM json_array_elements_text(p_reasons::json) AS t(value);
  END IF;
  IF p_actions IS NOT NULL THEN
    SELECT array_agg(value) INTO v_actions FROM json_array_elements_text(p_actions::json) AS t(value);
  END IF;
  IF p_substanceclasses IS NOT NULL THEN
    SELECT array_agg(value) INTO v_substanceclasses FROM json_array_elements_text(p_substanceclasses::json) AS t(value);
  END IF;


  -- Check for existing main record
  SELECT senselectiondetailsid INTO v_id, v_requestnumber
  FROM cjams.senselectiondetails_history
  WHERE personid = p_personid and approvalstatus NOT IN ('Changed', 'Created') and activeflag =1
  ORDER BY requestedon DESC
  LIMIT 1;
  IF p_servicecaseid IS NOT NULL THEN
	SELECT servicecasenumber INTO v_requestnumber FROM servicecase WHERE servicecaseid::uuid = p_servicecaseid  and activeflag = 1 LIMIT 1;
	v_casetype := 'servicecase';
	v_objectid = p_servicecaseid;
  ELSE
	SELECT ISR.servicerequestnumber, 
	  CASE 
		WHEN ISR.actiontype = 'IR' THEN 'CPS IR'
		WHEN ISR.actiontype = 'AR' THEN 'CPS AR'
		ELSE NULL
	  END AS casetype
	INTO 
	  v_requestnumber, v_casetype
	FROM 
	  intakeservicerequest ISR
	WHERE 
	  ISR.intakeserviceid = p_intakeserviceid::uuid
	  AND ISR.activeflag = 1
	LIMIT 1;
	v_objectid = p_intakeserviceid;
  END IF;
  
  SELECT '(' || pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || (pr.cjamspid)::character varying || ')' INTO v_personname FROM person pr WHERE pr.personid = p_personid  and activeflag =1  LIMIT 1;
  SELECT supervisorid INTO v_supervisorid FROM userprofile WHERE securityusersid::uuid = p_requestedby::uuid  and activeflag =1 LIMIT 1;
  SELECT firstname || ' ' || lastname INTO v_supervisorname
  FROM userprofile
  WHERE securityusersid::uuid = v_supervisorid   and activeflag =1 LIMIT 1;
  IF v_id IS NULL THEN
    p_approvedby := null;
    INSERT INTO cjams.senselectiondetails (
      personid, requestedon, requestedby,
      senstatus, approvalstatus,
      reasons, otherreason, actions, substanceclasses, sencriteria , birthinghospital, othersubstances,
      objectid, activeflag, insertedby, insertedon, updatedby, updatedon
    ) VALUES (
      p_personid, p_requestedon, p_requestedby,
      p_senstatus, p_approvalstatus,
      v_reasons, p_otherreason, v_actions, v_substanceclasses, p_sencriteria ,  p_birthinghospital, p_othersubstances,
      v_objectid, 1, p_requestedby::uuid, p_requestedon, p_requestedby::uuid, p_requestedon
    )
    RETURNING senselectiondetailsid INTO v_id;

    v_from_securityusersid := p_requestedby;
    v_to_securityusersid := v_supervisorid;
    vs_notification_txt := 'SEN removal Request has been submitted for review for the child';
    IF p_approvalstatus NOT IN ('Changed', 'Created') THEN
    v_op := 'created';
     INSERT INTO routing(
      eventcode, fromsecurityusersid, tosecurityusersid, objectid,
      routingstatustypeid, insertedby, updatedby, insertedon, updatedon,
      servicerequestnumber, entityid
    ) VALUES (
      'SENCHECK', p_requestedby::uuid, v_supervisorid, v_id, 15,
      p_requestedby::uuid, p_requestedby::uuid, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,
      v_requestnumber, p_personid
    );
      END IF;

  ELSE
    v_op := lower(p_approvalstatus);
    v_from_securityusersid := p_approvedby;
    v_to_securityusersid := p_requestedby;
    
  IF p_approvalstatus = 'Approved' THEN
    vs_notification_txt := 'SEN removal Request has been approved by ' || v_supervisorname || ' for the child';
    UPDATE cjams.senselectiondetails
    SET
      requestedon = p_requestedon,
      requestedby = p_requestedby,
      approvedby = p_approvedby,
      approvedon = CURRENT_TIMESTAMP,
      senstatus = p_senstatus,
      approvalstatus = p_approvalstatus,
      reasons = v_reasons,
      otherreason = p_otherreason,
      actions = v_actions,
      substanceclasses = v_substanceclasses,
      sencriteria = p_sencriteria,
      birthinghospital = p_birthinghospital,
      othersubstances = p_othersubstances,
      activeflag = p_activeflag,
      updatedby = p_approvedby,
      updatedon = CURRENT_TIMESTAMP
    WHERE personid = p_personid;
  UPDATE routing SET routingstatustypeid = 16, fromsecurityusersid=v_from_securityusersid, tosecurityusersid=v_to_securityusersid, updatedby = p_approvedby, updatedon = NOW() WHERE objectid::character varying = v_id::character varying AND eventcode = 'SENCHECK' AND entityid::uuid = p_personid::uuid;
  ELSIF p_approvalstatus = 'Deny' THEN
  vs_notification_txt := 'SEN removal Request has been denied by ' || v_supervisorname || ' for the child';
   UPDATE cjams.senselectiondetails
    SET
      requestedon = p_requestedon,
      requestedby = p_requestedby,
      approvedby = p_approvedby,
      approvedon = CURRENT_TIMESTAMP,
      senstatus = p_senstatus,
      approvalstatus = p_approvalstatus,
      denialreasonkey = p_denialreasonkey,
      denialreasondesc = p_denialreasondesc,
      otherreason = p_otherreason,
      activeflag = p_activeflag,
      updatedby = p_approvedby,
      updatedon = CURRENT_TIMESTAMP
    WHERE personid = p_personid;
    UPDATE routing SET routingstatustypeid = 17, updatedby = p_approvedby, updatedon = NOW() WHERE objectid::character varying = v_id::character varying AND eventcode = 'SENCHECK' AND entityid::uuid = p_personid::uuid;
  ELSIF p_approvalstatus = 'Changed' THEN
    v_op := 'created';
   UPDATE cjams.senselectiondetails
    SET
      requestedon = p_requestedon,
      requestedby = p_requestedby,
      approvedby = null,
      approvedon = null,
      senstatus = p_senstatus,
      approvalstatus = p_approvalstatus,
      denialreasonkey = null,
      denialreasondesc = null,
      otherreason = null,
      activeflag = p_activeflag,
      updatedby = p_requestedby,
      updatedon = CURRENT_TIMESTAMP
    WHERE personid = p_personid;

    ELSIF v_op <> 'created' THEN
      v_from_securityusersid := p_requestedby;
      v_to_securityusersid := v_supervisorid;
      v_op := 'pending';
      vs_notification_txt := 'SEN removal Request has been submitted for review for the child';
      UPDATE cjams.senselectiondetails
      SET
        requestedon = p_requestedon,
        requestedby = p_requestedby,
        approvedby = p_approvedby,
        approvedon = NULL,
        senstatus = p_senstatus,
        approvalstatus = p_approvalstatus,
        reasons = v_reasons,
        otherreason = p_otherreason,
        actions = v_actions,
        substanceclasses = v_substanceclasses,
        sencriteria = p_sencriteria,
        birthinghospital = p_birthinghospital,
        othersubstances = p_othersubstances,
        activeflag = p_activeflag,
        updatedon = CURRENT_TIMESTAMP
      WHERE personid = p_personid;
      UPDATE routing SET activeflag = 0, updatedby = p_approvedby, updatedon = NOW() WHERE eventcode = 'SENCHECK' AND servicerequestnumber = v_requestnumber AND entityid::uuid = p_personid::uuid;
      INSERT INTO routing(
        eventcode, fromsecurityusersid, tosecurityusersid, objectid,
        routingstatustypeid, insertedby, updatedby, insertedon, updatedon,
        servicerequestnumber, entityid
      ) VALUES (
        'SENCHECK', p_requestedby::uuid, v_supervisorid, v_id, 15,
        p_requestedby::uuid, p_requestedby::uuid, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,
        v_requestnumber, p_personid
      );
    END IF;
  END IF;

  -- Insert audit log
  INSERT INTO cjams.senselectiondetails_history (
    senselectiondetailsid,
    personid, requestedby, senstatus, approvalstatus,
    reasons, otherreason, actions, substanceclasses, sencriteria , birthinghospital, othersubstances,
    objectid, requestedon, processedon,
    approvedby, approvedon, insertedby, insertedon, updatedby, updatedon,
    activeflag, denialreasonkey, denialreasondesc
  ) VALUES (
    v_id,
    p_personid, p_requestedby, p_senstatus, p_approvalstatus,
    v_reasons, p_otherreason, v_actions, v_substanceclasses,  p_sencriteria , p_birthinghospital, p_othersubstances,
    v_objectid, p_requestedon, CURRENT_TIMESTAMP,
    p_approvedby,
    CASE WHEN p_approvalstatus = 'Approved' OR p_approvalstatus = 'Deny' THEN CURRENT_TIMESTAMP ELSE NULL END,
    p_requestedby::uuid, CURRENT_TIMESTAMP, p_requestedby::uuid, CURRENT_TIMESTAMP,
    1, p_denialreasonkey, p_denialreasondesc
  );
  IF ((p_approvalstatus NOT IN ('Changed', 'Created')) OR v_op = 'pending') THEN
  vs_notification_txt := vs_notification_txt || ' ' || v_personname;
  insert into cjams.usernotification
      ( usernotificationid, securityusersid, usernotificationtypekey, objectid, activeflag, 
        url, subject, priorityleveltypekey, "body", hasattachments, 
        updatedby, updatedon, insertedby, insertedon, effectivedate, 
        expirationdate, "timestamp", teammemberid, isread, attachmentlocation, 
        isexternalentity, ismailsent, mailsentdate, old_id, objecttype, 
        objectcasenumber, entityid, isdeleted, teamtypekey
      )
    values
      ( gen_random_uuid(), v_to_securityusersid, 'System', v_objectid, 1, 
        NULL, vs_notification_txt, 'High', vs_notification_txt, NULL, 
        p_requestedby::uuid, now(), p_requestedby::uuid, now(),  now(), 
        NULL, NULL, NULL, NULL, NULL, 
        false, false, NULL, 
        NULL, 
        v_casetype, 
        v_requestnumber, v_id, NULL, 'CW'
      )
    RETURNING "usernotificationid" INTO  v_usernotificationid; 

    insert into cjams.usernotificationmap
      ( usernotificationmapid, usernotificationid,fromsecurityusersid, tosecurityusersid, parentusernotificationmapid, isreplied, 
        isforwarded, iscarboncopy, isread, expirationdate, effectivedate, 
        activeflag, teammemberid, insertedby, updatedby, insertedon, 
        updatedon, old_id, isdeleted
      )
    values
      (   gen_random_uuid(), v_usernotificationid, v_from_securityusersid, v_to_securityusersid, NULL, NULL, 
        NULL, NULL, false, now(), now(), 
        1, NULL, p_requestedby::uuid, p_requestedby::uuid, now(), 
        now(), NULL, NULL
      );
  END IF;
  return_id := v_id;
  success := TRUE;
  message := format('SEN selection record %s and audit logged', v_op);
  operation := v_op;
  RETURN NEXT;

EXCEPTION WHEN OTHERS THEN
  return_id := NULL;
  success := FALSE;
  message := 'Error: ' || SQLERRM;
  operation := 'error';
  RETURN NEXT;
END;
$function$;