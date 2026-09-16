DROP FUNCTION IF EXISTS cjams.mycasesearch_expunge(character varying, integer, integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.mycasesearch_expunge(userid character varying, page integer, pagelimit integer, casesearchval character varying, sortorder character varying, sortcolumn character varying, v_worker character varying, actiontype character varying, v_foldertypekey character varying, v_status character varying)
 RETURNS TABLE(totalcount bigint, intakeserviceid character varying, legalguardian json, servicerequestnumber character varying, srtype text, datereceived timestamp without time zone, workername character varying, updateon timestamp without time zone, adoptionplanningid uuid, startdate timestamp without time zone, restrictedstatus text, outcomes json, providerdetails json, istagged integer)
 LANGUAGE plpgsql
AS $function$                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
------------------------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 11/10/2025 Amiya Pradhan - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
-- 11/06/2025 Umasankar Raavi - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases (intake changes)
------------------------------------------------------------------------------------------------------------  
DECLARE v_pageoffset int;
v_pagenumber int;
l_actiontype character varying;
BEGIN v_pagenumber := (page -1)* 10;
l_actiontype := actiontype;
RETURN QUERY 
select 
  count(1) over(), 
  x.*, 
  COALESCE(
    (
      SELECT 
        1 
      FROM 
        userreference 
      WHERE 
        securityusersid = userid 
        AND objectid = x.intakeserviceid
    ), 
    0
  ) 
from 
  (
    (
      select 
        ins.intakeserviceid :: character varying, 
        (
          select 
            (getcasepersonname_expunge) as legalguardian 
          from 
            getcasepersonname_expunge (
              'servicerequest', ins.intakeserviceid :: character varying
            )
        ), 
        ins.servicerequestnumber, 
        case when ins.actiontype = 'IR' then 'CPS IR' when ins.actiontype = 'AR' then 'CPS AR' end as casetype, 
        CAST(ins.ReportedDate as timestamp) as datereceived, 
        (
          select 
            string_agg(distinct up.fullname, '- '):: character varying 
          from 
            caseassignment ca 
            inner join userprofile up on up.securityusersid = ca.toworkeridno 
            and up.activeflag = 1 
          where 
            ca.objectid :: text = ins.intakeserviceid :: text 
            and ca.objecttypekey = 'servicerequest' 
            and (
              ca.enddate is null 
              or ca.enddate > now()
            )
        ) as fullname, 
        ins.updatedon, 
        null :: uuid, 
        null :: timestamp without time zone, 
        (
          SELECT 
            * 
          FROM 
            getRestrictedCaseStatus(
              ins.intakeserviceid :: text, userid
            )
        ) AS restrictStatus, 
        (
          select 
            json_agg(a) 
          from 
            (
              select 
                alle."name" 
              from 
                investigation inv 
                join Investigationmaltreatment im on im.investigationid = inv.investigationid 
                and im.activeflag = 1 
                JOIN Investigationallegation ia ON ia.maltreatmentid = im.maltreatmentid 
                INNER JOIN allegation alle on alle.allegationid = ia.allegationid 
                AND alle.activeflag = 1 
              where 
                inv.intakeserviceid = ins.intakeserviceid 
              group by 
                alle."name" 
              order by 
                (
                  case sortorder when 'asc' then alle."name" end
                ) asc nulls last, 
                (
                  case sortorder when 'desc' then alle."name" end
                ) desc nulls last
            ) as a
        ) as outcomes, 
        null :: json 
      from 
        expunge.intakeservicerequest_expunge ins 
      where 
        ins.activeflag = 1 
        and ins.teamtypekey = 'CW' 
        and ins.actiontype is not null 
        and ins.isdraft = 0 
        and (
          l_actiontype is null 
          or l_actiontype = '' 
          or ins.actiontype = l_actiontype
        ) 
        and (
          casesearchval is null 
          or casesearchval = '' 
          or LOWER(ins.servicerequestnumber) LIKE '%' || LOWER(casesearchval) || '%' 
          or ins.servicerequestnumber=(
            select 
              casenumber 
            from 
              cjamscisref 
            where 
              cisrefid :: character varying = casesearchval :: character varying 
            limit 
              1
          )
        ) 
        and (
          v_worker is null 
          or v_worker = '' 
          or (
            ins.intakeserviceid in (
              select 
                (
                  case when length(objectid)= 36 then objectid else null end
                ):: uuid 
              from 
                routing r 
              where 
                (r.tosecurityusersid) = (v_worker)
            )
          )
        ) 
      group by 
        ins.intakeserviceid, 
        ins.servicerequestnumber, 
        ins.actiontype, 
        ins.reporteddate, 
        ins.updatedon
    ) 
    union all 
      (
        SELECT 
          ids.intakenumber AS intakenumber, 
          (
            SELECT 
              (getcasepersonname_expunge) AS legalguardian 
            FROM 
              getcasepersonname_expunge(
                'intake', 
                ids.intakenumber:: varchar
              )
          ), 
          ids.intakenumber, 
          'Referral' AS casetype, 
          CASE WHEN ids.submitteddate IS NOT NULL THEN ids.submitteddate ELSE (
            SELECT 
              isr.reporteddate 
            FROM 
              expunge.intakeservicerequest_expunge isr 
            WHERE 
              isr.intakenumber = ids.intakenumber 
            ORDER BY 
              isr.insertedon DESC 
            LIMIT 
              1
          ) END AS datereceived, 
          (
            SELECT 
              upr.fullname 
            FROM 
              userprofile upr 
            WHERE 
              upr.securityusersid = up.intakeuser
            ORDER BY 
              upr.updatedon DESC 
            LIMIT 
              1
          ) AS fullname, 
          ids.updatedon, 
          NULL :: uuid, 
          NULL :: timestamp without time zone, 
          (
            SELECT 
              * 
            FROM 
              getRestrictedCaseStatus(
                ids.intakenumber:: text, 
                userid
              )
          ) AS restrictStatus, 
          NULL :: json, 
          NULL :: json 
        FROM 
          expunge.intakedastatus_expunge ids 
          JOIN expunge.intakedastaging_expunge up ON up.intakenumber = ids.intakenumber 
          AND up.activeflag = 1 
        WHERE 
          ids.activeflag = 1 
          AND ids.teamtypekey = 'CW' 
          AND up.teamtypekey = 'CW' 
          AND (
            l_actiontype IS NULL 
            OR l_actiontype = '' 
            OR l_actiontype = 'REF'
          ) 
          AND (
            casesearchval IS NULL 
            OR casesearchval = '' 
            OR LOWER(
              ids.intakenumber
            ) LIKE '%' || LOWER(casesearchval) || '%' 
            OR ids.intakenumber = (
              SELECT 
                casenumber 
              FROM 
                cjamscisref 
              WHERE 
                cisrefid :: varchar = casesearchval :: varchar 
              LIMIT 
                1
            )
          ) AND (
            v_worker IS NULL 
            OR v_worker = '' 
            OR up.intakeuser = v_worker
          )
      ) 
    union all 
      --CIDM-9845 - Migrated intakes
      (
        SELECT 
          ids.intakenumber:: varchar(50) AS intakenumber, 
          (
            SELECT 
              (getcasepersonname_expunge) AS legalguardian 
            FROM 
              getcasepersonname_expunge(
                'intake', 
                ids.intakenumber:: varchar(50)
              )
          ), 
          ids.intakenumber:: varchar(50), 
          'Referral' AS casetype, 
          CASE WHEN ids.submitteddate IS NOT NULL THEN ids.submitteddate ELSE (
            SELECT 
              isr.reporteddate 
            FROM 
              expunge.intakeservicerequest_expunge isr 
            WHERE 
              isr.intakenumber = ids.intakenumber 
            ORDER BY 
              isr.insertedon DESC 
            LIMIT 
              1
          ) END AS datereceived, 
          'Migrated User' AS fullname, 
          ids.updatedon, 
          NULL :: uuid, 
          NULL :: timestamp without time zone, 
          (
            SELECT 
              * 
            FROM 
              getRestrictedCaseStatus(
                ids.intakenumber:: text, 
                userid
              )
          ) AS restrictStatus, 
          NULL :: json, 
          NULL :: json 
        FROM 
          expunge.intakedastatus_expunge ids 
        WHERE 
          ids.activeflag = 1 
          AND ids.teamtypekey = 'CW' 
          AND ids.updatedby = 'migrationuser' 
          AND (
            l_actiontype IS NULL 
            OR l_actiontype = '' 
            OR l_actiontype = 'REF'
          ) 
          AND (
            casesearchval IS NULL 
            OR casesearchval = '' 
            OR LOWER(
              ids.intakenumber:: varchar(50)
            ) LIKE '%' || LOWER(casesearchval) || '%' 
            OR ids.intakenumber:: varchar(50) = (
              SELECT 
                casenumber 
              FROM 
                cjamscisref 
              WHERE 
                cisrefid :: varchar = casesearchval :: varchar 
              LIMIT 
                1
            )
          ) AND (
            v_worker IS NULL 
            OR v_worker = ''
          ) 
          AND NOT EXISTS (
            SELECT 
              1 
            FROM 
              expunge.intakedastaging_expunge sta 
            WHERE 
              sta.intakenumber = ids.intakenumber 
          )
      )
  ) x 
WHERE 
  x.restrictStatus in ('INCL', 'INCLRES', 'EXCLUDE') 
ORDER BY 
  (
    case sortorder when 'asc' then case sortcolumn when 'srtype' then cast(x.casetype as character varying) when 'servicerequestnumber' then cast(
      x.servicerequestnumber as character varying
    ) when 'legalguardian' then cast(
      x.legalguardian as character varying
    ) when 'datereceived' then cast (
      x.datereceived as character varying
    ) when 'workername' then cast(x.fullname as character varying) when 'outcomes' then cast(x.outcomes as character varying) END END
  ) ASC NULLS LAST, 
  (
    case sortorder when 'desc' then case sortcolumn when 'srtype' then cast(x.casetype as character varying) when 'servicerequestnumber' then cast(
      x.servicerequestnumber as character varying
    ) when 'legalguardian' then cast(
      x.legalguardian as character varying
    ) when 'datereceived' then cast (
      x.datereceived as character varying
    ) when 'workername' then cast(x.fullname as character varying) when 'outcomes' then cast(x.outcomes as character varying) END END
  ) DESC NULLS LAST 
LIMIT 
  pagelimit OFFSET v_pagenumber;
END;
$function$;
