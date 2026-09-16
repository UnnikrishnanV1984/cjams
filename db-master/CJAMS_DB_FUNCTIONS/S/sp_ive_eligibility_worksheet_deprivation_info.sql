Drop function if exists sp_ive_eligibility_worksheet_deprivation_info(json);

CREATE OR REPLACE FUNCTION cjams.sp_ive_eligibility_worksheet_deprivation_info(reqobj json)
 RETURNS TABLE(v_clientid bigint, v_reasonforabsence character varying, v_deprivationtype character varying, v_dateofparentdeath date, v_dateofincarceration date, v_ivepersondeprivationid uuid, v_removalid integer, v_parentid integer, v_relationship character varying, v_childdeprivedofparentalsupport character varying, v_isunemployment character varying, v_nameofhouseholdmember character varying, v_relationshiptochild character varying)
 LANGUAGE plpgsql
AS $function$ 

DECLARE
	v_clientid  bigint;
	v_clientid1  bigint;
	returnStatus text;
	v_num INT;	
	v_reasonforabsence VARCHAR; 
	v_deprivationtype VARCHAR;
	v_dateofparentdeath DATE; 
	v_dateofincarceration DATE;
	v_ivepersondeprivationid UUID;
	v_counter json;
	v_childdeprivedofparentalsupport VARCHAR(20);
	v_isunemployment VARCHAR(20);
	v_removalid INT;
	v_removalid1 INT;
    v_nameofhouseholdmember VARCHAR(50);
    v_relationshiptochild VARCHAR(50);
	
   
BEGIN

	select distinct k ->> 'clientId', k ->> 'removalid' into v_clientid1, v_removalid1 from json_array_elements(reqobj) k;
	DELETE FROM ivepersondeprivation WHERE clientid = v_clientid1 and removalid = v_removalid1;

		FOR v_counter IN SELECT * FROM json_array_elements(reqobj)
		loop
			RAISE NOTICE 'JSON DATA %', reqobj;
			RAISE NOTICE 'V_COUNTER VALUE1 %', v_counter;
			v_ivepersondeprivationid := v_counter ->> 'ivepersondeprivationid';
			v_clientid := v_counter ->> 'clientId';	
			v_reasonforabsence := v_counter ->> 'reasonforabsence';
			v_deprivationtype := v_counter ->> 'deprivationtype';
			v_dateofparentdeath := v_counter ->> 'dateofparentdeath';
			v_dateofincarceration := v_counter ->> 'dateofincarceration';
			v_removalid := v_counter ->> 'removalid';
			v_parentid := v_counter ->> 'parentid';
			v_relationship := v_counter ->> 'relationship';
			v_childdeprivedofparentalsupport := v_counter ->> 'childdeprivedofparentalsupport';
			v_isunemployment := v_counter ->> 'isunemployment';
            v_nameofhouseholdmember := v_counter ->> 'nameofhouseholdmember';
            v_relationshiptochild := v_counter ->> 'relationshiptochild';
			RAISE NOTICE 'client id  %', v_clientid;
			returnStatus := 'Success';

			INSERT INTO ivepersondeprivation(ivepersondeprivationid, clientid, activeflag, reasonforabsence, deprivationtype, dateofparentdeath, dateofincarceration,
						removalid, parentid, relationship,childdeprivedofparentalsupport, isunemployment, nameofhouseholdmember, relationshiptochild) 
				VALUES(gen_random_uuid() , v_clientid, 1, v_reasonforabsence, v_deprivationtype, v_dateofparentdeath, v_dateofincarceration,v_removalid,
				v_parentid,v_relationship, v_childdeprivedofparentalsupport, v_isunemployment, v_nameofhouseholdmember, v_relationshiptochild);
		END loop;

RETURN QUERY
SELECT 

ipd.clientid  				as v_clientid,
ipd.reasonforabsence		as v_reasonforabsence,
ipd.deprivationtype			as v_deprivationtype,
ipd.dateofparentdeath		as v_dateofparentdeath,
ipd.dateofincarceration		as v_dateofincarceration,
ipd.ivepersondeprivationid	as v_ivepersondeprivationid,
ipd.removalid as v_removalid,
ipd.parentid as v_parentid,
ipd.relationship as v_relationship,
ipd.childdeprivedofparentalsupport as v_childdeprivedofparentalsupport,
ipd.isunemployment as v_isunemployment,
ipd.nameofhouseholdmember as v_nameofhouseholdmember,
ipd.relationshiptochild as v_relationshiptochild
FROM  ivepersondeprivation ipd
WHERE  ipd.clientid = v_clientid1 and ipd.removalid = v_removalid1;

--RETURN format('%s', returnStatus);

END;
	
$function$
;
