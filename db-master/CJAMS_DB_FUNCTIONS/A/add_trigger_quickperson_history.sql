CREATE OR REPLACE FUNCTION cjams.add_trigger_quickperson_history()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

--------------------------------------------------------
-- 01/25 - Veera Changes for Quick Person History
--------------------------------------------------------

DECLARE
	modifieddata_v jsonb;	
 
BEGIN
	  INSERT INTO cjams.quickperson_history (quickpersonid, caseid, firstname, middlename, lastname, dob, ssn, insertedon, insertedby, 
	  updatedon, updatedby, activeflag, legalclientid, expungementflag, datavalidflag, clientmergeid, old_id, intakenumber, objecttype,
	  etl_userid, etl_load_date,  personid)
		      SELECT quickpersonid, caseid, firstname, middlename, lastname, dob, ssn, insertedon, insertedby, updatedon, updatedby,
		      activeflag, legalclientid, expungementflag, datavalidflag, clientmergeid, old_id, intakenumber, objecttype,
		      etl_userid, etl_load_date, personid 
		      FROM cjams.quickperson
		      WHERE quickpersonid = new.quickpersonid;
  
  RETURN null;
END;
$function$
;

DROP TRIGGER IF EXISTS add_quickperson_history ON cjams.quickperson;

create trigger add_quickperson_history after
insert
    or
update
    on quickperson for each row execute procedure add_trigger_quickperson_history();


