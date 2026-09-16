DROP FUNCTION IF EXISTS cjams.savecontactnotes(json, character varying, json, json, json, json);
CREATE OR REPLACE FUNCTION cjams.savecontactnotes(contactnotedata json, v_progressnotereasontypekey character varying, contactparticipantjson json, progressnoterolejson json, progressnotereasonjson json, contacttrialvisitjson json)
 RETURNS TABLE(progressnoteid uuid, witsid bigint, entitytype varchar, entitytypeid varchar, intakeserviceid uuid, servicecaseid uuid, progressnotedetailid uuid, description text, activeflag integer, effectivedate character varying, updatedon timestamp)
 LANGUAGE plpgsql
AS $function$
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--Revision(s)
-- CIDM-9097 Manasa Kasula Fix to not update entity id on contact update
-- 04/13/2025 - Vinesh Puthan - CIDM-11321 Added motivational interview options to be saved as the part of contact notes.
-- CIDM-11381 Raghavendra Puli - Updating the function to capture 'Reasons for delayed data entry' and its flag.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------


DECLARE 
		v_progressnotetypeid uuid;
		v_progressnotesubtypeid uuid;
		v_title text;
		v_description text;
		v_entitytype character varying(50);
		v_entitytypeid character varying(50);
		v_pageurl text;
		v_savemode boolean;
		v_contactdate timestamp;
		v_contactname character varying(256);
		v_progressnotetypekey character varying(20);
		v_contactphone character varying(32);
		v_contactemail character varying(256);
		v_initiationindicator boolean;
		v_attemptindicator boolean;
		v_insertedby character varying(50);
		v_documentpropertiesid uuid;
		v_starttime timestamp;
		v_endtime timestamp;
		v_totaltime character varying(50);
		v_stafftypekey character varying(50);
		v_instantresults int;
		v_contactstatus boolean;
		v_drugscreen boolean;
		v_progressnotepurposetypekey  character varying(50);
		v_traveltime character varying(50);
		v_locationname character varying(50);
		v_isintake character varying(1);
		v_otherpersonname text;
		v_uploadedfile json;
		v_progressnoteid uuid;
		v_progressnotedetailid uuid; 
        v_intakeserviceid uuid;
        v_servicecaseid uuid;
        currentRow json; 
		v_progressnotecount int;
		v_issuedesc  character varying(500);
		v_safetydesc  character varying(500);
		v_services_childdesc character varying(500);
		v_services_parentdesc character varying(500);
		v_permanencystepdesc character varying(500);
		v_placementdesc character varying(500);
		v_educationdesc character varying(500);
		v_healthdesc character varying(500);
		v_socialareadesc character varying(500);
		v_financialliteracydesc character varying(500);
		v_familyplanningdesc character varying(500);
		v_skillissuedesc character varying(500);
		v_transitionplandesc character varying(500);
		v_focusperson json;
		v_updatedocumentproperties character varying;
		v_mioptions character varying(500);
		v_delayreasons character varying(1000);
		v_hasdelay boolean;
       
