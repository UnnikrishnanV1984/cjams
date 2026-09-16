CREATE OR REPLACE FUNCTION cjams.reopenservicecase(v_input json)
 RETURNS TABLE(message character varying, success boolean)
 LANGUAGE plpgsql
AS $function$              
 
/*
B-119350 - REFINEMENT of User Story B-108258: Reopening a Closed Service Case

-- Revision(s)
-- 04/06/2022 - Vineet Tirodkar - Change in the logic to re-open Program assignments (CIDM-4364/B-119350)
--- 11/29/2022 - Umasankar Raavi -- CDM-26788- Type case changes
-- 12-01 - Veera Auroa Issue fixes- CDM-26923
*/
DECLARE                                                                                                                                                                            
	statusid_v character varying;                                                                                                                                                                
	dispositionid_v character varying;                                                                                                                                                          
	caseworkerid_v uuid;
	teamid_v uuid;
	userid_v uuid;       
	v_personid uuid;       	 
	responsibilitytypekey_v character varying;                                                                                                                                                            
	reviewcomments_v character varying;
	servicecaseid_v uuid;
	servicecasedispositionid_v uuid;
	reopenreasonkey_v character varying;
	existingcaseclosuredt_v date;
	assignmentstatus_v integer;
	assignmentdescription_v character varying;
	v_pa_type character varying;
 
	cur_program_assignment record;
	cur_program_assignment_refcur REFCURSOR;
	
