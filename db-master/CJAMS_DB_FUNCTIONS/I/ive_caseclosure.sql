
DROP FUNCTION IF EXISTS cjams.ive_caseclosure(v_casenumber character varying, v_clientid character varying, v_status character varying, v_roleid character varying, fromsecurityusersid character varying, v_tosecurityusersid character varying, statustype character varying, v_securityuserid character varying, pagenumber bigint, pagesize bigint);                           
DROP FUNCTION IF EXISTS cjams.ive_caseclosure(v_casenumber character varying, v_clientid character varying, v_status character varying, v_roleid character varying, fromsecurityusersid character varying, v_tosecurityusersid character varying, statustype character varying, v_county character varying, v_securityuserid character varying, pagenumber bigint, pagesize bigint);
DROP FUNCTION IF EXISTS cjams.ive_caseclosure(v_casenumber character varying, v_clientid character varying, v_status character varying, v_roleid character varying, fromsecurityusersid character varying, v_tosecurityusersid character varying, statustype character varying, v_county uuid, v_securityuserid character varying, pagenumber bigint, pagesize bigint);
DROP FUNCTION IF EXISTS cjams.ive_caseclosure(v_casenumber character varying, v_clientid character varying, v_status character varying, v_roleid character varying, fromsecurityusersid character varying, v_tosecurityusersid character varying, statustype character varying, v_securityuserid character varying, pagenumber bigint, pagesize bigint, v_county uuid);
DROP FUNCTION IF EXISTS cjams.ive_caseclosure(v_casenumber character varying, v_clientid integer, v_status character varying, v_roleid character varying, fromsecurityusersid character varying, v_tosecurityusersid character varying, statustype character varying, v_county uuid, v_securityuserid character varying, pagenumber bigint, pagesize bigint);
DROP FUNCTION IF EXISTS cjams.ive_caseclosure(v_casenumber character varying, v_clientid integer, v_status character varying, v_roleid character varying, fromsecurityusersid character varying, v_tosecurityusersid character varying, statustype character varying, v_securityuserid character varying, pagenumber bigint, pagesize bigint, v_county uuid);
DROP FUNCTION IF EXISTS cjams.ive_caseclosure(v_casenumber character varying, v_clientid integer, v_status character varying, v_roleid character varying, fromsecurityusersid character varying, v_tosecurityusersid character varying, statustype character varying, v_securityuserid character varying, pagenumber bigint, pagesize bigint, v_county uuid , filtertype character varying);
CREATE OR REPLACE FUNCTION cjams.ive_caseclosure(v_casenumber character varying, v_clientid integer, v_status character varying, v_roleid character varying, fromsecurityusersid character varying, v_tosecurityusersid character varying, statustype character varying, v_securityuserid character varying, pagenumber bigint, pagesize bigint, v_county varchar[], filtertype character varying DEFAULT NULL::character varying)
 RETURNS TABLE(countdata bigint, casenumber character varying, caseid uuid, casetype character varying, ivereviewstatus character varying, ivecaseclosurereviewid character varying, timeframe character varying, startdate timestamp without time zone, updatedon timestamp without time zone, fromid character varying, touserid character varying, ivestatuscode integer, jurisdiction character varying, legalguardian jsonb, caseworker character varying, assignedto character varying, persondetails jsonb)
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------
--Revision(s)
-- 06/03/2024 - Smitha Somasekharan - IV-E Case closure update userstory changes (CIDM-8903)
-- 09/04/2024 - Vinesh - CIDM-9305 Client ID Search results are not fetched for IV-E Case closure review assignment and approval dashboard 
-- 09/13/2024 - Vinesh/Agathya - CIDM-9305 changes made for query optimization
--12/16/2024 - Sai Teja Chintha -- CDM-42867 Missing cases on the case closure dashboard
-- 09/23/2025 - Veera Nadimpalli - CDM-44518 To get Guardian Subsidy ID
-- CIDM-10835 - Veera - IVE Dashboard refinement
--02/10       - for IVECCR query refined to improve performace
-- 03/12 - Veera Fix for Head of household
-------------------------------------------------------------------------
 
    DECLARE
        v_pageoffset int;
        v_pagenumber int;
    DECLARE 
        totalcount integer;
    BEGIN
	    v_pagenumber := pagenumber-1;
        v_pageoffset = v_pagenumber * pagesize;
    if(v_roleid = 'IVECCR') then
		    if (fromsecurityusersid is null and v_tosecurityusersid is null) then
             RETURN QUERY 
             
        WITH base_query AS (
                -- STEP 1: Identify ALL matching IDs (Millisecond speed because no JSON logic)
                SELECT 
                DISTINCT ON (iccr.ivecaseclosurereviewid)
                    iccr.ivecaseclosurereviewid,
                    iccr.objectid,
                    iccr.updatedon,
                    'servicecase'::text as c_type,
                    sc.servicecasenumber as c_num
                FROM ivecaseclosurereview iccr
                INNER JOIN servicecase sc ON sc.servicecaseid = iccr.objectid 
                INNER JOIN cjams.routing rt ON rt.objectid = iccr.ivecaseclosurereviewid::character varying 
                    AND rt.activeflag = 1 AND rt.eventcode = 'IVECCR'
                    INNER JOIN tb_client_eligibility tce ON tce.case_id = sc.servicecasenumber::bigint
                WHERE iccr.activeflag = 1
                   
                  and (case when v_status is not null then iccr.ivereviewstatus = v_status else (CASE WHEN statustype = 'assignment' THEN iccr.ivereviewstatus in ('CCR_Review', 'CCR_Assigned') ELSE iccr.ivereviewstatus in ('CCR_Pending', 'CCR_Approved', 'CCR_Rejected') END) end)
			and (case when v_casenumber is not null then sc.servicecasenumber = v_casenumber::character varying else true end)
			AND (CASE WHEN lower(filtertype) = 'unassigned' then rt.tosecurityusersid  is null ELSE TRUE END)
			and (case when iccr.ivereviewstatus = 'CCR_Pending' then rt.tosecurityusersid=v_securityuserid else (case when iccr.ivereviewstatus = 'CCR_Approved' then rt.fromsecurityusersid=v_securityuserid else true end)end) 
		and case when v_clientid is not null then exists (select 1 from tb_client_eligibility tce where tce.case_id = sc.servicecasenumber::bigint and tce.client_id = v_clientid) else true end
          			and case when v_county is not null and (ARRAY_LENGTH(v_county,1)  > 0) then exists (select 1 from caseassignment ca where  ca.objectid =  iccr.objectid and lower(ca.responsibilitytypekey) = 'family' and ca.activeflag = 1 and ca.toldssid :: text = ANY(v_county)) else true end 
  

                 
                UNION ALL

                SELECT 
                DISTINCT ON (iccr.ivecaseclosurereviewid)
                    iccr.ivecaseclosurereviewid,
                    iccr.objectid,
                    iccr.updatedon,
                    'adoptioncase'::text as c_type,
                    ac.adoptioncasenumber::character varying as c_num
                FROM ivecaseclosurereview iccr
                INNER JOIN adoptioncase ac ON ac.adoptioncaseid = iccr.objectid 
                INNER JOIN cjams.routing rt ON rt.objectid = iccr.ivecaseclosurereviewid::character varying 
                    AND rt.activeflag = 1 AND rt.eventcode = 'IVECCR'
                    INNER JOIN tb_client_eligibility tce ON tce.case_id =  ac.adoptioncasenumber::bigint
                WHERE iccr.activeflag = 1
                  and (case when v_status is not null then iccr.ivereviewstatus = v_status else (CASE WHEN statustype = 'assignment' THEN iccr.ivereviewstatus in ('CCR_Review', 'CCR_Assigned') ELSE iccr.ivereviewstatus in ('CCR_Pending', 'CCR_Approved', 'CCR_Rejected') END) end)
			AND (CASE WHEN lower(filtertype) = 'unassigned' then rt.tosecurityusersid  is null ELSE TRUE END)
			and (case when v_casenumber is not null then ac.adoptioncasenumber = v_casenumber::character varying else true end)
				and (case when iccr.ivereviewstatus = 'CCR_Pending' then rt.tosecurityusersid=v_securityuserid else (case when iccr.ivereviewstatus = 'CCR_Approved' then rt.fromsecurityusersid=v_securityuserid else true end)end)
		and case when v_clientid is not null then exists (select 1 from tb_client_eligibility tce where tce.case_id = ac.adoptioncasenumber::bigint and tce.client_id = v_clientid) else true end 
			and case when v_county is not null and (ARRAY_LENGTH(v_county,1)  > 0) then exists (select 1 from caseassignment ca where  ca.objectid =  iccr.objectid and lower(ca.responsibilitytypekey) = 'family' and ca.activeflag = 1 and ca.toldssid :: text = ANY(v_county)) else true end) 
            , countquery AS (
                SELECT 
                    COUNT(*) OVER() as total_count,
                    r.*
                FROM base_query r
                ORDER BY r.updatedon DESC
                LIMIT pagesize OFFSET v_pageoffset
            )  
            
            SELECT 
                pd.total_count,
                pd.c_num,
                pd.objectid::uuid, -- caseid
                pd.c_type::character varying,
                iccr.ivereviewstatus::character varying,
                pd.ivecaseclosurereviewid::character varying,
                to_char(cjams.nextbusinessday(iccr.insertedon::date, 5), 'MM/DD/YYYY HH:MI AM')::character varying,
                iccr.insertedon, -- startdate
                pd.updatedon,
                rt.fromsecurityusersid,
                rt.tosecurityusersid,
                rt.routingstatustypeid,
                (SELECT c.countyname FROM caseassignment ca JOIN county c ON c.countyid::character varying = ca.toldssid::character varying WHERE ca.objectid = iccr.objectid AND lower(ca.responsibilitytypekey) = 'family' AND ca.activeflag = 1 ORDER BY ca.insertedon DESC LIMIT 1),
                jsonb_build_array(jsonb_build_object('getcasepersonname', COALESCE((SELECT getcasepersonname(pd.c_type, pd.objectid::character varying))::jsonb, '[]'::jsonb))),
                cw.fullname,
                (CASE WHEN statustype = 'assignment' OR iccr.ivereviewstatus = 'CCR_Approved' THEN atu.fullname ELSE afu.fullname END),
                (SELECT coalesce(jsonb_agg(v_p), '[]') FROM (
                    SELECT DISTINCT p.personid, p.firstname, p.lastname,p.cjamspid,
                    (select isrcr.removalid from intakeservreqchildremoval isrcr where isrcr.personid = p.personid and isrcr.servicecaseid = iccr.objectid and isrcr.activeflag = 1 order by isrcr.insertedon desc limit 1),
                    (select tce.eligibility_type_cd  from tb_client_eligibility tce where tce.client_id = p.cjamspid and (tce.case_id = pd.c_num::bigint and btrim(tce.eligibility_type_cd) not in ('2275','2274')) and tce.delete_sw = 'N' order by  tce.update_ts desc limit 1),
			         (select tce.guardian_subsidy_id  from tb_client_eligibility tce where tce.client_id = p.cjamspid and (tce.case_id = pd.c_num::bigint and btrim(tce.eligibility_type_cd) in ('2935')) and tce.delete_sw = 'N' order by  tce.update_ts desc limit 1),
			         (select coalesce (jsonb_agg(v_place), '[]') from (select distinct(programkey) from personprogramarea pla where pla.personid = p.personid and pla.objectid = iccr.objectid::character varying and activeflag=1 ) as v_place ) programs
                    FROM person p 
                    INNER JOIN tb_client_eligibility tce ON tce.client_id = p.cjamspid AND tce.case_id = pd.c_num::bigint
                    WHERE (v_clientid IS NULL OR p.cjamspid = v_clientid)
                ) v_p)
            FROM countquery pd
            INNER JOIN ivecaseclosurereview iccr ON iccr.ivecaseclosurereviewid = pd.ivecaseclosurereviewid
            INNER JOIN cjams.routing rt ON rt.objectid = iccr.ivecaseclosurereviewid::character varying AND rt.activeflag = 1
            LEFT JOIN userprofile cw ON cw.securityusersid = iccr.insertedby
            LEFT JOIN userprofile atu ON atu.securityusersid = rt.tosecurityusersid
            LEFT JOIN userprofile afu ON afu.securityusersid = rt.fromsecurityusersid;

		else 
		    RETURN QUERY
			select count(1) over() as countdata, * from (
			(select distinct(sc.servicecasenumber) as casenumber, sc.servicecaseid as caseid, iccr.objecttype as casetype, iccr.ivereviewstatus, iccr.ivecaseclosurereviewid::character varying, 
			to_char(cjams.nextbusinessday(iccr.insertedon :: date, 5::integer),'MM/DD/YYYY HH:MI AM')::character varying as timeframe,
			sc.startdate, iccr.updatedon,
			r.fromsecurityusersid as fromid,
			r.tosecurityusersid as touserid,
            r.routingstatustypeid as ivestatuscode,
			(select c.countyname 
                from caseassignment ca  
                    join county c on c.countyid:: character varying = ca.toldssid::character varying
              where ca.objectid =  iccr.objectid
                    and lower(ca.responsibilitytypekey) = 'family'
                    and ca.activeflag = 1
              order by ca.insertedon desc
              limit 1) as jurisdiction,
			jsonb_build_array(jsonb_build_object('getcasepersonname',COALESCE((SELECT getcasepersonname('servicecase', sc.servicecaseid::character varying))::jsonb, '[]'::jsonb))) as legalguardian,
            (select up.fullname from userprofile up where up.securityusersid = iccr.insertedby) as caseworker,
			(select up.fullname from userprofile up where up.securityusersid = r.tosecurityusersid) as assignedTo,
			(select coalesce (jsonb_agg(v_person), '[]') from (select distinct(p.personid), p.firstname, p.lastname, p.cjamspid,
			(select isrcr.removalid from intakeservreqchildremoval isrcr where isrcr.personid = p.personid and isrcr.servicecaseid = iccr.objectid and isrcr.activeflag = 1 order by isrcr.insertedon desc limit 1),
			(select tce.eligibility_type_cd  from tb_client_eligibility tce where tce.client_id = p.cjamspid and (tce.case_id = sc.servicecasenumber::bigint and btrim(tce.eligibility_type_cd) not in ('2275','2274')) and tce.delete_sw = 'N' order by  tce.update_ts desc limit 1),
			(select tce.guardian_subsidy_id  from tb_client_eligibility tce where tce.client_id = p.cjamspid and (tce.case_id = sc.servicecasenumber::bigint and btrim(tce.eligibility_type_cd) in ('2935')) and tce.delete_sw = 'N' order by  tce.update_ts desc limit 1),
			(select coalesce (jsonb_agg(v_place), '[]') from (select distinct(programkey) from personprogramarea pla where pla.personid = p.personid and pla.objectid = iccr.objectid::character varying and activeflag=1 ) as v_place) as programs
			from person p  
			inner join tb_client_eligibility tce on tce.client_id = p.cjamspid and (tce.case_id = sc.servicecasenumber::bigint and btrim(tce.eligibility_type_cd) not in ('2275','2274')) and tce.delete_sw = 'N'
			where (case when v_clientid is not null then p.cjamspid = v_clientid else true end)) as v_person) as persondetails
			from ivecaseclosurereview iccr
			inner join routing r on r.objectid = iccr.ivecaseclosurereviewid::character varying and r.activeflag = 1
			inner join servicecase sc on sc.servicecaseid = iccr.objectid
			inner join tb_client_eligibility tce on tce.case_id = sc.servicecasenumber::bigint
			where iccr.activeflag =1 and (case when v_status is not null then iccr.ivereviewstatus = v_status else iccr.ivereviewstatus in ('CCR_Assigned', 'CCR_Pending', 'CCR_Approved')  end)
			and (case when v_casenumber is not null then sc.servicecasenumber = v_casenumber::character varying else true end)
			AND (CASE WHEN lower(filtertype) = 'unassigned' then r.tosecurityusersid  is null ELSE TRUE END)
			and (case when v_status is not null then (case when v_status='CCR_Pending' then  r.fromsecurityusersid::character varying = v_tosecurityusersid  else r.tosecurityusersid::character varying = v_tosecurityusersid end) else (r.tosecurityusersid::character varying = v_tosecurityusersid or r.fromsecurityusersid::character varying = v_tosecurityusersid) end)
			and case when v_clientid is not null then exists (select 1 from tb_client_eligibility tce where tce.case_id = sc.servicecasenumber::bigint and tce.client_id = v_clientid) else true end 
			and case when v_county is not null and (ARRAY_LENGTH(v_county,1)  > 0) then exists (select 1 from caseassignment ca where  ca.objectid =  iccr.objectid and lower(ca.responsibilitytypekey) = 'family' and ca.activeflag = 1 and ca.toldssid :: text = ANY(v_county)) else true end )
		union all
            -- adoption case
			(select distinct(ac.adoptioncasenumber) as casenumber, ac.adoptioncaseid as caseid, iccr.objecttype as casetype, iccr.ivereviewstatus, iccr.ivecaseclosurereviewid::character varying, 
			to_char(cjams.nextbusinessday(iccr.insertedon :: date, 5::integer),'MM/DD/YYYY HH:MI AM')::character varying as timeframe,
			ac.startdate, iccr.updatedon,
			r.fromsecurityusersid as fromid,
			r.tosecurityusersid as touserid,
			r.routingstatustypeid as ivestatuscode,
			(select c.countyname 
                from caseassignment ca  
                    join county c on c.countyid:: character varying = ca.toldssid::character varying
              where ca.objectid =  iccr.objectid
                    and lower(ca.responsibilitytypekey) = 'family'
                    and ca.activeflag = 1
              order by ca.insertedon desc
              limit 1) as jurisdiction,
			jsonb_build_array(jsonb_build_object('getcasepersonname',COALESCE((SELECT getcasepersonname('adoptioncase', ac.adoptioncaseid::character varying))::jsonb, '[]'::jsonb))) as legalguardian,
            (select up.fullname from userprofile up where up.securityusersid = iccr.insertedby) as caseworker,
			(select up.fullname from userprofile up where up.securityusersid = r.tosecurityusersid) as assignedTo,
			(select coalesce (jsonb_agg(v_person), '[]') from (
			select distinct(p.cjamspid),p.personid, p.firstname, p.lastname,tce.eligibility_type_cd,
			(select isrcr.removalid from intakeservreqchildremoval isrcr 
        		join intakeservicerequestactor iat on iat.intakeservicerequestactorid = apl.intakeservicerequestactorid and iat.activeflag = 1
        		where isrcr.personid = iat.personid and isrcr.activeflag = 1 order by isrcr.updatedon desc limit 1),
			 (select coalesce (jsonb_agg(v_place), '[]') from (select distinct(programkey) from personprogramarea pla where pla.personid = p.personid and pla.objectid = iccr.objectid::character varying and activeflag=1 ) as v_place) as programs			 
			from tb_client_eligibility tce 
			INNER JOIN person p ON p.cjamspid=tce.client_id AND p.activeflag=1
			LEFT JOIN adoptionplanning apl on apl.alternateid = tce.adoption_id and apl.activeflag = 1
			where tce.case_id::character varying=ac.adoptioncasenumber  and tce.eligibility_type_cd = '2934'
			and (case when v_clientid is not null then p.cjamspid = v_clientid else true end)
			) as v_person) as persondetails
			from ivecaseclosurereview iccr
			inner join routing r on r.objectid = iccr.ivecaseclosurereviewid::character varying and r.activeflag = 1
			inner join adoptioncase ac on ac.adoptioncaseid = iccr.objectid
			inner join tb_client_eligibility tce on tce.case_id = ac.adoptioncasenumber::bigint
			where iccr.activeflag =1 and (case when v_status is not null then iccr.ivereviewstatus = v_status else iccr.ivereviewstatus in ('CCR_Assigned', 'CCR_Pending', 'CCR_Approved')  end)
			and (case when v_casenumber is not null then ac.adoptioncasenumber = v_casenumber::character varying else true end)
			AND (CASE WHEN lower(filtertype) = 'unassigned' then r.tosecurityusersid  is null ELSE TRUE END)
			and (case when v_status is not null then (case when v_status='CCR_Pending' then r.fromsecurityusersid::character varying = v_tosecurityusersid else r.tosecurityusersid::character varying = v_tosecurityusersid end) else (r.tosecurityusersid::character varying = v_tosecurityusersid or r.fromsecurityusersid::character varying = v_tosecurityusersid) end)
		and case when v_clientid is not null then exists (select 1 from tb_client_eligibility tce where tce.case_id = ac.adoptioncasenumber::bigint and tce.client_id = v_clientid) else true end 
			and case when v_county is not null and (ARRAY_LENGTH(v_county,1)  > 0) then exists (select 1 from caseassignment ca where  ca.objectid =  iccr.objectid and lower(ca.responsibilitytypekey) = 'family' and ca.activeflag = 1 and ca.toldssid :: text = ANY(v_county)) else true end )
			) as y order by y.updatedon desc LIMIT pagesize OFFSET v_pageoffset;
		end if;
			--limit pagesize offset v_pageoffset;
    end if;
    END;
$function$
;
