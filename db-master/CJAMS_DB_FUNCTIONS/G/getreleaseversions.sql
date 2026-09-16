DROP FUNCTION IF EXISTS cjams.getreleaseversions(date, date, character varying, character varying, character varying, character varying, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getreleaseversions(v_startdate date, v_enddate date, v_releaseversion character varying, v_securityusersid character varying, v_sortcolumn character varying, v_sortorder character varying, pagenumber integer, pagesize integer, v_application character varying)
 RETURNS TABLE(totalcount bigint, releaseversionno character varying, releasedate date, publish boolean)
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_pageoffset 	INTEGER;
	v_pagenumber 	INTEGER;
	v_approver		BOOLEAN;
	v_admin			BOOLEAN;

BEGIN

	v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;
	
	select case when count(*) > 0 then true else false end into v_approver
		from cjams.muser m
			join cjams.userresource ur on ur.userid = m.id and ur.activeflag = 1
			join cjams.permissiongroup pg on pg.permissiongroupid  = ur.permissiongroupid and pg.activeflag = 1
		where pg.permissiongroupname = 'RELEASE_APPROVER'
			and m.securityusersid = v_securityusersid; 
			
	select case when count(*) > 0 then true else false end into v_admin
		from cjams.muser m
			join cjams.userresource ur on ur.userid = m.id and ur.activeflag = 1
			join cjams.permissiongroup pg on pg.permissiongroupid  = ur.permissiongroupid and pg.activeflag = 1
		where pg.permissiongroupname = 'RELEASE_ADMIN'
			and m.securityusersid = v_securityusersid; 
	
	RETURN QUERY
		SELECT  COUNT(*) over(), r.releaseversionno, r.releasedate, r.publish 
			FROM defecttracking.releasenotes r
			WHERE activeflag = 1
				AND r.application = v_application
				AND CASE WHEN v_releaseversion IS NOT NULL THEN lower(r.releaseversionno) like '%' || lower(v_releaseversion) ||'%' ELSE true END
				AND CASE WHEN v_startdate IS NOT NULL THEN r.releasedate >= v_startdate::date ELSE true END
				AND CASE WHEN v_enddate IS NOT NULL THEN r.releasedate <= v_enddate::date ELSE true END
				and CASE WHEN v_approver IS true OR v_admin IS true THEN true ELSE r.publish IS true END 
			GROUP BY  r.releaseversionno, r.releasedate, r.publish 
			ORDER BY 
						(
						CASE v_sortorder
							WHEN 'asc'
							THEN
								CASE v_sortcolumn
									WHEN 'releaseversionno' THEN r.releaseversionno:: character varying
									WHEN 'releasedate' THEN  (r.releasedate::timestamp)::character varying
									ELSE  r.releasedate::character varying
								END
						END) ASC NULLS last,
						(CASE v_sortorder
							WHEN 'desc'
							THEN
								CASE v_sortcolumn
									WHEN 'releaseversionno' THEN r.releaseversionno:: character varying
									WHEN 'releasedate' THEN  (r.releasedate::timestamp)::character varying
									ELSE  r.releasedate::character varying
								END
						END) DESC NULLS last 
			LIMIT  pagesize 
			offset v_pageoffset;  
	
END;

$function$
;
