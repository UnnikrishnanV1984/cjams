DROP FUNCTION IF EXISTS cjams.searchpriordsdsaction_adoptioncase(uuid, varchar, varchar, varchar);

CREATE OR REPLACE FUNCTION cjams.searchpriordsdsaction_adoptioncase(v_personid uuid, v_userid character varying)
 RETURNS TABLE(objectid character varying, danumber character varying, daplanningid character varying, dasubtype character varying, roles jsonb, datereceived timestamp without time zone, datecreated timestamp without time zone, datecompleted timestamp without time zone, status character varying, datype character varying, county character varying, restrictstatus text, outcomes json, personname text, relationshiparray json, workername character varying, headofhousehlod json, allegedmaltreator json)
 LANGUAGE plpgsql
AS $function$    
BEGIN 
RETURN QUERY

SELECT * FROM (
        select ac.adoptioncaseid::character varying,
            ac.adoptioncasenumber,
            ac.adoptionplanningid::character varying,
            ''::character varying as dasubtype,
            jsonb_agg(ref_role.value_text) as roles,
            ac.startdate as DateReceived,
            ac.startdate as DateCreated,
            case
                when lower(acd.dispositioncode) = 'closed' then acd.effectivedate
                else null
            end AS DateCompleted,
            ac.statustypekey as Status,
            'Adoption Case'::character varying as datype,
            null::character varying as county,
            (
                SELECT *
                FROM getRestrictedCaseStatus(ac.adoptioncaseid::text, v_userid)
            ) AS restrictStatus,
            null::json,
            null::text,
            null::json,
            (
                SELECT cast(
                        UP.firstname || ' ' || UP.lastname as character varying
                    ) as workername
                FROM routing R
                    INNER JOIN userprofile UP on UP.securityusersid = R.tosecurityusersid
                WHERE R.objectid = ac.adoptioncaseid::character varying
                    AND R.activeflag = 1
                limit 1
            ), (
                SELECT json_agg(x) as headofhousehlod
                FROM (
                        SELECT distinct concat_ws(
                                ' ',
                                coalesce(p.firstname, null),
                                coalesce(p.middlename, null),
                                coalesce(p.lastname, null),
                                coalesce(p.suffix, null)
                            )::character varying as personname
                        FROM adoptioncaseactor acar
                            INNER JOIN person p on p.personid = acar.personid
                            AND p.activeflag = 1
                            AND acar.adoptioncaseid = ac.adoptioncaseid
                        ORDER BY 1
                    ) as x
            )::json,
            null::json 
        FROM adoptioncase ac
            join adoptioncaseactor acar on ac.adoptioncaseid = acar.adoptioncaseid
            join person pr on pr.personid = acar.personid
            and pr.activeflag = 1
            left join referencevalues ref_role on ref_role.ref_key = acar.actortypekey
            and ref_role.referencetypeid in (175, 176)
            left join (
                select *
                from adoptioncasedisposition acd1
                where acd1.adoptioncaseid in (
                        select distinct(acar1.adoptioncaseid)
                        from person p1 join adoptioncaseactor acar1 on acar1.personid = p1.personid
                        where p1.personid = v_personid                                
                    )
                    and acd1.activeflag = 1
                order by updatedon desc
                limit 1
            ) acd on acd.adoptioncaseid = ac.adoptioncaseid
        where (pr.personid = v_personid)
        group by ac.adoptioncaseid,
            ac.adoptioncasenumber,
            ac.adoptionplanningid,
            ac.startdate,
            ac.statustypekey,
            acd.dispositioncode,
            acd.effectivedate
    ) AS datav
WHERE datav.restrictStatus in ('INCL', 'INCLRES', 'EXCLUDE')
order by datav.datype,
    datav.DateReceived desc;
END;
$function$
;