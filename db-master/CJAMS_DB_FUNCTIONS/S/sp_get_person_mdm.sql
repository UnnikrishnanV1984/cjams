Drop function if exists sp_get_person_mdm(uuid);

CREATE OR REPLACE FUNCTION cjams.sp_get_person_mdm(person_id uuid)
 RETURNS TABLE(personid uuid, "countryOfOrigin" character varying, "alienNumber" character varying, "primaryCitizenshipCd" character varying, "requestId" bigint, "sourceSystem" character varying, "sourceKey" character varying, role character varying, names json, "languageCd" character varying, "genderCd" character varying, "dateOfBirth" character varying, "eyeColor" character varying, "hairColor" character varying, "deathDate" character varying, "maritalStatusCd" character varying, "raceCd" character varying, ssn character varying, "mdmId" character varying, "ethnicityCd" character varying, "driverLicenseNumber" character varying, addresses json, phones json, "emailAddresses" json, "hearingImpairCd" character varying, "visualImpairCd" character varying)
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
-- Revision(s)
-- 11/03/2022 - Vineet Tirodkar 
-- To fix the Person name with spaces and Alien Registration Number issues (CIDM-6014)
-- 12/07/2022 - Vineet Tirodkar 
-- To fix haircolortypekey and prefixCode to match with MDM codes (CDM-18629) 
-- 4/26/2024 - Chandra Ramasamy -- To send latest phone no and addrss fix
-------------------------------------------------------------------------------------------
DECLARE 
	vs_person_id uuid;
		
