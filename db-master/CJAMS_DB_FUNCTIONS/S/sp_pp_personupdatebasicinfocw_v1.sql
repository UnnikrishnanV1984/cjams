DROP FUNCTION IF EXISTS  cjams.sp_pp_personupdatebasicinfocw_v1(v_personid uuid, persondetails json, v_intakeserviceid uuid, v_securityuserid character varying);


CREATE OR REPLACE FUNCTION cjams.sp_pp_personupdatebasicinfocw_v1(v_personid uuid, persondetails json, v_intakeserviceid uuid, v_securityuserid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

  -------------------------------------------------------------------------------------------------------
-- 05/31/2022 Mounika Gudise - AFCARS USER STORY CHANGES (CIDM-4647/B-125245)
-- 07/15/2022 - Vijaya Laxmi Devunoori - Update intercountryadoption , priorlegalguardianship and preplacementguardianshipdate  - (CIDM-5099)
-- 10/19/2022 - Vineet Tirodkar - SP deployment was missed as aprt of CIDM-5099 (CIDM-5797)
-- 11/04/2022 - Vigneshwar Kumar - CIDM-6014 - Persons with missing MDM ID
--4/28/2023 -Smitha Somasekharan -Adding columns for CIDM-7055,additional children in homeresponse timer
--01/18/2024: Palani/Manasa - Query optimization (CIDM-8255)
--02/22/2024: Sreekanth Marrikanti - Changes for Notification to Adoption Case Worker
--  07/31/2024- Umasankar Raavi --CIDM-9029-Person profile -Added new column othergendertypekey
-- 10/29/2024- Parshal Chitrakar --CIDM-9637 - Marital Status values like Place Of Divorce, Number OF Children and Zip Code are not retained after saving it
 --6/16/2025 -Umasankar Raavi --CIDM-10541-Child Fatality Radio Button-Added new column sdmpersonapprovalflag
 -- 06/18/2025 - Parshal Chitrakar -- CIDM-10580 - Safe Heven flag update on profile table.
 -- 09/09/2025 - Sandeep Kiran Anugolu -- CIDM-10625 - Update Profile table when SEN flag is checked and sent for approval.
-- 01-06-2026 - Veera Nadimpalli -- CIDM-10982 - To save Sen Criteria Identification
 ---01/08/2026 --CIDM-10981--Umasankar Raavi --Added additional Person table columns for the Limited English Proficiency (LEP) user story
-------------------------------------------------------------------------------------------------------
DECLARE 

	v_person json;	
	v_date timestamp without time zone;	
	dadetails json;	
	modifiedlog json;	
	v_isnamechanged boolean;
	v_alsoknownas json;
	v_personrole json;
	v_role json;
	v_personroleid uuid;
	v_personroletypeid uuid;
	v_actorid uuid;
	vm_actorid uuid;
	v_intakeservicerequestactorid uuid;
    v_intakenumber character varying;
    v_racejson json;
    v_racekey json;
	v_personalise json;
    v_racetypekey character varying;
   
	returnmsg character varying;
	empcount bigint;
	empdetailcount bigint;
	empdetailid uuid;
	v_personemployerdetailsid uuid;
	
	v_auditeithincity boolean;
	v_auditrace boolean;

	v_persondescription text;
	v_isheadofhousehold boolean default false ;
	v_priorcasesecurityusersid uuid;
	v_notifystatus  character varying; 
	v_cjamspid bigint;
	i record;
	j record;
	v_msg character varying;
	v_msg_body text;
	v_firstname character varying;
	v_middlename character varying;
	v_lastname character varying;
	v_finalobjectnumber character varying;
	v_finalobjectid character varying;
	v_msgcasetype character varying;
	v_newintakecounty character varying;
	v_isreporter boolean;
	v_clientalreadyexists int;
	l_objectid_uuidornot uuid;
	 v_printakeserviceid uuid;
	 v_printakenumber character varying;
	 v_prservicecaseid uuid;
	 v_personrolemessage uuid;

BEGIN

	v_clientalreadyexists := 0;
	v_person := persondetails;
	v_personrole := v_person ->> 'personRole';
	v_isreporter := false;
	v_alsoknownas := v_person ->'alias';
    v_intakenumber :=  v_person ->>'intakenumber';
    v_racejson := v_person-> 'Race';
	v_personalise := v_person-> 'alias';
	v_date := now() at time zone 'utc';
	v_isheadofhousehold := v_person ->> 'isheadofhousehold';
	
	raise notice 'v_isheadofhousehold ::% ',v_isheadofhousehold;

	select count(*) into v_clientalreadyexists from intakeservicerequestactor where personid = v_personid 
	and (intakenumber = v_intakenumber or intakeserviceid = v_intakeserviceid:: uuid or servicecaseid = (v_person  ->> 'servicecaseid'):: uuid)
	and activeflag = 1;

    select personDescription into v_persondescription from  getpersonnameandid(v_personid);


		select case when (p.racetypekey != v_person->>'Race') then true
			else false end israce into v_auditrace from person p where p.personid = v_personid and p.activeflag = 1;
	
		select case when (coalesce(p.ethnicgrouptypekey,'null') != v_person->>'ethnicgrouptypekey') then true
			else false end isethinicity into v_auditeithincity from person p where p.personid = v_personid and p.activeflag = 1;
	
 

SELECT
	case
		when (p.lastname != v_person->>'Lastname'
		or p.firstname != v_person->>'Firstname'
		or p.middlename != v_person->>'Middlename') then true
		else null
	end isnamechanged into
		v_isnamechanged
	from
		person p
	where
		p.personid = v_personid
		and p.activeflag = 1;


select
	json_strip_nulls(json_build_object('lastname', a.lastname, 'firstname', a.firstname , 'dob', a.dob , 'maritalstatustypekey', a.maritalstatustypekey, 'occupation', a.occupation, 'height', a.height, 'weight', a.weight, 'tattoo', a.tattoo, 'phymark', a.phymark, 'userphoto', a.userphoto))
from
	(
	select
		case
			when p.lastname != v_person->>'Lastname' then (
				select json_build_object('oldvalue', p.lastname, 'newvalue', v_person->>'Lastname') x)
			else null
		end lastname ,
		case
			when p.firstname != v_person->>'Firstname' then (
				select json_build_object('oldvalue', p.firstname, 'newvalue', v_person->>'Firstname') x)
			else null
		end firstname ,
		case
			when p.dob != (v_person->>'Dob')::timestamp then (
				select json_build_object('oldvalue', p.dob, 'newvalue', (v_person->>'Dob')::timestamp) x)
			else null
		end dob ,
		case
			when p.dateofdeath != (v_person->>'dateofdeath')::timestamp then (
				select json_build_object('oldvalue', p.dateofdeath, 'newvalue', (v_person->>'dateofdeath')::timestamp) x)
			else null
		end dod ,
		case
			when p.maritalstatustypekey != v_person->>'maritalstatus' then (
				select json_build_object('oldvalue', p.maritalstatustypekey, 'newvalue', v_person->>'maritalstatus') x)
			else null
		end maritalstatustypekey ,
		case
			when p.occupation != v_person->>'occupation' then (
				select json_build_object('oldvalue', p.occupation, 'newvalue', v_person->>'occupation') x)
			else null
		end occupation ,
		case
			when pht.attributevalue != v_person->>'height' then (
				select json_build_object('oldvalue', pht.attributevalue, 'newvalue', v_person->>'height') x)
			else null
		end height ,
		case
			when pwt.attributevalue != v_person->>'weight' then (
				select json_build_object('oldvalue', pwt.attributevalue, 'newvalue', v_person->>'weight') x)
			else null
		end weight ,
		case
			when ptt.attributevalue != v_person->>'tattoo' then (
				select json_build_object('oldvalue', ptt.attributevalue, 'newvalue', v_person->>'tattoo') x)
			else null
		end tattoo ,
		case
			when ppm.attributevalue != v_person->>'PhyMark' then (
				select json_build_object('oldvalue', ppm.attributevalue, 'newvalue', v_person->>'PhyMark') x)
			else null
		end phymark ,
		case
			when p.userphoto != v_person->>'userphoto' then (
				select json_build_object('oldvalue', p.userphoto, 'newvalue', v_person->>'userphoto') x)
			else null
		end userphoto
	from
		person p
	left join personphysicalattribute pht on
		pht.personid = p.personid
		and pht.physicalattributetypekey = 'Ht'
		and pht.activeflag = 1
	left join personphysicalattribute pwt on
		pwt.personid = p.personid
		and pwt.physicalattributetypekey = 'Wt'
		and pwt.activeflag = 1
	left join personphysicalattribute ptt on
		ptt.personid = p.personid
		and ptt.physicalattributetypekey = 'Tattoo'
		and ptt.activeflag = 1
	left join personphysicalattribute ppm on
		ppm.personid = p.personid
		and ppm.physicalattributetypekey = 'PhyMark'
		and ppm.activeflag = 1
	where
		p.personid = v_personid
		and p.activeflag = 1 ) a into
		modifiedlog;
	
	-- Inserting the old name to Alias if the name changed
 	 IF v_isnamechanged = true THEN 
	 	INSERT INTO alias ( personid, firstname, lastname, middlename, insertedby, insertedon, activeflag, updatedby, updatedon ) 
	 	SELECT p.personid, p.firstname, p.lastname, p.middlename, v_securityuserid, now(), 1, v_securityuserid, now()
		FROM person p
		WHERE p.activeflag = 1 AND p.personid = v_personid;
	END IF;

	UPDATE person
	SET
		userphoto = v_person->>'userphoto',	
		
		prefx = v_person->>'prefix',
		firstname = TRIM(v_person->>'Firstname'),
		lastname = TRIM(v_person->>'Lastname'),
		middlename = TRIM(v_person->>'Middlename'),
		suffix = v_person->>'nameSuffix',
		dob = (v_person->>'Dob')::timestamp,
		isapproxdob = (v_person->>'isapproxdob')::int4,--case when v_person->>'isapproxdob' = 'true' THEN 1 else 0 end,
		everbeenadoptedflag = (v_person->>'everbeenadoptedflag')::int4,
		cferesourcehomechild = (v_person->>'cferesourcehomechild')::boolean,
	    limitedenglishproficiency = (v_person->>'limitedenglishproficiency')::boolean,
		needtranslatorinterpreter = (v_person->>'needtranslatorinterpreter')::boolean,
		readingproficiency = (v_person->>'readingproficiency')::boolean,
		writingproficiency = (v_person->>'writingproficiency')::boolean,
		speakingproficiency = (v_person->>'speakingproficiency')::boolean,
		preadoptiondate = (v_person->>'preadptdate')::timestamp,
		dateofdeath = (v_person->>'dateofdeath')::timestamp,
	 	isapproxdod = (v_person->>'isapproxdod')::int4,--case when v_person->>'isapproxdod' = 'true' THEN 1 else 0 end,
		gendertypekey = (v_person->>'gendertypekey'), 
		othergendertypekey = (v_person->>'othergendertypekey')::int4,
		sdmpersonapprovalflag=(v_person->>'sdmpersonapprovalflag')::int,
		livingsituationkey = v_person->>'livingsituationkey', 
		livingsituationdesc = v_person->>'livingsituationdesc',
		livingarrangementkey = v_person->>'livingarrangementkey', 
		livingarrangementdesc = v_person->>'livingarrangementdesc',
		safehavenbabyflag = case when v_person  ->> 'safehavenbabyflag' = 'true' THEN 1 else 0 end,

		stateid = v_person->>'stateid',
		ssnno = v_person->>'SSN',
		ssnverified = (v_person ->>'ssnverified')::bool,
		racetypekey = v_person ->> 'Race',
		ethnicgrouptypekey = v_person ->> 'ethnicgrouptypekey',
		occupation = v_person->>'occupation',
		tribalassociation = v_person ->> 'tribalassociation',
		religiontypekey = v_person ->> 'religiontypekey',
		
		primarylanguageid = v_person ->> 'primarylanguage', 
		secondarylanguageid = v_person ->> 'secondarylanguage',	
		citizenalenageflag = (v_person ->> 'citizenalenageflag')::int4,	
		primarycitizenshiptypekey = v_person ->> 'primarycitizenship',	 
		seccitizenshiptypekey = v_person ->> 'secondarycitizenship',	
		nationalitytypekey = v_person ->> 'nationality',	
		alienstatustypekey = v_person ->> 'astatus',
		alienregistrationtext = v_person ->> 'arnumber',
		
		aname = (v_person ->> 'aname')::bool, 
		maritalstatustypekey = v_person ->> 'maritalstatustypekey',
		
		haircolortypekey = v_person ->>'haircolortypekey',
		hairtexturetypekey = v_person ->>'hairtexturetypekey',
		eyecolortypekey = v_person ->>'eyecolortypekey',
		physicalbuildtypekey = v_person ->>'physicalbuildtypekey',
		skintonetypekey = v_person ->>'skintonetypekey',
		hairtextureotherdesc = v_person ->>'hairtextureotherdesc',
     	haircolorotherdesc = v_person ->>'haircolorotherdesc',
     	isglasses = (v_person ->>'isglasses'):: boolean,
		employername = v_person ->>'employername',
		clienttitle = v_person ->>'clienttitle',
		biologicalmothermarriedsw = (v_person ->>'biologicalmothermarriedsw')::int4,
		clientflag = (v_person ->>'clientflag')::int4,
		updatedby = v_securityuserid,
		updatedon = now(),
		icwastatusinquiry = v_person ->>'icwastatusinquiry',
		icwaeligibleformembership = v_person ->>'icwaeligibleformembership',
		icwatribename = v_person ->>'icwatribename',
		icwaunderdefinition = v_person ->>'icwaunderdefinition',
		icwanotification = (v_person ->>'icwanotification')::date,
		icwatribelegalnotice = v_person ->>'icwatribelegalnotice',
		-- CIDM-5099
		intercountryadoption = (v_person ->>'intercountryadoption')::int,
		priorlegalguardianship = (v_person ->>'priorlegalguardianship')::int,
		preplacementguardianshipdate = (v_person ->>'preplacementguardianshipdate')::timestamp,
		substanceexposednewbornflag = (v_person ->> 'substanceexposednewbornflag')::INT,
		senstatusflag = (case when COALESCE((v_person ->> 'substanceexposednewbornflag')::INT, 0) = 1 and coalesce(senstatusflag, 99) <> 0 Then 1 when COALESCE((v_person ->> 'substanceexposednewbornflag')::INT, 0) = 0 and coalesce(senstatusflag, 99) <> 0 then null else senstatusflag end),
		substanceexposednewbornsourceid = (v_person ->> 'substanceexposednewbornsourceid')::character varying,
		substanceexposednewbornsourcetypekey = (v_person ->> 'substanceexposednewbornsourcetypekey')::INT,
		substanceexposednewborntimetamp = (v_person ->> 'substanceexposednewborntimetamp')::timestamp,
		substanceclasses = (v_person ->> 'substanceclasses')::json,
		sencriteria = (v_person ->> 'sencriteria')::character varying,
		birthinghospital = (v_person ->> 'birthinghospital')::character varying,
		othersubstances = (v_person ->> 'othersubstances')::character varying
	WHERE personid = v_personid;

	IF v_personid IS NOT NULL AND COALESCE((v_person ->> 'substanceexposednewbornflag')::INT, 0) = 1 AND v_intakeserviceid IS NOT NULL AND (v_person ->> 'substanceexposednewbornsourceid')::character varying = v_intakeserviceid::character varying THEN
		IF((select count(*) from intakeservicerequestsdm where intakeserviceid = v_intakeserviceid and activeflag = 1) > 0) THEN
			UPDATE intakeservicerequestsdm SET updatedby = v_securityuserid, updatedon = now(), drugexposednewbornflag = 1 where intakeserviceid = v_intakeserviceid and activeflag = 1; 
		ELSE 
			INSERT INTO cjams.intakeservicerequestsdm(intakeserviceid, drugexposednewbornflag, activeflag, updatedby, updatedon, insertedby, insertedon)
			VALUES(v_intakeserviceid, 1, 1, v_securityuserid, now(), v_securityuserid, now());
		END IF;
	END IF;

	IF v_personid IS NOT NULL AND COALESCE((v_person ->> 'substanceexposednewbornflag')::INT, 0) = 1 AND (v_person ->> 'substanceexposednewbornsourcetypekey')::character varying = '2954' AND (v_person ->> 'substanceexposednewbornsourceid')::character varying = v_intakenumber THEN
		UPDATE intakedastaging
		SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_exposednewborn}', 'true'))
			, updatedby = v_securityuserid
			, updatedon = now()
		WHERE intakenumber = (v_person ->> 'substanceexposednewbornsourceid')::character varying AND activeflag=1;

		UPDATE intakedastaging 
		SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json
			, updatedby = v_securityuserid
			, updatedon = now()
		WHERE intakenumber = (v_person ->> 'substanceexposednewbornsourceid')::character varying AND activeflag = 1;
	END IF;


