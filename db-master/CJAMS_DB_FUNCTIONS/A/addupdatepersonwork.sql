CREATE OR REPLACE FUNCTION cjams.addupdatepersonwork(v_personid uuid, workdetails json, v_intakeserviceid uuid, v_securityuserid character varying, isnew integer)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
declare 
v_date timestamp without time zone;
employerdetails json; 
occupationdetails json;
supervisordetails json;
employeraddress json;
contactdetails json;
careergoaldetails json;
careergoalid uuid;
personemployerdetailsid uuid;
begin
v_date := now();
employerdetails := workdetails  	->>  'employerdetails';
occupationdetails := workdetails  	->>  'occupationdetails';
supervisordetails := workdetails  	->>  'supervisordetails';
employeraddress := workdetails  	->>  'employeraddress';
contactdetails := workdetails  	->>  'contactdetails';
careergoaldetails := workdetails  	->>  'careergoaldetails';

IF isnew = 1 THEN
	IF (careergoaldetails is not null)
 	then
		insert into personworkcarrergoal
			(personworkcarrergoalid,personid,careergoals,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate)
			values
			(gen_random_uuid(),v_personid,careergoaldetails->>'careergoals',1,v_securityuserid,v_date,v_securityuserid,v_date,v_date)returning personworkcarrergoalid into
		careergoalid;
	end if;
	IF (employerdetails is not null)
 	then
		insert into personemployerdetail
			(personemployerdetailid,personid,employername,currentemployer,noofhours,duties,startdate,enddate,
				reasonforleaving,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,personworkcarrergoalid)
			values
			(gen_random_uuid(),v_personid,employerdetails->>'employername',(employerdetails ->>'currentemployer')::boolean,employerdetails->>'noofhours'
				,employerdetails->>'duties',(employerdetails->>'startdate')::timestamp,(employerdetails->>'enddate')::timestamp,employerdetails->>'reasonforleaving'
			,1,v_securityuserid,v_date,v_securityuserid,v_date,v_date,careergoalid)returning personemployerdetailid into
		personemployerdetailsid;
	end if;
	IF (occupationdetails is not null or employerdetails is not null or employeraddress is not null or contactdetails is not null or supervisordetails is not null)
 	then
		INSERT INTO personemployment
			(personemploymentid, employername, supervisorprefixtypekey, supervisorfirstname, supervisormiddlename, supervisorlastname, 
				supervisorsuffixtypekey, clienttitle, startdate, enddate, workschedule, emplymenttypekey, income, wagefreqtypekey, addresstypekey, 
				address1, address2, cityname, countytypekey, statetypekey, zip5no, workphone, email, 
				insertedon, insertedby, updatedon, updatedby, activeflag, personid,clientmergeid,personemployerdetailsid,promotedemploymentflag)
			VALUES(gen_random_uuid(), employerdetails->>'employername', supervisordetails->>'supervisorprefixtypekey', supervisordetails->>'supervisorfirstname', supervisordetails->>'supervisormiddlename'
				,supervisordetails->>'supervisorlastname', supervisordetails->>'supervisorsuffixtypekey', occupationdetails->>'clienttitle', (employerdetails->>'startdate')::timestamp, (employerdetails->>'enddate')::timestamp, occupationdetails->>'workschedule'
				,occupationdetails->>'emplymenttypekey', (occupationdetails->>'income')::numeric, occupationdetails->>'wagefreqtypekey', employeraddress->>'addresstypekey'
				, employeraddress->>'address1', employeraddress->>'address2', employeraddress->>'cityname', employeraddress->>'countytypekey'
				,employeraddress->>'statetypekey', (employeraddress->>'zip5no')::int, (contactdetails->>'workphone')::json, (contactdetails->>'email')::json
				,v_date,v_securityuserid,v_date,v_securityuserid,1, v_personid,v_personid,personemployerdetailsid,0);
	end if;
