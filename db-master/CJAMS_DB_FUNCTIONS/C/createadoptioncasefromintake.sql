DROP FUNCTION cjams.createadoptioncasefromintake(v_intakenumber character varying, v_intakeserviceid character varying, v_userid character varying);
CREATE OR REPLACE FUNCTION cjams.createadoptioncasefromintake(v_intakenumber character varying, v_intakeserviceid character varying, v_userid character varying)
 RETURNS TABLE(adoptioncasenumber character varying, caseid uuid, personid uuid, message character varying)
 LANGUAGE plpgsql
AS $function$


	DECLARE 
	l_adoptioncaseid uuid;
	l_adoptioncasenumber CHARACTER VARYING;
	l_personid uuid;
	l_programkey  CHARACTER VARYING;
	l_subprogramkey  CHARACTER VARYING;
	l_finaldate date;
	v_roletypkey character varying;
	v_teamid uuid;
    l_ppareferenceid uuid;
      
    BEGIN
		
	/*Get Program area for adoption from configuration */
    --SELECT programkey, subprogramkey INTO l_programkey, l_subprogramkey FROM programareaconfig WHERE LOWER(servicerequestsubtypekey) = 'adoption' AND isdefault =1 limit 1;
	
              
      --Start Adoption case changes
      --Create Adoption case and update adoptioncase id in adoptionagreement, get rid of adoptionplanning from adoptioncase table
		INSERT INTO adoptioncase 
			(startdate,enddate,statustypekey,insertedon, insertedby, updatedon, updatedby)
		VALUES
	       	(now(), now(), 'TBA', now(), v_userid, now(), v_userid )
		RETURNING    adoptioncase.adoptioncaseid , adoptioncase.adoptioncasenumber  INTO l_adoptioncaseid, l_adoptioncasenumber;

     
--      INSERT INTO adoptioncaseagreement
--        (adoptioncaseid, isofferedsubsidy, offeraccepteddate, startdate, enddate, finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, alternateid, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, agreementcomments, childplacedby, childplacedfrom)
--      SELECT 
--        l_adoptioncaseid, isofferedsubsidy, offeraccepteddate, startdate, enddate, finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, alternateid, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, agreementcomments, childplacedby, childplacedfrom
--      FROM 
--        adoptionagreement
--      WHERE 
--        adoptionplanningid = v_adoptionplanningid
--      RETURNING "adoptionagreementid" INTO l_adoptioncase_adoptionagreementid;
-- 
--    
	   select isra.personid into l_personid from intakeservicerequestactor isra
	   where 
	   isra.intakeserviceid::character varying = v_intakeserviceid
	   and isra.intakeservicerequestpersontypekey = 'PVTADPCHILD'
	   and isra.activeflag = 1;
    
--		l_personid:= gen_random_uuid();
  	    --Adoption actor
		INSERT INTO cjams.adoptioncaseactor ( adoptioncaseid, personid, actortypekey,  activeflag,  insertedby, updatedby)
		    VALUES( 
		        l_adoptioncaseid,
		        l_personid, 
		        'PVTADPCHILD',
		        1, 
		        v_userid, 
		        v_userid
		    );
         
		/*Get Program area for adoption from configuration */
        SELECT programkey, subprogramkey INTO l_programkey, l_subprogramkey FROM programareaconfig WHERE LOWER(servicerequestsubtypekey) = 'adoption' AND isdefault =1 limit 1;
	
		/*Add program area*/	
		SELECT adoptiondate::date INTO l_finaldate FROM intakeservicerequestpa WHERE intakeserviceid::character varying = v_intakeserviceid ORDER BY insertedon DESC LIMIT 1;
			INSERT INTO personprogramarea 
					(personid, programkey, subprogramkey, 
					 objecttypekey, objectid, startdate,
					 insertedby, updatedby,  entityid, sourcetype) 
			VALUES( l_personid, l_programkey, l_subprogramkey, 
					'adoptioncase', l_adoptioncaseid:: character varying, COALESCE(l_finaldate,NOW()) :: DATE, 
					v_userid, v_userid,  l_adoptioncasenumber, 'CW')
			RETURNING personprogramid into l_ppareferenceid;

			IF l_ppareferenceid IS NOT NULL THEN
			INSERT INTO auditlog(referenceid, logtypekey, description, metadata, insertedon, insertedby)
			VALUES(l_ppareferenceid,'PRGMAREA','systemupdate03',
						(SELECT row_to_json(personprogramarea) FROM personprogramarea WHERE personprogramid = l_ppareferenceid), now(), v_userid);
			END IF;
			

     
