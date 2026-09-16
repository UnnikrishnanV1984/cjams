DROP FUNCTION cjams.get_provider_search(providerid integer, providername character varying, tax_id numeric, zip numeric, service_ids integer, pagenumber bigint, pagesize bigint, filtertype character varying);

CREATE OR REPLACE FUNCTION cjams.get_provider_search(providerid integer, providername character varying, tax_id numeric, zip numeric, service_ids integer, pagenumber bigint, pagesize bigint, filtertype character varying DEFAULT NULL::character varying)
 RETURNS TABLE(totalcount bigint, "ID" integer, provider_service_id bigint, "NAME" character varying, taxid numeric, county character varying, address character varying, service character varying, "Paid/NonPaid" character, service_id integer)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s):
-- 05/10/2021 Vineet Tirodkar - Modifications for Provider schema changes (B-102023)
-- 05/12/2022 Vineet Tirodkar - Modifications to Show only Active Services (tb_services) - CDM-22319
-- 06/02/2022 Vigneshwar Kumar - CIDM-4406 - Cfe Bed Retainer Payment User Story Changes
-- 06/26/2023 Palani/Chandra - Performance tuning - CIDM-7370
-- 07/16/2025 Naresh Moola - Performance tuning - CIDM-10477
------------------------------------------------------------------------
/*DECLARE
V_ProviderID bigint := '5000275';
V_ProviderName character varying (100) := 'Klein''s Pharmacy';
V_taxId numeric(9) := '5000275';
V_Zip numeric(5) := '21040'; -- dont delete these variable.
*/
declare
v_pageoffset int;
v_pagenumber int;
begin
v_pagenumber := pagenumber-1;
v_pageoffset = v_pagenumber * pagesize;
RETURN QUERY

select * from (
select  count(1) over(),
PR.Provider_ID AS ProviderID,
PS.provider_service_id
, case when (PR.Provider_nm is null or (PR.provider_nm='')) then concat(PR.provider_first_nm,' ',PR.provider_last_nm) else PR.provider_nm end AS ProviderName
,PR.tax_id_no AS TaxID
--,PA.adr_zip5_no AS ZipCode
,(select c.countyname as county from county c where c.statecountycode = PA.adr_county_cd and c.activeflag = 1)

,(select provider_adr from get_provider_address(PR.provider_id,trim('{3357,3356}') ))

/*
,(select concat_ws(' ',coalesce(TRIM(TBPA.adr_street_tx),null),coalesce(TBPA.adr_street_nm,null),coalesce(TBPA.adr_city_nm,null),coalesce(TRIM(pv.description_tx),null),coalesce(rv.description,null),coalesce(TBPA.adr_zip5_no,null)):: text AS address
from TB_PROVIDER_ADDRESSES TBPA
left join tb_picklist_values pv on TRIM(pv.picklist_value_cd)= TRIM(TBPA.adr_county_cd) and pv.picklist_type_id=328
left join referencevalues rv on rv.ref_key =TBPA.adr_state_cd and rv.referencetypeid=211
where TBPA.parent_key_id::int = PR.provider_id and TBPA.delete_sw='N'
and trim(TBPA.adr_type_cd)='3357' and (TBPA.adr_end_dt is null or TBPA.adr_end_dt >= now()::date) order by TBPA.adr_format_cd limit 1
) */
,CASE WHEN SE.structure_service_cd in ('S') AND paid_non_paid_cd IN ('3334','3335') THEN SE.Service_nm else SE.service_nm END AS Service
,CASE WHEN SE.structure_service_cd = 'S' AND paid_non_paid_cd IN ('3334','3335') THEN SE.paid_non_paid_cd END AS "Paid/NonPaid"
,CASE WHEN SE.structure_service_cd = 'S' AND paid_non_paid_cd IN ('3334','3335') THEN SE.Service_id END AS Service_id
FROM TB_SERVICES SE
INNER JOIN TB_PROVIDER_SERVICES PS ON PS.Service_id = SE.Service_id
and PS.delete_sw = 'N'
and coalesce(SE.structure_service_cd, '') <> 'P'
INNER JOIN tb_provider PR ON PR.Provider_id = PS.Provider_id
and PR.delete_sw = 'N'
and pr.provider_status_cd = '1791'
LEFT OUTER JOIN TB_PROVIDER_ADDRESSES PA
on PA.Parent_key_id::integer = PR.PROVIDER_ID
and PA.delete_sw = 'N'
and trim(PA.adr_type_cd)='3357'
and (PA.adr_end_dt is null or PA.adr_end_dt >= now()::date)
--INNER JOIN TB_PROVIDER_ADDRESSES PA ON PA.Parent_key_id::integer = PR.PROVIDER_ID and PA.delete_sw ='N'
WHERE SE.delete_sw = 'N'
and SE.active_sw = 'Y'
--and trim(SE.paid_non_paid_cd) :: character varying in ('3334','3335')
and (SE.paid_non_paid_cd) in ('3334','3335')
and PS.start_dt <= now()::date
and PS.delete_sw='N'
and ((PS.end_dt is null) or (PS.end_dt >= now()::date))
and (providerid is null or PR.Provider_id = providerid)
-- and (providername is null or PR.Provider_nm = providername)
and (providername is null or
(case when PR.provider_nm!='' then
(COALESCE(lower(PR.provider_nm) ,'') ilike  '%' || COALESCE(lower(providername) ,'')||'%')
or soundex((lower(trim(PR.provider_nm)))) = soundex((lower(trim(providername))))
when PR.provider_nm='' then
((COALESCE(lower(PR.provider_first_nm) ,'') iLIKE  '%' || COALESCE(lower(providername) ,'')||'%')
or  soundex((lower(trim(PR.provider_first_nm)))) = soundex((lower(trim(providername))))
or (COALESCE(lower(PR.provider_last_nm) ,'') LIKE COALESCE(lower(providername) ,'')||'%'))
or  soundex(lower(trim(PR.provider_last_nm))) = soundex(lower(trim(providername)))
or (COALESCE(lower(concat (PR.provider_first_nm,' ',PR.provider_last_nm)) ,'') iLIKE '%'|| COALESCE(lower(providername) ,'')||'%')
end)
or  
soundex(lower(trim(concat (PR.provider_first_nm,' ',PR.provider_last_nm)))) = soundex(lower(trim(providername)))
)

and (tax_id is null or PR.tax_id_no = tax_id)
-- and (zip is null or PA.adr_zip5_no = zip)
and (zip is null or PR.Provider_id
in (select parent_key_id::integer from tb_provider_addresses where adr_zip5_no = zip))
and (Service_ids is null or SE.Service_id = Service_ids)
and case when filtertype = 'cfe' then PR.Provider_id in (select provider_id from tb_provider_additional_info where is_cfe = true) else true end  
group by ProviderID, PS.provider_service_id,PR.Provider_nm , PR.provider_first_nm,
PR.provider_last_nm,PR.tax_id_no,pa.adr_county_cd,se.structure_service_cd,
se.paid_non_paid_cd,se.service_nm,se.service_id
order by (case when (providername is not null or trim(providername) !='') then
( case when PR.provider_nm is not null then
levenshtein( PR.provider_nm,(lower( trim( providername) )) ,1,0,4)
 else
levenshtein((concat_ws(' ',PR.provider_first_nm,PR.provider_last_nm) ),
(lower( trim( providername) )) ,1,0,4)
 end )
end )) a order by ProviderID
LIMIT pagesize OFFSET v_pageoffset;

END;

$function$
;


