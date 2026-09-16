-- FUNCTION: cjams.listpersonhouseholdaddresses(uuid)

-- DROP FUNCTION cjams.listpersonhouseholdaddresses(uuid);

CREATE OR REPLACE FUNCTION cjams.listpersonhouseholdaddresses(
	intakeserviceid uuid)
    RETURNS TABLE( "houseHoldPersonsAddresses" json) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$



DECLARE
    
    v_intakeserviceid uuid;

	
BEGIN
    
    v_intakeserviceid := intakeserviceid;
	

RETURN QUERY

SELECT json_agg(phra) as "houseHoldPersonsAddresses" FROM 
	(
	select p.firstname, 
		p.lastname, 
		p.middlename,
		pa.* 
		from person p inner join personaddress pa on p.personid = pa.personid where pa.personid in 
		(select distinct personid from actor a where a.intakeserviceid = v_intakeserviceid and a.ishouseholdmember = 1 and a.activeflag = 1) 
		and pa.activeflag = 1 and pa.personaddresstypekey = '39'
	) phra;

END;



$BODY$;

ALTER FUNCTION cjams.listpersonhouseholdaddresses(uuid)
    OWNER TO welfareadmin;