BEGIN

		v_progressnoteid:= contactnotedata ->> 'progressnoteid';
		v_progressnotetypeid:= contactnotedata ->> 'progressnotetypeid';
		v_progressnotesubtypeid:= contactnotedata ->> 'progressnotesubtypeid';
		v_title:= contactnotedata ->> 'titleShrink';
		v_description:= contactnotedata ->> 'description';
		v_entitytype:= contactnotedata ->> 'entitytype';
		v_entitytypeid:= contactnotedata ->> 'entitytypeid';
		v_pageurl:= contactnotedata ->> 'pageurl';
		v_savemode:= contactnotedata ->> 'savemode';
		v_contactdate:= contactnotedata ->> 'contactdate';
		v_contactname:= contactnotedata ->> 'contactname';
		v_progressnotetypekey:= contactnotedata ->> 'progressnotetypekey';
		v_contactphone:= contactnotedata ->> 'contactphone';
		v_contactemail:= contactnotedata ->> 'contactemail';
		v_initiationindicator:= contactnotedata ->> 'initiationindicator';
		v_attemptindicator:= contactnotedata ->> 'attemptindicator';
		v_insertedby:= contactnotedata ->> 'insertedby';
		v_documentpropertiesid:= contactnotedata ->> 'documentpropertiesid';
		v_starttime:= contactnotedata ->> 'starttime';
		v_endtime:= contactnotedata ->> 'endtime';
		v_totaltime:= contactnotedata ->> 'totaltime';
		v_stafftypekey:= contactnotedata ->> 'stafftypekey';
		v_instantresults:= contactnotedata ->> 'instantresults';
		v_contactstatus:= contactnotedata ->> 'contactstatus';
		v_drugscreen:= contactnotedata ->> 'drugscreen';
		v_progressnotepurposetypekey:= contactnotedata ->> 'progressnotepurposetypekey';
		v_traveltime:= contactnotedata ->> 'traveltime';
		v_locationname:= contactnotedata ->> 'locationname';
		v_isintake:= contactnotedata ->> 'isintake';
		v_otherpersonname:= contactnotedata ->> 'otherpersonname';
        v_intakeserviceid:= contactnotedata ->> 'intakeserviceid';
        v_servicecaseid:= contactnotedata ->> 'servicecaseid';
		v_issuedesc:= contacttrialvisitjson ->> 'issuedesc';
		v_safetydesc:= contacttrialvisitjson ->> 'safetydesc';
		v_services_childdesc:= contacttrialvisitjson ->> 'services_childdesc';
		v_services_parentdesc:= contacttrialvisitjson ->> 'services_parentdesc';
		v_permanencystepdesc:= contacttrialvisitjson ->> 'permanencystepdesc';
		v_placementdesc:= contacttrialvisitjson ->> 'placementdesc';
		v_educationdesc:= contacttrialvisitjson ->> 'educationdesc';
		v_healthdesc:= contacttrialvisitjson ->> 'healthdesc';
		v_socialareadesc:= contacttrialvisitjson ->> 'socialareadesc';
		v_financialliteracydesc:= contacttrialvisitjson ->> 'financialliteracydesc';
		v_familyplanningdesc:= contacttrialvisitjson ->> 'familyplanningdesc';
		v_skillissuedesc:= contacttrialvisitjson ->> 'skillissuedesc';
		v_transitionplandesc:= contacttrialvisitjson ->> 'transitionplandesc';
		v_focusperson:= contactnotedata ->> 'focusperson';
		v_mioptions:=  contactnotedata ->> 'mioptions';
		v_delayreasons := contactnotedata ->> 'delayreasons';

		v_hasdelay := CASE 
			WHEN v_delayreasons IS NOT NULL AND TRIM(v_delayreasons) <> '' THEN TRUE
			ELSE FALSE
		END;

	select count(*) into v_progressnotecount from progressnote pgt where pgt.progressnoteid = v_progressnoteid;

