-- FUNCTION: addupdatephonenumber( uuid, json, character varying);

-- DROP FUNCTION addupdatephonenumber( uuid, json, character varying);
DROP FUNCTION IF EXISTS cjams.addupdatephonenumber(personid uuid, phonenumbers json, securityuserid character varying);
CREATE OR REPLACE FUNCTION cjams.addupdatephonenumber(personid uuid, phonenumbers json, securityuserid character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------
--Revision(s)
-- 05/31/2024 - Srinivas Tenali - CIDM-8963 PI24Q2 CJAMS CW - Person Profile - Primary Phone Number Enhancement (CIDM-8963)
-------------------------------------------------------------------------

DECLARE
    
    v_personid uuid;
    v_phonenumberjson json;
    v_securityuserid character varying;
    v_phonenumber json;
	v_result json;

	
BEGIN
    
    v_personid := personid :: uuid;
    v_phonenumberjson := phonenumbers;
    v_securityuserid := securityuserid;

-- Delete Person phone --
--UPDATE  personphonenumber  p SET  

--activeflag = 0 WHERE p.personid = v_personid;

FOR  v_phonenumber  IN  SELECT  *  FROM    json_array_elements(v_phonenumberjson)  LOOP

IF (v_phonenumber  ->> 'isprimary')::bool  
THEN

UPDATE  personphonenumber p SET  isprimary = false, updatedby=v_securityuserid, updatedon=now()
	WHERE p.personid = (v_personid)::uuid and p.isprimary is true;

END IF;
IF (v_phonenumber  ->> 'personphonenumberid') IS NULL THEN
insert into personphonenumber (
    personid, 
    personphonetypekey, 
    phonenumber,
    isprimary,
    phoneextension, 
    startdate,
	enddate,
    commentsphone,
    insertedby, 
    updatedby
    ) 
values(
    v_personid,
    v_phonenumber  ->> 'personphonetypekey',
    v_phonenumber  ->> 'phonenumber', 
    (v_phonenumber  ->> 'isprimary')::bool,
    v_phonenumber  ->> 'phoneextension',
    (v_phonenumber  ->> 'startdate')::timestamp,
	(v_phonenumber  ->> 'enddate')::timestamp,
     v_phonenumber ->> 'commentsphone',
     v_securityuserid, 
     v_securityuserid
    );

ELSE

UPDATE  personphonenumber  p SET  

activeflag = 1,
personphonetypekey = v_phonenumber  ->> 'personphonetypekey',
phonenumber = v_phonenumber  ->> 'phonenumber',
phoneextension =  v_phonenumber  ->> 'phoneextension',
isprimary = (v_phonenumber  ->> 'isprimary')::bool,
startdate =  (v_phonenumber  ->> 'startdate')::timestamp,
enddate =  (v_phonenumber  ->> 'enddate')::timestamp,
commentsphone = v_phonenumber ->> 'commentsphone',
updatedby = v_securityuserid,
updatedon = now()

WHERE p.personphonenumberid = (v_phonenumber  ->> 'personphonenumberid') :: uuid;

END IF;

END LOOP;



SELECT json_agg(pph) into v_result FROM 
	(
	select p.personphonenumberid, p.personid, p.personphonetypekey,p.isprimary, p.phonenumber, p.phoneextension, p.commentsphone from personphonenumber p where p.personid = v_personid and p.activeflag = 1    
		
	) pph;
	
RETURN v_result;

END;



$function$;
