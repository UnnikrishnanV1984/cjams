DROP FUNCTION if exists cjams.getplacementdetailinfos(text);
CREATE OR REPLACE FUNCTION cjams.getplacementdetailinfos (i_placementids text)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$


DECLARE
    
    v_placementids text[];
    v_result json;

BEGIN
v_placementids := i_placementids;
SELECT json_agg(pi)
into v_result
FROM (
	select p.placementid
	, p.altproviderid as provider_id
	, CASE WHEN (la.livingid = null)
		THEN
			'Provider Placement'
		ELSE
			'Living Arrangement: ' ||
			(select value_text
			            from referencevalues rv
			            where rv.referencetypeid = 76
			                and rv.ref_key = la.livingarrangementtypekey
			)
			END as placement_type
	, CASE WHEN (la.livingid = null)
		THEN
			f_ename('2953', p.altproviderid::bigint)
		ELSE
			la.primarycaregiver END as provider_name
	, p.startdatetime as entry_date
	, p.enddatetime as exit_date
	,CASE WHEN (la.livingid = null) 
	THEN (CAST(INITCAP(TRIM(coalesce((TBPA1.adr_street_tx),''))||
																   ' '||TRIM(coalesce((TBPA1.adr_street_nm),''))||
																   ' '||TRIM(coalesce((TBPA1.adr_street_suffix_cd),''))||
																   ' '||TRIM(coalesce((TBPA1.adr_unit_type_cd),''))||
																   ' '||TRIM(coalesce((TBPA1.adr_unit_no_tx),''))||
																   ' '||TRIM(coalesce((TBPA1.adr_city_nm),'')) ||
																   ' '||TRIM(coalesce((TBPA1.adr_state_cd),'')) ||
																   ' '||TRIM((coalesce((TBPA1.adr_zip5_no),0::numeric))::character varying)) AS character varying))
	ELSE
	(coalesce(la.streetname,'')||' '||coalesce(la.streettext,'')||' '||
	   coalesce(la.cityname,'')||' '||coalesce(s.statename,'')||' '||coalesce(la.zip5no,0)) END AS address
	,
	(SELECT service_nm FROM tb_Services WHERE tb_Services.service_id = p.service_id AND tb_Services.delete_sw ='N' LIMIT 1) as placementstructuredesc											   
			from placement p
			left join livingarrangement la on p.placementid = la.placementid
		 	left join state s on s.stateabbr::character varying=la.statetypekey and s.activeflag=1
			left join tb_provider tp on tp.provider_id=p.altproviderid 
			left join tb_provider_addresses TBPA1 on TBPA1.parent_key_id=p.altproviderid ::character varying and TBPA1.adr_type_cd='3357' and TBPA1.delete_sw='N' and TBPA1.adr_default_sw='Y'
			where p.placementid = ANY( v_placementids::uuid[])
				and p.activeflag = 1
) pi;

RETURN	v_result;



END;

 
$function$
;