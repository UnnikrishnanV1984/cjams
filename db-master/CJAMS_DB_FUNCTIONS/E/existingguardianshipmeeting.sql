DROP FUNCTION IF EXISTS existingguardianshipmeeting(character varying,int,int);

CREATE OR REPLACE FUNCTION existingguardianshipmeeting(v_dateofmeeting character varying, pageno integer, pagesize integer)
 RETURNS TABLE(totalcount bigint, guardinshipmeetingid uuid, countyid uuid, dateofmeeting timestamp without time zone, meetingstatus character varying, meetingtype character varying, starttime timestamp without time zone, endtime timestamp without time zone, guardinmeetingboardmembers json)
 LANGUAGE plpgsql
AS $function$

DECLARE v_pageoffset int;
  v_pagenumber int;
  
BEGIN
	v_pagenumber := pageno-1;
	v_pageoffset = v_pagenumber * pagesize;
RETURN QUERY 

select  count(1) OVER() totalcount,gm.guardinshipmeetingid,gm.countyid,gm.dateofmeeting, rv.description as meetingstatus,rv1.description as meetingtype,
gm.starttime,gm.endtime,
(SELECT json_agg(item)
FROM (select gmbms.guardinmeetingboardmembersid, gmbms.boardmembertype,gmbms.firstname,gmbms.lastname,gmbms.email,gmbms.phoneno from guardinmeetingboardmembers gmbms 
 left join referencevalues rv on rv.ref_key=gmbms.boardmembertype
where gmbms.guardinshipmeetingid=gm.guardinshipmeetingid) item
) as guardinmeetingboardmembers
from intakeservreqguradmeetingconfig ingc 
inner join guardinshipmeeting gm on gm.guardinshipmeetingid=ingc.guardinshipmeetingid and gm.activeflag=1

inner join referencevalues rv on rv.ref_key=gm.meetingstatus and rv.activeflag=1
inner join referencevalues rv1 on rv1.ref_key=gm.meetingtype and rv1.activeflag=1


where  gm.dateofmeeting::date=v_dateofmeeting::date and gm.meetingstatus='Pending'
 limit pagesize  offset v_pageoffset ;
 END;


$function$

