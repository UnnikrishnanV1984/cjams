Drop function if exists sp_get_person_mdm_phone(uuid);

CREATE OR REPLACE FUNCTION cjams.sp_get_person_mdm_phone(person_id uuid)
 RETURNS TABLE(personid uuid, "dateOfBirth" character varying, "sourceSystem" character varying, "sourceKey" character varying, "requestId" bigint, "role" character varying, "genderCd" character varying, names json, phones json)
--  RETURNS TABLE(personid uuid, cjamspid bigint, "dateOfBirth" character varying, "sourceSystem" character varying, "sourceKey" character varying, "requestId" bigint, "role" character varying, "genderCd" character varying, "mdmId" character varying, addresses json, phones json, "emailAddresses" json)
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
-- Revision(s)
-- 02/06/2026 - Sandeep kiran Anugolu 
-- To get details for person save for phone(CIDM-11131)
-------------------------------------------------------------------------------------------
DECLARE 
	vs_person_id uuid;
		
BEGIN
	vs_person_id := person_id;

	RETURN QUERY
		
		SELECT 
		p.personid,
		-- p.cjamspid,	
		(SELECT TO_CHAR(((p.dob) :: date),'MM-DD-YYYY')):: character varying AS "dateOfBirth",
		('CJAMS') :: character varying AS "sourceSystem",
		(p.cjamspid ) :: character varying AS "sourceKey",
		(SELECT nextval('MDMrequestId') AS "requestId"),
		('PERSON' ) :: character varying AS "role",
		(select distinct mdmcode AS "genderCd" from referencevalues where referencetypeid = 301 AND (mdmcode is not null OR mdmcode != '') AND ref_key = p.gendertypekey),
		( 
			SELECT 
				Json_agg(e) AS "names" 
			FROM 
			( 
				SELECT
					'LEGAL' AS "nameTypeCode",
					trim(p.lastname) AS "lastName",
					trim(p.middlename) AS "middleName",
					trim(p.firstname) AS  "firstName"
				FROM person p                     
				WHERE p.personid = vs_person_id

				UNION

				SELECT
					(CASE WHEN a.akatypetypekey = 'MN' THEN 'MAIDEN' WHEN a.akatypetypekey = 'AN' THEN 'ALIAS' END) AS "nameTypeCode",
					trim(a.lastname) AS "lastName",
					trim(a.middlename) AS "middleName",
					trim(a.firstname) AS  "firstName"	
					
				FROM alias a                     
				WHERE a.personid = vs_person_id and a.akatypetypekey in ('MN', 'AN') and a.lastname is not null and trim(a.lastname) != '' and a.firstname is not null and trim(a.firstname) != '' and a.activeflag = 1
			) AS e
		) ::json,
		( 
			SELECT 
				Json_agg(e) AS "phones" 
			FROM 
			( 
				SELECT
					(select distinct mdmcode AS "phoneType" from referencevalues where referencetypeid = 173 AND (mdmcode is not null OR mdmcode != '') AND ref_key = pn.personphonetypekey),
					(select distinct mdmcode AS "phoneCommType" from referencevalues where referencetypeid = 201 AND (mdmcode is not null OR mdmcode != '') AND ref_key = pn.personphonetypekey),
					trim(pn.phonenumber) AS "phoneNumber",
					TO_CHAR(pn.startdate::date,'MM-DD-YYYY') AS "phoneEffectiveBeginDate",
					TO_CHAR(pn.enddate::date,'MM-DD-YYYY') AS "phoneEffectiveEndDate"

				FROM personphonenumber pn                    
				WHERE pn.personid = vs_person_id and pn.activeflag = 1 and trim(phonenumber) != '' and 
				pn.personphonetypekey in (select distinct ref_key from referencevalues where referencetypeid = 173 AND (mdmcode is not null OR mdmcode != ''))
				-- AND pn.isprimary = true
				order by pn.updatedon  desc 
			) AS e
		) ::json
		FROM
			person p
		WHERE
			p.personid = vs_person_id 
		LIMIT 1;

	END;
    
$function$
;