DROP FUNCTION if exists cjams.geteducationplacements(uuid);
CREATE OR REPLACE FUNCTION cjams.geteducationplacements
(i_personeducationid uuid)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$


DECLARE
    
    v_personeducationid uuid;
    v_personid uuid;
    v_educationstartdate date;
    v_educationenddate date;
    v_result json;

BEGIN
    
    v_personeducationid := i_personeducationid :: uuid;

select personid :: uuid, startdate :: date, enddate :: date
into v_personid
, v_educationstartdate, v_educationenddate from cjams.personeducation pe where pe.personeducationid = v_personeducationid;

SELECT json_agg(pi)
into v_result
FROM
    (
            select p.placementid,
            'Living Arrangement: ' ||
(select value_text
            from referencevalues rv
            where rv.referencetypeid = 76
                and rv.ref_key = la.livingarrangementtypekey
) as placement_type
, 0 as provider_id
,la.primarycaregiver as provider_name
, p.startdatetime as entry_date
, p.enddatetime as exit_date
, (coalesce(la.streetname,'')||' '||coalesce(la.streettext,'')||' '||
   coalesce(la.cityname,'')||' '||coalesce(s.statename,'')||' '||coalesce(la.zip5no,0))
   as address
,'' as placementstructuredesc														   
       from placement p
        left join livingarrangement la on p.placementid = la.placementid
		 left join state s on s.stateabbr::character varying=la.statetypekey and s.activeflag=1
        where p.placementid = la.placementid
            and p.personid = v_personid
            and p.activeflag = 1
            and la.activeflag = 1
            and p.altproviderid is null
            and (p.isvoided is null or p.isvoided = 0)
--            and (p.startdatetime::date <= coalesce (v_educationenddate, current_date ) -- "School End Date"
--            or p.startdatetime::date >= v_educationstartdate)
--            and ( p.enddatetime::date is null or p.enddatetime::date >= v_educationstartdate ) -- "School Start Date"
            and (select count(*)
            from routing rt
            where rt.objectid::character varying = p.placementid::character varying
                and rt.eventcode = 'PLTR'
                and rt.activeflag = 1
                and rt.routingstatustypeid  = '16'
) > 0
    union all
        select p.placementid, 'Provider Placement' as placement_type
, p.altproviderid as provider_id
, f_ename('2953', p.altproviderid::bigint) as provider_name
, p.startdatetime as entry_date
, p.enddatetime as exit_date
,(CAST(INITCAP(TRIM(coalesce((TBPA1.adr_street_tx),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_street_nm),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_street_suffix_cd),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_unit_type_cd),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_unit_no_tx),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_city_nm),'')) ||
                                                           ' '||TRIM(coalesce((TBPA1.adr_state_cd),'')) ||
                                                           ' '||TRIM((coalesce((TBPA1.adr_zip5_no),0::numeric))::character varying)) AS character varying)) 
                                                           AS address
,(SELECT service_nm FROM tb_Services WHERE tb_Services.service_id = p.service_id AND tb_Services.delete_sw ='N' LIMIT 1) placementstructuredesc														   
        from placement p
		left join tb_provider tp on tp.provider_id=p.altproviderid 
		left join tb_provider_addresses TBPA1 on TBPA1.parent_key_id=p.altproviderid ::character varying and TBPA1.adr_type_cd='3357' and TBPA1.delete_sw='N' and TBPA1.adr_default_sw='Y'
        where p.personid = v_personid
            and p.activeflag = 1
            and p.altproviderid is not null
            and (p.isvoided is null or p.isvoided = 0)
--            and (p.startdatetime::date <= coalesce (v_educationenddate, current_date ) -- "School End Date"
--            or p.startdatetime::date >= v_educationstartdate)
--            and ( p.enddatetime::date  is null or p.enddatetime::date >= v_educationstartdate ) -- "School Start Date"
            and (select count(*)
            from routing rt
            where rt.objectid::character varying = p.placementid::character varying
                and rt.eventcode = 'PLTR'
                and rt.activeflag = 1
                and rt.routingstatustypeid  = '16'
) > 0
            and f_prvpcklst_cat(p.altproviderid::bigint,'PLACEMENT')  <> '3302'
    union all
        select p.placementid, 'CPA Home Placement' as placement_type
, pc.altproviderid as provider_id
, f_ename('2953', pc.altproviderid::bigint) as provider_name
, pc.entrydt::date as entry_date
, pc.exitdt::date as exit_date
,(CAST(INITCAP(TRIM(coalesce((TBPA1.adr_street_tx),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_street_nm),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_street_suffix_cd),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_unit_type_cd),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_unit_no_tx),''))||
                                                           ' '||TRIM(coalesce((TBPA1.adr_city_nm),'')) ||
                                                           ' '||TRIM(coalesce((TBPA1.adr_state_cd),'')) ||
                                                           ' '||TRIM((coalesce((TBPA1.adr_zip5_no),0::numeric))::character varying)) AS character varying)) 
                                                           AS address
,(SELECT service_nm FROM tb_Services WHERE tb_Services.service_id = p.service_id AND tb_Services.delete_sw ='N' LIMIT 1) placementstructuredesc														   
        from placement p
        left join placementcpahomes pc on p.placementid = pc.placementid
		left join tb_provider tp on tp.provider_id=p.altproviderid 
		left join tb_provider_addresses TBPA1 on TBPA1.parent_key_id=p.altproviderid ::character varying and TBPA1.adr_type_cd='3357' and TBPA1.delete_sw='N' and TBPA1.adr_default_sw='Y'
        where
			p.personid = v_personid
            and p.activeflag = 1
            and pc.activeflag = 1
            and p.altproviderid is not null
            and (p.isvoided is null or p.isvoided = 0)
--			and (pc.entrydt::date <= coalesce (v_educationenddate, current_date ) -- "School End Date"
--            or pc.entrydt::date >= v_educationstartdate)
--            and ( pc.exitdt::date is null or pc.exitdt::date >= v_educationstartdate ) -- "School Start Date"
            and (select count(*)
            from routing rt
            where rt.objectid::character varying = p.placementid::character varying
                and rt.eventcode = 'PLTR'
                and rt.activeflag = 1
                and rt.routingstatustypeid  = '16'
) > 0
            and f_prvpcklst_cat(p.altproviderid::bigint,'PLACEMENT') = '3302'
        order by 3 desc
) pi where placement_type NOT LIKE '%Runaway';

RETURN	v_result;



END;

 
$function$
;
