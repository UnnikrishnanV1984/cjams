
DROP FUNCTION IF EXISTS personlifeskillassessmentlist(v_personid uuid, pagenumber bigint, pagesize bigint);
CREATE OR REPLACE FUNCTION personlifeskillassessmentlist(v_personid uuid, pagenumber bigint, pagesize bigint)
RETURNS json
LANGUAGE plpgsql
AS $function$

DECLARE
v_pageoffset int;
v_pagenumber int; 
l_serviceaction json;
BEGIN
v_pagenumber := pagenumber-1;
v_pageoffset = v_pagenumber * pagesize;

SELECT json_agg(e) INTO l_serviceaction 
FROM(
SELECT count(1) over() as totalcount,
lsa.lifeskillassessid,
lsa.assessmentdate,
lsa.assessmenttypekey,
(select pv.value_tx from tb_picklist_values pv where trim(pv.picklist_value_cd) = trim(lsa.assessmenttypekey) and pv.picklist_type_id = 10018 ) as assessmenttype,
lsa.assessmentlocation,
lsa.insertedby, 
lsa.updatedby,
lsa.insertedon, 
lsa.updatedon, 
lsa.activeflag, 
lsa.fk_id, 
lsa.old_id,
lsa.personid
from personlifeskillassessment lsa 
where  lsa.activeflag = 1 and lsa.personid = v_personid
order by lsa.assessmentdate asc
LIMIT pagesize OFFSET v_pageoffset	)e ;
RETURN l_serviceaction;
END;

$function$
;