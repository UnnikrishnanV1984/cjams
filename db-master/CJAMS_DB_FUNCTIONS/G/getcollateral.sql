DROP FUNCTION IF EXISTS cjams.getcollateral(v_IntakeServiceID character varying(50));


CREATE OR REPLACE FUNCTION cjams.getcollateral(v_IntakeServiceID character varying(50))
 RETURNS TABLE(
    collateralida uuid ,
	referralid uuid ,
	caseid uuid ,
	prefixtypekey varchar(50) ,
	firstname varchar(100) ,
	middlename varchar(100) ,
	lastname varchar(100) ,
	suffixtypekey varchar(50) ,
	dob timestamp ,
	ssn numeric ,
	primaryracetypekey varchar(50) ,
	relationshiptypekey varchar(50) ,
	testifyflag int4 ,
	attestableinfo varchar(1000) ,
	familyknowledge varchar(1000) ,
	"comments" varchar(1000) ,
	workphone varchar(10) ,
	workextn varchar(10) ,
	homephone varchar(50) ,
	pager varchar(20) ,
	email varchar(200) ,
	fax varchar(100) ,
	mobile varchar(20) ,
	url varchar(200) ,
	othercontacts varchar(500) ,
	insertedon timestamp ,
	insertedby varchar(10) ,
	updatedon timestamp ,
	updatedby varchar(10) ,
	activeflag int4 ,
	datenotified timestamp ,
	clientnotes varchar(2000) ,
	legalclientid int4 ,
	expungementflag int4 ,
	datavalidflag int4 ,
	clientmergeid uuid ,
	agencyname varchar(100) ,
	old_id varchar(12) ,
	collateraladdressid uuid ,
	collateralid uuid ,
	addresstypekey varchar(50) ,
	formattypekey varchar(50) ,
	streetnumber int4 ,
	boxnumber int4 ,
	predirtypekey varchar(50) ,
	streetname varchar(100) ,
	streetsuffixtypekey varchar(50) ,
	postdirtypekey varchar(50) ,
	unittypekey varchar(50) ,
	unitnumbertx varchar(500) ,
	cityname varchar(100) ,
	countytypekey varchar(50) ,
	statetypekey varchar(50) ,
	zip5no int4 ,
	zip4no int4 ,
	direction varchar(500) ,
	foreignaddress varchar(20) ,
	foreignstate varchar(20) ,
	country varchar(20) ,
	postalcode varchar(20) ,
	defaultflag int4 ,
	startdate timestamp ,
	enddate timestamp ,
	insertedona timestamp ,
	insertedbya varchar(10) ,
	updatedona timestamp ,
	updatedbya varchar(10) ,
	activeflaga int4,
	streetnotes varchar(2000) ,
	old_ida varchar(12) 
 )
 LANGUAGE plpgsql
AS $function$
DECLARE 

BEGIN
RETURN QUERY               
select * from collateral c
inner join collateraladdress ca on ca.collateralid=c.collateralid
where c.caseid in (
v_IntakeServiceID :: uuid,
(SELECT DISTINCT intakeserviceid:: uuid FROM intakeservicerequest WHERE servicecaseid::text =v_IntakeServiceID  LIMIT 1),
(SELECT DISTINCT intakenumber:: uuid FROM intakeservicerequestactor WHERE (servicecaseid::text =v_IntakeServiceID OR intakeserviceid::text =v_IntakeServiceID )  LIMIT 1),
(SELECT DISTINCT servicecaseid:: uuid FROM intakeservicerequestactor WHERE (servicecaseid::text =v_IntakeServiceID OR intakeserviceid::text =v_IntakeServiceID ) LIMIT 1)
); 
END;
$function$
;