IF v_progressnotecount > 0 THEN

	UPDATE progressnote pgt
	SET 	progressnotetypeid = v_progressnotetypeid,
			progressnotesubtypeid = v_progressnotesubtypeid,
			title = v_title,
			description = v_description,
			-- entitytype = v_entitytype,
			-- entitytypeid = v_entitytypeid,
			pageurl = v_pageurl,
			savemode = true,
			contactdate = v_contactdate,
			contactname = v_contactname,
			progressnotetypekey = v_progressnotetypekey,
			contactphone = v_contactphone,
			contactemail = v_contactemail,
			initiationindicator = v_initiationindicator,
			attemptindicator = v_attemptindicator,
			documentpropertiesid = v_documentpropertiesid,
			starttime = v_starttime,
			endtime = v_endtime,
			totaltime = v_totaltime,
			stafftypekey = v_stafftypekey,
			instantresults = v_instantresults,
			contactstatus = v_contactstatus,
			drugscreen = v_drugscreen,
			progressnotepurposetypekey = v_progressnotepurposetypekey,
			traveltime = v_traveltime,
			focusperson = v_focusperson,
			locationname = v_locationname,
			progressnotereasontypekey = v_progressnotereasontypekey,
			updatedby = v_insertedby,
			updatedon = now(),
			otherpersonname = v_otherpersonname,
			uploadedfile  = null,
			intakeserviceid = v_intakeserviceid,
			servicecaseid = v_servicecaseid,
			delayreasons = v_delayreasons,
            hasdelay = v_hasdelay
	WHERE pgt.progressnoteid = v_progressnoteid;

	select * into v_updatedocumentproperties from cjams.updatedocumentproperties(null, contactnotedata -> 'uploadedfile',v_progressnoteid::varchar,'progressnote', null,v_insertedby);

	UPDATE contacttrialvisit cv
	SET 	issuedesc = v_issuedesc,
			safetydesc = v_safetydesc,
			services_childdesc = v_services_childdesc,
			services_parentdesc = v_services_parentdesc,
			permanencystepdesc = v_permanencystepdesc,
			placementdesc = v_placementdesc,
			educationdesc = v_educationdesc,
			healthdesc = v_healthdesc,
			socialareadesc = v_socialareadesc,
			financialliteracydesc = v_financialliteracydesc,
			familyplanningdesc = v_familyplanningdesc,
			skillissuedesc = v_skillissuedesc,
			transitionplandesc = v_transitionplandesc,
			updatedby = v_insertedby,
			updatedon = now()
	WHERE cv.progressnoteid = v_progressnoteid;

	UPDATE progressnotedetail pndl 
	SET description = v_description,
		updatedby = v_insertedby,
		updatedon = now()
	WHERE pndl.progressnoteid = v_progressnoteid AND pndl.isaddendum = 0;

	UPDATE contactparticipant cp set activeflag =0, updatedby = v_insertedby, updatedon = now() WHERE cp.progressnoteid = v_progressnoteid;
	UPDATE progressnoteroletype pnrt set activeflag =0, updatedby = v_insertedby, updatedon = now() WHERE pnrt.progressnoteid = v_progressnoteid;
	UPDATE progressnotereasontypeconfig pnrc set activeflag =0, updatedby = v_insertedby, updatedon = now() WHERE pnrc.progressnoteid = v_progressnoteid;

END IF;


IF v_progressnotecount = 0 THEN
 
	select gen_random_uuid() into v_progressnoteid; 
	
	INSERT INTO progressnote
	(progressnoteid, progressnotetypeid, title, description, entitytype, entitytypeid, pagetitle, pageurl, islatest, versionof, insertedby, 
	insertedon, archivedby, archivedon, updatedby, updatedon, "timestamp", savemode, progressnotesubtypeid, contactdate, 
	contactname, progressnotetypekey, contactroletypekey, contactphone, contactemail, attemptindicator, activeflag, documentpropertiesid, 
	starttime, endtime, instantresults, contactstatus, drugscreen, progressnotepurposetypekey, old_id, traveltime, totaltime, progressnotereasontypekey, 
	locationname, witsinboundid, roletypekey, islocked, stafftypekey, notesid, witsstatus, witsupdatedate, witsupdatebyidno, 
	contactcategoryidno, iconimgtext, parametercodeidno, detaillookup, fk_id, initiationindicator, intakeserviceid, servicecaseid, isintake, 
	otherpersonname, uploadedfile, adjustmentfostercaretext, screeningfortheservicetext, ischildgotoshool, qualityofcaretochildtext, fk_user_id, 
	etl_userid, etl_load_date, fromjurisdictionid, tojurisdictionid, transferdate, transfertime, focusperson, mioptions, delayreasons, hasdelay)
	VALUES(v_progressnoteid, v_progressnotetypeid, v_title, v_description, v_entitytype, v_entitytypeid, null, v_pageurl, null, null, v_insertedby, 
			now(), null, null, v_insertedby, now(), null, v_savemode, v_progressnotesubtypeid, v_contactdate,
	v_contactname, v_progressnotetypekey, null, v_contactphone, v_contactemail, v_attemptindicator, 1, v_documentpropertiesid, 
    v_starttime, v_endtime, v_instantresults, v_contactstatus, v_drugscreen, v_progressnotepurposetypekey, null, v_traveltime, v_totaltime, v_progressnotereasontypekey,
    v_locationname, null, null, false, v_stafftypekey, null, null, null, null, 	
    null, null, null, null, null, v_initiationindicator, v_intakeserviceid, v_servicecaseid, v_isintake, 	
    v_otherpersonname, null, null, null, null, null, null, 
    null, null, null, null, null, null, v_focusperson, v_mioptions, v_delayreasons, v_hasdelay);	

	select * into v_updatedocumentproperties from cjams.updatedocumentproperties(null, contactnotedata -> 'uploadedfile',v_progressnoteid::varchar,'progressnote', null,v_insertedby);

    INSERT INTO contacttrialvisit
	(contacttrialvisitid, progressnoteid, issuedesc, safetydesc, services_childdesc, services_parentdesc, 
	permanencystepdesc, placementdesc, educationdesc, healthdesc, socialareadesc, financialliteracydesc, 
	familyplanningdesc, skillissuedesc, transitionplandesc, activeflag, insertedby, insertedon, 
	updatedby, updatedon, effectivedate, old_id)
	VALUES(gen_random_uuid(), v_progressnoteid, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, v_insertedby, now(), v_insertedby, now(), now(), null);

	select gen_random_uuid() into v_progressnotedetailid;

	INSERT INTO progressnotedetail
	(progressnotedetailid, progressnoteid, description, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, 
	updatedon, "timestamp", old_id, isaddendum, fk_user_id, etl_userid, etl_load_date)
	VALUES(v_progressnotedetailid, v_progressnoteid, v_description, 1, now(), null, v_insertedby, now(), v_insertedby, now(), null, null, 0, null, null, null);

