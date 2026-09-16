CREATE OR REPLACE FUNCTION cjams.savereleasenotes(itemlist json, securityusersid character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_record 		json;
	v_releasedate 	date;
	v_releaseversionno character varying;

BEGIN
	
	IF (itemlist IS NOT NULL) THEN
		FOR v_record IN SELECT * FROM JSON_ARRAY_ELEMENTS(itemlist) 
		LOOP
			IF (v_releasedate IS NULL AND v_releaseversionno IS NULL) THEN
				v_releasedate = (v_record ->> 'Release_Date')::date;
				v_releaseversionno = (v_record ->> 'Release_Version_Number')::character varying;
			END IF;
		END LOOP;	
		
		IF (v_releasedate IS NOT NULL AND v_releaseversionno IS NOT NULL) THEN
			UPDATE 	defecttracking.releasenotes
					SET activeflag = 0,
						updatedon = now(),
						updatedby = securityusersid
					WHERE activeflag = 1
						AND releaseversionno = v_releaseversionno
						AND releasedate = v_releasedate;
		END IF;
		
		FOR v_record IN SELECT * FROM JSON_ARRAY_ELEMENTS(itemlist)
		LOOP
			INSERT INTO defecttracking.releasenotes
				(releaseversionno, 
				releasedate, 
				application, 
				itemtype, 
				itemid, 
				title, 
				description, 
				supportid, 
				documentlink, 
				raisedby,
				activeflag, insertedby, insertedon, updatedby, updatedon)
			VALUES((v_record ->> 'Release_Version_Number')::character varying,
				(v_record ->> 'Release_Date')::date,
				(v_record ->> 'Application')::character varying,
				(v_record ->> 'Item_Type')::character varying,
				(v_record ->> 'Item_Id')::character varying,
				(v_record ->> 'Title')::character varying,
				(v_record ->> 'Description')::text,
				(v_record ->> 'Support_Id')::character varying, 
				(v_record ->> 'Document_Link')::character varying,
				(v_record ->> 'Raised_By')::character varying,
				1, securityusersid, now(), securityusersid, now());
		END LOOP;
	END IF;
	
	RETURN 'Success';
END;

$function$
;