BEGIN        
  servicecaseid_v:= (v_input ->>'servicecaseid')::uuid;
  statusid_v:= (v_input ->>'statusid')::character varying;                                                                                                                          
  dispositionid_v:= (v_input ->>'dispositionid')::character varying;
  userid_v:= (v_input ->>'securityuserid')::uuid;
  caseworkerid_v:= (v_input ->>'caseworkerid')::uuid;
  teamid_v:= (v_input ->>'teamid')::uuid;
  responsibilitytypekey_v:= (v_input ->>'responsibilitytypekey')::character varying;
  reviewcomments_v:= (v_input ->>'reviewcomments')::character varying;
  servicecasedispositionid_v:=(v_input ->>'servicecasedispositionid')::uuid;
  reopenreasonkey_v:=(v_input ->>'reopenreasonkey')::character varying;

  SELECT date(enddate) INTO existingcaseclosuredt_v FROM servicecase WHERE servicecaseid = servicecaseid_v;

	-- Step 1 - Adding/Updating disposition table with supervisor comment
	IF(servicecasedispositionid_v is null) THEN
		INSERT INTO cjams.servicecasedisposition( 
				servicecaseid
				, statusdate
				, intakeserreqstatustypekey
				, dispositioncode
				, supervisorcomment
				, effectivedate
				, reopenreasonkey
				, activeflag
				, insertedby
				, insertedon
				, updatedby
				, updatedon)
		VALUES(servicecaseid_v
				, now()
				, 'Reopen'
				, 'Inprogress'
				, reviewcomments_v
				, now()
				, reopenreasonkey_v
				, 1
				, userid_v
				, now()
				, userid_v
				, now()
		) RETURNING servicecasedispositionid into servicecasedispositionid_v;  

  ELSE

		UPDATE cjams.servicecasedisposition
		SET updatedby = userid_v,
			updatedon = now(),
			supervisorcomment = reviewcomments_v,
			reopenreasonkey = reopenreasonkey_v
		WHERe servicecasedispositionid = servicecasedispositionid_v;

  END IF;

  -- Step 2 - Updating the status type in servicecase
  UPDATE servicecase
  SET statustypekey ='Open',
	  dispositioncode = 'Open',
	  enddate = null,
	  updatedby = userid_v,
	  updatedon = now()
  WHERE servicecaseid = servicecaseid_v;

  -- Step 3 - Assigning case to a case worker
  SELECT * INTO assignmentstatus_v, assignmentdescription_v 
  FROM reassigncase('SRVC':: character varying
						, servicecaseid_v :: uuid
						, userid_v :: character varying
						, caseworkerid_v :: character varying
						, responsibilitytypekey_v :: character varying
						, null ::uuid
						, null ::timestamp without time zone
						, reviewcomments_v ::character varying
						, null ::integer
						, teamid_v :: uuid
						, null ::json
						, 'W':: character varying
						, now() ::timestamp without time zone
      );

  -- Step 4 - Add a new row to routing table with approved status
  UPDATE routing
  SET activeflag = 0,
	  updatedby = userid_v,
	  updatedon = now()
  WHERE objectid = servicecasedispositionid_v::character varying;

  INSERT INTO routing(
			eventcode,
			fromsecurityusersid,
			tosecurityusersid,
			teamid,
			fromroleid,
			toroleid,
			objectid,
			routingstatustypeid,
			insertedby,  
			updatedby,
			objecttypekey,
			routeddescription,
			insertedon,
			updatedon
  )
  VALUES('SCDR',
		  userid_v,
		  caseworkerid_v,
		  teamid_v,
		  'CWSP',
		  'CWCW',
		  servicecasedispositionid_v::character varying,
		  16,
		  userid_v,
		  userid_v,
		  'servicecase',
		  'Disposition Auto Approved',
		  now(),
		  now()
  );


  -- Step 5 - Reopen program assignment and GAP Subsidy
  IF(reopenreasonkey_v = 'RSIE') THEN
	OPEN cur_program_assignment_refcur FOR
		select distinct personid, 
			'OOH' as pa_type
		from intakeservreqchildremoval i
			inner join routing r on r.objectid = i.intakeservreqchildremovalid::character varying  
		where i.servicecaseid = servicecaseid_v
			and i.exitdate is null
			and r.activeflag = 1 
			and r.routingstatustypeid = 16
		union all
		select distinct i.personid,
			'GAP' as pa_type
		from gapagreement ga
			inner join guardianship g on g.gapid = ga.gapid 
				and g.servicecaseid = servicecaseid_v 
				and ga.activeflag = 1
			inner join permanencyplan p on p.permanencyplanid = g.permanencyplanid 
				and g.activeflag = 1
			inner join intakeservicerequestactor i 
				on i.intakeservicerequestactorid = p.intakeservicerequestactorid 
					and i.activeflag = 1
		where date(ga.enddate) >= date(now())
		;
	LOOP
		fetch cur_program_assignment_refcur into cur_program_assignment;
		exit when not found;

		v_personid := cur_program_assignment.personid;
		v_pa_type := cur_program_assignment.pa_type;
		
		IF v_pa_type = 'OOH' THEN
			update personprogramarea pa1
			set enddate = NULL,
				updatedby = userid_v,
				updatedon = now()
			where pa1.personprogramid
				in ( select pa.personprogramid
						from personprogramarea pa
					 where pa.objectid = servicecaseid_v::character varying
					 	and pa.personid = v_personid
						and pa.activeflag = 1
						and pa.programkey = 'OOH'
					 order by startdate desc
					 limit 1 	  
					) ;
			
		ELSEIF v_pa_type = 'GAP' THEN
			update personprogramarea pa1
			set enddate = NULL,
				updatedby = userid_v,
				updatedon = now()
			where pa1.personprogramid
				in ( select pa.personprogramid
						from personprogramarea pa
					 where pa.objectid = servicecaseid_v::character varying
					 	and pa.personid = v_personid
						and pa.activeflag = 1
						and pa.programkey = 'GAP'
					 order by startdate desc
					 limit 1 	  
					) ;
		END IF;
			
	END LOOP;
	CLOSE cur_program_assignment_refcur;

	

  END IF;


  RETURN QUERY SELECT 'Service case reopened successfully'::character varying, true;

  -- Handling exceptions
  EXCEPTION WHEN OTHERS THEN
  BEGIN
  RAISE NOTICE 'Internal error: %', sqlerrm;
  RETURN QUERY SELECT 'Unable to process reopen service case. Please try again later.'::character varying, false;  
  END;

END;
$function$ ;