if jsonb_array_length( v_racejson::jsonb ) > 0 then
update personracetypemap set activeflag=0, updatedon = now(), updatedby = v_securityuserid  where personid=v_personid;

for v_racekey in select
	*
from
	json_array_elements(v_racejson)
		

	loop

	  v_racetypekey:= v_racekey ->>'racetypekey';

insert
	into
		PersonRaceTypeMap(PersonRaceTypeMapId,
		personid,
		RaceTypeKey,
		updatedby,
		updatedon,
		insertedby,
		insertedon,
		activeflag,
		effectivedate)
	values (
	gen_random_uuid(),  
	v_personid,
	v_racetypekey,
	v_securityuserid,
	v_date,
	v_securityuserid,
	v_date,
	1,
	v_date);
end loop;

end if;


	IF LENGTH(LOWER( v_person ->> 'SSN' )) > 0 THEN 
		UPDATE personidentifier
		SET	activeflag = 0, updatedon = now(), updatedby = v_securityuserid 
		WHERE personid = v_personid AND personidentifiertypekey = 'SSN';
	
		INSERT INTO personidentifier( personid, personidentifiertypekey, personidentifiervalue, insertedby, insertedon, 
		activeflag, effectivedate )		
		VALUES ( v_personid, 'SSN', v_person->>'SSN', v_securityuserid, v_date, 1, v_date );
	END IF;

	IF LENGTH(LOWER( v_person ->> 'stateid' )) > 0 THEN 
		UPDATE personidentifier
		SET	activeflag = 0, updatedon = now(), updatedby = v_securityuserid 
		WHERE personid = v_personid AND personidentifiertypekey = 'DL';
	
		INSERT INTO personidentifier( personid, personidentifiertypekey, personidentifiervalue, insertedby, insertedon, 
		activeflag, effectivedate )		
		VALUES ( v_personid, 'DL', v_person->>'stateid', v_securityuserid, v_date, 1, v_date );
	END IF;

	IF LENGTH(LOWER( v_person ->> 'height' )) > 0 THEN 
		UPDATE personphysicalattribute
		SET	activeflag = 0, updatedon = now(), updatedby = v_securityuserid 
		WHERE personid = v_personid AND physicalattributetypekey = 'Ht';
	
		INSERT INTO personphysicalattribute( personid, physicalattributetypekey, attributevalue, insertedby, insertedon, 
		activeflag, effectivedate )		
		VALUES ( v_personid, 'Ht', v_person->>'height', v_securityuserid, v_date, 1, v_date );
	END IF;

	IF LENGTH(LOWER( v_person ->> 'weight' )) > 0 THEN 
		UPDATE personphysicalattribute
		SET	activeflag = 0, updatedon = now(), updatedby = v_securityuserid 
		WHERE personid = v_personid AND physicalattributetypekey = 'Wt';
	
		INSERT INTO personphysicalattribute( personid, physicalattributetypekey, attributevalue, insertedby, insertedon, 
		activeflag, effectivedate )		
		VALUES ( v_personid, 'Wt', v_person->>'weight', v_securityuserid, v_date, 1, v_date );
	END IF;

	IF LENGTH(LOWER( v_person ->> 'tattoo' )) > 0 THEN 
		UPDATE personphysicalattribute
		SET	activeflag = 0, updatedon = now(), updatedby = v_securityuserid 
		WHERE personid = v_personid AND physicalattributetypekey = 'Tattoo';
	
		INSERT INTO personphysicalattribute( personid, physicalattributetypekey, attributevalue, insertedby, insertedon, 
		activeflag, effectivedate )		
		VALUES ( v_personid, 'Tattoo', v_person->>'tattoo', v_securityuserid, v_date, 1, v_date );
	END IF;

	IF LENGTH(LOWER( v_person ->> 'PhyMark' )) > 0 THEN 
		UPDATE personphysicalattribute
		SET	activeflag = 0, updatedon = now(), updatedby = v_securityuserid 
		WHERE personid = v_personid AND physicalattributetypekey = 'PhyMark';
	
		INSERT INTO personphysicalattribute( personid, physicalattributetypekey, attributevalue, insertedby, insertedon, 
		activeflag, effectivedate )		
		VALUES ( v_personid, 'PhyMark', v_person->>'PhyMark', v_securityuserid, v_date, 1, v_date );
	END IF;



	-- Alias status update