-- 		SELECT routingintake INTO l_response 
--        FROM routingintake(
--            l_adoptioncaseid:: character varying ,l_supervisor,'ADPC',2,'Adoptioncase Created', v_assigntoid,
--            true,false,false, 'Adoptioncase Created','Adoptioncase Created', 
--            v_servicecaseid:: character varying,'' , 1);
--           
--           
--          

			SELECT  tm.teamid  INTO  v_teamid
			FROM    teammemberassignment tma 
			INNER JOIN  teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
			INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
			WHERE  tma.SecurityUsersId = v_userid
			AND   tma.activeflag =1;

			select role.roletypekey INTO v_roletypkey  from rolemapping rm
			join role on role.id = rm.roleid and role.activeflag = 1 
			join muser on muser.id = rm.principalid::int and muser.activeflag = 1 and rm.activeflag = 1 and rm.teamtypekey = 'CW'
			where muser.securityusersid = v_userid;

			INSERT INTO routing(
			eventcode, fromsecurityusersid, tosecurityusersid, 
			teamid, fromroleid, toroleid, objectid, 
			routingstatustypeid, insertedby, 
			updatedby, servicerequestnumber, 
			objecttypekey, routeddescription, 
			insertedon, updatedon
			) 
			VALUES 
			(
				'ADPC', v_userid, v_userid, v_teamid, 
				v_roletypkey, v_roletypkey, l_adoptioncaseid, 
				2, v_userid, v_userid, l_adoptioncasenumber, 
				'adoptioncase', 'Adoption Case Created', 
				now(), now()
			);

--    INSERT INTO cjams.tb_client_eligibility 
--            (start_dt, 
--             end_dt, 
--             eligibility_type_cd, 
--             eligibility_status_cd, 
--             client_id, 
--             removal_id, 
--             create_user_id, 
--             update_user_id, 
--             delete_sw, 
--             adoption_id, 
--             case_id, 
--             data_valid_sw, 
--             client_merge_id, 
--             guardian_subsidy_id, 
--             transactionid, 
--             create_ts, 
--             update_ts)   
--		SELECT 
--			(SELECT ag.finalizationdate::date FROM  adoptionagreement ag
--      			WHERE ag.adoptionplanningid = ac.adoptionplanningid order by ag.insertedon desc limit 1),
--			null,  
--			'2934', 
--			'2909', 
--			null, 
--			null,
--			ac.insertedby,
--			ac.updatedby, 
--			'N',
--			0,
--			(SELECT alternateid FROM  adoptionplanning ap
--      			WHERE ap.adoptionplanningid = ac.adoptionplanningid order by ap.insertedon desc limit 1), -- send alternate id of adoption planning here 
--			 null,
--			 null,
--			 null,
--			 null,
--			 now(),
--			 now()
-- 		FROM cjams.adoptioncase ac where ac.adoptioncaseid=l_adoptioncaseid and ac.activeflag=1 limit 1 ;           
           
	
--			SELECT  t.teamid  INTO  l_fromteamid 
--	        FROM    teammemberassignment tma 
--					INNER JOIN  teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
--					INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
--	        WHERE  tma.SecurityUsersId = v_userid
--	        AND   tma.activeflag =1;
--	       
--	       
--	       SELECT   toworkeridno, responsibilitytypekey, fromldssid, toldssid, toteamid 
--                    INTO l_assignedsecurity,l_responsibilitytypekey,l_fromldssid,l_toldssid,l_toteamid 
--	       FROM     caseassignment 
--           WHERE    objectid = v_servicecaseid AND objecttypekey = 'servicecase' ORDER BY insertedon DESC LIMIT 1;
-- 	
--
-- 			INSERT INTO caseassignment(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid,startdate,fromteamid,toteamid,responsibilitytypekey,fromldssid,toldssid)
--			VALUES(l_supervisor,l_assignedsecurity,'admin','admin',now(),now(),'adoptioncase',l_adoptioncaseid,now(),l_fromteamid,l_toteamid,l_responsibilitytypekey,l_fromldssid,l_toldssid);
-- 

			--Updating AdoptionCaseAgreement with details from IntakeServiceRequestPA
			INSERT INTO adoptioncaseagreement(adoptioncaseid, finalizationdate, isofferedsubsidy, issubsidypaid, ismedassist, parent1signdate,parent2signdate,ldssdate, effectivedate)
			SELECT l_adoptioncaseid, adoptiondate, adoptionofferedflag, subsidyflag, 
			(CASE WHEN paymentkeytype='Y' THEN TRUE 
			ELSE FALSE 
			END),
			fatheragreementdate, motheragreementdate, designeeagreementdate, effectivedate FROM intakeservicerequestpa WHERE intakeserviceid::character varying = v_intakeserviceid;  

 RETURN QUERY  
-- 	SELECT l_adoptioncasenumber, l_adoptioncaseid, l_personid, 'Success':: character varying;
 	SELECT l_adoptioncasenumber, l_adoptioncaseid, l_personid, 'Success':: character varying;
 
END;
 
$function$
;