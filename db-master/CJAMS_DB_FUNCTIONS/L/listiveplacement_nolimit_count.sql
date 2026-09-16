CREATE OR REPLACE FUNCTION cjams.listiveplacement_nolimit_count(userid character varying, v_status text[], v_roleid character varying, v_placementtype character varying, pagenumber bigint, pagesize bigint, fname character varying, lname character varying, clientiddata character varying, eligiblestatus character varying, rdate timestamp without time zone, todate timestamp without time zone, county character varying[], v_sortorder character varying, filtertype character varying DEFAULT NULL::character varying, assignedspecialist character varying DEFAULT NULL::character varying)
RETURNS TABLE(countdata bigint, gapagreementid uuid, adoptionbreakthelinkid uuid, placementid uuid, assignedtouser character varying, clientid bigint, lastname character varying, firstname character varying, removaldate timestamp without time zone, removalid bigint, childname character varying, casenumber bigint, childagency character varying, childjurisdiction character varying, placementdate date, dateofbirth date, removalage character varying, caseid uuid, sqnm_sw character varying, fostercareeligibilitystatus text, startdate timestamp without time zone, rownumber bigint)
 LANGUAGE plpgsql

--IMMUTABLE PARALLEL SAFE STRICT 
AS $function$

---------------------------------------------------------------------------------------
-- CIDM-11127 - IVE Slowness issue fix - 02-11-2026
-- CIDM-11293 – To show records on dashboard for IV-E GAP/Adoption Auto-Approval Eligible/Reimbursable - 05-14-2026
---------------------------------------------------------------------------------------
 
DECLARE
    v_pageoffset int;
    v_pagenumber int;
DECLARE 
    totalcount integer;