ELSE
	IF isnew = 3 THEN
		UPDATE personworkcarrergoal set activeflag = 0 where personid = v_personid and personworkcarrergoalid = (workdetails->>'personworkcarrergoalid')::uuid;
		UPDATE personemployerdetail set activeflag = 0 where personid = v_personid and personemployerdetailid = (workdetails->>'personemployerdetailid')::uuid;
		UPDATE personemployment set activeflag = 0 where personid = v_personid and personemploymentid = (workdetails->>'personemploymentid')::uuid;
	ELSE
		IF (careergoaldetails is not null)
	 	then
	 		UPDATE personworkcarrergoal set activeflag = 0 where personid = v_personid and personworkcarrergoalid = (workdetails->>'personworkcarrergoalid')::uuid;
			insert into personworkcarrergoal
			(personworkcarrergoalid,personid,careergoals,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate)
			values
			(gen_random_uuid(),v_personid,careergoaldetails->>'careergoals',1,v_securityuserid,v_date,v_securityuserid,v_date,v_date)returning personworkcarrergoalid into
		careergoalid;
		end if;
		IF (employerdetails is not null)
	 	then
	 		UPDATE personemployerdetail set activeflag = 0 where personid = v_personid and personemployerdetailid = (workdetails->>'personemployerdetailid')::uuid;
			insert into personemployerdetail
			(personemployerdetailid,personid,employername,currentemployer,noofhours,duties,startdate,enddate,
				reasonforleaving,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,personworkcarrergoalid)
			values
			(gen_random_uuid(),v_personid,employerdetails->>'employername',(employerdetails ->>'currentemployer')::boolean,employerdetails->>'noofhours'
				,employerdetails->>'duties',(employerdetails->>'startdate')::timestamp,(employerdetails->>'enddate')::timestamp,employerdetails->>'reasonforleaving'
			,1,v_securityuserid,v_date,v_securityuserid,v_date,v_date,careergoalid)returning personemployerdetailid into
		personemployerdetailsid;
		end if;
		IF (occupationdetails is not null or employerdetails is not null or employeraddress is not null or contactdetails is not null or supervisordetails is not null)
	 	then
	 		UPDATE personemployment set activeflag = 0 where personid = v_personid and personemploymentid = (workdetails->>'personemploymentid')::uuid;
			INSERT INTO personemployment
			(personemploymentid, employername, supervisorprefixtypekey, supervisorfirstname, supervisormiddlename, supervisorlastname, 
				supervisorsuffixtypekey, clienttitle, startdate, enddate, workschedule, emplymenttypekey, income, wagefreqtypekey, addresstypekey, 
				address1, address2, cityname, countytypekey, statetypekey, zip5no, workphone, email, 
				insertedon, insertedby, updatedon, updatedby, activeflag, personid,clientmergeid,personemployerdetailsid,promotedemploymentflag)
			VALUES(gen_random_uuid(), employerdetails->>'employername', supervisordetails->>'supervisorprefixtypekey', supervisordetails->>'supervisorfirstname', supervisordetails->>'supervisormiddlename'
				,supervisordetails->>'supervisorlastname', supervisordetails->>'supervisorsuffixtypekey', occupationdetails->>'clienttitle', (employerdetails->>'startdate')::timestamp, (employerdetails->>'enddate')::timestamp, occupationdetails->>'workschedule'
				,occupationdetails->>'emplymenttypekey', (occupationdetails->>'income')::numeric, occupationdetails->>'wagefreqtypekey', employeraddress->>'addresstypekey'
				, employeraddress->>'address1', employeraddress->>'address2', employeraddress->>'cityname', employeraddress->>'countytypekey'
				,employeraddress->>'statetypekey', (employeraddress->>'zip5no')::int, (contactdetails->>'workphone')::json, (contactdetails->>'email')::json
				,v_date,v_securityuserid,v_date,v_securityuserid,1, v_personid,v_personid,personemployerdetailsid,0);
	end if;
	end if;
END if;
	return v_personid;
end;
$function$
;
