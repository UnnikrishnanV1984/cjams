DROP FUNCTION IF EXISTS cjams.adoptionprovidersearch(searchobj json, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.adoptionprovidersearch(searchobj json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, provider_id integer, providername character varying, programname character varying, preferred character varying, vacancy integer, placementstructure character varying, provider_category_cd character varying, provider_category_name character varying, comar_sw character, contract_program_id integer, placement_service_id integer, providerdetails json, childcharacteristicsdetails json, ssnno character varying, dob_dt date, affiliate_provider_id integer, countyname character varying, service_status text)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Parshal Chitrakar - 09/11/2024 CIDM-9412 Provider Name Suffix is not updated in CW Application
-- Vinesh Puthan - 4/7/2025 - CIDM-10365 Placement SP Update to support PROVIDER User Story (Fix to not show the providers that are endated on the current  date in provider search)
------------------------------------------------------------------------------------------------
DECLARE 
        
	v_picklist_value_cd_childcharacteristics VARCHAR(100); 
	v_service_id_placementstructures INTEGER;    
	v_service_id_bundledplacementservices INTEGER;    
	v_prov_tax_type_cd_taxid VARCHAR(30);
	v_adr_zip5_no_zipcode numeric; 
	v_localdepartmenthomecaregiver boolean; 
	v_provider_id INTEGER;   
	v_lvService VARCHAR(50);                        
	v_lvServiceSubType VARCHAR(50);                         
	v_lvPaymentType VARCHAR(50);     
	v_lvChildCharacter json;                                                     
	v_liZipCode INT;       
	v_liCounty uuid;
	v_lvProvider VARCHAR(50);
	v_liCount INT;                              
	v_lvSortCol VARCHAR(50);                              
	v_lvSortDir VARCHAR(10); 
	v_pagenumber int;
	v_pageoffset int;
	v_fodertype VARCHAR(50);
	v_isoperatedbydjs bool;
	v_organization_name VARCHAR(100);
	v_fname VARCHAR(50);
	v_mname VARCHAR(50);
	v_lname VARCHAR(50);
	v_pname VARCHAR(100);
	v_gender VARCHAR(50);
	v_age int;
	v_otherLocalDeptmntTypeId VARCHAR(10);
	v_tax_id_no numeric;
 	v_fromproviderplacement  VARCHAR(50) ; 
  
 
BEGIN 
v_picklist_value_cd_childcharacteristics := searchobj ->> 'childcharacteristics';
v_service_id_placementstructures := searchobj ->> 'placementstructures'; 
v_service_id_bundledplacementservices := searchobj ->> 'bundledplacementservices'; 
v_prov_tax_type_cd_taxid := searchobj ->> 'taxid';
v_adr_zip5_no_zipcode := searchobj ->> 'zipcode';
v_localdepartmenthomecaregiver := searchobj ->> 'localdepartmenthomecaregiver';
v_provider_id := searchobj ->> 'providerid';
v_organization_name := searchobj ->> 'organizationName';
v_fname := searchobj ->> 'firstname';
v_mname := searchobj ->> 'middlename';
v_lname := searchobj ->> 'lastname';
v_gender := searchobj ->> 'gender';
v_pname := searchobj ->> 'providername';
v_age := searchobj ->> 'age';
v_otherLocalDeptmntTypeId := searchobj ->> 'otherLocalDeptmntTypeId';
v_tax_id_no := searchobj ->> 'taxId';
v_fromproviderplacement := searchobj ->> 'fromproviderplacement';

IF v_localdepartmenthomecaregiver is null THEN
    v_localdepartmenthomecaregiver = false;
END IF;

IF v_fromproviderplacement = 'true' THEN
    v_fromproviderplacement = 'true';
    else
     v_fromproviderplacement = null;
END IF;

v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

  RETURN query
    SELECT COUNT(1) OVER() totalcount, 
	TBP.provider_id ,
/*	(CASE WHEN (TBP.provider_nm = null OR TBP.provider_nm='') 
	THEN CONCAT(TBP.provider_first_nm,' ',TBP.provider_last_nm)::character varying ELSE TBP.provider_nm END),*/
	cjams.f_ename('2953', TBP.provider_id::bigint),
	(SELECT ''::character varying ) as program_nm, (SELECT ''::character varying ) as preferred, 
	TBP.vacancy_no,  
	TBS.service_nm,
    TBP.provider_category_cd,
	'Local Department Home'::character varying,    
    'Y'::character as comar_sw, (SELECT null::integer ) as contract_program_id, TBS.service_id,
	(SELECT json_agg(x) from (
	select a.provider_id , a.prov_tax_type_cd, a.tax_id_no, a.affiliate_provider_id as provider_organization_id,(CASE WHEN (a.provider_nm = null OR a.provider_nm='') 
	THEN CONCAT(a.provider_first_nm,' ',a.provider_last_nm)::character varying ELSE a.provider_nm END) as provider_organization_name,
	a.adr_work_phone_tx as phonenumber,
	(select concat_ws(' ',tpa.adr_street_no,tpa.adr_box_no,tpa.adr_unit_no_tx,tpa.adr_street_nm,tpa.adr_street_suffix_cd,tpa.adr_city_nm,tpa.adr_state_cd,tpa.adr_zip5_no)
        from tb_provider_addresses tpa where   tpa.parent_key_id = TBP.provider_id::character varying and adr_format_cd in ('P','S') ORDER BY tpa.adr_format_cd ASC Limit 1)::character varying as address,
	TBS.service_id , TBS.service_nm as placementstructure , 0::integer as bundled_service_id, '' as bundledplacementstructure, TBPS.provider_service_id,
	(select json_agg(x) from (select concat(up.firstname,' ',up.lastname) as license_cordinator from userprofile up where up.securityusersid=a.create_user_id and up.activeflag=1) as x) as license_cordinators
	from tb_provider as a 
	where a.provider_id = TBP.provider_id and a.delete_sw = 'N') as x) as providerdetails,
	(select json_agg(x) from ( select TBP.provider_id, TBPLV.picklist_value_cd as childcharacteristics_picklist_value_cd, 
	TBPLV.description_tx as childcharacteristics_description from tb_provider_picklist as TBPPL  
	JOIN tb_picklist_values as TBPLV ON TBPLV.picklist_value_cd = TBPPL.picklist_value_cd and TBPLV.delete_sw = 'N' and TBPLV.picklist_type_id = 43 
	Where TBPPL.provider_id = TBP.provider_id and TBPPL.delete_sw = 'N' AND 
	(CASE WHEN v_picklist_value_cd_childcharacteristics IS NOT NULL THEN TBPLV.picklist_value_cd = v_picklist_value_cd_childcharacteristics ELSE TRUE END)) as x) as childcharacteristicsdetails, TBP.tax_id_no :: character varying, TBP.dob_dt
	,TBP.affiliate_provider_id
 	,(select c.countyname from county c where trim(c.statecountycode)=trim(TBP.county_cd) limit 1) as countyname,
 	--TBPS.service_status
 	CASE WHEN (TBPS.end_dt IS NULL OR TBPS.end_dt>now()::date) THEN 'Active' ELSE 'Inactive' END AS service_status
	FROM tb_provider as TBP
INNER JOIN tb_provider_services as TBPS ON TBPS.provider_id = TBP.provider_id 
	and TBPS.delete_sw = 'N' and (TBPS.end_dt is null or TBPS.end_dt > current_date) --and TBPS.service_id = '501'
INNER JOIN tb_services as TBS ON  TBS.service_id =  TBPS.service_id and TBS.structure_service_cd='P' and TBS.delete_sw = 'N' -- Placement structures		

WHERE TBP.provider_status_cd = '1791'  -- Provider Status Active
AND TBP.delete_sw = 'N' 
AND EXISTS (
	SELECT 1
	FROM tb_provider_approval tbaa
	WHERE tbaa.delete_sw = 'N'
	AND tbaa.approval_status_cd = '3579'
	AND tbaa.approval_type_cd IN ('4992', '3577', '3590')
	AND tbaa.approval_dt <= current_date
	AND (tbaa.effective_end_dt >= current_date OR tbaa.effective_end_dt IS NULL)
	AND tbaa.active_sw = 'Y'
	AND tbaa.provider_id = TBP.provider_id
)
AND TBP.provider_id in (
	SELECT tpcl1.provider_id FROM TB_PROVIDER_PICKLIST tpcl1 WHERE tpcl1.PICKLIST_TYPE_ID=155 
	AND tpcl1.PICKLIST_VALUE_CD IN ('1783') 
	AND tpcl1.PROVIDER_ID = TBP.PROVIDER_ID AND tpcl1.DELETE_SW = 'N')


	AND (CASE WHEN v_fname IS NOT NULL THEN TBP.provider_first_nm like '%' || v_fname || '%' ELSE TRUE END)
	AND (CASE WHEN v_mname IS NOT NULL THEN TBP.provider_middle_nm like '%' || v_mname || '%' ELSE TRUE END)
	AND (CASE WHEN v_lname IS NOT NULL THEN TBP.provider_last_nm like '%' || v_lname || '%' ELSE TRUE END)
	AND (CASE WHEN v_pname IS NOT NULL THEN 
				CASE WHEN (TBP.provider_nm = null OR TBP.provider_nm='') 
		THEN CONCAT(TBP.provider_first_nm,' ',TBP.provider_last_nm)::character varying like '%' || v_pname || '%'
		ELSE
		TBP.provider_nm like '%' || v_pname || '%' END ELSE TRUE END)
	AND 
		(v_adr_zip5_no_zipcode is null OR 
		  EXISTS(
		       SELECT TBPA.adr_zip5_no FROM 
               tb_provider_addresses AS TBPA 
	           WHERE TBPA.adr_zip5_no = v_adr_zip5_no_zipcode::numeric
	           AND TBPA.parent_key_id::integer=TBP.provider_id
		  ) 
		  )
	AND (CASE WHEN v_provider_id IS NOT NULL THEN TBP.provider_id = v_provider_id ELSE TRUE END)
	AND (CASE WHEN v_tax_id_no IS NOT NULL THEN TBP.tax_id_no = v_tax_id_no ELSE TRUE END)
	AND (CASE WHEN v_organization_name IS NOT NULL THEN TBP.provider_nm like '%' || v_organization_name || '%' ELSE TRUE END)
	AND (CASE WHEN v_otherLocalDeptmntTypeId IS NOT NULL THEN trim(TBP.county_cd) = trim(v_otherLocalDeptmntTypeId) ELSE TRUE END)
	AND (CASE WHEN v_fromproviderplacement IS NOT NULL THEN TBS.service_id not in (71,501,503) ELSE TRUE END)
	AND ( v_picklist_value_cd_childcharacteristics IS null
		 or EXISTS 
		 (SELECT tpcl2.provider_id FROM TB_PROVIDER_PICKLIST tpcl2 WHERE tpcl2.PICKLIST_TYPE_ID in(43) 
			AND tpcl2.PROVIDER_ID = TBP.provider_id AND tpcl2.DELETE_SW = 'N'
			and tpcl2.picklist_value_cd=v_picklist_value_cd_childcharacteristics )
		)
	AND 
		(v_service_id_placementstructures is null OR 
		TBPS.service_id = v_service_id_placementstructures::integer 
		)
	AND 
		(v_service_id_bundledplacementservices is null OR 
		  EXISTS(
		       SELECT TBS1.service_id  FROM 
                tb_services as TBS1 WHERE  TBS1.service_id =  TBPS.service_id 
                and TBS1.paid_non_paid_cd in ('3334','3335') and TBS1.delete_sw = 'N' 
	            and TBS1.service_id=v_service_id_bundledplacementservices::integer 
		  )
		
		)
	and (v_age is null OR 
		  EXISTS(
		       select tb_prov_accomodation.gender_cd from 
               tb_prov_accomodation  
	           where tb_prov_accomodation.minimum_age_no <= v_age and tb_prov_accomodation.maximum_age_no >= v_age  
	        --   and tb_prov_accomodation.provider_approval_id = TBAA.provider_approval_id 
		  )
		
		)
	order by vacancy_no  desc  nulls last
	LIMIT v_liPageSize OFFSET v_pageoffset;           

END;
$function$
;