BEGIN
    v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;
 
    if(v_placementtype = 'Fostercare') then
        if(v_roleid in ('IVESP','IVEEA') and v_status:: character varying = '{70}' :: character varying) then --return resp for non-assigned user 
            raise notice 'test %',v_status;
            RETURN QUERY 
                   WITH base_query AS (
                   SELECT 
                   DISTINCT ON (isrcr.removalid)
                     p.cjamspid, isrcr.removalid,
                     pl.placementid AS ref_placementid, 
                     tce.eligibility_id, 
        isrcr.servicecaseid, p.lastname, p.firstname, p.middlename,  p.dob,
        isrcr.removaldate AS sort_date, isrcr.insertedon AS sort_update,pl.startdatetime::date as placement_date, sc.servicecasenumber::BIGINT as casenumber_val
    FROM tb_client_eligibility tce
    INNER JOIN person p ON p.cjamspid = tce.client_id AND p.activeflag = 1
    INNER JOIN intakeservreqchildremoval isrcr ON isrcr.removalid = tce.removal_id 
        AND isrcr.activeflag = 1 AND isrcr.exitdate IS NULL
    INNER JOIN placement pl ON (
        (pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.placementtypekey = 'PRPL') OR 
        (pl.placementtypekey = 'LA' AND pl.personid = isrcr.personid)
    )
    INNER JOIN (
        SELECT plc.personid, MAX(plc.alternateid) AS max_alt_id
        FROM placement plc
        INNER JOIN routing r ON (CASE WHEN length(r.objectid)=36 THEN r.objectid ELSE NULL END)::uuid = plc.placementid
        WHERE r.activeflag = 1 
          AND r.eventcode = 'PLTR' 
          AND r.tosecurityusersid::varchar = userid
          AND r.routingstatustypeid::text = ANY(v_status) 
          AND r.toroleid = v_roleid
        GROUP BY plc.personid
    ) as plc_filter ON plc_filter.personid = p.personid AND plc_filter.max_alt_id = pl.alternateid
    INNER JOIN servicecase sc ON (sc.servicecaseid = isrcr.servicecaseid OR sc.servicecaseid = pl.servicecaseid) AND sc.activeflag = 1
    WHERE tce.eligibility_type_cd = '2931' 
      AND tce.delete_sw = 'N' 
      AND pl.activeflag = 1
      AND (fname IS NULL OR UPPER(p.firstname) LIKE '%' || UPPER(fname) || '%')
      AND (lname IS NULL OR UPPER(p.lastname) LIKE '%' || UPPER(lname) || '%')
      AND (clientIddata IS NULL OR p.cjamspid::character varying = clientIddata)
      AND (rdate IS NULL OR isrcr.removaldate::date BETWEEN date(rdate) AND date(todate))
       and (pl.startdatetime >= isrcr.removaldate  or (pl.enddatetime is null and pl.startdatetime <= isrcr.removaldate))
      ORDER BY isrcr.removalid, pl.alternateid DESC, tce.eligibility_id DESC
),
filtered_data AS (
    SELECT b.*,
        (SELECT c.countyname FROM caseassignment ca 
         JOIN county c ON c.countyid = ca.toldssid AND c.activeflag = 1
         WHERE ca.objectid = b.servicecaseid AND ca.enddate IS NULL 
         ORDER BY ca.insertedon DESC LIMIT 1)::character varying as childjurisdiction_val,
        (SELECT tpv.description_tx::text FROM tb_eligibility_period tep 
         JOIN tb_picklist_values tpv ON trim(tpv.picklist_value_cd) = trim(tep.status_cd) AND tpv.picklist_type_id = 262
         WHERE tep.eligibility_id = b.eligibility_id AND tep.delete_sw = 'N' 
         ORDER BY tep.update_ts DESC LIMIT 1) as eligibility_status_val
    FROM base_query b
),
sorted_query AS (
    SELECT *, COUNT(1) OVER() as total_count
    FROM filtered_data
    WHERE 
	(CASE WHEN county IS NOT NULL THEN childjurisdiction_val :: character varying = ANY(county) ELSE TRUE END )
                    AND (CASE when lower(filtertype) = 'completed' THEN eligibility_status_val is not null and eligibility_status_val not in ('Pending','Incomplete')  ELSE TRUE END)
                    AND (CASE WHEN eligiblestatus = 'Pending' then (eligibility_status_val is null or eligibility_status_val = 'Incomplete') when eligiblestatus IS NOT NULL THEN eligibility_status_val::character varying = eligiblestatus ELSE TRUE END)
                  
    ORDER BY 
        (CASE v_sortorder WHEN 'asc' THEN sort_date END) ASC NULLS LAST,
        (CASE v_sortorder WHEN 'desc' THEN sort_date END) DESC NULLS LAST,
        (CASE WHEN v_sortorder IS NULL THEN sort_update END) DESC NULLS LAST
    LIMIT pagesize OFFSET v_pageoffset
)
    SELECT 
    pr.total_count, NULL::uuid, NULL::uuid, pr.ref_placementid, NULL::varchar,
    pr.cjamspid, pr.lastname, pr.firstname, pr.sort_date::timestamp, pr.removalid,
    CONCAT(pr.firstname, ' ', pr.middlename, ' ', pr.lastname)::VARCHAR,
    pr.casenumber_val, 'DHS'::character varying, pr.childjurisdiction_val,
    pr.placement_date,
    pr.dob::date,
    (EXTRACT(year FROM age(pr.sort_date::date, pr.dob::date))::varchar || ' Years ' || 
     EXTRACT(month FROM age(pr.sort_date::date, pr.dob::date))::varchar || ' Months')::varchar,
    pr.servicecaseid,
    (SELECT tep.sqnm_sw::character varying FROM tb_eligibility_period tep 
     WHERE tep.eligibility_id = pr.eligibility_id AND tep.delete_sw = 'N' 
     AND tep.approvalstatus = 'APPROVED' ORDER BY tep.sqnm_sw LIMIT 1),
    pr.eligibility_status_val, NULL::timestamp, NULL::bigint
    FROM sorted_query pr;
        else
            RETURN QUERY
                  select count(1) over(), * from (SELECT fclist.* from (select null :: uuid,null :: uuid,pl.placementid,
                    (select up.fullname::varchar from routing r join userprofile up on up.securityusersid = r.tosecurityusersid
                    join placement plt1 on pl.personid = plt1.personid
                        where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
                        and plt1.activeflag=1 and (plt1.startdatetime >= isrcr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= isrcr.removaldate))
                        and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
                    ) ,
                    p.cjamspid,p.lastname,p.firstname,isrcr.removaldate,isrcr.removalid,
                    CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)::VARCHAR as childname,
                    sc.servicecasenumber::BIGINT as casenumber,
                    'DHS' ::character varying  as childagency,
                    (select c.countyname from caseassignment ca join county c on c.countyid = ca.toldssid and c.activeflag =1
                        where ca.objectid = sc.servicecaseid and ca.enddate is null order by ca.updatedon desc limit 1)
                        ::character varying as childjurisdiction,
                    pl.startdatetime::date as placementdate,
                    p.dob::date as dateofbirth,
                    (EXTRACT(year FROM age(isrcr.removaldate::date,p.dob::date)) :: character varying || ' Years'::varchar || ' ' ||
               EXTRACT(month FROM age(isrcr.removaldate::date,p.dob::date)) :: character varying  || ' Months'::varchar)::varchar as removalage,
                    sc.servicecaseid as caseid,
                    (select tep.sqnm_sw:: CHARACTER varying from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' and tep.approvalstatus = 'APPROVED' order by tep.sqnm_sw limit 1),
                    (select tpv.description_tx::text as fostercareeligibilitystatus from tb_eligibility_period tep join tb_picklist_values tpv on trim(tpv.picklist_value_cd) = trim(tep.status_cd) and tpv.picklist_type_id = 262
                     where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' order by tep.update_ts desc limit 1), null :: timestamp, row_number () over ( partition by p.cjamspid,sc.servicecaseid order by pl.alternateid desc)  as rownum
                FROM tb_client_eligibility tce
                INNER JOIN person p on p.cjamspid = tce.client_id AND p.activeflag=1
                INNER JOIN intakeservreqchildremoval isrcr ON isrcr.removalid = tce.removal_id AND isrcr.activeflag=1 AND isrcr.exitdate is null
                INNER JOIN placement pl on (( pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or
                (pl.placementtypekey = 'LA' and pl.personid = isrcr.personid )) 
                -- inner join ( SELECT plc.personid,  MAX(plc.alternateid) AS alternateid
                --            FROM tb_client_eligibility tce
                --             INNER JOIN person per on per.cjamspid = tce.client_id                            
                --             INNER JOIN placement plc on per.personid = plc.personid
                --             INNER JOIN intakeservreqchildremoval isrcr ON isrcr.removalid=tce.removal_id AND isrcr.activeflag=1 AND isrcr.exitdate is null
                --             INNER JOIN servicecase sc ON (sc.servicecaseid = isrcr.servicecaseid or sc.servicecaseid = plc.servicecaseid) AND sc.activeflag = 1
                --         WHERE tce.eligibility_type_cd = '2931' AND tce.delete_sw = 'N' and
                --              plc.placementid  in (
                --                 select  (case when length(routing.objectid)=36 then objectid else null end)::uuid from routing where routing.activeflag=1 AND routing.eventcode='PLTR' AND routing.routingstatustypeid::int = any (v_status::int[])
                --                 )
                --             AND plc.activeflag=1 and ( plc.startdatetime >= isrcr.removaldate  or (plc.enddatetime is null and plc.startdatetime <= isrcr.removaldate))                        
                --         GROUP BY plc.personid
                --     ) AS PLC on PLC.alternateid = pl.alternateid
                INNER JOIN servicecase sc ON (sc.servicecaseid = isrcr.servicecaseid or sc.servicecaseid = pl.servicecaseid) AND sc.activeflag = 1
                WHERE tce.eligibility_type_cd = '2931' AND tce.delete_sw = 'N' and
                (CASE WHEN fname IS NOT NULL THEN  UPPER(p.firstname) like '%' || UPPER(fname) || '%' ELSE TRUE END)
                AND (CASE WHEN lname IS NOT NULL THEN  UPPER(p.lastname) like '%' || UPPER(lname) || '%' ELSE TRUE END)
                AND (CASE WHEN clientIddata IS NOT NULL THEN  p.cjamspid::character varying = clientIddata ELSE TRUE END)
                AND (CASE WHEN rdate IS NOT NULL THEN isrcr.removaldate::date between date(rdate) and date(todate) ELSE TRUE END)
                order by (case v_sortorder when 'asc' then isrcr.removaldate END) ASC NULLS LAST,
                (case v_sortorder when 'desc' then isrcr.removaldate END) DESC NULLS last,
                (case v_sortorder when null then isrcr.insertedon END) DESC NULLS last) as fclist
                where (CASE WHEN county IS NOT NULL THEN fclist.childjurisdiction:: character varying = ANY(county) ELSE TRUE END )
                AND (CASE WHEN lower(filtertype) = 'unassigned' then fclist.fullname is null 
                          WHEN lower(filtertype) = 'assigned' then fclist.fullname is not null 
                          when lower(filtertype) = 'completed' THEN fclist.fostercareeligibilitystatus is not null and fclist.fostercareeligibilitystatus not in ('Pending','Incomplete') ELSE TRUE END)
                AND (CASE WHEN assignedspecialist IS NOT NULL THEN lower(fclist.fullname) = lower(assignedspecialist) ELSE TRUE END )
                AND (CASE WHEN eligiblestatus = 'Pending' then (fclist.fostercareeligibilitystatus is null or fclist.fostercareeligibilitystatus = 'Incomplete') WHEN eligiblestatus IS NOT NULL THEN  fclist.fostercareeligibilitystatus::character varying = eligiblestatus ELSE TRUE END)
                ) a where rownum = 1 LIMIT pagesize OFFSET v_pageoffset;
        end if;
elsif (v_placementtype = 'Adoption') then
    IF(v_roleid in ('IVESP','IVEEA') and v_status:: character varying = '{67}' :: character varying) THEN
        RETURN QUERY
        WITH base_query AS (
            SELECT 
                adbl.adoptionbreakthelinkid, tce.eligibility_id, tce.eligibility_status_cd,
                ac.adoptioncaseid, apl.intakeservicerequestactorid, apl.servicecaseid,
                p.cjamspid, p.lastname, p.firstname, p.middlename, p.dob, p.gendertypekey,
                aca.startdate as sort_date, ac.updatedon as sort_update,
                (SELECT c.countyname FROM caseassignment ca JOIN county c ON c.countyid = ca.toldssid AND c.activeflag = 1
                 WHERE ca.objectid = ac.adoptioncaseid AND ca.enddate IS NULL ORDER BY ca.insertedon DESC LIMIT 1)::character varying as childjurisdiction_val,
                (SELECT tpv.description_tx::text FROM tb_picklist_values tpv WHERE TRIM(tpv.picklist_value_cd) = TRIM(tce.eligibility_status_cd) AND tpv.picklist_type_id = 262) as fostercareeligibilitystatus_val
            FROM tb_client_eligibility tce
            INNER JOIN person p ON p.cjamspid = tce.client_id AND p.activeflag = 1
            -- RESTORED: These must be LEFT JOINs to include the [NULL] rows seen in your screenshot
            LEFT JOIN adoptionplanning apl ON apl.alternateid = tce.adoption_id AND apl.activeflag = 1
            LEFT JOIN adoptionbreakthelink adbl ON apl.adoptionplanningid = adbl.adoptionplanningid AND adbl.activeflag = 1
            INNER JOIN adoptioncase ac ON ac.adoptioncasenumber::bigint = tce.case_id AND ac.activeflag = 1 
                AND (ac.enddate IS NULL OR ac.enddate::date >= CURRENT_DATE)
            INNER JOIN adoptioncaseagreement aca ON aca.adoptioncaseid = ac.adoptioncaseid AND aca.activeflag = 1
            WHERE tce.eligibility_type_cd = '2934' AND tce.delete_sw = 'N'
            AND (tce.eligibility_status_cd = '2909' OR (p.dob <= (CURRENT_DATE - INTERVAL '18 years') AND p.dob >= (CURRENT_DATE - INTERVAL '21 years')))
            AND adbl.adoptionbreakthelinkid IN (
                SELECT (CASE WHEN length(r.objectid)=36 THEN r.objectid ELSE NULL END)::uuid 
                FROM routing r 
                WHERE r.activeflag=1 AND r.eventcode='ABLR' 
                AND r.routingstatustypeid::int = ANY (v_status::int[])
                AND r.tosecurityusersid::character varying = userid AND r.toroleid = v_roleid
            )  AND (CASE WHEN fname IS NOT NULL THEN  UPPER(p.firstname) like '%' || UPPER(fname) || '%' ELSE TRUE END)
                AND (CASE WHEN lname IS NOT NULL THEN  UPPER(p.lastname) like '%' || UPPER(lname) || '%' ELSE TRUE END)
                AND (CASE WHEN clientIddata IS NOT NULL THEN  p.cjamspid::character varying = clientIddata ELSE TRUE END)
                AND (CASE WHEN eligiblestatus = 'Eligible Reimbursable' THEN  trim(tce.eligibility_status_cd)::character varying = '2913'
                          WHEN eligiblestatus = 'Ineligible' THEN  trim(tce.eligibility_status_cd)::character varying = '2914'
                          WHEN eligiblestatus = 'Pending' THEN  trim(tce.eligibility_status_cd)::character varying = '2909' ELSE TRUE end)
            
        ),
        filtered_query AS (
            SELECT * FROM base_query
            WHERE (CASE WHEN county IS NOT NULL THEN childjurisdiction_val = ANY(county) ELSE TRUE END)
            AND (CASE WHEN lower(filtertype) = 'completed' THEN fostercareeligibilitystatus_val IS NOT NULL AND fostercareeligibilitystatus_val != 'Pending' ELSE TRUE END)
        ),
        sorted_query AS (
            SELECT *, count(1) OVER() as total_count
            FROM filtered_query
            ORDER BY 
                (CASE v_sortorder WHEN 'asc' THEN sort_date END) ASC NULLS LAST,
                (CASE v_sortorder WHEN 'desc' THEN sort_date END) DESC NULLS LAST,
                (CASE WHEN v_sortorder IS NULL THEN sort_update END) DESC NULLS LAST
            LIMIT pagesize OFFSET v_pageoffset
        )
        SELECT 
            sr.total_count, NULL::uuid, sr.adoptionbreakthelinkid, NULL::uuid, NULL::varchar,
            sr.cjamspid, sr.lastname, sr.firstname, NULL::timestamp,
            (SELECT isrcr1.removalid FROM intakeservreqchildremoval isrcr1 
             JOIN intakeservicerequestactor iat ON iat.intakeservicerequestactorid = sr.intakeservicerequestactorid AND iat.activeflag = 1
             WHERE isrcr1.personid = iat.personid ORDER BY isrcr1.updatedon DESC LIMIT 1),
            CONCAT(sr.firstname, ' ', sr.middlename, ' ', sr.lastname)::VARCHAR,
            sc.servicecasenumber::BIGINT, 'DHS'::character varying,
            sr.childjurisdiction_val, NULL::date, sr.dob::date, sr.gendertypekey::varchar, sr.servicecaseid,
            (SELECT tep.sqnm_sw FROM tb_eligibility_period tep WHERE tep.eligibility_id = sr.eligibility_id AND tep.delete_sw = 'N' AND tep.approvalstatus = 'APPROVED' AND tep.approvalid != 'AUTO_APPROVAL' ORDER BY tep.sqnm_sw DESC LIMIT 1),
            sr.fostercareeligibilitystatus_val, sr.sort_date, NULL::bigint
        FROM sorted_query sr
        LEFT JOIN servicecase sc ON sc.servicecaseid = sr.servicecaseid;

    ELSE
        -- OPTIMIZED ELSE BLOCK
        RETURN QUERY
        WITH base_query AS (
            SELECT 
                adbl.adoptionbreakthelinkid, tce.eligibility_id, tce.eligibility_status_cd, tce.case_id as tce_case_id,
                ac.adoptioncaseid, apl.intakeservicerequestactorid, apl.servicecaseid,
                p.cjamspid, p.lastname, p.firstname, p.middlename, p.dob, p.gendertypekey,
                aca.startdate as sort_date, ac.updatedon as sort_update,
                (SELECT up.fullname::varchar FROM routing r JOIN userprofile up ON up.securityusersid = r.tosecurityusersid
                 WHERE r.activeflag=1 AND r.eventcode='ABLR' AND r.toroleid IN ('IVESP','IVEEA') AND 
                 r.routingstatustypeid::text = '67' AND r.objectid::text = adbl.adoptionbreakthelinkid::text ORDER BY r.insertedon DESC LIMIT 1) as fullname_val,
                (SELECT c.countyname FROM caseassignment ca JOIN county c ON c.countyid = ca.toldssid AND c.activeflag = 1
                 WHERE ca.objectid = ac.adoptioncaseid AND ca.enddate IS NULL ORDER BY ca.insertedon DESC LIMIT 1)::character varying as childjurisdiction_val,
                (SELECT tpv.description_tx::text FROM tb_picklist_values tpv WHERE TRIM(tpv.picklist_value_cd) = TRIM(tce.eligibility_status_cd) AND tpv.picklist_type_id = 262) as fostercareeligibilitystatus_val,
                (SELECT tep.sqnm_sw::VARCHAR FROM tb_eligibility_period tep WHERE tep.eligibility_id = tce.eligibility_id AND tep.delete_sw = 'N' AND tep.approvalstatus = 'APPROVED'  AND tep.approvalid != 'AUTO_APPROVAL' ORDER BY tep.sqnm_sw DESC LIMIT 1) as sqnm_sw_val
            FROM tb_client_eligibility tce
            INNER JOIN person p ON p.cjamspid = tce.client_id AND p.activeflag = 1
            LEFT JOIN adoptionplanning apl ON apl.alternateid = tce.adoption_id AND apl.activeflag = 1
            LEFT JOIN adoptionbreakthelink adbl ON apl.adoptionplanningid = adbl.adoptionplanningid AND adbl.activeflag = 1
            INNER JOIN adoptioncase ac ON ac.adoptioncasenumber::bigint = tce.case_id AND ac.activeflag = 1 
                AND (ac.enddate IS NULL OR ac.enddate::date >= CURRENT_DATE)
            INNER JOIN adoptioncaseagreement aca ON aca.adoptioncaseid = ac.adoptioncaseid AND aca.activeflag = 1
            WHERE tce.eligibility_type_cd = '2934' AND tce.delete_sw = 'N'
            AND (tce.eligibility_status_cd = '2909' OR (p.dob <= (CURRENT_DATE - INTERVAL '18 years') AND p.dob >= (CURRENT_DATE - INTERVAL '21 years')))
                AND (CASE WHEN fname IS NOT NULL THEN  UPPER(p.firstname) like '%' || UPPER(fname) || '%' ELSE TRUE END)
                AND (CASE WHEN lname IS NOT NULL THEN  UPPER(p.lastname) like '%' || UPPER(lname) || '%' ELSE TRUE END)
            AND (clientIddata IS NULL OR p.cjamspid::text = clientIddata)
        ),
        filtered_query AS (
            SELECT * FROM base_query
            WHERE (CASE WHEN county IS NOT NULL THEN childjurisdiction_val = ANY(county) ELSE TRUE END)
            AND (CASE WHEN lower(filtertype) = 'unassigned' THEN fullname_val IS NULL 
                      WHEN lower(filtertype) = 'assigned' THEN fullname_val IS NOT NULL 
                      WHEN lower(filtertype) = 'completed' THEN fostercareeligibilitystatus_val IS NOT NULL AND fostercareeligibilitystatus_val != 'Pending' ELSE TRUE END)
            AND (CASE WHEN assignedspecialist IS NOT NULL THEN lower(fullname_val) = lower(assignedspecialist) ELSE TRUE END)
            AND (CASE WHEN sqnm_sw_val IS NOT NULL THEN sqnm_sw_val != 'R' ELSE TRUE END)
        ),
        sorted_query AS (
            SELECT *, count(1) OVER() as total_count
            FROM filtered_query
            ORDER BY 
                (CASE v_sortorder WHEN 'asc' THEN sort_date END) ASC NULLS LAST,
                (CASE v_sortorder WHEN 'desc' THEN sort_date END) DESC NULLS LAST,
                (CASE WHEN v_sortorder IS NULL THEN sort_update END) DESC NULLS LAST
            LIMIT pagesize OFFSET v_pageoffset
        )
        SELECT 
            sr.total_count, NULL::uuid, sr.adoptionbreakthelinkid, NULL::uuid, sr.fullname_val,
            sr.cjamspid, sr.lastname, sr.firstname, NULL::timestamp,
            (SELECT isrcr1.removalid FROM intakeservreqchildremoval isrcr1 
             JOIN intakeservicerequestactor iat ON iat.intakeservicerequestactorid = sr.intakeservicerequestactorid AND iat.activeflag = 1
             WHERE isrcr1.personid = iat.personid AND isrcr1.activeflag = 1 ORDER BY isrcr1.updatedon DESC LIMIT 1),
            CONCAT(sr.firstname, ' ', sr.middlename, ' ', sr.lastname)::VARCHAR,
            COALESCE(sc.servicecasenumber::BIGINT, sr.tce_case_id::BIGINT), 'DHS'::character varying,
            sr.childjurisdiction_val, NULL::date, sr.dob::date, sr.gendertypekey::varchar, sr.servicecaseid,
            sr.sqnm_sw_val, sr.fostercareeligibilitystatus_val, sr.sort_date, NULL::bigint
        FROM sorted_query sr
        LEFT JOIN servicecase sc ON sc.servicecaseid = sr.servicecaseid;
    END IF;
  
    elsif (v_placementtype = 'ACA') then
        RETURN QUERY 
              select count(1) over(), acalist.* from (select null :: uuid,aa.adoptionapplicabilityid :: uuid,null :: uuid,
                (select up.fullname::varchar from routing r join userprofile up on up.securityusersid = r.tosecurityusersid
                where r.activeflag=1 AND r.eventcode='ADAP' and r.toroleid in ('IVESP','IVEEA') AND 
                r.routingstatustypeid::text = '67' and r.objectid:: character varying = aa.adoptionapplicabilityid:: character varying order by r.insertedon desc limit 1),
                p.cjamspid,p.lastname,p.firstname,null::timestamp,aa.removalid,
                CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)::VARCHAR as childname, sc.servicecasenumber::BIGINT as casenumber, 'DHS' ::character varying as childagency,
(select c.countyname from caseassignment ca join county c on c.countyid = ca.toldssid and c.activeflag =1
                        where ca.objectid = sc.servicecaseid order by ca.updatedon desc limit 1) ::character varying as childjurisdiction,
                null::date as placementdate, p.dob::date as dateofbirth, null::varchar as removalage, sc.servicecaseid as caseid, '' :: varchar, '' :: text,
                (select case when aa.resubmissiondate IS NOT NULL then aa.resubmissiondate else aa.submissiondate end), null::bigint
                FROM person p
                INNER JOIN adoptionapplicabilityinfo aa ON aa.clientid = p.cjamspid and aa.activeflag = 1
                INNER JOIN intakeservreqchildremoval isrcr ON isrcr.removalid=aa.removalid AND isrcr.activeflag=1
                INNER JOIN servicecase sc ON sc.servicecaseid = isrcr.servicecaseid AND sc.activeflag = 1
where
            (
 (SELECT case when tm.roletypekey = 'IVESV' then true else false end FROM teammemberassignment tma  INNER JOIN  teammember tm  ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1 WHERE tma.SecurityUsersId = userid AND tma.activeflag =1  )
OR
 aa.adoptionapplicabilityid in
 (
select (case when length(routing.objectid)=36 then objectid else null end)::uuid from routing where ( routing.tosecurityusersid::character varying=userid or routing.tosecurityusersid is null ) AND routing.activeflag=1  AND routing.eventcode='ADAP'  AND routing.routingstatustypeid::text = any (v_status)
 ) OR (select case when v_roleid = 'IVESV' then true else false end)
)
            AND aa.ivestatus in ('REVIEW','COMPLETED','DETERMINE')
            AND (CASE WHEN fname IS NOT NULL THEN  UPPER(p.firstname) like '%' || UPPER(fname) || '%' ELSE TRUE END)
            AND (CASE WHEN lname IS NOT NULL THEN  UPPER(p.lastname) like '%' || UPPER(lname) || '%' ELSE TRUE END)
            AND (CASE WHEN clientIddata IS NOT NULL THEN  p.cjamspid::character varying = clientIddata ELSE TRUE END)
            order by aa.submissiondate desc ) as acalist
            where (CASE WHEN county IS NOT NULL THEN acalist.childjurisdiction :: character varying = ANY(county) ELSE TRUE END )
            AND (CASE WHEN lower(filtertype) = 'unassigned' then acalist.fullname is null WHEN lower(filtertype) = 'assigned' then acalist.fullname is not null ELSE TRUE END)
            AND (CASE WHEN assignedspecialist IS NOT NULL THEN lower(acalist.fullname) = lower(assignedspecialist) ELSE TRUE END )
            LIMIT pagesize OFFSET v_pageoffset;
    elsif (v_placementtype = 'Gap') then
         IF(v_roleid in ('IVESP','IVEEA') and v_status:: character varying = '{73}' :: character varying) THEN 
            RETURN QUERY 
                select count(1) over(), gaplist.* from (select ga.gapagreementid,null::uuid, null::uuid,null::varchar, p.cjamspid,p.lastname,p.firstname,null::timestamp,tce.guardian_subsidy_id::bigint,
                        CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)::VARCHAR as childname, sc.servicecasenumber::BIGINT as casenumber,'DHS' ::character varying as childagency,
                        (select c.countyname from caseassignment ca join county c on c.countyid = ca.toldssid and c.activeflag =1
                        where ca.objectid = sc.servicecaseid and ca.enddate is null order by ca.insertedon desc limit 1) ::character varying as childjurisdiction,
                        null::date as placementdate, p.dob::date as dateofbirth, null::varchar as removalage, sc.servicecaseid as caseid,
                        (select tep.sqnm_sw:: CHARACTER varying from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' and tep.approvalstatus = 'APPROVED'  AND tep.approvalid != 'AUTO_APPROVAL' order by tep.sqnm_sw desc limit 1),
                        (select tpv.description_tx::text as fostercareeligibilitystatus from tb_picklist_values tpv where trim(tpv.picklist_value_cd) = trim(tce.eligibility_status_cd) and tpv.picklist_type_id = 262),
                        ga.startdate, null::bigint
                from  tb_client_eligibility tce  
                INNER JOIN person p ON p.cjamspid=tce.client_id AND p.activeflag=1
                INNER JOIN guardianship g on g.alternateid = tce.guardian_subsidy_id
                INNER JOIN gapagreement ga on ga.gapid = g.gapid AND ga.activeflag = 1
                INNER JOIN servicecase sc ON sc.servicecaseid = g.servicecaseid AND sc.activeflag = 1
                WHERE tce.eligibility_type_cd = '2935' AND tce.delete_sw = 'N' and ga.enddate >= now() and
                (tce.eligibility_status_cd = '2909' or (EXTRACT(year FROM age(now()::date,p.dob::date)) between 18 and 21)) and
                ga.gapagreementid  in
                (
                    select (case when length(routing.objectid)=36 then objectid else null end)::uuid from routing where routing.tosecurityusersid::character varying=userid AND routing.activeflag=1 AND routing.eventcode='GAAR' AND routing.routingstatustypeid::text = any (v_status) and routing.toroleid = v_roleid
                )
                AND (CASE WHEN fname IS NOT NULL THEN  UPPER(p.firstname) like '%' || UPPER(fname) || '%' ELSE TRUE END)
                AND (CASE WHEN lname IS NOT NULL THEN  UPPER(p.lastname) like '%' || UPPER(lname) || '%' ELSE TRUE END)
                AND (CASE WHEN clientIddata IS NOT NULL THEN  p.cjamspid::character varying = clientIddata ELSE TRUE END)
                order by (case v_sortorder when 'asc' then ga.startdate END) ASC NULLS LAST,
                    (case v_sortorder when 'desc' then ga.startdate END) DESC NULLS last,
                    (case v_sortorder when null then ga.updatedon END) DESC NULLS last)  as gaplist
            where (CASE WHEN county IS NOT NULL THEN gaplist.childjurisdiction:: character varying = ANY(county) ELSE TRUE END )
            AND (CASE when gaplist.sqnm_sw IS NOT NULL THEN gaplist.sqnm_sw != 'R' ELSE TRUE END)
            AND (CASE WHEN eligiblestatus IS NOT NULL THEN  trim(gaplist.fostercareeligibilitystatus)::character varying = eligiblestatus ELSE TRUE END)
            AND (CASE when lower(filtertype) = 'completed' THEN gaplist.fostercareeligibilitystatus is not null and gaplist.fostercareeligibilitystatus != 'Pending' ELSE TRUE END)
            LIMIT pagesize OFFSET v_pageoffset;
            ELSE 
                RETURN QUERY 
                select count(1) over(), gaplist.* from (select ga.gapagreementid,null::uuid, null::uuid,
                        (select up.fullname::varchar from routing r join userprofile up on up.securityusersid = r.tosecurityusersid
                        where r.activeflag=1 AND r.eventcode='GAAR' AND r.routingstatustypeid::text = '73' and r.toroleid in ('IVESP','IVEEA')
                        and r.objectid :: character varying = ga.gapagreementid :: character varying order by r.insertedon desc limit 1), p.cjamspid,p.lastname,p.firstname,null::timestamp,tce.guardian_subsidy_id::bigint,
                        CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)::VARCHAR as childname, sc.servicecasenumber::BIGINT as casenumber,'DHS' ::character varying as childagency,
                        (select c.countyname from caseassignment ca join county c on c.countyid = ca.toldssid and c.activeflag =1
                        where ca.objectid = sc.servicecaseid and ca.enddate is null order by ca.insertedon desc limit 1) ::character varying as childjurisdiction,
                        null::date as placementdate, p.dob::date as dateofbirth, null::varchar as removalage, sc.servicecaseid as caseid,
                        (select tep.sqnm_sw:: CHARACTER varying from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' and tep.approvalstatus = 'APPROVED'  AND tep.approvalid != 'AUTO_APPROVAL' order by tep.sqnm_sw desc limit 1),
                        (select tpv.description_tx::text as fostercareeligibilitystatus from tb_picklist_values tpv where trim(tpv.picklist_value_cd) = trim(tce.eligibility_status_cd) and tpv.picklist_type_id = 262),
                        ga.startdate, null::bigint
                from  tb_client_eligibility tce   
                INNER JOIN person p ON p.cjamspid=tce.client_id AND p.activeflag=1 
                INNER JOIN guardianship g on g.alternateid = tce.guardian_subsidy_id
                INNER JOIN gapagreement ga on ga.gapid = g.gapid AND ga.activeflag = 1
                INNER JOIN servicecase sc ON sc.servicecaseid = g.servicecaseid AND sc.activeflag = 1
                WHERE tce.eligibility_type_cd = '2935' AND tce.delete_sw = 'N' and ga.enddate >= now() and
                (tce.eligibility_status_cd = '2909' or (EXTRACT(year FROM age(now()::date,p.dob::date)) between 18 and 21)) and
                ga.gapagreementid in
                (
                    select (case when length(routing.objectid)=36 then objectid else null end)::uuid from routing where routing.activeflag=1 AND routing.eventcode='GAAR' AND routing.routingstatustypeid::text = any (v_status)
                )
                AND (CASE WHEN fname IS NOT NULL THEN  UPPER(p.firstname) like '%' || UPPER(fname) || '%' ELSE TRUE END)
                AND (CASE WHEN lname IS NOT NULL THEN  UPPER(p.lastname) like '%' || UPPER(lname) || '%' ELSE TRUE END)
                AND (CASE WHEN clientIddata IS NOT NULL THEN  p.cjamspid::character varying = clientIddata ELSE TRUE END)
                order by (case v_sortorder when 'asc' then ga.startdate END) ASC NULLS LAST,
                    (case v_sortorder when 'desc' then ga.startdate END) DESC NULLS last,
                    (case v_sortorder when null then ga.updatedon END) DESC NULLS last)  as gaplist
            where (CASE WHEN county IS NOT NULL THEN gaplist.childjurisdiction:: character varying = ANY(county) ELSE TRUE END )
            AND (CASE WHEN lower(filtertype) = 'unassigned' then gaplist.fullname is null 
                      WHEN lower(filtertype) = 'assigned' then gaplist.fullname is not null 
                      when lower(filtertype) = 'completed' THEN gaplist.fostercareeligibilitystatus is not null and gaplist.fostercareeligibilitystatus != 'Pending' ELSE TRUE END)
            AND (CASE WHEN eligiblestatus IS NOT NULL THEN  trim(gaplist.fostercareeligibilitystatus)::character varying = eligiblestatus ELSE TRUE END)
            AND (CASE WHEN assignedspecialist IS NOT NULL THEN lower(gaplist.fullname) = lower(assignedspecialist) ELSE TRUE END )
            AND (CASE when gaplist.sqnm_sw IS NOT NULL THEN gaplist.sqnm_sw != 'R' ELSE TRUE END)
                LIMIT pagesize OFFSET v_pageoffset;
            END IF;
    end if;
END;

$function$
;