/*	IF LENGTH(v_alsoknownas ->>'aliasid') > 0 THEN 
		UPDATE alias
		SET	activeflag = 0
		WHERE aliasid = (v_alsoknownas ->>'aliasid')::uuid;
	else 
	raise notice 'v_alsoknownas%',v_alsoknownas;
		INSERT INTO alias( aliasid, activeflag, personid, firstname, lastname, middlename, sfxname, akatypetypekey, 
		prefixtypekey, insertedby, insertedon )		
		VALUES (
		gen_random_uuid(),
		1,
		v_personid,
		v_alsoknownas ->> 'firstname' :: character varying,
		v_alsoknownas ->> 'lastname' :: character varying,
		v_alsoknownas ->> 'middlename' :: character varying,
		v_alsoknownas ->> 'sfxname' :: character varying,
		v_alsoknownas ->> 'akatypetypekey' :: character varying,
		v_alsoknownas ->> 'prefixtypekey' :: character varying,
		v_securityuserid, 
		v_date );
	END IF;  */
delete from alias WHERE personid =  v_personid;
 for v_alsoknownas in select
	*
from
	json_array_elements(v_personalise) loop
	


if(((v_alsoknownas ->>'aliasid') :: uuid) is null ) then 
	
INSERT INTO alias
(aliasid, activeflag, personid, firstname, lastname, middlename, sfxname,  akatypetypekey, prefixtypekey,insertedby,insertedon)
VALUES(
gen_random_uuid(),
1,
v_personid,
v_alsoknownas ->> 'firstname' :: character varying,
v_alsoknownas ->> 'lastname' :: character varying,
v_alsoknownas ->> 'middlename' :: character varying,
v_alsoknownas ->> 'sfxname' :: character varying,
v_alsoknownas ->> 'akatypetypekey' :: character varying,
v_alsoknownas ->> 'prefixtypekey' :: character varying,
v_securityuserid,now()
);

	
	else
	
	--UPDATE alias
	--	SET	activeflag = 0
		delete from alias WHERE aliasid = (v_alsoknownas ->>'aliasid')::uuid;
		
	INSERT INTO alias
