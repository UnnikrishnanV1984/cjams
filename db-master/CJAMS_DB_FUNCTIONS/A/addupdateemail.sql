-- FUNCTION: addupdatephoneemail( uuid, json, character varying);

-- DROP FUNCTION addupdateemail( uuid, json, character varying);

	CREATE OR REPLACE FUNCTION cjams.addupdateemail(personid uuid, emails json, securityuserid character varying)
	 RETURNS json
	 LANGUAGE plpgsql
	AS $function$
	
	
	
	DECLARE
	    
	    v_personid uuid;
	    v_emailjson json;
	    v_securityuserid character varying;
	    v_email json;
		v_result json;
	
		
	BEGIN
	    
	    v_personid := personid :: uuid;
	    v_emailjson := emails;
	    v_securityuserid := securityuserid;
	
	-- Delete Person email --
	--UPDATE  personemail  e SET  
	
	--activeflag = 0 WHERE e.personid = v_personid;
	
	FOR  v_email  IN  SELECT  *  FROM    json_array_elements(v_emailjson)  LOOP
	
	IF (v_email  ->> 'personemailid') IS NULL THEN
	
	insert into personemail (
	    personid, 
	    personemailtypekey, 
	    email, 
	    startdate,
	    enddate,
		commentsemail,
	    insertedby, 
	    updatedby
	    ) 
	values(
	    v_personid,
	    v_email  ->> 'personemailtypekey',
	    v_email  ->> 'email',
	    ( v_email  ->> 'startdate')::timestamp,
		(v_email  ->> 'enddate')::timestamp,
		 v_email ->> 'commentsemail',
	    v_securityuserid, 
	    v_securityuserid
	    );
	
	ELSE
	
	UPDATE  personemail e SET  
	
	activeflag = 1,
	personemailtypekey = v_email  ->> 'personemailtypekey',
	email = v_email  ->> 'email',
	startdate= (v_email  ->> 'startdate')::timestamp,
	enddate=(v_email  ->> 'enddate')::timestamp,
	commentsemail = v_email ->> 'commentsemail',
	updatedby = v_securityuserid,
	updatedon = now()
	
	WHERE e.personemailid = (v_email  ->> 'personemailid') :: uuid;
	
	END IF;
	
	END LOOP;
	
	
	
	SELECT json_agg(pe) into v_result FROM 
		(
		select e.personemailid, e.personid, e.personemailtypekey, e.email, e.commentsemail from personemail e where e.personid = v_personid and e.activeflag = 1    
			
		) pe;
		
	RETURN v_result;
	
	END;
	
	
	
	$function$;