Drop FUNCTION IF EXISTS cjams.getpersonauditlog(uuid, character varying, bigint, bigint, character varying, character varying, character varying, character varying, character varying) ;

CREATE OR REPLACE FUNCTION cjams.getpersonauditlog(v_personid uuid, v_userid character varying, pagenumber bigint, pagesize bigint, sortorder character varying, sortcolumn character varying, v_updatedfrom character varying, v_updatedto character varying, caseworker character varying)
 RETURNS TABLE(totalcount bigint, personauditlogid uuid, personid uuid, personjson jsonb, updatedby character varying, updatedon timestamp without time zone, roledesc jsonb, racedes character varying, mdm_id character varying)
 LANGUAGE plpgsql
AS $function$      

-------------------------------------------------------------------------------------------------------
-- 05/13/2022 Mounika Gudise - Added racedesc condition to update only for particular record (CIDM-4625)
-- 09/22/2023 Chandra/Palani - Query tuning(CIDM-7984)
-- 05/11/2026 Vinesh - CIDM-11395 Audit log not loading after the person search fuzzy logic changes.
-------------------------------------------------------------------------------------------------------


DECLARE
v_pageoffset int;
    v_pagenumber int;

BEGIN

v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;
  RAISE  NOTICE  'v_updatedfrom  %',v_updatedfrom;
 RAISE  NOTICE  'v_updatedto  %',v_updatedto;
 RETURN QUERY
 
 select count(1) over(), pal.personauditlogid,pal.personid,pal.personjson,up.fullname,pal.insertedon,
  (select json_agg(x) from (select rv.description from referencevalues rv where rv.referencetypeid in (175,176) and (teamtypekey is null or teamtypekey = 'CW') and rv.ref_key = ANY (
( select * from jsonb_array_elements_text((pal.personjson ->>'roles'):: jsonb)))
 ) as x):: jsonb,
 (select r.typedescription from racetype r where  r.racetypekey = ((pal.personjson ->'Race'->0->> 'racetypekey') ::character varying)
  ) as racedes
 --rt.typedescription as racedes
 ,ip.personidentifiervalue as mdm_id
from personauditlog pal
left join personidentifier ip on ip.personid  = pal.personid  and ip.activeflag  =1
   and ip.personidentifiertypekey = 'MDM_ID'
left join userprofile up on up.securityusersid = pal.insertedby
left join personracetypemap pm on pm.personid =pal.personid and pm.activeflag =1
left join racetype rt on rt.racetypekey = pm.racetypekey  and rt.activeflag  =1
where pal.personid = v_personid
 and
/*case    WHEN (v_updatedfrom IS NOT NULL and  v_updatedto is not null)  and ( v_updatedfrom !='' and v_updatedto !='' )
THEN to_date(cast(pal.insertedon::date as text), 'YYYY-MM-DD')
BETWEEN to_date(cast(v_updatedfrom::date as TEXT), 'YYYY-MM-DD') and to_date(cast(v_updatedto::date as text), 'YYYY-MM-DD')
     WHEN (v_updatedto IS NOT NULL and  v_updatedto !='') and  (v_updatedfrom is null  or  v_updatedfrom ='' )
    THEN to_date(cast(pal.insertedon::date as text), 'YYYY-MM-DD')<= to_date(cast(v_updatedto::date as TEXT), 'YYYY-MM-DD')
      WHEN (v_updatedfrom IS NOT null and v_updatedfrom !='' ) and (v_updatedto ='' or v_updatedto is null)  
      THEN to_date(cast(pal.insertedon::date as text), 'YYYY-MM-DD')>= to_date(cast(v_updatedfrom::date as TEXT), 'YYYY-MM-DD')
   else true end*/
 
 case    WHEN (v_updatedfrom IS NOT NULL and  v_updatedto is not null)  and ( v_updatedfrom !='' and v_updatedto !='' )
THEN date(pal.insertedon)
BETWEEN to_date(cast(v_updatedfrom::date as TEXT), 'YYYY-MM-DD') and to_date(cast(v_updatedto::date as text), 'YYYY-MM-DD')
     WHEN (v_updatedto IS NOT NULL and  v_updatedto !='') and  (v_updatedfrom is null  or  v_updatedfrom ='' )
    THEN date(pal.insertedon)<= to_date(cast(v_updatedto::date as TEXT), 'YYYY-MM-DD')
      WHEN (v_updatedfrom IS NOT null and v_updatedfrom !='' ) and (v_updatedto ='' or v_updatedto is null)  
      THEN date(pal.insertedon)>= to_date(cast(v_updatedfrom::date as TEXT), 'YYYY-MM-DD')
   else true end
 
  and case when caseworker is not null and caseworker!='' then pal.updatedby = caseworker  else true end
order by (
CASE sortorder
WHEN 'asc'
THEN
                         CASE sortcolumn
                          WHEN 'modifiedby' THEN cast(up.fullname as character varying)
                            WHEN 'modifiedon' THEN  pal.insertedon :: character varying
                          WHEN 'suffix' THEN cast(pal.personjson ->> 'nameSuffix' as character varying)
                          WHEN 'prefix' THEN cast(pal.personjson ->> 'prefix' as character varying)
                          WHEN 'Firstname' THEN cast(pal.personjson ->> 'Firstname' as character varying)
                          WHEN 'LastName' THEN cast(pal.personjson ->> 'Lastname' as character varying)
                          WHEN 'Middlename' THEN cast(pal.personjson ->> 'Middlename' as character varying)
                          WHEN 'DOb' THEN pal.personjson ->> 'Dob' :: character varying
                          WHEN 'SSN' THEN pal.personjson ->> 'SSN'
              ELSE
                  pal.insertedon :: character varying
              END
              END) ASC NULLS LAST,
                (CASE sortorder
                  WHEN 'desc'
THEN
CASE sortcolumn
WHEN 'modifiedby' THEN cast(up.fullname as character varying)
                            WHEN 'modifiedon' THEN  pal.insertedon :: character varying
WHEN 'suffix' THEN cast(pal.personjson ->> 'nameSuffix' as character varying)
                          WHEN 'prefix' THEN cast(pal.personjson ->> 'prefix' as character varying)
                          WHEN 'Firstname' THEN cast(pal.personjson ->> 'Firstname' as character varying)
                          WHEN 'LastName' THEN cast(pal.personjson ->> 'Lastname' as character varying)
                          WHEN 'Middlename' THEN cast(pal.personjson ->> 'Middlename' as character varying)
                          WHEN 'DOb' THEN pal.personjson ->> 'Dob' :: character varying
                   WHEN 'SSN' THEN pal.personjson ->> 'SSN'
            ELSE
                pal.insertedon :: character varying
              END
                   END) DESC NULLS LAST
--            ELSE
--               insertedon DESC NULLS LAST
--            END

LIMIT pagesize OFFSET v_pageoffset;

END;

$function$
;