(aliasid, activeflag, personid, firstname, lastname, middlename, sfxname,  akatypetypekey, prefixtypekey,insertedby,insertedon)
VALUES(
gen_random_uuid(),
1,
v_personid,
v_alsoknownas ->> 'firstname' :: character varying,
v_alsoknownas ->> 'lastname' :: character varying,
v_alsoknownas ->> 'middlename' :: character varying,
v_alsoknownas ->> 'sfxname' :: character varying,
v_alsoknownas ->> 'akatypetypekey' :: character varying,
v_alsoknownas ->> 'prefixtypekey' :: character varying,
v_securityuserid,now()
);
end if;
	end loop;
	
raise notice 'v_intakeserviceid inside basic%',v_intakeserviceid;

select pr.personroleid, pr.intakeserviceid,pr.intakenumber,pr.servicecaseid into v_personroleid, v_printakeserviceid, v_printakenumber, v_prservicecaseid 
from personrole pr where pr.personid = v_personid and pr.activeflag = 1 and 
(case when (v_person  ->> 'servicecaseid') is not null then pr.servicecaseid = (v_person  ->> 'servicecaseid')::uuid 
when v_intakeserviceid is not null then pr.intakeserviceid = v_intakeserviceid 
when v_intakenumber is not null then pr.intakenumber= v_intakenumber else false end);

   IF (v_personroleid IS NOT NULL ) THEN 
		IF((v_person  ->> 'servicecaseid') is not null) then 
			IF(v_printakenumber is not null and v_printakeserviceid is not null) then 
				select rolelinkupdateforintake into v_personrolemessage from cjams.rolelinkupdateforintake(v_printakenumber, v_securityuserid, null, v_personroleid);
				select rolelinkupdateforcps into v_personrolemessage from cjams.rolelinkupdateforcps(v_printakeserviceid, v_securityuserid, null, null, v_personroleid);
				update personrole set intakenumber = null, intakeserviceid = null, updatedby = v_securityuserid, updatedon = now() WHERE personroleid = v_personroleid::uuid;	
			elseif(v_printakenumber is not null) then 
				select rolelinkupdateforintake into v_personrolemessage from cjams.rolelinkupdateforintake(v_printakenumber, v_securityuserid, null, v_personroleid);
				update personrole set intakenumber = null, updatedby = v_securityuserid, updatedon = now() WHERE personroleid = v_personroleid::uuid;
			elseif(v_printakeserviceid is not null) then 
				select * into v_personrolemessage from cjams.rolelinkupdateforcps(v_printakeserviceid, v_securityuserid, null, null, v_personroleid);
				update personrole set intakeserviceid = null, updatedby = v_securityuserid, updatedon = now() WHERE personroleid = v_personroleid::uuid;
			END If;
		ELSEIF (v_intakeserviceid is not null) then 
			IF(v_printakenumber is not null and v_prservicecaseid is not null) then 
				select rolelinkupdateforintake into v_personrolemessage from cjams.rolelinkupdateforintake(v_printakenumber, v_securityuserid, null, v_personroleid);
				select rolelinkupdateforservicecase into v_personrolemessage from cjams.rolelinkupdateforservicecase(v_prservicecaseid, v_securityuserid, null, null, v_personroleid);
				update personrole set intakenumber = null, servicecaseid = null, updatedby = v_securityuserid, updatedon = now() WHERE personroleid = v_personroleid::uuid;	
			elseif(v_printakenumber is not null) then 
				select rolelinkupdateforintake into v_personrolemessage from cjams.rolelinkupdateforintake(v_printakenumber, v_securityuserid, null, v_personroleid);
				update personrole set intakenumber = null, updatedby = v_securityuserid, updatedon = now() WHERE personroleid = v_personroleid::uuid;	
			elseif(v_prservicecaseid is not null) then 
				select rolelinkupdateforservicecase into v_personrolemessage from cjams.rolelinkupdateforservicecase(v_prservicecaseid, v_securityuserid, null, null, v_personroleid);
				update personrole set servicecaseid = null, updatedby = v_securityuserid, updatedon = now() WHERE personroleid = v_personroleid::uuid;
			END If;
		elseif(v_intakenumber is not null) then 
			IF(v_printakeserviceid is not null and v_prservicecaseid is not null) then 
				select rolelinkupdateforcps into v_personrolemessage from cjams.rolelinkupdateforcps(v_printakeserviceid, v_securityuserid, null, null, v_personroleid);
				select rolelinkupdateforservicecase into v_personrolemessage from cjams.rolelinkupdateforservicecase(v_prservicecaseid, v_securityuserid, null, null, v_personroleid);
				update personrole set intakeserviceid = null, servicecaseid = null, updatedby = v_securityuserid, updatedon = now() WHERE personroleid = v_personroleid::uuid;	
			elseif(v_printakeserviceid is not null) then 
				select rolelinkupdateforcps into v_personrolemessage from cjams.rolelinkupdateforcps(v_printakeserviceid, v_securityuserid, null, null, v_personroleid);
				update personrole set intakeserviceid = null, updatedby = v_securityuserid, updatedon = now() WHERE personroleid = v_personroleid::uuid;	
			elseif(v_prservicecaseid is not null) then 
				select rolelinkupdateforservicecase into v_personrolemessage from cjams.rolelinkupdateforservicecase(v_prservicecaseid, v_securityuserid, null, null, v_personroleid);
				update personrole set servicecaseid = null, updatedby = v_securityuserid, updatedon = now() WHERE personroleid = v_personroleid::uuid;
			END If;
		end if;
		UPDATE personrole
		SET 
			activeflag = 1,
			ishouseholdmember = (v_person  ->> 'ishousehold')::int4,
			iscollateralcontact = (v_person  ->> 'iscollateralcontact')::int4,
			drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,
			drugexposedtypekey = v_person  -> 'drugexposedtypekey',
			otherdrugs = v_person  ->> 'otherdrugs',
			safehavenbabyflag = case when v_person  ->> 'safehavenbabyflag' = 'true' THEN 1 else 0 end,
			probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
			sexoffenderregisteredflag = case when v_person  ->> 'sexoffenderregisteredflag' = 'true' THEN 1 else 0 END,
			dangertoself = (v_person  ->> 'dangerousself')::int4,
			dangertoselfreason = v_person  ->> 'dangerousselfreason',
			isdangertoworker = (v_person  ->> 'Dangerousworker')::int4,	
			dangertoworkerreason = v_person  ->> 'DangerousWorkerReason',
			ismentalillness = (v_person  ->> 'ismentalillness')::int4,
			mentalillnessdetail = v_person  ->> 'ismentalillnessReason',
			ismentalimpair = (v_person  ->> 'ismentalimpair')::int4,
			mentalimpairdetail = v_person  ->> 'ismentalimpairReason',
			updatedby = v_securityuserid,
			updatedon = now(),
			initialresponse = (v_person->>'initialresponse') ::int4,
			initialresponseupdatedby =v_person ->> 'initialresponseupdatedby',
			initialresponseupdatedon = (v_person ->> 'initialresponseupdatedon')::timestamp
		WHERE personroleid = v_personroleid::uuid;
  ELSE
		raise notice 'else inside%',v_intakeserviceid;

	 	v_personroleid = gen_random_uuid();

	 	INSERT INTO personrole ( personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
		otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, 
		dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, updatedby, updatedon, intakenumber , intakeserviceid , servicecaseid,initialresponse,initialresponseupdatedby,initialresponseupdatedon)

		VALUES (
		v_personroleid,
		1,
		v_personid,
--		1,
		(v_person  ->> 'ishousehold')::int,
		(v_person  ->> 'iscollateralcontact')::int4,
		(v_person  ->> 'drugexposednewbornflag')::int4,
		v_person  -> 'drugexposedtypekey',
		v_person  ->> 'otherdrugs',
		case when v_person  ->> 'safehavenbabyflag' = 'true' THEN 1 else 0 END,
		(v_person  ->> 'probationsearchconductedflag')::int4,
		case when v_person  ->> 'sexoffenderregisteredflag' = 'true' THEN 1 else 0 END,		
		(v_person  ->> 'dangerousself')::int4,
		v_person  ->> 'dangerousselfreason',
		(v_person  ->> 'Dangerousworker')::int4,	
		v_person  ->> 'DangerousWorkerReason',
		(v_person  ->> 'ismentalillness')::int4,
		v_person  ->> 'ismentalillnessReason',
		(v_person  ->> 'ismentalimpair')::int4,
		v_person  ->> 'ismentalimpairReason',
		v_securityuserid, 
		v_date,
		v_intakenumber,
		v_intakeserviceid,
		(v_person  ->> 'servicecaseid')::uuid,
		(v_person  ->> 'initialresponse')::int4,
		v_person ->> 'initialresponseupdatedby',
		(v_person ->> 'initialresponseupdatedon') ::timestamp);	
