DROP FUNCTION IF EXISTS sp_ive_alerts_mytasks_count(CHARACTER VARYING, CHARACTER VARYING);

CREATE OR REPLACE FUNCTION cjams.sp_ive_alerts_mytasks_count(
    v_loggedusersid CHARACTER VARYING, 
    v_loggeduserrole CHARACTER VARYING
)
 RETURNS TABLE(countdata bigint)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- CIDM-11090 - Veera - IVE Performance Enhancements- 02/08/2026
-- CIDM-11158 - Veera - IVE Dashboard Pagination issue fix - 02/26/2026
-- CDM-44783 - Vinesh - Completed Task is showing on the Dashboard - 05/05/2026
------------------------------------------------------------------------------------------------
DECLARE 
      v_notificationstartdate date;
BEGIN 
      
      SELECT settingvalue INTO v_notificationstartdate FROM settings 
      WHERE settingname = 'ivealertsnotificationdate' AND activeflag = 1;

RETURN QUERY 
with AllAlerts as (
 select * from (select pr.cjamspid ,row_number () over ( partition by pr.cjamspid,sc.servicecaseid order by pl.alternateid desc)  as rownum, 
    (select r.tosecurityusersid from routing r 
        join placement plt1 on pr.personid = plt1.personid
        where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
        and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
        and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
    ) as assigned_specialist_id,
    (select r.fromsecurityusersid from routing r 
        join placement plt1 on pr.personid = plt1.personid
        where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
        and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
        and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
    ) as assigned_supervisor_id
    from tb_client_eligibility tce
    join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
    join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('JD')
    INNER JOIN placement pl on ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid))
    INNER JOIN servicecase sc ON (sc.servicecaseid = iscr.servicecaseid or sc.servicecaseid = pl.servicecaseid) AND sc.activeflag = 1
    left join tb_foster_care_judicial tfcj on tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id and tfcj.period_type =  concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))) 
    where btrim(tce.eligibility_type_cd) = '2931' AND tce.delete_sw = 'N' and tce.start_dt::date <= (CURRENT_DATE - INTERVAL '1 year')::date
    AND (tce.end_dt IS null or tce.end_dt::date > now()) and (iscr.exitdate is null or iscr.exitdate::date > now())
    and LEAST((date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 day')::date,tfcj.date_agency_lost_legal_responsibility)::date >= v_notificationstartdate
    and LEAST((date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 day')::date,tfcj.date_agency_lost_legal_responsibility)::date <= now()::date
    and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and 
    ((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))) and tep.approvalstatus is not null)))
    and not exists (select 1 from tb_foster_care_judicial tfcj where tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id 
    and tfcj.period_type !=  concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))) and tfcj.date_agency_lost_legal_responsibility is not null)
    ) a where rownum = 1
    UNION ALL
  select * from (select pr.cjamspid ,row_number () over ( partition by pr.cjamspid,sc.servicecaseid order by pl.alternateid desc)  as rownum,
(select r.tosecurityusersid from routing r 
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
) as assigned_specialist_id,
(select r.fromsecurityusersid from routing r 
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
) as assigned_supervisor_id
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('JD')
INNER JOIN placement pl on (( pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or
(pl.placementtypekey = 'LA' and pl.personid = iscr.personid ))
    CROSS JOIN LATERAL (
        SELECT 
            date_trunc('month', tce.start_dt)::date as start_mo,
            f_age(date_trunc('month', tce.start_dt)::date, iscr.exitdate::date) as age_val
    ) calc_base
    CROSS JOIN LATERAL (
        SELECT 
            concat('R', calc_base.age_val + 1) as period_key,
            (calc_base.start_mo + (calc_base.age_val * '1 year'::INTERVAL))::date as threshold_dt
    ) calc
    INNER JOIN servicecase sc ON (sc.servicecaseid = iscr.servicecaseid or sc.servicecaseid = pl.servicecaseid) AND sc.activeflag = 1
left join tb_foster_care_judicial tfcj on tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id and tfcj.period_type =  calc.period_key 
where btrim(tce.eligibility_type_cd) = '2931' AND tce.delete_sw = 'N' and tce.start_dt::date <= (CURRENT_DATE)::date
AND (tce.end_dt::date > calc.threshold_dt) 
and (iscr.exitdate::date > calc.threshold_dt)
and LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)::date >= v_notificationstartdate
and LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)::date <= now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and 
((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = calc.period_key and tep.approvalstatus is not null)))
and not exists (select 1 from tb_foster_care_judicial tfcj where tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id 
and tfcj.period_type !=  calc.period_key and tfcj.date_agency_lost_legal_responsibility is not null)
) a where rownum = 1 
union all
select * from (select pr.cjamspid, row_number () over ( partition by pr.cjamspid,sc.servicecaseid order by pl.alternateid desc)  as rownum,
(select r.tosecurityusersid from routing r 
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
) as assigned_specialist_id,
(select r.fromsecurityusersid from routing r 
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
) as assigned_supervisor_id
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('TLV', 'CDVP','EHA')
INNER JOIN placement pl on (( pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or
(pl.placementtypekey = 'LA' and pl.personid = iscr.personid ))
INNER JOIN servicecase sc ON (sc.servicecaseid = iscr.servicecaseid or sc.servicecaseid = pl.servicecaseid) AND sc.activeflag = 1
left join tb_foster_care_judicial tfcj on tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id and tfcj.period_type =  concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))+ 1) 
where btrim(tce.eligibility_type_cd) = '2931' AND tce.delete_sw = 'N' and tce.start_dt::date <= (CURRENT_DATE - INTERVAL '1 year')::date
AND (tce.end_dt IS null or tce.end_dt::date > now()) and (iscr.exitdate is null or iscr.exitdate::date > now())
AND LEAST((date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL))::date,tfcj.date_agency_lost_legal_responsibility) >= v_notificationstartdate
AND LEAST((date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL))::date,tfcj.date_agency_lost_legal_responsibility) <= now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and 
((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) + 1) and tep.approvalstatus is not null)))
and not exists (select 1 from tb_foster_care_judicial tfcj where tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id 
and tfcj.period_type !=  concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))+ 1) and tfcj.date_agency_lost_legal_responsibility is not null)
) a where rownum = 1
union all 
select * from (select pr.cjamspid,
row_number () over ( partition by pr.cjamspid,sc.servicecaseid order by pl.alternateid desc)  as rownum,
(select r.tosecurityusersid from routing r 
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
) as assigned_specialist_id,
(select r.fromsecurityusersid from routing r 
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
) as assigned_supervisor_id
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('TLV', 'CDVP','EHA')
INNER JOIN placement pl on (( pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or
(pl.placementtypekey = 'LA' and pl.personid = iscr.personid ))
INNER JOIN servicecase sc ON (sc.servicecaseid = iscr.servicecaseid or sc.servicecaseid = pl.servicecaseid) AND sc.activeflag = 1
left join tb_foster_care_judicial tfcj on tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id and tfcj.period_type =  concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))+ 2) 
where btrim(tce.eligibility_type_cd) = '2931' AND tce.delete_sw = 'N' and tce.start_dt::date <= CURRENT_DATE
AND (tce.end_dt::date > (case when (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) = 1 then (tce.start_dt + ('181 day'::INTERVAL)) else
(date_trunc ('month', tce.start_dt ) + ((f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date)) * '1 year'::INTERVAL))::date end)) 
and (iscr.exitdate::date > (case when (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) = 1 then (tce.start_dt + ('181 day'::INTERVAL)) else
(date_trunc ('month', tce.start_dt ) + ((f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date)) * '1 year'::INTERVAL))::date end))
and LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)::date >= v_notificationstartdate
and LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)::date <= now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and 
((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = concat ('R',(f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date)) + 1) and tep.approvalstatus is not null)))
and not exists (select 1 from tb_foster_care_judicial tfcj where tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id 
and tfcj.period_type !=  concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))+ 2) and tfcj.date_agency_lost_legal_responsibility is not null)
) a where rownum = 1
union all
SELECT * FROM (
    SELECT pr.cjamspid,
           row_number() OVER (PARTITION BY pr.cjamspid, sc.servicecaseid ORDER BY pl.alternateid DESC) AS rownum,
           (select r.tosecurityusersid from routing r 
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
      ) as assigned_specialist_id,
     (select r.fromsecurityusersid from routing r 
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
     ) as assigned_supervisor_id
    FROM tb_client_eligibility tce
    JOIN person pr ON pr.cjamspid = tce.client_id 
        AND pr.activeflag = 1 
    JOIN intakeservreqchildremoval iscr ON iscr.removalid = tce.removal_id 
        AND iscr.activeflag = 1 
        AND iscr.removaltypekey IN ('TLV', 'CDVP', 'EHA')
    INNER JOIN placement pl ON (
        (pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid AND pl.placementtypekey = 'PRPL') OR
        (pl.placementtypekey = 'LA' AND pl.personid = iscr.personid)
    )
    INNER JOIN servicecase sc ON (sc.servicecaseid = iscr.servicecaseid OR sc.servicecaseid = pl.servicecaseid) 
        AND sc.activeflag = 1
    LEFT JOIN tb_foster_care_judicial tfcj ON tfcj.client_id = tce.client_id 
        AND tfcj.removal_id = tce.removal_id 
        AND tfcj.period_type = 'R1' 
    WHERE tce.eligibility_type_cd = '2931'  -- Removed btrim if column is clean
      AND tce.delete_sw = 'N'
      AND tce.start_dt <= (CURRENT_DATE - INTERVAL '180 days')
      AND tce.start_dt > (CURRENT_DATE - INTERVAL '1 year')
      AND (tce.end_dt IS NULL OR tce.end_dt > tce.start_dt)
      AND (iscr.exitdate IS NULL OR iscr.exitdate > tce.start_dt)
      AND (tce.start_dt + INTERVAL '180 days') >= '2025-10-16'
      AND (tfcj.date_agency_lost_legal_responsibility IS NULL OR tfcj.date_agency_lost_legal_responsibility >= '2025-10-16')
      AND (iscr.exitdate IS NULL OR iscr.exitdate >= '2025-10-16')
      AND NOT EXISTS (
          SELECT 1 FROM tb_eligibility_period tep 
          WHERE tep.eligibility_id = tce.eligibility_id 
            AND (tep.delete_sw = 'N' OR tep.create_ts >= '2025-10-16')
            AND (
                (tep.sqnm_sw = 'I' AND tep.delete_sw = 'N' AND trim(tep.status_cd) = '2914') OR 
                (tep.sqnm_sw = 'R1' AND tep.approvalstatus IS NOT NULL)
            )
      )
) a 
WHERE rownum = 1
union all
select * from(
select pr.cjamspid,0 as rownum,
(select r.tosecurityusersid from routing r 
      where r.activeflag=1 AND r.eventcode='GAAR' AND r.routingstatustypeid::text = '73' and r.toroleid in ('IVESP','IVEEA')
      and r.objectid :: character varying = ga.gapagreementid :: character varying order by r.insertedon desc limit 1),
(select r.fromsecurityusersid from routing r 
      where r.activeflag=1 AND r.eventcode='GAAR' AND r.routingstatustypeid::text = '73' and r.toroleid in ('IVESP','IVEEA')
      and r.objectid :: character varying = ga.gapagreementid :: character varying order by r.insertedon desc limit 1)
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
INNER JOIN guardianship g on g.alternateid = tce.guardian_subsidy_id
INNER JOIN gapagreement ga on ga.gapid = g.gapid AND ga.activeflag = 1
inner join tb_eligibility_period tep on tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N'--and tep.sqnm_sw = 'I' 
where btrim(tce.eligibility_type_cd) = '2935' AND tce.delete_sw = 'N'
and (pr.dob + interval  '18 Year')::date >= v_notificationstartdate
and (pr.dob + interval  '18 Year')::date <= now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and 
(tep.sqnm_sw = 'R' and tep.approvalstatus is not null))
)
union all
select * from ( select pr.cjamspid,0 as rownum,
(select r.tosecurityusersid from routing r 
      where r.activeflag=1 AND r.eventcode='ABLR' and r.toroleid in ('IVESP','IVEEA') AND 
      r.routingstatustypeid::text = '67' and r.objectid :: character varying = adbl.adoptionbreakthelinkid :: character varying order by r.insertedon desc limit 1),
(select r.fromsecurityusersid from routing r 
      where r.activeflag=1 AND r.eventcode='ABLR' and r.toroleid in ('IVESP','IVEEA') AND 
      r.routingstatustypeid::text = '67' and r.objectid :: character varying = adbl.adoptionbreakthelinkid :: character varying order by r.insertedon desc limit 1)
 from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
LEFT JOIN adoptionplanning apl on apl.alternateid = tce.adoption_id and apl.activeflag = 1
LEFT JOIN adoptionbreakthelink adbl on apl.adoptionplanningid = adbl.adoptionplanningid and adbl.activeflag = 1
INNER JOIN adoptioncase ac on ac.adoptioncasenumber::bigint = tce.case_id and ac.activeflag = 1 and (ac.enddate is null or ac.enddate::date >= now()::date)
inner join tb_eligibility_period tep on tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N'--and tep.sqnm_sw = 'I' 
where btrim(tce.eligibility_type_cd) = '2934' AND tce.delete_sw = 'N'
and (pr.dob + interval  '18 Year')::date >= v_notificationstartdate
and (pr.dob + interval  '18 Year')::date <= now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and 
(tep.sqnm_sw = 'R' and tep.approvalstatus is not null))
)
)
SELECT count(*) as countdata FROM AllAlerts A where 
(CASE WHEN v_loggeduserrole = 'IVESP'
        THEN A.assigned_specialist_id = v_loggedusersid
      ELSE (A.assigned_supervisor_id = v_loggedusersid OR A.assigned_specialist_id IS NULL) END)
;

END $function$;