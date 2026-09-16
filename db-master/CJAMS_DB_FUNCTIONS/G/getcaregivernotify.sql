CREATE OR REPLACE FUNCTION cjams.getcaregivernotify(v_intakeservicerequestcourthearingid character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$   
   
DECLARE   

l_caregivernotifylist json;

BEGIN     
     
	select coalesce ((select json_agg(e) 
		into l_caregivernotifylist 
	from (
	
					select 
					a.caregivernotifyid ,
					a.notifydate,
					a.persons , 
					a.cargivers,
					a.courtname,
					a.countaddreslineone,
					a.countaddreslinetwo,
					a.city, 
					a.state,
					a.zipcode,
					a.roomnumber,
					(select up.firstname || ' ' || up.lastname 
						from userprofile up 
					 where up.securityusersid = a.insertedby::character varying 
						and up.activeflag=1 ) as generatedby,
					a.insertedby,
					a.insertedon as generatedon
					from caregivernotify a
					where a.intakeservicerequestcourthearingid =v_intakeservicerequestcourthearingid ::uuid
	
	
	)e),'[]') ;
	 
		RETURN l_caregivernotifylist;
END;

$function$
;
