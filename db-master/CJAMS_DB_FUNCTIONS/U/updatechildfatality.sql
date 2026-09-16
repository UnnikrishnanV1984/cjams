DROP FUNCTION IF EXISTS cjams.updatechildfatality;

--Revision(s)
--  -6/25/2025 -Triveni Bala --CIDM-10541-Child Fatality Radio Button- Added function to audit trail
--  -01/23/2026 - Vamshikri.byreddy --CIDM-10829-SDM story- Capturing audit trail for service case

CREATE OR REPLACE FUNCTION cjams.updatechildfatality(v_intakeserviceid character varying, v_childfatality text, v_sdmid character varying, v_securityid character varying, v_casenumber character varying, v_fatalitypersons jsonb, v_servicecase boolean  DEFAULT false)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE
begin
	
	UPDATE cjams.intakeservicerequestsdm
    SET ischildfatality = (v_childfatality = 'yes'),
    updatedby = v_securityid::uuid,
	updatedon = now()
    WHERE intakeservicerequestsdmid = v_sdmid::uuid;

	insert into cjams.sdmtraffickingaudittrail(
		intakeservicerequestsdmid,
		updatedby,
		updatedon,
		objecttype,
		objectid,
		insertedby,
		insertedon,
		objectkey,
		ischildfatality,
		fatalitypersons
		)
values(
		v_sdmid::uuid,
		v_securityid::uuid,
		now(),
		CASE
            WHEN v_servicecase THEN 'Service Case'
            WHEN NULLIF(v_intakeserviceid, '') IS NULL THEN 'Intake'
            ELSE 'CPS Case'
        END,
		v_casenumber,
		v_securityid::uuid,
		now(),
		'childfatality',
		v_childfatality,
		v_fatalitypersons
	);

	RETURN 'SUCCESS';
END 
$function$
;