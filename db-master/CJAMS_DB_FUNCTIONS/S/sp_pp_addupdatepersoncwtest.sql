CREATE OR REPLACE FUNCTION cjams.sp_pp_addupdatepersoncwtest(v_personid uuid, persondetails json, v_intakeserviceid uuid, v_securityuserid character varying)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$

 declare v_personjsondata json;

v_person json;

l_generatedactorid uuid;

l_generatedintakeservicereqactorid uuid;

l_genereatedactorrelationshipid uuid;

v_personrolejs json;

v_date timestamp without time zone;

returnmsg character varying;

v_intakeservicerequestactorid uuid;

v_actorid uuid;

v_personroleid uuid;

v_personroletypeid uuid;

v_maritalstatus json;

	v_personrole json;
	v_role json;

v_personalise json;

v_alsoknownas json ; 

v_racejson json;

v_racekey json;

v_racetypekey character varying;

v_intakenumber character varying;
begin
v_date := now() at time zone 'utc';

v_person := persondetails;

v_actorid := v_person ->>'actorid';
	v_intakenumber :=  v_person ->>'intakenumber';
raise notice 'v_personrole teet %',  v_person ->> 'alias';

v_maritalstatus := v_person ->'maritalstatus';

--raise notice 'values %',
--v_Personjsondata->>'activeflag';

	v_personrole := v_person ->> 'personRole';

v_personalise := v_person-> 'alias';

v_racejson := v_person-> 'Race';
raise notice 'v_personrole %',
v_personrole;

--raise notice 'v_personrole %',
--v_personrole->>'rolekey';

if(v_personid is not null) then select
	*
from
	sp_pp_personupdatebasicinfocwtest(v_personid,
	persondetails,
	v_intakeserviceid,
	v_securityuserid) into
		returnmsg;
else
--raise notice 'nameneme %', v_person ->>'Firstname';
insert
	into
		Person ( 
		activeflag,
		firstname,
		lastname,
		middlename,
		dob,
		gendertypekey,
		insertedby,
		insertedon,
		dateofdeath,
		isapproxdod,
		isapproxdob,
		stateid,
		--racetypekey,
		ethnicgrouptypekey,
		occupation,
		tribalassociation,
		physicalattributes,
		effectivedate,
		userphoto,
		livingsituationdesc,
		primarylanguageid,
		secondarylanguageid,
		isuscitizen,
		ssnno,
        ssnverified,
		prefx,
		suffix,
		everbeenadoptedflag,
		livingsituationkey,
		maritalstatustypekey,
		religiontypekey,
		citizenalenageflag,
		primarycitizenshiptypekey,
		seccitizenshiptypekey,
		nationalitytypekey,
		alienstatustypekey,
		substanceexposednewbornsourcetypekey,
		safehavenbabyflag,
		dangertoself )
	values( 
	1,
	v_person ->>'Firstname',
	v_person ->>'Lastname',
	v_person ->>'Middlename',
	(v_person ->>'Dob')::timestamp,
	v_person ->>'gendertypekey',
	v_securityuserid,
	v_date,
	(v_person ->>'Dod')::timestamp ,
	(v_person ->>'isapproxdod')::int,
	(v_person ->>'isapproxdob')::int,
	v_person ->>'stateid',
	--v_person ->>'Race',
	v_person ->>'ethnicgrouptypekey',
	v_person ->>'occupation',
	v_person ->>'tribalassociation',
	v_person ->>'physicalattributes',
	v_date,
	v_person ->>'userphoto',
	v_person ->>'livingsituationdesc',
	v_person ->>'primarylanguageid',
	v_person ->>'secondarylanguageid',
	v_person ->>'isuscitizen',
	v_person ->>'SSN',
    (v_person ->>'ssnverified')::bool,
	v_person ->>'prefix',
	v_person ->>'nameSuffix',
	(v_person ->>'everbeenadoptedflag')::int,
	v_person ->>'livingsituationkey',
	v_person ->>'maritalstatustypekey',
	v_person ->>'religiontypekey',
	(v_person ->>'citizenalenageflag')::int,
	v_person ->>'primarycitizenship',
	v_person ->>'secondarycitizenship',
	v_person ->>'nationality',
	v_person ->>'alienstatustypekey',
	v_person ->>'substanceexposednewbornsourcetypekey',
	case when (v_person  ->> 'safehavenbabyflag') = 'true' THEN 1 else 0 END,
	(v_person ->>'dangertoself')::int )returning personid into
		v_personid;
	
		--raise notice 'v_racejson%',v_racejson;
	--raise notice 'jsonb_array_length( v_racejson::jsonb ) = 0%',jsonb_array_length( v_racejson::jsonb );
	
