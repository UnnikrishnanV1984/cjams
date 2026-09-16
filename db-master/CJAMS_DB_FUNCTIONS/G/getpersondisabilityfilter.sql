
DROP FUNCTION IF EXISTS cjams.getpersondisability_filter(json,character varying);  --clean up _ ones in all envs
DROP FUNCTION IF EXISTS cjams.getpersondisabilityfilter(json,character varying);
CREATE OR REPLACE FUNCTION cjams.getpersondisabilityfilter(filters json,v_activeflag character varying )
 RETURNS TABLE(disabilityconditiontypekey character varying, diagnoiseddisabilitynotes character varying,
 startdate timestamp without time zone, enddate timestamp without time zone, 
 evaluationdate timestamp without time zone, evaluatorname character varying, disabilitytypekey character varying,
 comments character varying, value_text character varying, disablitydescription character varying,
 referencetypeid integer, disabilityflag integer, persondisabilityid uuid, personid uuid, hygienekey character varying, specialkey character varying,
 startdateunknown boolean, insertedon timestamp without time zone,activeflag integer ,submittedby text,previouscondition boolean,doesnotapply boolean,existingcondition boolean,selectdisability character varying)
 LANGUAGE plpgsql
AS $function$

-- 03/24/2025 Simar Singh -- CIDM-10103 add filter values for searching along with person id

DECLARE
v_personid uuid;
v_startDate timestamp;
v_endDate   timestamp;

BEGIN
v_startDate := (filters ->> 'startDate')::timestamp;
v_endDate := (filters ->> 'endDate')::timestamp;
v_personid := (filters ->> 'personid')::uuid;

RETURN QUERY

SELECT
pd.disabilityconditiontypekey,pd.diagnoiseddisabilitynotes,pd.startdate,pd.enddate,pd.evaluationdate,pd.evaluatorname,
pd.disabilitytypekey,pd.comments,rv.value_text,rv.description,rv.referencetypeid,pd.disabilityflag,pd.persondisabilityid,pd.personid,
pd.hygienekey,pd.specialkey,pd.startdateunknown,pd.insertedon,pd.activeflag,
COALESCE(up.firstname,'')||' '|| COALESCE(up.lastname,'') as submittedby ,pd.previouscondition,pd.doesnotapply,pd.existingcondition,pd.selectdisability
FROM 
persondisability pd
INNER JOIN referencevalues rv ON rv.ref_key=pd.disabilitytypekey AND rv.activeflag=1 and rv.teamtypekey='CW'
left join userprofile up on up.securityusersid::character varying=pd.insertedby::character varying
WHERE pd.personid=v_personid
and case when v_startDate is not null and v_endDate is not null and pd.startdate is not null then ( Date(pd.startdate) >= Date(v_startDate) and Date(pd.startDate) <= Date(v_endDate)) else true end

--AND pd.activeflag=1;
 and CASE WHEN v_activeflag is NOT NULL THEN (pd.activeflag in (0,1)) ELSE (pd.activeflag=1) end
  order by pd.insertedon desc;

END;


$function$;