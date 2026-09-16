-- FUNCTION: updatepersonaddresscurrentlocation( uuid, uuid);

-- DROP FUNCTION updatepersonaddresscurrentlocation( uuid, uuid);

CREATE OR REPLACE FUNCTION updatepersonaddresscurrentlocation( personaddressid uuid, securityuserid uuid)
    RETURNS json 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$



DECLARE
    
    v_personid uuid;
    v_personaddressid uuid;
    v_securityuserid uuid;
	v_result json;

	
BEGIN
    
    v_personaddressid := personaddressid :: uuid;
    v_securityuserid := securityuserid :: uuid;
    
    select pa.personid into v_personid from personaddress pa where pa.personaddressid = v_personaddressid;

    update personaddress set 
    currentlocationflag = 0,
    updatedby = v_securityuserid,
    updatedon = now()  where personid = v_personid; 

    update personaddress pa set 
    currentlocationflag = 1,
    updatedby = v_securityuserid,
    updatedon = now()  where pa.personaddressid = v_personaddressid;
    
    
    select json_agg(e) into v_result from (select 

    pa.personaddressid,
    pa.currentlocationflag

    from personaddress pa where pa.personid = v_personid) e;

	
RETURN v_result;

END;



$BODY$;

ALTER FUNCTION updatepersonaddresscurrentlocation( personaddressid uuid, securityuserid uuid)
    OWNER TO welfareadmin;