BEGIN
	vs_person_id := person_id;

	RETURN QUERY
		SELECT
		"Person".personid,
		(select distinct mdmcode from referencevalues where referencetypeid = 310 AND (mdmcode is not null OR mdmcode != '') AND ref_key = "Person".primarycitizenshiptypekey) AS "countryOfOrigin",
		(case when length("Person".alienregistrationtext) >= 8
				and length("Person".alienregistrationtext) <= 9 then
			trim("Person".alienregistrationtext)
		else
			null
		end )::character varying AS "alienNumber",	
		-- "Person".alienregistrationtext AS "alienNumber",
		(case when "Person".citizenalenageflag = '1' then 'C' else null end):: character varying AS "primaryCitizenshipCd",
		(SELECT nextval('MDMrequestId') AS "requestId"),
		('CJAMS') :: character varying AS "sourceSystem",
		("Person".cjamspid ) :: character varying AS "sourceKey",
		('PERSON' ) :: character varying AS "role",
		( 
			SELECT 
				Json_agg(e) AS "names" 
			FROM 
			( 
				SELECT
					'LEGAL' AS "nameTypeCode",
					(case when trim(p.prefx) = 'Dr.' then NULL else 
					(select distinct mdmcode from referencevalues where referencetypeid = 309 AND (mdmcode is not null OR mdmcode != '') AND ref_key = p.prefx) end ) AS "prefixCode",
					(select distinct mdmcode from referencevalues where referencetypeid = 302 AND (mdmcode is not null OR mdmcode != '') AND ref_key = trim(p.suffix)) AS "sufixCode",	
					trim(p.lastname) AS "lastName",
					trim(p.middlename) AS "middleName",
					trim(p.firstname) AS  "firstName",
					CONCAT(trim(p.firstname),' ', trim(p.middlename),' ', trim(p.lastname)) AS "fullName",
					(SELECT TO_CHAR(((now()) :: date),'MM-DD-YYYY')) AS "nameEffectiveStartDate",
					('12-31-9999') :: character varying AS "nameEffectiveEndDate"
					
				FROM person p                     
				WHERE p.personid = vs_person_id

				UNION

				SELECT
					(CASE WHEN a.akatypetypekey = 'MN' THEN 'MAIDEN' WHEN a.akatypetypekey = 'AN' THEN 'ALIAS' END) AS "nameTypeCode",
					(select distinct mdmcode from referencevalues where referencetypeid = 309 AND (mdmcode is not null OR mdmcode != '') AND ref_key = trim(a.prefixtypekey)) AS "prefixCode",
					(select distinct mdmcode from referencevalues where referencetypeid = 302 AND (mdmcode is not null OR mdmcode != '') AND ref_key = trim(a.sfxname)) AS "sufixCode",	
					trim(a.lastname) AS "lastName",
					trim(a.middlename) AS "middleName",
					trim(a.firstname) AS  "firstName",
					CONCAT(trim(a.firstname),' ', trim(a.middlename),' ', trim(a.lastname)) AS "fullName",
					(SELECT TO_CHAR(((now()) :: date),'MM-DD-YYYY')) AS "nameEffectiveStartDate",
					('12-31-9999') :: character varying AS "nameEffectiveEndDate"
					
				FROM alias a                     
				WHERE a.personid = vs_person_id and a.akatypetypekey in ('MN', 'AN') and a.lastname is not null and trim(a.lastname) != '' and a.firstname is not null and trim(a.firstname) != '' and a.activeflag = 1) AS e
		) ::json,
		(select distinct mdmcode AS "languageCd" from referencevalues where referencetypeid = 27 AND (mdmcode is not null OR mdmcode != '') AND ref_key = "Person".primarylanguage),--"Person".primarylanguage AS languageCd,
		(select distinct mdmcode AS "genderCd" from referencevalues where referencetypeid = 301 AND (mdmcode is not null OR mdmcode != '') AND ref_key = "Person".gendertypekey),--"Person".gendertypekey AS genderCd,
		(SELECT TO_CHAR((("Person".dob) :: date),'MM-DD-YYYY')):: character varying AS "dateOfBirth",
		("Person".eyecolortypekey)::character varying AS "eyeColor",
		(select distinct mdmcode AS "hairColor" from referencevalues where referencetypeid = 348 AND (mdmcode is not null OR mdmcode != '') AND ref_key = "Person".haircolortypekey),
		(SELECT TO_CHAR((("Person".dateofdeath) :: date),'MM-DD-YYYY')):: character varying AS "deathDate",
		(select distinct mdmcode AS "maritalStatusCd" from referencevalues where referencetypeid = 118 AND (mdmcode is not null OR mdmcode != '') AND ref_key = "Person".maritalstatustypekey),--"Person".maritalstatustypekey AS maritalStatusCd,
		(select distinct mdmcode AS "raceCd" from referencevalues where referencetypeid = 171 AND (mdmcode is not null OR mdmcode != '') AND ref_key = "Person".race),--"Person".race AS raceCd,
		(SELECT trim(personidentifiervalue)::varchar from personidentifier pi where pi.personid = vs_person_id and personidentifiertypekey = 'SSN' and activeflag = 1) AS "ssn",
		(SELECT trim(personidentifiervalue)::varchar from personidentifier pi where pi.personid = vs_person_id and personidentifiertypekey = 'MDM_ID' and activeflag = 1) AS "mdmId",
		(select distinct mdmcode AS "ethnicityCd" from referencevalues where referencetypeid = 300 AND (mdmcode is not null OR mdmcode != '') AND ref_key = "Person".ethnicity),--"Person".ethnicity AS ethnicityCd,
		(SELECT trim(personidentifiervalue)::varchar from personidentifier pi where pi.personid = vs_person_id and personidentifiertypekey = 'DL' and activeflag = 1) AS "driverLicenseNumber",
		( 
			SELECT 
				Json_agg(e) AS "addresses" 
			FROM 
			( 
				SELECT     
					trim(pa.address) AS "addressLine1",
					trim(pa.address2) AS "addressLine2",
					trim(pa.city) AS "addressCity",
					trim(pa.state) AS "addressState",
					trim(pa.county) AS "addressCounty",
					trim(pa.zipcode) AS "addressZip",
					trim(pa.country) AS "addressCountry",
					TO_CHAR(pa.effectivedate::date,'MM-DD-YYYY') AS "addressEffectiveBeginDate",
					TO_CHAR(pa.expirationdate::date,'MM-DD-YYYY') AS "addressEffectiveEndDate",
					(select distinct mdmcode AS "addressType" from referencevalues where referencetypeid = 172 AND (mdmcode is not null OR mdmcode != '') AND ref_key = pa.personaddresstypekey)                 
				FROM personaddress  pa                  
				WHERE pa.personid = vs_person_id and pa.activeflag = 1 and pa.personaddresstypekey in (select distinct ref_key from referencevalues where referencetypeid = 172 AND (mdmcode is not null OR mdmcode != ''))
				order by pa.updatedon  desc
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
		) ::json,

		( 
			SELECT 
				Json_agg(e) AS "emailAddresses" 
			FROM 
			( 
				SELECT   
					'PERSONAL' AS "emailType",
					'EMAIL' AS "emailCommType",
					trim(email) AS "emailAddress",
					TO_CHAR(pm.startdate::date,'MM-DD-YYYY') AS "emailEffectiveBeginDate",
					TO_CHAR(pm.enddate::date,'MM-DD-YYYY') AS "emailEffectiveEndDate"
				FROM personemail  pm                  
				WHERE pm.personid = vs_person_id and activeflag = 1 and pm.personemailtypekey = 'P') AS e
		) ::json,
		(SELECT trim(disabilitytypekey) FROM persondisability pdb WHERE pdb.personid = vs_person_id AND trim(disabilitytypekey) = 'HDY' AND activeflag = 1 AND disabilityflag = 1 ):: character varying AS "hearingImpairCd" ,
		(SELECT trim(disabilitytypekey) FROM persondisability pdb WHERE pdb.personid = vs_person_id AND trim(disabilitytypekey) = 'VIDY' AND activeflag = 1 AND disabilityflag = 1 ):: character varying AS "visualImpairCd"
			
	FROM  
	(
		SELECT        
			p.personid,
			trim(p.primarycitizenshiptypekey)::varchar as primarycitizenshiptypekey,
			trim(p.alienregistrationtext) as alienregistrationtext,
			p.citizenalenageflag,
			p.cjamspid,
			trim(p.firstname) as firstname,
			trim(p.lastname) as lastname,
			trim(p.middlename) as middlename ,
			trim(p.suffix) as suffix,
			trim(p.primarylanguageid) AS "primarylanguage",
			trim(p.gendertypekey) as gendertypekey,
			p.dob,
			-- p.eyecolortypekey,
			(select trim(mdmcode) as mdmcode
				from tb_picklist_values
			 where picklist_type_id = 79
				and trim(picklist_value_cd) = trim(p.eyecolortypekey)
			) as eyecolortypekey,
			trim(p.haircolortypekey) as haircolortypekey,
			p.dateofdeath,
			trim(p.maritalstatustypekey) as maritalstatustypekey,
			(select distinct trim(racetypekey) from personracetypemap prtm where prtm.personid = p.personid limit 1) AS "race",
			trim(p.ethnicgrouptypekey) AS "ethnicity",
			trim(p.stateid) as stateid

		FROM
			person p
		WHERE
			p.personid = vs_person_id 
	) AS "Person" LIMIT 1;

END;
    
$function$
;