--	END IF;	
		UPDATE person
		SET  dangertoself=(v_person  ->> 'dangerousself')::int4,dangertoselfreason=v_person  ->> 'dangerousselfreason', updatedby=v_securityuserid, updatedon=now(), safehavenbabyflag = case when v_person  ->> 'safehavenbabyflag' = 'true' THEN 1 else 0 END
		WHERE personid=v_personid;
	 END IF;
	   raise notice 'v_personroleid%',v_personroleid;
		select * from insertupdatepersonrole(v_personrole, v_intakeserviceid, v_intakenumber, v_personid, v_person , v_personroleid, v_securityuserid, v_isheadofhousehold) into
					returnmsg;
 
       raise notice 'returnmsg%',returnmsg;
	-- Marital status update
	IF ((v_person ->> 'maritalstatustypekey') IN ('MR', 'LP', 'LS', 'DV', 'WD')) THEN
		UPDATE personmaritalstatus
		SET	activeflag = 0, updatedon = now(), updatedby = v_securityuserid 
		WHERE personmaritalstatusid = (v_person ->> 'personmaritalstatusid')::uuid;
	
		UPDATE personspouseaddress
		SET	activeflag = 0, updatedon = now(), updatedby = v_securityuserid 
		WHERE personid = v_personid;	
	
		IF ( v_person ->> 'personmaritalstatusid' IS NOT NULL ) THEN 
			UPDATE personmaritalstatus
			SET 
				activeflag = 1,			
				statustypekey = v_person ->> 'maritalstatustypekey',
				marriageplace = v_person ->> 'marriageplace',
				divorceplace = v_person ->> 'divorceplace',
				startdate = (v_person ->> 'maritalstartdate')::timestamp,
				enddate = (v_person ->> 'maritalenddate')::timestamp,
				childrenno = (v_person ->> 'numberofchildren')::int,
				informallivingcomments = v_person ->> 'maritalcomments',
				prefixtypekey = v_person ->> 'spouseprefix',	
				firstname = v_person ->> 'spousefirstname',
				middlename = v_person ->> 'spousemiddlename',
				lastname = v_person ->> 'spouselastname',
				suffixtypekey = v_person ->> 'spousesuffix',	
				adrhomephone = v_person ->> 'spousehomenumber',
				adrworkphone = v_person ->> 'spouseofficenumber',
				adrworkxtn = v_person ->> 'spouseofficeextension',
				updatedby = v_securityuserid,
				updatedon = now() 
			WHERE personmaritalstatusid = (v_person  ->> 'personmaritalstatusid')::uuid;
		
			UPDATE personspouseaddress
			SET 
				activeflag = 1,				
				adr1 = (v_person ->> 'spouseaddress1')::VARCHAR,
				adr2 = (v_person ->> 'spouseAddress2')::VARCHAR,
				city = v_person ->> 'spousecity',
				county = v_person ->> 'spousecounty',
				state = v_person ->> 'spousestate',
				zip5no = (v_person ->> 'spousezipcode')::numeric,
				updatedby = v_securityuserid,
				updatedon = now() 
			WHERE personspouseaddressid = (v_person  ->> 'personspouseaddressid')::uuid;
		ELSE
			INSERT INTO personmaritalstatus( personmaritalstatusid, statustypekey, marriageplace, divorceplace, startdate, 
			enddate, childrenno, informallivingcomments, prefixtypekey, firstname, middlename, lastname, suffixtypekey, 
			adrhomephone, adrworkphone, adrworkxtn, insertedby, insertedon,updatedon, activeflag, personid )
			
			VALUES ( 
			gen_random_uuid(), 
			v_person ->> 'maritalstatustypekey',
			v_person ->> 'marriageplace',
			v_person ->> 'divorceplace',
			(v_person ->> 'maritalstartdate')::timestamp,
			(v_person ->> 'maritalenddate')::timestamp,
			(v_person ->> 'numberofchildren')::int,
			v_person ->> 'maritalcomments',
			v_person ->> 'spouseprefix',	
			v_person ->> 'spousefirstname',
			v_person ->> 'spousemiddlename',
			v_person ->> 'spouselastname',
			v_person ->> 'spousesuffix',	
			v_person ->> 'spousehomenumber',
			v_person ->> 'spouseofficenumber',
			v_person ->> 'spouseofficeextension',
			v_securityuserid,
			v_date,	
			v_date,	
			1,
			v_personid );
		
			INSERT INTO personspouseaddress( personspouseaddressid, personid, adr1, adr2, city, county, state, zip5no, insertedon, 
			insertedby, activeflag )
			VALUES ( 
			gen_random_uuid(), 
			v_personid,
			(v_person ->> 'spouseaddress1')::VARCHAR,
			(v_person ->> 'spouseAddress2')::VARCHAR,
			v_person ->> 'spousecity',
			v_person ->> 'spousecounty',
			v_person ->> 'spousestate',
			(v_person ->> 'spousezipcode')::numeric,
			v_date,		
			v_securityuserid,	
			1 );
		END IF;
	ELSE
		UPDATE personmaritalstatus
		SET	activeflag = 0, updatedon = now(), updatedby = v_securityuserid 
		WHERE personmaritalstatusid = (v_person ->> 'personmaritalstatusid')::uuid;	
	
		IF ( v_person ->> 'personmaritalstatusid' IS NOT NULL ) THEN 
			UPDATE personmaritalstatus
			SET 
				activeflag = 1,			
				statustypekey = v_person ->> 'maritalstatustypekey',
				updatedby = v_securityuserid,
				updatedon = now() 
			WHERE personmaritalstatusid = (v_person  ->> 'personmaritalstatusid')::uuid;
		ELSE
			INSERT INTO personmaritalstatus( personmaritalstatusid, statustypekey, marriageplace, divorceplace, startdate, 
			enddate, childrenno, informallivingcomments, prefixtypekey, firstname, middlename, lastname, suffixtypekey, 
			adrhomephone, adrworkphone, adrworkxtn, insertedby, insertedon, activeflag, personid )
			
			VALUES ( 
			gen_random_uuid(), 
			v_person ->> 'maritalstatustypekey',
			v_person ->> 'marriageplace',
			v_person ->> 'divorceplace',
			(v_person ->> 'maritalstartdate')::timestamp,
			(v_person ->> 'maritalenddate')::timestamp,
			(v_person ->> 'numberofchildren')::int,
			v_person ->> 'maritalcomments',
			v_person ->> 'spouseprefix',	
			v_person ->> 'spousefirstname',
			v_person ->> 'spousemiddlename',
			v_person ->> 'spouselastname',
			v_person ->> 'spousesuffix',	
			v_person ->> 'spousehomenumber',
			v_person ->> 'spouseofficenumber',
			v_person ->> 'spouseofficeextension',
			v_securityuserid,
			v_date,	
			1,
			v_personid );
		END IF;		
	END IF;

	SELECT json_agg(e)
	FROM (
	SELECT
		v_person->>'Firstname' firstname ,
		v_person->>'Lastname' lastname,
		v_person->>'maritalstatus' maritalstatus ,
		v_person->>'SSN' ssn,
		v_person->>'weight' weight,
		v_person->>'occupation' occupation)e 
	INTO dadetails;

	INSERT INTO auditlog( logtypekey, description, referenceid, servicerequestnumber, isnew, isedit, isdelete, insertedon, 
	metadata, modifieddata, insertedby )
	VALUES(
	'IP',
	'Person Edited',
	v_personid,
	null,
	'false',
	'true',
	'false',
	v_date,
	dadetails::json,
	modifiedlog::json,
	v_securityuserid);
	
	
	INSERT INTO auditlog( logtypekey,  intakeserviceid,servicerequestnumber, referenceid, description, 
	isnew,isedit, isdelete,	insertedby,	updatedby,insertedon,updatedon, metadata,ipaddress, old_id,
	modifieddata, objectid, objecttype)
	 
	VALUES			
	
	('NY011',NULL,	null,NULL,concat('Demographic info is modified for client ', ' ', v_persondescription),
	false,	true,false,	v_securityuserid,v_securityuserid,now(),now(),persondetails::json,null,NULL,
	persondetails::json,v_person  ->> 'objectid',v_person  ->> 'objecttypekey');  
	

	--added for audit log entry by venky
	INSERT INTO personauditlog
