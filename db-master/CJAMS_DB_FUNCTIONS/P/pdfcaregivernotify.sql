				
CREATE OR REPLACE FUNCTION cjams.pdfcaregivernotify(v_caregivernotifyid character varying)
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
					to_char(a.notifydate, 'MM-DD-YYYY') as notifydate ,
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
					(select ph.phonenumber
						from userprofilephonenumber ph 
					 where ph.securityusersid = a.insertedby::character varying 
						and ph.activeflag=1 ) as phonenumber,
						(select to_char (hearingdatetime, 'MM-DD-YYYY') as hearingtime 
					  from intakeservicerequestcourthearing 
					  where intakeservicerequestcourthearingid =a.intakeservicerequestcourthearingid) as hearingdate,
                      (select to_char (hearingdatetime, 'HH:MI AM') as hearingtime 
					  from intakeservicerequestcourthearing 
					  where intakeservicerequestcourthearingid =a.intakeservicerequestcourthearingid) as hearingtime,
					  (select concat(address ,' ' ,city ,' ', state, ' ',zipcode) as caregiveraddress 
					  from personaddress where personid =a.caregiverid and activeflag = 1 order by updatedon limit 1 ) as caregiveraddress,
					a.insertedby,
					a.insertedon as generatedon
					from caregivernotify a
					where a.caregivernotifyid =v_caregivernotifyid ::uuid
	
	
	)e),'[]') ;
	 
		RETURN l_caregivernotifylist;
END;

$function$
;