if jsonb_array_length( v_racejson::jsonb ) > 0 then

for v_racekey in select
	*
from
	json_array_elements(v_racejson)
		

	loop
	
	raise notice 'v_racekey%',v_racekey;
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

if LENGTH(lower(v_person->>'ssn')) > 0 then insert
	into
		personidentifier(personid,
		personidentifiertypekey,
		personidentifiervalue,
		insertedby,
		insertedon,
		activeflag,
		effectivedate)
	values (v_personid,
	'SSN',
	v_person->>'SSN',
	v_securityuserid,
	v_date,
	1,
	v_date);
end if;

if Length(lower(v_person ->> 'dl')) > 0 then insert
	into
		personidentifier (personid,
		personidentifiertypekey,
		personidentifiervalue,
		insertedby,
		insertedon,
		activeflag,
		effectivedate)
	values (v_personid,
	'DL',
	v_person ->> 'dl',
	v_securityuserid,
	v_date,
	1,
	v_date);
end if;

if Length(lower(v_person ->> 'phymark')) > 0 then insert
	into
		personphysicalattribute (personid,
		physicalattributetypekey,
		attributevalue,
		insertedby,
		insertedon,
		activeflag,
		effectivedate)
	values (v_personid,
	'PhyMark',
	v_person ->> 'phymark',
	v_securityuserid,
	v_date,
	1,
	v_date);
end if;

if Length(lower(v_person ->> 'height')) > 0 then insert
	into
		personphysicalattribute (personid,
		physicalattributetypekey,
		attributevalue,
		insertedby,
		insertedon,
		activeflag,
		effectivedate)
	values (v_personid,
	'Ht',
	v_person ->> 'height',
	v_securityuserid,
	v_date,
	1,
	v_date);
end if;

if Length(lower(v_person ->> 'weight')) > 0 then insert
	into
		personphysicalattribute (personid,
		physicalattributetypekey,
		attributevalue,
		insertedby,
		insertedon,
		activeflag,
		effectivedate)
	values (v_personid,
	'Wt',
	v_person ->> 'weight',
	v_securityuserid,
	v_date,
	1,
	v_date);
end if;

if (lower(v_person ->> 'tatoo')) is not null then insert
	into
		personphysicalattribute (personid,
		physicalattributetypekey,
		attributevalue,
		insertedby,
		insertedon,
		activeflag,
		effectivedate)
	values (v_personid,
	'Tattoo',
	v_person ->> 'tatoo',
	v_securityuserid,
	v_date,
	1,
	v_date);
