-- FUNCTION: cjams.addupdatepersonnarrative(uuid, json, uuid, character varying, integer)

-- DROP FUNCTION cjams.addupdatepersonnarrative(uuid, json, uuid, character varying, integer);

CREATE OR REPLACE FUNCTION cjams.addupdatepersonnarrative(
	v_personid uuid,
	workdetails json,
	v_intakeserviceid uuid,
	v_securityuserid character varying,
	isnew integer)
    RETURNS uuid
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
declare 
v_date timestamp without time zone;
begin
v_date := now();

IF isnew = 1 THEN
		INSERT INTO personemployment
			(personemploymentid, promotedemploymentprogramname, promotedemploymentprogramstartdate, promotedemploymentprogramenddate, promotedemploymentnarrative
				,insertedon, insertedby, updatedon, updatedby, activeflag, personid,clientmergeid,promotedemploymentflag)
			VALUES(gen_random_uuid(), workdetails->>'promotedemploymentprogramname', (workdetails->>'promotedemploymentprogramstartdate')::timestamp, (workdetails->>'promotedemploymentprogramenddate')::timestamp, workdetails->>'promotedemploymentnarrative'
				,v_date,v_securityuserid,v_date,v_securityuserid,1, v_personid,v_personid,1);
ELSE
	IF isnew = 3 THEN
		UPDATE personemployment set activeflag = 0 where personid = v_personid and personemploymentid = (workdetails->>'personemploymentid')::uuid;
	ELSE
		INSERT INTO personemployment
			(personemploymentid, promotedemploymentprogramname, promotedemploymentprogramstartdate, promotedemploymentprogramenddate, promotedemploymentnarrative
				,insertedon, insertedby, updatedon, updatedby, activeflag, personid,clientmergeid,promotedemploymentflag)
			VALUES(gen_random_uuid(), workdetails->>'promotedemploymentprogramname', (workdetails->>'promotedemploymentprogramstartdate')::timestamp, (workdetails->>'promotedemploymentprogramenddate')::timestamp, workdetails->>'promotedemploymentnarrative'
				,v_date,v_securityuserid,v_date,v_securityuserid,1, v_personid,v_personid,1);
	end if;
END if;
	return v_personid;
end;
$BODY$;

ALTER FUNCTION cjams.addupdatepersonnarrative(uuid, json, uuid, character varying, integer)
    OWNER TO welfareadmin;