END IF;

	for currentRow IN SELECT * FROM json_array_elements(contactparticipantjson)
	loop
	INSERT INTO contactparticipant
	(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, 
	address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, 
	updatedon, old_id, participantid, etl_userid, etl_load_date)
	VALUES(gen_random_uuid(), v_progressnoteid, (currentRow->>'participanttypekey'):: character varying, 
	(currentRow->>'intakeservicerequestactorid'):: uuid, (currentRow->>'firstname'):: character varying,
	(currentRow->>'lastname'):: character varying, (currentRow->>'address1'):: character varying,
	(currentRow->>'address2'):: character varying, (currentRow->>'city'):: character varying,
	(currentRow->>'state'):: character varying, (currentRow->>'zipcode'):: character varying,
	(currentRow->>'email'):: character varying, (currentRow->>'phonenumber'):: character varying,
	1, now(), v_insertedby, now(), v_insertedby, now(), null, (currentRow->>'intakeservicerequestactorid'):: uuid, null, null);
	END LOOP;


	for currentRow IN SELECT * FROM json_array_elements(progressnoterolejson)
	loop
	INSERT INTO progressnoteroletype
	(progressnoteroletypeid, progressnoteid, contactroletypekey, updatedby, updatedon, insertedby, insertedon, 
	activeflag, effectivedate, expirationdate, old_id)
	VALUES(gen_random_uuid(), v_progressnoteid, (currentRow->>'contactroletypekey'):: character varying, v_insertedby, now(), v_insertedby, now(), 1, now(), null, null);
	END LOOP;

	for currentRow IN SELECT * FROM json_array_elements(progressnotereasonjson)
	loop
	INSERT INTO progressnotereasontypeconfig
	(progressnotereasontypeconfigid, progressnoteid, personid, "name", primaryphoneno, email, 
	relationship, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id, "role")
	VALUES(gen_random_uuid(), v_progressnoteid, (currentRow->>'personid'):: uuid,
	(currentRow->>'name'):: character varying, (currentRow->>'primaryphoneno'):: character varying, 
	(currentRow->>'email'):: character varying, (currentRow->>'relationship'):: character varying, 
	1, v_insertedby, now(), v_insertedby, now(), now(), null, null);
	END LOOP;

    RETURN QUERY
   	select p.progressnoteid as progressnoteid, p.witsid, p.entitytype, p.entitytypeid , p.intakeserviceid , p.servicecaseid, pd.progressnotedetailid as progressnotedetailid,
   	p.description as description, p.activeflag as activeflag, to_char(pd.effectivedate, 'MM/DD/YYYY, HH12:MI:SS AM')::character varying as effectivedate, coalesce (p.updatedon, p.insertedon) as updatedon
   	from progressnote p, progressnotedetail pd  where p.progressnoteid = pd.progressnoteid and p.progressnoteid = v_progressnoteid;

END;

$function$;