end if;
raise notice 'marrrr %',v_maritalstatus;
raise notice 'marrrr %',v_maritalstatus ->> 'marriageplace';
--if (v_maritalstatus ->> 'marriageplace' is not null
--or (lower(v_maritalstatus ->> 'divorceplace')) is not null
--or (lower(v_maritalstatus ->> 'startdate')) is not null
--or (lower(v_maritalstatus ->> 'enddate')) is not null
--or (lower(v_maritalstatus ->> 'childrenno')) is not null
--or (lower(v_maritalstatus ->> 'prefixtypekey')) is not null
--or (lower(v_maritalstatus ->> 'firstname')) is not null
--or (lower(v_maritalstatus ->> 'lastname')) is not null
--or (lower(v_maritalstatus ->> 'adrhomephone')) is not null
--or (lower(v_maritalstatus ->> 'adrworkphone')) is not null
--or ((v_maritalstatus ->> 'adrworkxtn')) is not null
--or (lower(v_maritalstatus ->> 'adrworkphone')) is not null ) then insert
--	into
--		cjams.personmaritalstatus (personmaritalstatusid,fk_id,
--		startdate,
--		enddate,
--		marriageplace,
--		divorceplace,
--		prefixtypekey,
--		childrenno,
--		firstname,
--		middlename,
--		lastname,
--		suffixtypekey,
--		adrhomephone,
--		adrworkphone,
--		adrworkxtn,
--		informallivingcomments,
--		insertedon,
--		insertedby,
--		activeflag,
--		personid,clientmergeid)
--	values( gen_random_uuid(),'CW',
--	(v_maritalstatus ->> 'startdate')::timestamp,
--	(v_maritalstatus ->> 'enddate')::timestamp,
--	v_maritalstatus ->> 'marriageplace',
--	v_maritalstatus ->> 'divorceplace',
--	v_maritalstatus ->> 'prefixtypekey',
--	(v_maritalstatus ->> 'childrenno')::int,
--	v_maritalstatus ->> 'firstname',
--	v_maritalstatus ->> 'middlename',
--	v_maritalstatus ->> 'lastname',
--	v_maritalstatus ->> 'suffixtypekey',
--	v_maritalstatus ->> 'adrhomephone',
--	v_maritalstatus ->> 'adrworkphone',
--	v_maritalstatus ->> 'adrworkxtn',
--	v_maritalstatus ->> 'informallivingcomments',
--	v_date,
--	v_securityuserid,
--	1,
--	v_personid,'00000000-0000-0000-0000-000000000000');
--end if;
--
--if ((lower(v_maritalstatus ->> 'streetno')) is not null
--or (lower(v_maritalstatus ->> 'streetname')) is not null
--or (lower(v_maritalstatus ->> 'city')) is not null
--or (lower(v_maritalstatus ->> 'state')) is not null
--or (lower(v_maritalstatus ->> 'county')) is not null
--or (lower(v_maritalstatus ->> 'zip5no')) is not null ) then insert
--	into
--		cjams.personspouseaddress ( personid,
--		streetno,
--		streetname,
--		city,
--		county,
--		state,
--		zip5no,
--		insertedon,
--		insertedby,
--		activeflag)
--	values(v_personid,
--	v_maritalstatus ->> 'streetno',
--	v_maritalstatus ->> 'streetname',
--	v_maritalstatus ->> 'city',
--	v_maritalstatus ->> 'county',
--	v_maritalstatus ->> 'state',
--	v_maritalstatus ->> 'zip5no',
--	v_date,
--	v_securityuserid,
--	1);
--end if;
--end if;

	-- Person Role Add	
	IF ( v_person ->> 'personroleid' IS NULL ) THEN 	
        v_personroleid = gen_random_uuid();
	 	
	 	INSERT INTO personrole ( personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
		otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, 
		dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, updatedby, updatedon , intakenumber)

		VALUES (
		v_personroleid,
		1,
		v_personid,
--		1,
		(v_person  ->> 'ishousehold')::int,
		(v_person  ->> 'iscollateralcontact')::int4,
		(v_person  ->> 'drugexposednewbornflag')::int4,
		v_person  ->> 'drugexposedkey',
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
		v_date ,
		v_intakenumber);	
		
		UPDATE person
		SET  dangertoself=(v_person  ->> 'dangerousself')::int4,dangertoselfreason=v_person  ->> 'dangerousselfreason', updatedby=v_securityuserid, updatedon=now(), safehavenbabyflag = case when v_person  ->> 'safehavenbabyflag' = 'true' THEN 1 else 0 END
		WHERE personid=v_personid;
	
		select * from insertupdatepersonrole(v_personrole, v_intakeserviceid, v_intakenumber, v_personid, v_person , v_personroleid, v_securityuserid) into
					returnmsg;
	
