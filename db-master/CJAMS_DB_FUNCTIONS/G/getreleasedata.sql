DROP FUNCTION IF EXISTS cjams.getreleasedata(v_input json);
CREATE OR REPLACE FUNCTION cjams.getreleasedata(v_input json)
 RETURNS TABLE(totalcount bigint, supportno character varying, itemid character varying, itemtype character varying, frommailid character varying, releasenotesid uuid, description text, title character varying, documentlink character varying, publish boolean, displayname character varying, raisedby character varying, jirarequestno character varying, jirasupportno character varying)
 LANGUAGE plpgsql
AS $function$
declare
	v_releaseversionno		CHARACTER VARYING;
	v_jiraid CHARACTER VARYING;
	v_supportno CHARACTER VARYING;
	v_raisedbyuser CHARACTER VARYING;
	v_releasedate 		date;
	v_itemtype CHARACTER VARYING;
	v_sortorder CHARACTER VARYING;
	v_sortcolumn CHARACTER VARYING;
	v_pageoffset 	INTEGER;
	v_pagenumber 	INTEGER;
	v_pagesize INTEGER;
	v_nolimit boolean;
	v_title CHARACTER VARYING;
	v_description CHARACTER VARYING;
	v_application CHARACTER VARYING;
begin
	v_releaseversionno	:= v_input->>'releaseversionno';
	v_jiraid := v_input->>'jiraid'; 
	v_raisedbyuser := v_input->>'raisedbyuser';
	v_supportno := v_input->>'supportticketno';
	v_releasedate	:= v_input->>'releasedate'; 
	v_sortorder :=v_input->>'sortdirection';
	v_sortcolumn := v_input->>'sortcolumn';
	v_pagesize := v_input->>'pagesize';
	v_pagenumber :=(v_input->>'pagenumber')::integer-1;
	v_pageoffset = v_pagenumber * v_pagesize;
	v_itemtype := v_input->>'tab';
	v_nolimit := (v_input->>'nolimit')::boolean;
	v_title := v_input->>'title';
	v_description := v_input->>'description';
	v_application := v_input->>'application';
	
	IF (v_nolimit IS NULL) THEN
		v_nolimit = false;
	END IF;
	
	
	RETURN QUERY
		select COUNT(*) over(), r.supportid,r.itemid,r.itemtype, s.frommailid,r.releasenotesid ,r.description ,
				r.title, r.documentlink, r.publish, up.displayname, r.raisedby, s.jirarequestno,s.supportno
			from defecttracking.releasenotes r 
				left join defecttracking.supportlog s on s.supportno = r.supportid and s.activeflag = 1
				left join cjams.userprofile up on lower(up.email) = lower(s.frommailid) and up.activeflag = 1
			where r.activeflag = 1
				AND r.releaseversionno = v_releaseversionno 
				and r.releasedate = v_releasedate::date  
				AND r.application = v_application
				and CASE WHEN v_itemtype IS NOT NULL THEN r.itemtype = v_itemtype ELSE true END
				AND CASE WHEN v_supportno IS NOT NULL THEN lower(r.supportid) like '%'|| lower(v_supportno) ||'%' ELSE true end
				AND CASE WHEN v_jiraid IS NOT NULL THEN lower(r.itemid) like '%'|| lower(v_jiraid) ||'%' ELSE true end
				AND CASE WHEN v_raisedbyuser IS NOT NULL THEN 
					CASE WHEN v_itemtype = 'Defect' THEN lower(up.displayname) like '%' ||lower(v_raisedbyuser) ||'%'
						 WHEN v_itemtype = 'Story' THEN lower(r.raisedby) like '%' ||lower(v_raisedbyuser) ||'%'
						 ELSE false END
					ELSE true END
				AND CASE WHEN v_title IS NOT NULL THEN lower(r.title) like '%'|| lower(v_title) ||'%' ELSE true end
				AND CASE WHEN v_description IS NOT NULL THEN lower(r.description) like '%'|| lower(v_description) ||'%' ELSE true end
			ORDER BY 
						(
						CASE v_sortorder
							WHEN 'asc'
							THEN
								CASE v_sortcolumn
									WHEN 'supportno' THEN r.supportid:: character varying
									WHEN 'itemid' THEN  r.itemid:: character varying
									WHEN 'frommailid' THEN  s.frommailid:: character varying
									ELSE   r.itemid::character varying
								END
						END) ASC NULLS last,
						(CASE v_sortorder
							WHEN 'desc'
							THEN
								CASE v_sortcolumn
									WHEN 'supportno' THEN r.supportid:: character varying
									WHEN 'itemid' THEN  r.itemid:: character varying
									WHEN 'frommailid' THEN  s.frommailid:: character varying
									ELSE   r.itemid::character varying
								END
						END) DESC NULLS last
		LIMIT   CASE WHEN v_nolimit = false  THEN v_pagesize END offset 
				CASE WHEN v_nolimit = false  THEN v_pageoffset END;

 end;
$function$
;
