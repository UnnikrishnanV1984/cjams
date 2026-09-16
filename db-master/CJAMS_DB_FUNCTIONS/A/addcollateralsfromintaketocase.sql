DROP FUNCTION IF EXISTS cjams.addcollateralsfromintaketocase(v_intakeNumber CHARACTER VARYING, v_IntakeServiceId CHARACTER VARYING, v_securityuserid CHARACTER VARYING);

CREATE OR REPLACE FUNCTION cjams.addcollateralsfromintaketocase(v_intakeNumber CHARACTER VARYING, v_IntakeServiceId CHARACTER VARYING, v_securityuserid CHARACTER VARYING)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE  
v_caseid character varying;
v_intakeid CHARACTER VARYING;
v_collateralid character varying;
v_current_collateral record;
v_insertedby CHARACTER VARYING;
v_updatedby CHARACTER VARYING;
v_insertedon timestamp;
v_updatedon timestamp;


BEGIN
	v_caseid := v_IntakeServiceId;
	v_intakeid := v_intakeNumber;

	v_insertedby := v_securityuserid;
	v_updatedby := v_securityuserid;
	v_insertedon := now();
	v_updatedon := now();
  
	--  FOR v_ractor IN select * from collateral where (intakeserviceid = v_intakeserviceid or intakenumber = v_intakenumber) and activeflag = 1
	--  FOR v_current_collateral IN SELECT * FROM collateral WHERE intakenumber = v_intakeid and activeflag = 1
  	FOR v_current_collateral IN SELECT * FROM collateral WHERE (intakenumber = v_intakeid OR caseid::CHARACTER VARYING = v_intakeid) and activeflag = 1

  	LOOP
  
    SELECT gen_random_uuid() INTO v_collateralid;
   
	INSERT INTO collateral
		(collateralid, caseid, objecttype, prefixtypekey, firstname, middlename, lastname, suffixtypekey, dob, ssn, primaryracetypekey, relationshiptypekey, testifyflag, attestableinfo, familyknowledge, "comments", workphone, workextn, homephone, pager, email, fax, mobile, url, othercontacts, insertedon, insertedby, updatedon, updatedby, activeflag, datenotified, clientnotes, legalclientid, expungementflag, datavalidflag, clientmergeid, agencyname, old_id, title)
	SELECT
		v_collateralid::uuid, v_caseid::uuid, 'case', prefixtypekey, firstname, middlename, lastname, suffixtypekey, dob, ssn, primaryracetypekey, relationshiptypekey, testifyflag, attestableinfo, familyknowledge, "comments", workphone, workextn, homephone, pager, email, fax, mobile, url, othercontacts, v_insertedon, v_insertedby, v_updatedon, v_updatedby, activeflag, datenotified, clientnotes, legalclientid, expungementflag, datavalidflag, clientmergeid, agencyname, old_id, title
	FROM
	    collateral
	WHERE
	    collateralid::uuid = v_current_collateral.collateralid::uuid;
  
   	-- collateral addresses
	INSERT INTO collateraladdress
		(collateralid, addresstypekey, formattypekey, streetnumber, boxnumber, predirtypekey, streetname, streetsuffixtypekey, postdirtypekey, unittypekey, unitnumbertx, cityname, countytypekey, statetypekey, zip5no, zip4no, direction, foreignaddress, foreignstate, country, postalcode, defaultflag, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, streetnotes, old_id)
	SELECT
		v_collateralid::uuid, addresstypekey, formattypekey, streetnumber, boxnumber, predirtypekey, streetname, streetsuffixtypekey, postdirtypekey, unittypekey, unitnumbertx, cityname, countytypekey, statetypekey, zip5no, zip4no, direction, foreignaddress, foreignstate, country, postalcode, defaultflag, startdate, enddate, v_insertedon, v_insertedby, v_updatedon, v_updatedby, activeflag, streetnotes, old_id
	FROM
		collateraladdress CA
	WHERE
		CA.collateralid::uuid = v_current_collateral.collateralid::uuid AND CA.activeflag = 1;
	
	-- collateral roles
	INSERT INTO collateralroleconfig
		(collateralid, actortypekey, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id)
	SELECT
		v_collateralid::uuid, actortypekey, activeflag, effectivedate, v_insertedby, v_insertedon, v_updatedby, v_updatedon, old_id
	FROM
		collateralroleconfig CRG
	WHERE
		CRG.collateralid::uuid = v_current_collateral.collateralid::uuid AND CRG.activeflag = 1;


  END LOOP;
   
RETURN  'success';
END;

$function$
;