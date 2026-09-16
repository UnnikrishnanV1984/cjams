
DROP FUNCTION IF EXISTS cjams.updateresponsetimer(v_intakeserviceid uuid, v_contactdate timestamp);
CREATE OR REPLACE FUNCTION cjams.updateresponsetimer(v_intakeserviceid uuid, v_contactdate timestamp, v_contactid uuid) 
RETURNS text 
LANGUAGE plpgsql 
AS $function$ 
-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 11/15/2021 Vineet Tirodkar - Modifications to update the Audit columns of intakeservicerequest (CIDM-4067)
-- 01/31/2022 Vigneshwar Kumar - Modifications on the CPS response timer logic (CIDM-4151)
-------------------------------------------------------------------------------------------------------------
DECLARE 
    l_status text;
    l_id uuid;
    l_timerflag bool;
    l_cpstype text;
    l_allegedvictimresponsetimer timestamp;
    l_caregiverresponsetimer timestamp;
    l_otherchildresponsetimer timestamp;
    l_responsetimer timestamp;
    l_updatetimer boolean;
    val_personid record;
    l_otherchildflag bool;

BEGIN
    l_status := 'Failed';
    l_timerflag := false;
    l_updatetimer:= false; 
	l_otherchildflag:= true;
    
    IF(SELECT count(p.progressnoteid) 
	    FROM progressnote p 
	    INNER JOIN progressnotetype pt on p.progressnotetypeid = pt.progressnotetypeid 
	    WHERE p.progressnoteid = v_contactid and pt.progressnotetypekey in ('Initialfacetoface', 'Face To Face')) then
	    
	    SELECT actiontype::text, allegedvictimresponsetimer, caregiverresponsetimer,  otherchildresponsetimer, responsetimer
	   			INTO l_cpstype, l_allegedvictimresponsetimer, l_caregiverresponsetimer, l_otherchildresponsetimer, l_responsetimer 
	    FROM intakeservicerequest where intakeserviceid = v_intakeserviceid; 
	   
	    CREATE temp TABLE temp_notes (
	            attemptindicator    bool,
	            progressnotetypekey varchar(50),
	            persons             json
	        );
	   
	    INSERT INTO temp_notes
	        SELECT 
	            pn.attemptindicator,
	            pnt.progressnotetypekey, (
	            SELECT array_to_json(array_agg(isra.personid)) FROM contactparticipant cp
	                JOIN intakeservicerequestactor isra 
	                    ON isra.intakeservicerequestactorid = cp.intakeservicerequestactorid AND isra.activeflag =1
	                WHERE cp.progressnoteid = pn.progressnoteid AND cp.activeflag =1) 
	            FROM progressnote pn 
	            JOIN progressnotetype pnt 
	                ON pn.progressnotetypeid = pnt.progressnotetypeid AND pnt.activeflag =1 
	                AND pnt.progressnotetypekey IN ('Face To Face','Initialfacetoface')
	            WHERE pn.entitytype = 'intakeservicerequest' 
	                AND pn.entitytypeid =v_intakeserviceid::character varying AND pn.activeflag =1;
	              
	    -- 1) AllegedVictim   
	    -- AR Case - Completed
	    -- IR Case - Completed        
	   	
		l_timerflag := (SELECT count(*)=0 
							FROM intakeservicerequestactor
							WHERE intakeserviceid = v_intakeserviceid 
									AND intakeservicerequestpersontypekey = 'AV' 
									AND activeflag =1 
									AND personid::character varying in (SELECT json_array_elements_text(persons) 
													 FROM temp_notes 
													 WHERE NOT attemptindicator)
						);
				
	    IF(l_timerflag IS FALSE) then
	    	
	    	IF(l_allegedvictimresponsetimer IS NULL  OR (l_allegedvictimresponsetimer IS NOT NULL AND v_contactdate < l_allegedvictimresponsetimer)) THEN 
	    		l_updatetimer = true;
	    		l_allegedvictimresponsetimer = v_contactdate;
	    	END IF;
	        
	       	UPDATE intakeservicerequest
	        SET allegedvictimresponsetimer = v_contactdate,
	        	updatedby = 'cwadmin',
				updatedon = now()
	    	WHERE intakeserviceid = v_intakeserviceid;
	    END IF;
	
	    -- 2) Caregiver - AllegedVictim   
	    -- AR Case - Completed
	    -- IR Case - Attempted/Completed
		l_timerflag := (SELECT count(*)=0 
			            FROM intakeservicerequestactor isra
			            JOIN actorrelationship ar ON ar.person2id = isra.personid AND ar.caregiverflag  = 1 AND ar.activeflag = 1
			            JOIN intakeservicerequestactor isra1 ON isra.intakeserviceid  = isra1.intakeserviceid AND isra1.intakeservicerequestactorid = ar.intakeservicerequestactorid                
			            WHERE isra.intakeserviceid = v_intakeserviceid 
			            		AND isra.intakeservicerequestpersontypekey = 'AV' 
			            		AND isra.activeflag =1
								AND isra.personid::character varying in (SELECT json_array_elements_text(persons) 
																	FROM temp_notes 
																	WHERE CASE WHEN l_cpstype = 'AR' THEN NOT attemptindicator ELSE attemptindicator IS NOT NULL END)
								AND ar.person1id::character varying 
										in (SELECT json_array_elements_text(persons) 
											FROM temp_notes 
											WHERE CASE WHEN l_cpstype = 'AR' THEN 
													NOT attemptindicator 
												  else
												  		attemptindicator IS NOT NULL 
												  END)
						);
	        
		IF(l_timerflag IS FALSE) THEN
	        IF(l_caregiverresponsetimer IS NULL  OR (l_caregiverresponsetimer IS NOT NULL AND v_contactdate < l_caregiverresponsetimer)) THEN 
	    		l_updatetimer = true;
	    		l_caregiverresponsetimer = v_contactdate;
	    	END IF;
	    END IF;
	   	
		
	   	-- 3) Caregiver - AllegedVictim   
	    -- AR Case - Completed
	    -- IR Case - Attempted/Completed
	   	FOR  val_personid  in  (SELECT personid 
						FROM intakeservicerequestactor
						WHERE intakeserviceid =v_intakeserviceid
							     	AND (intakeservicerequestpersontypekey='CHILD' or intakeservicerequestpersontypekey='OTHERCHILD') 
							     	AND activeflag = 1
					)
		loop
				IF(l_otherchildflag IS TRUE) THEN
					l_otherchildflag = EXISTS(SELECT 1 FROM temp_notes WHERE 
												 val_personid.personid::text in (SELECT json_array_elements_text(persons))
												 AND CASE WHEN l_cpstype = 'AR' THEN NOT attemptindicator ELSE attemptindicator IS NOT NULL END);
					
				
				END IF;
 		END  LOOP;
		
 		IF(l_otherchildflag IS TRUE) then
			RAISE NOTICE 'l_otherchildflag %', 1;
	       IF(l_otherchildresponsetimer IS NULL  OR (l_otherchildresponsetimer IS NOT NULL AND v_contactdate < l_otherchildresponsetimer)) THEN 
	    		l_updatetimer = true;
	    		l_otherchildresponsetimer = v_contactdate;
	    	END IF;
	    END IF;
	    
	    -- Updating response timer
	    UPDATE intakeservicerequest
	        SET responsetimer = CASE WHEN (l_allegedvictimresponsetimer IS NOT NULL AND l_caregiverresponsetimer IS NOT NULL AND l_otherchildresponsetimer IS NOT NULL and l_updatetimer = true) THEN v_contactdate ELSE NULL END
	        	, allegedvictimresponsetimer = l_allegedvictimresponsetimer
	        	, caregiverresponsetimer = l_caregiverresponsetimer
	        	, otherchildresponsetimer = l_otherchildresponsetimer
				, updatedby = 'cwadmin'
				, updatedon = now()
	    WHERE intakeserviceid = v_intakeserviceid;
    	
    	DROP TABLE temp_notes;
    
	    l_status := 'Success';
    ELSE
        l_status := 'Success';
	END IF;
        
RETURN l_status;
END;

$function$
;
