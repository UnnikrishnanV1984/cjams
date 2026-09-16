DROP FUNCTION IF EXISTS cjams.createservicecase(uuid, character varying, integer, character varying, character varying, character varying,character varying);
CREATE OR REPLACE FUNCTION cjams.createservicecase(v_intakeserviceid uuid, v_servicecaseid character varying, isnewcase integer, v_userid character varying, v_personprogramids uuid[], v_subtypekey character varying DEFAULT ''::character varying, v_source character varying DEFAULT ''::character varying, v_overriderequest boolean DEFAULT false)
 RETURNS TABLE(servicecaseno character varying, caseid uuid, message character varying, progrmkey character varying, subprogrmkey character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 02/15/2024 Vineet Tirodkar - To update updatedon audit column in personrole & other tables (CIDM-4704)
-- 07/22/2024 Manasa Kasula - To add other role for service case if no role other than AM
-- 10/08/2024 - Manasa Kasula - CIDM-9543- On opening an existing service case, new default admin assignment shouldn't be added and Caseworker/Supervisor assignments changes
-- 05/19/2025 Sandeep Kiran Anugolu - To Update program assignment case id for kinship when connecting to an existing service case 
-- 7/23/2025 Smita Somasekharan -CIDM-10607 -To update reporteddate and start time after Servicecase creation in override screen in scenario .
--08/01/2025- Triveni Bala- CIDM-10625 - Plan of selfcare user story changes
------------------------------------------------------------------------------------------------------------	

DECLARE l_personid uuid;
	l_personname character varying(100);
	l_servicecaseid uuid;
	l_servicecasenumber character varying(20) ;
	l_response text;
	l_supervisor character varying(100);
	l_servreqtypeid uuid;
	l_servreqsubtypeid uuid;
	l_status character varying;
	l_programkey character varying;
	l_subprogramkey character varying;
	l_ihsprogramkey character varying;
	l_ihssubprogramkey character varying;
	l_crpersonid uuid;
	l_dispositionstatus character varying;
	v_collateralmsg CHARACTER VARYING;
	v_intakenumber character varying;
	l_documentpropertiesid uuid;
	currentRow record;
	l_servicecasedispositionid uuid;
	l_record RECORD;
	l_action_type character varying;
	l_isfinalscreenin boolean;
	l_isIr boolean;
	l_isAr boolean;
	l_fromteamid uuid;
	l_fromldssid uuid;
	v_actorid uuid;
	v_personroleid uuid;
	actorrec record;
	personrolerec record;
	v_amPersonid uuid;
	v_notamrolecount int;   
	v_startdate timestamp;

BEGIN

     IF (COALESCE(v_subtypekey,'') ='') THEN 
		v_subtypekey:='default';
     END IF;
     IF (COALESCE(lower(v_source),'') in ('intake','cps')) THEN 
		l_status:='OPEN';
     END IF;
 
	CREATE TEMP TABLE IF NOT EXISTS
	Temp_insert_person_program_area (
	personprogramid uuid
	);

 	/*DA Type and Sub type taken for Servicecase */
     SELECT  intakeservreqtypeid INTO l_servreqtypeid  FROM intakeservicerequesttype WHERE LOWER(intakeservreqtypekey) ='servicecase' AND activeflag =1 LIMIT 1;  
	 SELECT  servicerequestsubtypeid INTO l_servreqsubtypeid FROM servicerequestsubtype  WHERE LOWER(classkey) =LOWER(v_subtypekey) AND activeflag =1 AND intakeservreqtypeid = l_servreqtypeid LIMIT 1;
	 SELECT programkey, subprogramkey into l_programkey, l_subprogramkey from personprogramarea WHERE objectid = v_intakeserviceid::varchar and activeflag = 1 and programkey = 'KIN' LIMIT 1;
	  	
	IF (l_programkey is null) then
		/*Get Program area and Sub program Area*/
		SELECT programkey, subprogramkey INTO l_programkey, l_subprogramkey FROM programareaconfig WHERE LOWER(servicerequestsubtypekey) = LOWER(v_subtypekey) AND isdefault =1 ;
	END IF;
	
     /*Get InHome service Program area and Sub program Area*/
	IF (v_subtypekey='ohm') THEN
        SELECT ISRA.personid INTO l_crpersonid 
        FROM Intakeservreqchildremoval cr INNER JOIN intakeservicerequestactor ISRA ON ISRA.intakeservicerequestactorID = CR.intakeservicerequestactorid AND ISRA.activeflag =1 
        WHERE cr.activeflag =1 AND CR.intakeserviceid =   v_intakeserviceid LIMIT 1;

        SELECT programkey, subprogramkey INTO l_ihsprogramkey, l_ihssubprogramkey FROM programareaconfig WHERE LOWER(servicerequestsubtypekey) =   'ihm'  AND isdefault =1 ;
	ELSE 
		SELECT l_programkey, l_subprogramkey INTO l_ihsprogramkey, l_ihssubprogramkey;
    END IF;
	

    IF (isnewcase=1) THEN  
		SELECT fromsecurityusersid::CHARACTER VARYING  INTO l_supervisor 
		FROM routing  r
		WHERE eventcode ='INVT' AND r.routingstatustypeid = 4
		AND r.objectid = v_intakeserviceid::character varying AND r.activeflag =1
		ORDER BY insertedon DESC LIMIT 1;

		IF v_overriderequest THEN 
		select reporteddate into v_startdate from intakeservicerequest 
		where intakeserviceid =v_intakeserviceid and activeflag =1 order by updatedon desc limit 1;
	    ELSE
		v_startdate := now();
		END IF;
        INSERT INTO servicecase 
                    (caseheadname, 
                     caseheadid, 
                     startdate, 
                     statustypekey, 
                     insertedby, 
					 insertedon,
					 updatedon,					 
                     updatedby, 
                     intakeservreqtypeid) 
        VALUES     (l_personname, 
                    l_personid, 
					v_startdate,
                    l_status, 
                    v_userid, 
					v_startdate,
					now(),
                    v_userid, 
                    l_servreqtypeid) 
        returning "servicecaseid"  INTO l_servicecaseid; 
        SELECT servicecasenumber INTO l_servicecasenumber FROM servicecase WHERE servicecaseid =l_servicecaseid;

		/*Request info added */
        INSERT INTO servicecaserequest 
                    (servicecaseid, 
                     intakeservreqtypeid, 
                     servicerequestsubtypeid, 
                     programkey, 
                     subprogramkey, 
                     insertedby, 
					 insertedon,
					 updatedon,						 
                     updatedby) 
        VALUES (l_servicecaseid, 
                     l_servreqtypeid, 
                     l_servreqsubtypeid, 
                     l_programkey, 
                     l_subprogramkey, 
                     v_userid, 
					 now(),	
					 now(),					 
                     v_userid);            
     	
        /*Map person into  Service case*/
        -- UPDATE actor SET servicecaseid = l_servicecaseid, updatedby = v_userid, updatedon = now()
		-- WHERE intakeserviceid = v_intakeserviceid AND activeflag =1 ; 
		For actorrec in select actorid from actor where intakeserviceid = v_intakeserviceid and activeflag = 1 loop 
			v_actorid := null;
			INSERT INTO actor
			(actorid, activeflag, personid, actortype,insertedby, insertedon, updatedby, updatedon, "timestamp", medicaideligibility, blockgranteligibility, recipientstatus, manualupdateflag, servicecaseid, iscollateralcontact, ismentalillness,mentalillnessdetail, ismentalimpair,mentalimpairdetail, ishouseholdmember, isdangertoworker,dangertoworkerreason, sexoffenderregisteredflag, probationsearchconductedflag, drugexposednewbornflag, otherdrugs, personroletypeid, drugexposedkey)
			select gen_random_uuid(), 1, personid, actortype, v_userid, now(), v_userid, now(),null, medicaideligibility, blockgranteligibility, recipientstatus, manualupdateflag, l_servicecaseid, iscollateralcontact, ismentalillness, mentalillnessdetail, ismentalimpair,mentalimpairdetail, ishouseholdmember, isdangertoworker,dangertoworkerreason, sexoffenderregisteredflag, probationsearchconductedflag, drugexposednewbornflag, otherdrugs, personroletypeid, drugexposedkey
			from actor where intakeserviceid = v_intakeserviceid and activeflag = 1 and actorid = actorrec.actorid returning actorid into v_actorid;

			INSERT INTO intakeservicerequestactor
			(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid,
			reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
			sexoffenderregisteredflag, probationsearchconductedflag,intakenumber,servicecaseid, fetalalcoholspctrmdisordflag,isheadofhousehold)
			select gen_random_uuid(), v_actorid, intakeservicerequestpersontypekey, now(),v_userid, now(), v_userid, null,
			reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
			sexoffenderregisteredflag, probationsearchconductedflag,null, l_servicecaseid , fetalalcoholspctrmdisordflag, isheadofhousehold
			from intakeservicerequestactor where intakeserviceid = v_intakeserviceid and actorid = actorrec.actorid and activeflag = 1;

		END LOOP;

		select personid into v_amPersonid from intakeservicerequestactor isra1 where isra1.servicecaseid = l_servicecaseid and isra1.activeflag = 1 and isra1.intakeservicerequestpersontypekey = 'AM';
		IF(v_amPersonid is not null) then 
			select count(*) into v_notamrolecount from intakeservicerequestactor isra where isra.servicecaseid = l_servicecaseid and isra.activeflag = 1 and isra.intakeservicerequestpersontypekey != 'AM' and isra.personid = v_amPersonid;
			IF(v_notamrolecount = 0) THEN
				INSERT INTO intakeservicerequestactor
				(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid,
				reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
				sexoffenderregisteredflag, probationsearchconductedflag,intakenumber,servicecaseid, fetalalcoholspctrmdisordflag,isheadofhousehold)
				select gen_random_uuid(), actorid, 'OTH', now(),v_userid, now(), v_userid, null,
				reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
				sexoffenderregisteredflag, probationsearchconductedflag,null, l_servicecaseid , fetalalcoholspctrmdisordflag, isheadofhousehold
				from intakeservicerequestactor where servicecaseid = l_servicecaseid and personid = v_amPersonid and activeflag = 1;
			End IF;
		End IF;
		
		For actorrec in select actorid from actor where intakeserviceid = v_intakeserviceid and activeflag = 1 loop 
	
			INSERT INTO cjams.actorrelationship
			(actorrelationshipid, relationshiptypekey, insertedby, insertedon, updatedby, updatedon, effectivedate, activeflag, intakeservicerequestactorid, client1id, client2id, person1id, person2id, servicecaseid, intakeserviceid, intakenumber)
			select gen_random_uuid(), relationshiptypekey, v_userid, now(), v_userid, now(), now(),1, (select isra1.intakeservicerequestactorid from intakeservicerequestactor isra1 where isra1.activeflag = 1 and isra1.servicecaseid = l_servicecaseid and isra1.personid = ar.person1id limit 1), client1id, client2id, person1id, person2id, l_servicecaseid, null, null
			from actorrelationship ar where ar.intakeservicerequestactorid in (select isra.intakeservicerequestactorid from intakeservicerequestactor isra where isra.intakeserviceid=v_intakeserviceid and actorid = actorrec.actorid and isra.activeflag = 1) and ar.activeflag = 1;

		END LOOP;
		For personrolerec in select personroleid from personrole where intakeserviceid = v_intakeserviceid and activeflag = 1 loop 
			v_personroleid := null;
			INSERT INTO personrole ( personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
			otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker,insertedon, insertedby,
			dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, updatedby, updatedon,servicecaseid,initialresponse,initialresponseupdatedby,initialresponseupdatedon)
			select gen_random_uuid(),1,personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
			otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker,now(), v_userid,
			dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, v_userid, now(), l_servicecaseid, initialresponse,initialresponseupdatedby,initialresponseupdatedon
			from personrole where intakeserviceid = v_intakeserviceid and personroleid = personrolerec.personroleid and activeflag = 1 returning personroleid into v_personroleid;

			INSERT INTO personroletype (personroletypeid, activeflag, personroleid, roletype, updatedby, updatedon, isprimary, insertedon, insertedby)
			select gen_random_uuid(), 1, v_personroleid, roletype, v_userid, now(), isprimary, now(), v_userid
			from personroletype where activeflag =1 and personroleid = (select personroleid from personrole where intakeserviceid = v_intakeserviceid and activeflag = 1 order by insertedon desc limit 1);

		End loop;
	
		IF(v_amPersonid is not null and (v_notamrolecount = 0)) THEN
			v_personroleid := null;
			select personroleid into v_personroleid from personrole where servicecaseid = l_servicecaseid and personid = v_amPersonid and activeflag = 1;
		
			INSERT INTO personroletype (personroletypeid, activeflag, personroleid, roletype, updatedby, updatedon, isprimary, insertedon, insertedby)
			select gen_random_uuid(), 1, v_personroleid, 'OTH', v_userid, now(), 0, now(), v_userid;

		End IF;
		-- UPDATE intakeservicerequestactor SET servicecaseid = l_servicecaseid, updatedby = v_userid, updatedon = now() 
        -- WHERE intakeserviceid = v_intakeserviceid 
		-- AND actorid IN (SELECT actorid FROM actor  WHERE intakeserviceid = v_intakeserviceid ); 
		
		-- UPDATE personrole SET servicecaseid = l_servicecaseid, updatedby = v_userid, updatedon = now()
		-- WHERE intakeserviceid = v_intakeserviceid AND activeflag =1 ;
		
		SELECT routingintake INTO l_response 
        FROM routingintake(l_servicecaseid:: character varying ,v_userid,'SRVC',2,'Servicecase Created',v_userid, true,false,false, 
		'Servicecase Created','Servicecase Created', l_servicecaseid:: character varying,'' , 1);
	
    	SELECT createfcchecklist INTO   l_response 
        FROM   Createfcchecklist(l_servicecaseid, l_servreqtypeid, l_servreqsubtypeid, v_userid , 'CW'); 
       
		SELECT intakenumber into v_intakenumber from intakeservicerequest where intakeserviceid = v_intakeserviceid :: uuid order by insertedon desc limit 1;

		FOR  currentRow  in ( Select * FROM cjams.documentproperties where intakenumber=v_intakenumber and activeflag in (1,3))
		LOOP 
			INSERT INTO cjams.documentproperties
			( objecttypekey, objectid, documenttypekey, documentdate, clientid, actualdocumentdate,
			thirdpartysourceid, filename, tag, title, description,other, mime, meta, "encoding", numberofbytes, updatedby, updatedon,
			insertedby, insertedon, activeflag, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid, 
			rootobjectid, rootobjecttypekey, s3bucketpathname, originalfilename, ecmsdocumentid, servicecaseid)
			SELECT  'Servicecase', objectid, documenttypekey, documentdate, clientid, actualdocumentdate,
			thirdpartysourceid, filename, tag, title, description, other, mime, meta, "encoding", numberofbytes, updatedby, now(),
			insertedby, now(), 1, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid,
			rootobjectid, rootobjecttypekey, s3bucketpathname, originalfilename, ecmsdocumentid, l_servicecaseid
			FROM cjams.documentproperties where documentpropertiesid=currentRow.documentpropertiesid and activeflag in (1,3) returning "documentpropertiesid"  INTO l_documentpropertiesid; 

			INSERT INTO cjams.documentattachment
			( documentpropertiesid, attachmenttypekey, attachmentclassificationtypekey,
			attachmentid, attachmentdate, sourceauthor, sourceposition, sourcephonenumber, sourceaddress, 
			attachmentsubject, attachmentpurpose, acquisitionmethod, locationoforiginal, note, updatedby, 
			updatedon, insertedby, insertedon, activeflag, expirationdate, old_id, "timestamp", assessmenttemplateid, 
			attachmentclassificationsubtypekey)
			SELECT  l_documentpropertiesid, attachmenttypekey, attachmentclassificationtypekey,
			attachmentid, attachmentdate, sourceauthor, sourceposition, sourcephonenumber, sourceaddress,
			attachmentsubject, attachmentpurpose, acquisitionmethod, locationoforiginal, note, updatedby,
			now(), insertedby, now(), 1, expirationdate, old_id, "timestamp", assessmenttemplateid, 
			attachmentclassificationsubtypekey
			FROM cjams.documentattachment where documentpropertiesid = currentRow.documentpropertiesid;
		END  LOOP; 

		INSERT INTO servicecasedisposition
		(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
		VALUES(l_servicecaseid, now(), 'Open', 'Inprogress','Case Accepted', now(), 1, v_userid,now(),v_userid,now())
		RETURNING servicecasedispositionid into l_servicecasedispositionid;

		INSERT INTO routing(routingstatustypeid, objectid, eventcode, fromsecurityusersid, activeflag, insertedby, insertedon, updatedby, updatedon)
		VALUES(16,l_servicecasedispositionid,'SCDR',v_userid, 1, v_userid, now(), v_userid, now());
      
	  	-- Update progamassigment for kinship
		if(v_personprogramids IS NOT NULL) then
			update personprogramarea
			set objectid = l_servicecaseid,
			entityid = l_servicecasenumber,
			updatedby=v_userid,
			updatedon=now()
			where personprogramid = ANY(v_personprogramids ::uuid[]) and objectid= v_intakeserviceid::character varying and programkey='KIN';
		end if;
		
 	ELSE 
	
		l_servicecaseid =v_servicecaseid::uuid;

		SELECT   tm.teamid, t.countyid  INTO  l_fromteamid, l_fromldssid
        FROM    teammemberassignment tma 
        INNER JOIN  teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
        INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
        WHERE  tma.SecurityUsersId = v_userid
        AND   tma.activeflag =1;

		SELECT servicecasenumber INTO l_servicecasenumber FROM servicecase WHERE servicecaseid =l_servicecaseid;
		SELECT intakeserreqstatustypekey INTO l_dispositionstatus FROM servicecasedisposition WHERE servicecaseid =l_servicecaseid ORDER BY statusdate DESC, insertedon DESC LIMIT 1;
		/*Map person into Existing Service case*/
		For actorrec in select actorid, personid from actor where intakeserviceid = v_intakeserviceid and activeflag = 1 loop 
			v_actorid := null;
			select actorid into v_actorid from actor where personid = actorrec.personid and activeflag = 1 and servicecaseid = v_servicecaseid::uuid;
			IF(v_actorid is null) then 
				INSERT INTO actor
				(actorid, activeflag, personid, actortype,insertedby, insertedon, updatedby, updatedon, "timestamp", medicaideligibility, blockgranteligibility, recipientstatus, manualupdateflag, servicecaseid, iscollateralcontact, ismentalillness,mentalillnessdetail, ismentalimpair,mentalimpairdetail, ishouseholdmember, isdangertoworker,dangertoworkerreason, sexoffenderregisteredflag, probationsearchconductedflag, drugexposednewbornflag, otherdrugs, personroletypeid, drugexposedkey)
				select gen_random_uuid(), 1, personid, actortype, v_userid, now(), v_userid, now(),null, medicaideligibility, blockgranteligibility, recipientstatus, manualupdateflag, l_servicecaseid, iscollateralcontact, ismentalillness, mentalillnessdetail, ismentalimpair,mentalimpairdetail, ishouseholdmember, isdangertoworker,dangertoworkerreason, sexoffenderregisteredflag, probationsearchconductedflag, drugexposednewbornflag, otherdrugs, personroletypeid, drugexposedkey
				from actor where intakeserviceid = v_intakeserviceid and activeflag = 1 and actorid = actorrec.actorid  returning actorid into v_actorid;
			End IF;

			INSERT INTO intakeservicerequestactor
			(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid,
			reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
			sexoffenderregisteredflag, probationsearchconductedflag,intakenumber,servicecaseid, fetalalcoholspctrmdisordflag,isheadofhousehold)
			select gen_random_uuid(), v_actorid, intakeservicerequestpersontypekey, now(),v_userid, now(), v_userid, null,
			reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
			sexoffenderregisteredflag, probationsearchconductedflag,null, l_servicecaseid , fetalalcoholspctrmdisordflag, isheadofhousehold
			from intakeservicerequestactor where intakeserviceid = v_intakeserviceid and actorid = actorrec.actorid 
			AND personid NOT IN ( SELECT personid FROM intakeservicerequestactor WHERE servicecaseid = l_servicecaseid AND activeflag =1);

		End Loop;

		select personid into v_amPersonid from intakeservicerequestactor isra1 where isra1.servicecaseid = l_servicecaseid and isra1.activeflag = 1 and isra1.intakeservicerequestpersontypekey = 'AM';
		IF(v_amPersonid is not null) then 
			select count(*) into v_notamrolecount from intakeservicerequestactor isra where isra.servicecaseid = l_servicecaseid and isra.activeflag = 1 and isra.intakeservicerequestpersontypekey != 'AM' and isra.personid = v_amPersonid;

			IF(v_notamrolecount = 0) THEN
				INSERT INTO intakeservicerequestactor
				(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid,
				reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
				sexoffenderregisteredflag, probationsearchconductedflag,intakenumber,servicecaseid, fetalalcoholspctrmdisordflag,isheadofhousehold)
				select gen_random_uuid(), actorid, 'OTH', now(),v_userid, now(), v_userid, null,
				reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
				sexoffenderregisteredflag, probationsearchconductedflag,null, l_servicecaseid , fetalalcoholspctrmdisordflag, isheadofhousehold
				from intakeservicerequestactor where servicecaseid = l_servicecaseid and personid = v_amPersonid and activeflag = 1;
			End IF;
		End IF;

		For actorrec in select actorid from actor where intakeserviceid = v_intakeserviceid and activeflag = 1 loop 
	
			INSERT INTO cjams.actorrelationship
			(actorrelationshipid, relationshiptypekey, insertedby, insertedon, updatedby, updatedon, effectivedate, activeflag, intakeservicerequestactorid, client1id, client2id, person1id, person2id, servicecaseid, intakeserviceid, intakenumber)
			select gen_random_uuid(), relationshiptypekey, v_userid, now(), v_userid, now(), now(),1, (select isra1.intakeservicerequestactorid from intakeservicerequestactor isra1 where isra1.activeflag = 1 and isra1.servicecaseid = l_servicecaseid and isra1.personid = ar.person1id limit 1), client1id, client2id, person1id, person2id, l_servicecaseid, null, null
			from actorrelationship ar where ar.intakeservicerequestactorid in (select isra.intakeservicerequestactorid from intakeservicerequestactor isra where isra.intakeserviceid=v_intakeserviceid and actorid = actorrec.actorid and isra.activeflag = 1) and ar.activeflag = 1;

		END LOOP;

		For personrolerec in select personroleid, personid from personrole where intakeserviceid = v_intakeserviceid and activeflag = 1 loop 
			v_personroleid := null;
			select personroleid into v_personroleid from personrole where personid = personrolerec.personid and activeflag = 1 and servicecaseid = v_servicecaseid::uuid;
			IF(v_personroleid is null) then 
				INSERT INTO personrole ( personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
				otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, insertedon, insertedby,
				dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, updatedby, updatedon,servicecaseid,initialresponse,initialresponseupdatedby,initialresponseupdatedon)
				select gen_random_uuid(),1,personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
				otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, now(), v_userid,
				dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, v_userid, now(), l_servicecaseid, initialresponse,initialresponseupdatedby,initialresponseupdatedon
				from personrole where intakeserviceid = v_intakeserviceid and activeflag = 1 and personroleid = personrolerec.personroleid  returning personroleid into v_personroleid;
			END IF;

			INSERT INTO personroletype (personroletypeid, activeflag, personroleid, roletype, updatedby, updatedon, isprimary, insertedon, insertedby)
			select gen_random_uuid(), 1, v_personroleid, roletype, v_userid, now(), isprimary, now(), v_userid
			from personroletype where activeflag =1 and personroleid = (select personroleid from personrole where intakeserviceid = v_intakeserviceid and personroleid = personrolerec.personroleid and activeflag = 1 order by insertedon desc limit 1);
		End Loop;

		IF(v_amPersonid is not null and (v_notamrolecount = 0)) THEN
			v_personroleid := null;
			select personroleid into v_personroleid from personrole where servicecaseid = l_servicecaseid and personid = v_amPersonid and activeflag = 1;
		
			INSERT INTO personroletype (personroletypeid, activeflag, personroleid, roletype, updatedby, updatedon, isprimary, insertedon, insertedby)
			select gen_random_uuid(), 1, v_personroleid, 'OTH', v_userid, now(), 0, now(), v_userid;

		End IF;

		-- UPDATE intakeservicerequestactor
		-- SET servicecaseid = l_servicecaseid ,
		-- updatedby = v_userid,
		-- updatedon = now()
		-- WHERE intakeserviceid = v_intakeserviceid 
		-- AND actorid IN (SELECT actorid FROM actor  WHERE intakeserviceid = v_intakeserviceid )-- AND ishouseholdmember =1
		-- AND personid NOT IN ( SELECT personid FROM intakeservicerequestactor WHERE  servicecaseid = l_servicecaseid AND activeflag =1 );

		-- UPDATE actor set servicecaseid = l_servicecaseid,updatedby = v_userid,updatedon = now()  
		-- FROM intakeservicerequestactor ISR 
		-- WHERE ISR.actorid = actor.actorid AND ISR.servicecaseid =l_servicecaseid AND actor.servicecaseid IS  NULL; 
		-- /*case reopened where case is closed*/

		-- UPDATE personrole SET servicecaseid = l_servicecaseid, updatedby = v_userid, updatedon = now() WHERE intakeserviceid = v_intakeserviceid AND activeflag =1 ;

		SELECT intakenumber into v_intakenumber from intakeservicerequest where intakeserviceid = v_intakeserviceid :: uuid order by insertedon desc limit 1;

		UPDATE cjams.documentproperties SET objecttypekey = 'Servicecase',updatedby = v_userid, updatedon = now(), servicecaseid = l_servicecaseid
		where documentpropertiesid in ( Select  documentpropertiesid   FROM cjams.documentproperties where intakenumber=v_intakenumber );
		
		-- Update progamassigment for kinship
		if(v_personprogramids IS NOT NULL) then
			update personprogramarea
			set objectid = l_servicecaseid,
			entityid = l_servicecasenumber,
			updatedby=v_userid,
			updatedon=now()
			where personprogramid = ANY(v_personprogramids ::uuid[]) and objectid= v_intakeserviceid::character varying and programkey='KIN';
		end if;

		IF (LOWER(l_dispositionstatus) IN ('completed','closed')) THEN 
			/*D-20943&D-20942 - UPDATE CASE REOPEN DATE IN STARTDATE */
			UPDATE servicecase SET statustypekey ='OPEN', dispositioncode = NULL, updatedby = v_userid,updatedon = now(), enddate = null, startdate =now() WHERE servicecaseid = l_servicecaseid  ;

			INSERT INTO servicecasedisposition
			(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
			VALUES(l_servicecaseid, now(), 'Open', 'Inprogress','Case Reopened', now(), 1, v_userid,now(),v_userid,now());

			SELECT routingintake INTO l_response 
			FROM routingintake(l_servicecaseid:: character varying ,v_userid,'SRVC',2,'Servicecase Re-opened',v_userid,
			true,false,false, 'Servicecase Re-opened','Servicecase Re-opened', l_servicecaseid:: character varying,'' , 1);
			
		-- Else 
			
		-- 	INSERT INTO caseassignment
		-- 	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,responsibilitytypekey,fromteamid,toteamid,fromldssid,toldssid,assignmenttype,assigndate)
		-- 	VALUES(v_userid,v_userid,v_userid,v_userid,now(),now(),now(),'servicecase',l_servicecaseid,'administrative',l_fromteamid,l_fromteamid,l_fromldssid,l_fromldssid,'W',now()::date);
	
		END IF;

		/*Request info added */
		IF NOT EXISTS (
			SELECT 1 FROM servicecaserequest 
			WHERE servicecaseid = l_servicecaseid 
			AND intakeservreqtypeid= l_servreqtypeid 
			AND servicerequestsubtypeid= l_servreqsubtypeid
		) THEN
			INSERT INTO servicecaserequest 
			(servicecaseid, 
			intakeservreqtypeid, 
			servicerequestsubtypeid, 
			programkey, 
			subprogramkey, 
			insertedby, 
			updatedby,
			insertedon,
			updatedon) 
			VALUES (l_servicecaseid, 
			l_servreqtypeid, 
			l_servreqsubtypeid, 
			l_programkey, 
			l_subprogramkey, 
			v_userid, 
			v_userid,
			now(),
			now()); 

			SELECT createfcchecklist INTO l_response FROM createfcchecklist(l_servicecaseid,l_servreqtypeid,l_servreqsubtypeid,v_userid, 'CW');
    	END IF; 
		
	END IF; 

   /*Insert program Area and Sub programarea
     # INSERT PROGRAM ASSIGNMENT FOR CHILD REMOVAL WITH ACTIVEFLAG=2 TO AVOID SHOWING IN PERSON CARD
   	 # ON SUPERVISOR APPROVAL UPDATE THE ACTIVEFLAG = 1
   */
	IF (LOWER(l_programkey) = 'ooh') THEN 
		WITH temp_ids AS (INSERT INTO personprogramarea (
			personid, 
			programkey, 
			subprogramkey, 
			objecttypekey, 
			objectid, 
			startdate, 
			insertedby, 
			updatedby,
			entityid, datatransferflag,
			activeflag,
			sourcetype
		) SELECT 
			personid, 
			l_programkey, 
			l_subprogramkey, 
			'servicecase', 
			l_servicecaseid, 
			Now() :: DATE, 
			v_userid, 
			v_userid,
			l_servicecasenumber, 'A',
			CASE LOWER(l_programkey) WHEN 'ooh' THEN 2 ELSE 1 END,
			'CW'
		FROM actor 
		WHERE intakeserviceid = v_intakeserviceid AND activeflag = 1 AND personid :: CHARACTER VARYING   IN (COALESCE(l_crpersonid :: CHARACTER VARYING,''))
		RETURNING personprogramid)
		INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;

		FOR l_record IN (select * from Temp_insert_person_program_area)
		LOOP
			INSERT INTO auditlog(referenceid, logtypekey, description, metadata, insertedon, insertedby)
			VALUES(l_record.personprogramid,'PRGMAREA','systemupdate06',
						(SELECT row_to_json(personprogramarea) FROM personprogramarea WHERE personprogramid = l_record.personprogramid), now(), v_userid);
		END LOOP;

		DROP TABLE Temp_insert_person_program_area;
		 
	END IF;
	
	/*Map Existing Transaction to  Servicecase*/      
	UPDATE intakeservicerequest SET servicecaseid = l_servicecaseid, updatedby = v_userid, updatedon = now() 
	WHERE intakeserviceid = v_intakeserviceid;
	
	UPDATE intakeservreqchildremoval SET servicecaseid = l_servicecaseid, updatedby = v_userid, updatedon = now()  
	WHERE intakeserviceid = v_intakeserviceid;
	
	UPDATE assessment SET servicecaseid = l_servicecaseid, updatedby = v_userid, updatedon = now() 
	WHERE objectid = v_intakeserviceid  ;
	
	SELECT actiontype,COALESCE(sdm.isfinalscreenin,false), COALESCE(sdm.isAr,false), COALESCE(sdm.isIr,false) INTO l_action_type,l_isfinalscreenin,l_isAr,l_isIr FROM intakeservicerequest ir
    LEFT OUTER JOIN intakeservicerequestsdm sdm ON sdm.intakeserviceid = ir.intakeserviceid
    WHERE ir.intakeserviceid = v_intakeserviceid;
	
	IF ( (l_action_type IS NULL OR l_action_type = '' OR v_subtypekey = 'IHM') AND (l_isfinalscreenin = false or (l_isAr = false and l_isIr = false)) ) THEN 
	   UPDATE intakeservicerequest SET activeflag=0, updatedby = v_userid, updatedon = now() 
	   WHERE intakeserviceid = v_intakeserviceid;
	END IF;

/*           
	UPDATE personprogramarea SET enddate=now()::date, datatransferflag='U', updatedon = now(), updatedby =v_userid 
	WHERE objectid in (Select intakeserviceid:: character varying from intakeservicerequest 
	WHERE servicecaseid =l_servicecaseid and activeflag =1 )
	AND enddate IS NULL AND programkey NOT IN ('CPS');
*/	  	  
	-- Add collaterals to case on approval
	select * from addcollateralsfromintaketocase(v_intakeserviceid::CHARACTER VARYING, l_servicecaseid::CHARACTER VARYING, v_userid) INTO v_collateralmsg;

 update personprogramarea
  set objectid = l_servicecaseid,
	entityid = l_servicecasenumber,
	updatedby=v_userid,
	updatedon=now()
  where objectid= v_intakeserviceid::character varying
  and programkey='IHSFP'
  and subprogramkey = 'SFCI';
 
with personids as (
	select
		distinct D.personid
	from intakeservicerequest as A
	inner join intakeservicerequestactor as B on A.intakeserviceid = B.intakeserviceid and B.activeflag = 1
	inner join actor as C on C.ActorId = B.ActorId and C.activeflag = 1
	inner join person as D on C.personid = D.personid and D.senstatusflag  = 1 and D.activeflag = 1
	where A.intakeserviceid = v_intakeserviceid
	AND A.activeflag = 1
)
INSERT INTO personprogramarea (
			personid, 
			programkey, 
			subprogramkey, 
			objecttypekey, 
			objectid, 
			startdate, 
			insertedby, 
			updatedby,
			entityid,
			datatransferflag,
			activeflag,
			sourcetype,
			isdefault,
      insertedon,
      updatedon
		) SELECT 
			personid, 
			'IHSFP', 
			'SFCI',
			'servicecase',
			l_servicecaseid::character varying,
			Now() :: DATE, 
			v_userid, 
			v_userid,
			l_servicecasenumber,
			'A',
			1,
			'CW',
			true,
      Now(),
      Now()
		from personids p
		where not exists (select 1 from personprogramarea pa
		where pa.personid = p.personid and programkey='IHSFP'
  		and subprogramkey = 'SFCI' );
	   
 RETURN QUERY SELECT l_servicecasenumber, l_servicecaseid,'Success':: character varying, l_ihsprogramkey, l_ihssubprogramkey;
 
 END;

$function$;
