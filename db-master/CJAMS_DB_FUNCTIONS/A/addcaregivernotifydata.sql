CREATE OR REPLACE FUNCTION cjams.addcaregivernotifydata(caregivernotifydata json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
 
DECLARE
	v_caregivernotifydata json;
	v_caregivernotifyid uuid;
	
	
BEGIN 
	v_caregivernotifydata := caregivernotifydata;
	
	
	
			INSERT INTO cjams.caregivernotify
					(caregivernotifyid, 
					intakeservicerequestcourthearingid,
					objecttypekey,
					objectid,
					notifydate,
					persons,
					cargivers,
					caregiverid,
					courtname, 
					countaddreslineone,
					countaddreslinetwo,
					city, 
					state, 
					zipcode,
					roomnumber,
					activeflag,
					insertedby,
					insertedon)
					VALUES
						(gen_random_uuid(), 
						(v_caregivernotifydata->>'intakeservicerequestcourthearingid')::uuid,
						(v_caregivernotifydata->>'objecttypekey')::character varying,
						(v_caregivernotifydata->>'objectid')::character varying,
						(v_caregivernotifydata->>'notifydate')::timestamp,
						(v_caregivernotifydata->>'persons') ::json,
						(v_caregivernotifydata->>'cargivers') ::character varying,
						(v_caregivernotifydata->>'caregiverid')::uuid,
						(v_caregivernotifydata->>'countname')::character varying, 
						(v_caregivernotifydata->>'countaddreslineone')::character varying, 
						(v_caregivernotifydata->>'countaddreslinetwo')::character varying,  
						(v_caregivernotifydata->>'city')::character varying, 
						(v_caregivernotifydata->>'state')::character varying, 
						(v_caregivernotifydata->>'zipcode')::character varying, 
						(v_caregivernotifydata->>'roomnumber')::character varying, 
						1,
						(v_caregivernotifydata->>'insertedby')::character varying,  
						now())RETURNING "caregivernotifyid" INTO  v_caregivernotifyid;

	
    return 'Success';
END;

$function$
;