(personauditlogid, personid, personjson,typekey, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES(gen_random_uuid(), v_personid , v_person , 'old':: character varying, now(), v_securityuserid ,  v_securityuserid,now(), 1);


select  count(1) into empdetailcount from personemployerdetail  where personid = v_personid and activeflag =1;
select ped.personemployerdetailid into empdetailid from personemployerdetail ped where personid = v_personid and ped.activeflag=1 order by ped.insertedon desc limit 1;
if((v_person ->> 'employername') != '' and (v_person ->> 'employername') is not null)
then
if(empdetailcount > 0)
then
update personemployerdetail set employername = v_person ->> 'employername', updatedon = now(), updatedby = v_securityuserid  where personemployerdetailid 
in (select ped.personemployerdetailid from personemployerdetail ped where personid = v_personid and ped.activeflag=1 order by ped.insertedon desc limit 1);
else
insert into personemployerdetail
    	(personemployerdetailid,personid,employername,activeflag,updatedby,updatedon,insertedby,insertedon)
		values (gen_random_uuid(),v_personid,v_person->>'employername',1,v_securityuserid,now(),v_securityuserid,now())
		returning personemployerdetailid into
		empdetailid;
end if;
end if;

if((v_person ->> 'clienttitle') != '' and (v_person ->> 'clienttitle') is not null)
then
select  count(1) into empcount from personemployment  where personid = v_personid and activeflag =1;
if(empcount > 0)
then
update personemployment set clienttitle = v_person ->> 'clienttitle',personemployerdetailsid = empdetailid,promotedemploymentflag = 0 where  personemploymentid 
in (select ped.personemploymentid from personemployment ped where personid = v_personid and ped.activeflag=1 order by ped.insertedon desc limit 1);
else
insert into personemployment
			(personemploymentid,personid,personemployerdetailsid,promotedemploymentflag,clientmergeid,clienttitle,activeflag,updatedby,updatedon,insertedby,insertedon)
    		values (gen_random_uuid(),v_personid,empdetailid,0,v_personid,v_person->>'clienttitle',1,v_securityuserid,now(),v_securityuserid,now());
end if;
end if;

	IF v_auditeithincity = TRUE THEN
			
	INSERT INTO auditlog( logtypekey,  intakeserviceid,servicerequestnumber, referenceid, description, 
	isnew,isedit, isdelete,	insertedby,	updatedby,insertedon,updatedon, metadata,ipaddress, old_id,
	modifieddata, objectid, objecttype)
	 
	VALUES			
	
	('NY010',NULL,	null,NULL,concat('Hispanic or Latino Ethnicity is modified for', ' ', v_persondescription),
	false,	true,false,	v_securityuserid,v_securityuserid,now(),now(),persondetails::json,null,NULL,
	persondetails::json,v_person  ->> 'objectid',v_person  ->> 'objecttypekey');  

			end if;
		
IF v_auditrace = TRUE THEN
			
	INSERT INTO auditlog( logtypekey,  intakeserviceid,servicerequestnumber, referenceid, description, 
	isnew,isedit, isdelete,	insertedby,	updatedby,insertedon,updatedon, metadata,ipaddress, old_id,
	modifieddata, objectid, objecttype)
	 
	VALUES			
	
	('NY009',NULL,	null,NULL,concat('Race is modified for', ' ', v_persondescription),
	false,	true,false,	v_securityuserid,v_securityuserid,now(),now(),persondetails::json,null,NULL,
	persondetails::json,v_person  ->> 'objectid',v_person  ->> 'objecttypekey');  

end if;

FOR v_role IN SELECT * FROM json_array_elements(v_personrole)
	loop
	if ((v_role  ->> 'roletype'):: text = 'Rep':: text) THEN

	v_isreporter := true;

	end if;
	end loop;

if ((v_intakenumber is not null or v_intakeserviceid is not null or (v_person  ->> 'servicecaseid')::uuid is not null) and v_isreporter = false and v_clientalreadyexists = 0) then

if ((v_person  ->> 'servicecaseid')::character varying  is not null) THEN

v_msgcasetype := 'Service case ';
select servicecasenumber ::character varying, servicecaseid ::character varying into v_finalobjectnumber, v_finalobjectid from servicecase where servicecaseid = (v_person  ->> 'servicecaseid')::uuid ;

ELSIF (v_intakeserviceid is not null) THEN

v_msgcasetype := 'CPS Case ';
select servicerequestnumber ::character varying, intakeserviceid ::character varying into v_finalobjectnumber, v_finalobjectid from intakeservicerequest where intakeserviceid = v_intakeserviceid:: uuid;

ELSIF (v_intakenumber is not null and v_intakeserviceid is null and (v_person  ->> 'servicecaseid')::uuid is null) THEN

v_msgcasetype := 'Referral/Intake ';
v_finalobjectnumber := v_intakenumber;
v_finalobjectid:= v_intakenumber;

end if;

raise notice 'message type ::% ',v_msgcasetype;
raise notice 'final obj number ::% ',v_finalobjectnumber;
raise notice 'final obj id ::% ',v_finalobjectid;

FOR i IN select * from searchpriordsdsaction(v_personid,null, null, null) where (status not in  ('Closed', 'Completed') or status is null) and datype in ('Service Case', 'Child Protective Services','Adoption Case')
LOOP

-- SELECT R.tosecurityusersid :: uuid into v_priorcasesecurityusersid
-- FROM routing R 
-- WHERE R.objectid = i.objectid AND R.activeflag =1 AND R.toroleid = 'CWCW' limit 1;

select p.cjamspid, p.firstname, p.middlename, p.lastname into v_cjamspid, v_firstname, v_middlename, v_lastname from person p where p.personid = v_personid and p.activeflag = 1;

select countyname into v_newintakecounty from v_userprofile where securityusersid = v_securityuserid::character varying;

raise notice 'user id ::% ',v_priorcasesecurityusersid;
raise notice 'cjamspid ::% ',v_cjamspid;
raise notice 'type ::% ',v_newintakecounty;

SELECT * into l_objectid_uuidornot from uuid_or_null(i.objectid);

FOR j IN select toworkeridno,responsibilitytypekey from caseassignment ca where ca.objectid   = l_objectid_uuidornot and ca.enddate is null and ca.activeflag = 1 group by 1,2
LOOP

v_priorcasesecurityusersid:= j.toworkeridno:: uuid;

if ( v_priorcasesecurityusersid is not null) THEN

v_msg := concat ('System Identified ',v_firstname, ' ', v_middlename, ' ', v_lastname, ' (', v_cjamspid, ') involved in Case ', i.danumber ,' is added to ', v_msgcasetype, v_finalobjectnumber, ' in ',v_newintakecounty, ' county.');

raise notice 'msg final ::% ',v_msg;

 SELECT send_notification into v_notifystatus from send_notification(
	 					   v_priorcasesecurityusersid :: character varying,
						   v_securityuserid :: character varying,
						   v_priorcasesecurityusersid :: character varying,                                                                                                                                   
                          'System':: character varying, 
						  'High' :: character varying,   
						  v_msg:: character varying,                                                                                                                                               
                          v_msg:: text,                                                                                                                                                                 
                          v_finalobjectid :: character varying);

end if;
END LOOP;
END LOOP;
end if;
RETURN 'Success';
END;

 

$function$;