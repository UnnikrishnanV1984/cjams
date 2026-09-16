DROP FUNCTION IF EXISTS cjams.updateservicecasedisposition(character varying);

CREATE OR REPLACE FUNCTION cjams.updateservicecasedisposition(
	v_objectid character varying, 
	v_securityusersid character varying)
  RETURNS character varying                                                                                                                
  LANGUAGE plpgsql                                                                                                                         
 AS $function$                                                                                                                           
                                                                                                                                         
                                                                                                                                         
 DECLARE  
                                                                                          
	 v_intakeserreqstatustypekey character varying;                                                                                          
	 v_dispositioncode character varying;                                                                                                    
	 v_servicecaseid uuid;                                                                                                                   
BEGIN                                                                                                                                   

	SELECT intakeserreqstatustypekey, servicecaseid, dispositioncode INTO v_intakeserreqstatustypekey, v_servicecaseid , v_dispositioncode
	FROM servicecasedisposition WHERE servicecasedispositionid:: character varying=v_objectid LIMIT 1;                                    

	-- Will update enddate = null, statustypekey = ' Open', and dispositioncode = null when case is reopened in createservicecase()   

	update servicecase set enddate = now(), statustypekey = v_intakeserreqstatustypekey, dispositioncode = v_dispositioncode               
	where servicecaseid = v_servicecaseid;                                                                                                  

	--## END WORKER ASSIGNMENT WHEN DISPOSITION IS APPROVED
	UPDATE caseassignment SET enddate = NOW(), updatedon= NOW(), updatedby='admin' WHERE objectid:: character varying = v_servicecaseid:: character varying and enddate is null; --AND toworkeridno = v_securityusersid;

	RETURN    'SUCCESS'; 

END;                                                                                                                                    
                                                                                                                                         
  $function$                                                                                                                                

