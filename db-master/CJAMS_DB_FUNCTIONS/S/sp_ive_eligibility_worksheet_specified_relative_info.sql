Drop function if exists cjams.sp_ive_eligibility_worksheet_specified_relative_info(json);

CREATE OR REPLACE FUNCTION cjams.sp_ive_eligibility_worksheet_specified_relative_info(reqobj json)
 RETURNS TABLE(v_clientid bigint, v_specifiedrelativeclientid bigint, v_specifiedrelativedatechildlastlivedwith timestamp without time zone, v_specifiedrelativename character varying, v_specifiedrelativephysicaladdress character varying, v_specifiedrelativerelationshipid integer, v_specifiedrelativeid uuid, v_relationshiptochild character varying, v_removalid integer)
 LANGUAGE plpgsql
AS $function$ 

DECLARE
	v_clientid  BIGINT;
	v_clientid1  BIGINT;
	returnStatus text;
	v_num INT;
	v_specifiedrelativeclientid BIGINT;
	v_specifiedrelativedatechildlastlivedwith TIMESTAMP;
	v_specifiedrelativename varchar(50);
	v_specifiedrelativephysicaladdress varchar(500);   
	v_specifiedrelativerelationshipid int;
	v_specifiedrelativeid UUID;
    v_relationshiptochild varchar(50);
	v_record json;
	v_removalid INT;
	v_removalid1 INT;
   
begin
	
	select distinct k ->> 'clientId', k ->> 'removalid' into v_clientid1, v_removalid1 from json_array_elements(reqobj) k;
	
	DELETE FROM specifiedrelative WHERE toclientid = v_clientid1 and removalid = v_removalid1;

	FOR v_record IN SELECT * FROM json_array_elements(reqobj)
	LOOP		
			v_clientid := v_record ->> 'clientId';
			v_specifiedrelativeclientid := v_record ->> 'specifiedrelativeclientid';
			v_specifiedrelativedatechildlastlivedwith := v_record ->> 'specifiedrelativedatechildlastlivedwith';
			v_specifiedrelativename := v_record ->> 'specifiedrelativename';
			v_specifiedrelativephysicaladdress := v_record ->> 'specifiedrelativephysicaladdress';
			v_specifiedrelativerelationshipid := v_record ->> 'specifiedrelativerelationshipid';
            v_relationshiptochild := v_record ->> 'relationshiptochild';
			v_removalid := v_record ->> 'removalid';
			returnStatus := 'Success';
		
	
		INSERT INTO specifiedrelative(specifiedrelativeid, toclientid, activeflag, specifiedrelativeclientid, specifiedrelativedatechildlastlivedwith,
				specifiedrelativename, specifiedrelativephysicaladdress, specifiedrelativerelationshipid,relationshiptochild, removalid) 
					VALUES(gen_random_uuid() , v_clientid, 1, v_specifiedrelativeclientid, v_specifiedrelativedatechildlastlivedwith, 
				v_specifiedrelativename, v_specifiedrelativephysicaladdress, v_specifiedrelativerelationshipid, v_relationshiptochild, v_removalid::int);
		
	END LOOP;

RETURN QUERY
SELECT 

sr.toclientid  											as v_clientid,
sr.specifiedrelativeclientid							as v_specifiedrelativeclientid,
sr.specifiedrelativedatechildlastlivedwith				as v_specifiedrelativedatechildlastlivedwith,
sr.specifiedrelativename								as v_specifiedrelativename,
sr.specifiedrelativephysicaladdress						as v_specifiedrelativephysicaladdress,
sr.specifiedrelativerelationshipid						as v_specifiedrelativerelationshipid,
sr.specifiedrelativeid									as v_specifiedrelativeid,
sr.relationshiptochild                                  as v_relationshiptochild,
sr.removalid                                            as v_removalid

FROM specifiedrelative sr
WHERE sr.toclientid = v_clientid1 and sr.removalid = v_removalid1;
--RETURN format('%s', returnStatus);

end;
	
$function$
;