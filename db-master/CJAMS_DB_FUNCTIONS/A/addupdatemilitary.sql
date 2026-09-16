-- FUNCTION: cjams.addupdatemilitary(uuid, json, character varying)


DROP FUNCTION IF EXISTS addupdatemilitary(uuid, json, character varying);

CREATE OR REPLACE FUNCTION cjams.addupdatemilitary(
	personid uuid,
	military json,
	securityuserid character varying)
    RETURNS TABLE("Pid" uuid, "personMilitaryServices" json) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$
 

DECLARE
    
    v_personid uuid;    
    v_securityuserid character varying;
    v_military json;
	v_result json;
	v_personmilitaryserviceid uuid;
	v_personmilitaryphoneid uuid;
	v_phonelist json;
	v_phone json;
	v_superiorphonelist json;
	v_superior json;

BEGIN
    
    v_personid := personid :: uuid;
    v_military := military;
    v_securityuserid := securityuserid;
	v_phonelist := v_military ->>'phonelist';
	v_superiorphonelist := v_military ->'superiorphonelist';

    raise notice 'v_phonelist%',v_phonelist ;
     raise notice 'v_superiorphonelist%',v_superiorphonelist;
   	raise notice 'military%',v_military;
	IF (v_military  ->> 'personmilitaryserviceid') IS NULL THEN
	
		v_personmilitaryserviceid := gen_random_uuid();
	
		INSERT INTO personmilitaryservices (
			personmilitaryserviceid,
		    personid, 
		    branchkey,
		    serviceid,
		    dutystation,
		    servicestatuskey,
		    startdate, 
			enddate,
			contactprefixkey,
			contactfirstname,
			contactmiddlename,
			contactlastname,
			contactsuffixkey,
			contactphonetypekey,
			contactphone,
			contactphoneextension,
			superiorprefixkey,
			superiorfirstname,
			superiormiddlename,
			superiorlastname,
			superiorsuffixkey,
			superiorphonetypekey,
			workphone,
			workxtn,
			adr1, 
			adr2,
			city,	
			state,
			county,
			zip5no,
			comments,
		    insertedby, 
		    insertedon
		    ) 
		values(
			v_personmilitaryserviceid,
		    v_personid,
			v_military  ->> 'branchkey',
			v_military  ->> 'serviceid',
			v_military  ->> 'dutystation',
			v_military  ->> 'servicestatuskey',
		    (v_military  ->> 'startdate')::timestamp,
			(v_military  ->> 'enddate')::timestamp,
			
			v_military  ->> 'contactprefixkey',
			v_military  ->> 'contactfirstname',
			v_military  ->> 'contactmiddlename',
			v_military  ->> 'contactlastname',
			v_military  ->> 'contactsuffixkey',			
			v_military  ->> 'contactphonetypekey',
			v_military  ->> 'contactphone',
			v_military  ->> 'contactphoneextension',
			
			v_military  ->> 'superiorprefixkey',
			v_military  ->> 'superiorfirstname',
			v_military  ->> 'superiormiddlename',
			v_military  ->> 'superiorlastname',
			v_military  ->> 'superiorsuffixkey',			
			v_military  ->> 'superiorphonetypekey',
			v_military  ->> 'workphone',
			v_military  ->> 'workxtn',
			
			v_military  ->> 'adr1',
			v_military  ->> 'adr2',
			v_military  ->> 'city',
			v_military  ->> 'state',			
			v_military  ->> 'county',
			(v_military  ->> 'zip5no')::numeric,
			v_military  ->> 'comments',
			
		    v_securityuserid, 
		    now()
		    );	
			
		
			
			if (v_phonelist is not null) then for v_phone in select
				*
			from
			json_array_elements(v_phonelist) loop 
			raise notice 'variable %',v_phone;
			insert into personmilitaryphone(personmilitaryserviceid,personsuperiortypekey,personphonetypekey,phonenumber,insertedby,updatedby,insertedon, updatedon)
			values (v_personmilitaryserviceid,'phone',v_phone  ->> 'personphonetypekey',v_phone  ->> 'phonenumber',v_securityuserid,v_securityuserid, now(), now());
	
			end loop;
			end if;
			
			if (v_superiorphonelist is not null) then for v_superior in select
				*
			from
			json_array_elements(v_superiorphonelist) loop 
			insert into personmilitaryphone(personmilitaryserviceid,personsuperiortypekey,personphonetypekey,phonenumber,insertedby,updatedby,insertedon, updatedon)
			values (v_personmilitaryserviceid,'superior',v_superior  ->> 'personphonetypekey',v_superior  ->> 'phonenumber',v_securityuserid,v_securityuserid, now(), now());
	
			end loop;
			end if;
		   
				
	ELSE
	
		UPDATE  personmilitaryservices ms 
		SET 			
			activeflag = 1,
			branchkey = v_military  ->> 'branchkey',
			serviceid = v_military  ->> 'serviceid',
			dutystation = v_military  ->> 'dutystation',
			servicestatuskey = v_military  ->> 'servicestatuskey',
		    startdate = (v_military  ->> 'startdate')::timestamp,
			enddate = (v_military  ->> 'enddate')::timestamp,		
			contactprefixkey = v_military  ->> 'contactprefixkey',
			contactfirstname = v_military  ->> 'contactfirstname',
			contactmiddlename = v_military  ->> 'contactmiddlename',
			contactlastname = v_military  ->> 'contactlastname',
			contactsuffixkey = v_military  ->> 'contactsuffixkey',			
			contactphonetypekey = v_military  ->> 'contactphonetypekey',
			contactphone = v_military  ->> 'contactphone',
			contactphoneextension = v_military  ->> 'contactphoneextension',
			superiorprefixkey = v_military  ->> 'superiorprefixkey',
			superiorfirstname = v_military  ->> 'superiorfirstname',
			superiormiddlename = v_military  ->> 'superiormiddlename',
			superiorlastname = v_military  ->> 'superiorlastname',
			superiorsuffixkey = v_military  ->> 'superiorsuffixkey',			
			superiorphonetypekey = v_military  ->> 'superiorphonetypekey',
			workphone = v_military  ->> 'workphone',
			workxtn = v_military  ->> 'workxtn',
			adr1 = v_military  ->> 'adr1',
			adr2 = v_military  ->> 'adr2',
			city = v_military  ->> 'city',
			state = v_military  ->> 'state',			
			county = v_military  ->> 'county',
			zip5no = (v_military  ->> 'zip5no')::numeric,
			comments = v_military  ->> 'comments',
			updatedby = v_securityuserid,
			updatedon = now()			
		WHERE ms.personmilitaryserviceid = (v_military  ->> 'personmilitaryserviceid') :: uuid;		
		
		    if (v_phonelist is not null) then 
			update personmilitaryphone set activeflag=0,
			updatedby = v_securityuserid, updatedon = now() 
			where personmilitaryserviceid= (v_military  ->> 'personmilitaryserviceid') :: uuid and personsuperiortypekey='phone';
			for v_phone in select
				*
			from
			json_array_elements(v_phonelist) loop 
			insert into personmilitaryphone(personmilitaryserviceid,personsuperiortypekey,personphonetypekey,phonenumber,insertedby, updatedby,insertedon, updatedon)
			values ((v_military  ->> 'personmilitaryserviceid') :: uuid,'phone',v_phone  ->> 'personphonetypekey',v_phone  ->> 'phonenumber',v_securityuserid,v_securityuserid, now(), now());
	
			end loop;
			end if;
			
			if (v_superiorphonelist is not null) then 
						update personmilitaryphone set activeflag=0, updatedby = v_securityuserid, updatedon = now()  where personmilitaryserviceid= (v_military  ->> 'personmilitaryserviceid') :: uuid and personsuperiortypekey='superior';
			for v_superior in select
				*
			from
			json_array_elements(v_superiorphonelist) loop 
			insert into personmilitaryphone(personmilitaryserviceid,personsuperiortypekey,personphonetypekey,phonenumber,insertedby,updatedby,insertedon, updatedon)
			values ((v_military  ->> 'personmilitaryserviceid') :: uuid,'superior',v_superior  ->> 'personphonetypekey',v_superior  ->> 'phonenumber',v_securityuserid,v_securityuserid, now(), now());
	
			end loop;
			end if;
	
	END IF;

RETURN QUERY

	SELECT p.personid AS "Pid",
	(SELECT to_json(pms) FROM 
	(
	SELECT 
		ms.personmilitaryserviceid, ms.branchkey, ms.serviceid, ms.dutystation, ms.servicestatuskey, ms.startdate, ms.enddate,
		ms.contactprefixkey, ms.contactfirstname, ms.contactmiddlename, ms.contactlastname, ms.contactsuffixkey, ms.contactphonetypekey,
		ms.contactphone, ms.contactphoneextension, ms.superiorprefixkey, ms.superiorfirstname, ms.superiormiddlename, ms.superiorlastname, 
		ms.superiorsuffixkey, ms.superiorphonetypekey, ms.workphone, ms.workxtn, ms.adr1, ms.adr2, ms.city, ms.state, ms.county, ms.zip5no, ms.comments
	FROM personmilitaryservices ms 
	WHERE ms.personid = p.personid AND ms.activeflag = 1 AND ms.personmilitaryserviceid = v_personmilitaryserviceid   
		
	) pms)::json AS "personMilitaryServices"
	FROM person p 
	WHERE p.personid = v_personid AND p.activeflag = 1;
 

END;

 
$BODY$;