--		v_actorid = gen_random_uuid();
--		FOR v_role IN SELECT * FROM json_array_elements(v_personrole)
--		LOOP
--			IF ( v_role ->> 'personroletypeid' IS NULL ) then
--				v_personroletypeid = gen_random_uuid();
--				v_intakeservicerequestactorid = gen_random_uuid();
--				
--				INSERT INTO personroletype ( personroletypeid, activeflag, personroleid, roletype, updatedby, updatedon, isprimary )
--				VALUES (
--				v_personroletypeid,
--				1,
--				v_personroleid,
--				v_role  ->> 'roletype',
--				v_securityuserid, 
--				v_date,
--				v_role  ->> 'isprimary');	
--			
--				if ((v_role  ->> 'isprimary')::int4 = 1)
--				then
--				
--				update actor  set activeflag=0 where personid= v_personid and intakenumber = v_intakenumber;
--	            update intakeservicerequestactor  set activeflag=0 where personid = v_personid and intakenumber = v_intakenumber;
--				
--				INSERT INTO actor
--				(actorid, activeflag, personid, actortype,insertedby, insertedon, updatedby, updatedon, "timestamp", medicaideligibility, blockgranteligibility, recipientstatus, manualupdateflag, intakeserviceid, iscollateralcontact, ismentalillness,mentalillnessdetail, ismentalimpair,mentalimpairdetail, ishouseholdmember, isdangertoworker,dangertoworkerreason, servicecaseid, sexoffenderregisteredflag, probationsearchconductedflag, drugexposednewbornflag, otherdrugs, personroletypeid, drugexposedkey,
--				intakenumber)
--				values (
--				v_actorid, 1, v_personid, v_role  ->> 'roletype', v_securityuserid, now(), v_securityuserid, now(),null, true, true, true,
--				'N'::bpchar, v_intakeserviceid, (v_person  ->> 'iscollateralcontact')::int4, (v_person  ->> 'ismentalillness')::int4,v_person  ->> 'ismentalillnessReason',
--				(v_person  ->> 'ismentalimpair')::int4,v_person  ->> 'ismentalimpairReason',(v_person  ->> 'ishousehold')::int, (v_person  ->> 'Dangerousworker')::int4,
--				v_person  ->> 'DangerousWorkerReason', (v_person  ->> 'servicecaseid')::uuid, case when v_person  ->> 'sexoffenderregisteredflag' = 'true' THEN 1 else 0 END, (v_person  ->> 'probationsearchconductedflag')::int4, 
--				(v_person  ->> 'drugexposednewbornflag')::int4, v_person  ->> 'otherdrugs', v_personroletypeid, v_person  ->> 'drugexposedkey',v_intakenumber);
--				end if;
--			    raise notice 'v_intakeservicerequestactorid%',v_intakeservicerequestactorid;
--				INSERT INTO intakeservicerequestactor
--				(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid, reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag, sexoffenderregisteredflag, probationsearchconductedflag,intakenumber,servicecaseid)
--				VALUES(v_intakeservicerequestactorid, v_actorid, v_role  ->> 'roletype', now(),v_securityuserid, now(), v_securityuserid, v_intakeserviceid, true, (v_role  ->> 'isprimary')::boolean, v_personid, 1, 1, 1, (v_person  ->> 'drugexposednewbornflag')::int4, case when v_person  ->> 'sexoffenderregisteredflag' = 'true' THEN 1 else 0 END, (v_person  ->> 'probationsearchconductedflag')::int4,v_intakenumber,(v_person  ->> 'servicecaseid')::uuid);
--			
--				INSERT INTO actorrelationship
--				(actorrelationshipid, relationshiptypekey, insertedby, insertedon, updatedby, updatedon, "timestamp", intakeserviceid, activeflag, intakeservicerequestactorid, effectivedate)
--				VALUES(gen_random_uuid(), 'SELF', v_securityuserid, now(), v_securityuserid, now(), null,v_intakeserviceid, 1, v_intakeservicerequestactorid, now());
--	
--			END IF;
--	 	END LOOP;
    END IF;

--added for alise name by venky -18-4 -19
for v_alsoknownas in select
	*
from
	json_array_elements(v_personalise) loop
	
	raise notice 'testest %',v_alsoknownas;
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

	end if;
	end loop;
end if;
return v_personid;
end;

$function$
