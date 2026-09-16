DROP FUNCTION IF EXISTS cjams.updatedisposition(character varying);

CREATE OR REPLACE FUNCTION cjams.updatedisposition(
	v_objectid character varying, 
	v_securityusersid character varying)
  RETURNS character varying                                                                                                                           
  LANGUAGE plpgsql                                                                                                                                    
 AS $function$   
-- Revision
-----------------------------------------------------------------
-- CDM-43896-01/28/2025: Fix for case Assignment not getting end dated after case closure
----------------------------------------------------------------- 

DECLARE


v_date  timestamp    without    time    zone;
v_intakeserreqstatustypeid uuid;
v_intakeserviceid uuid;
begin
	
	v_date :=  now();
	--v_intakeserreqstatustypeid := (select intakeserreqstatustypeid from intakeserreqstatustype where intakeserreqstatustypekey = 'Closed' limit 1);

	SELECT intakeserreqstatustypeid, intakeserviceid INTO v_intakeserreqstatustypeid, v_intakeserviceid 
	FROM Intakeservicerequestdispositioncode WHERE Intakeservicerequestdispositioncodeid:: character varying=v_objectid LIMIT 1;


	update intakeservicerequest set exitdate = now(), intakeserreqstatustypeid = v_intakeserreqstatustypeid
	where intakeserviceid = v_intakeserviceid;
	
	--## END WORKER ASSIGNMENT WHEN DISPOSITION IS APPROVED
	UPDATE caseassignment 
	SET enddate = NOW(), updatedon= NOW(), updatedby='admin' 
	WHERE objectid = v_intakeserviceid 
	-- AND toworkeridno = (SELECT securityusersid from routing r
	-- 					INNER JOIN userprofile  up ON up.securityusersid = r.fromsecurityusersid
	-- 					WHERE r.eventcode = 'INDR' AND r.objectid  =  v_objectid 
	-- 					and r.routingstatustypeid = 15 ORDER BY r.insertedon DESC LIMIT 1)
	AND enddate is null and activeflag = 1;

	UPDATE Intakeservicerequestdispositioncode SET statusdate = now(), updatedon = now() 
	WHERE Intakeservicerequestdispositioncodeid:: character varying=v_objectid ;

    RETURN    'SUCCESS';    
END;    

 $function$  

