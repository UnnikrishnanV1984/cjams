DROP function if exists getusernotification(json, boolean);

CREATE OR REPLACE FUNCTION cjams.getusernotification(searchobj json, isextentity boolean DEFAULT false)
 RETURNS TABLE(totalcount bigint, usernotificationid uuid, objecttype character varying, fromname text, toname character varying, frommail text, tomail character varying, usernotificationtypekey character varying, url text, subject character varying, priorityleveltypekey character varying, body text, hasattachments boolean, source character varying, entityid uuid, updatedby character varying, updatedon timestamp without time zone, insertedby character varying, insertedon timestamp without time zone, teammemberid uuid, attachmentlocation character, servicerequestnumber character varying, tosecurityusersid character varying, isreplied boolean, isforwarded boolean, iscarboncopy boolean, isread boolean, effectivedate timestamp without time zone, expirationdate timestamp without time zone, intakeserviceid character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 08/18/2021 - Vineet Tirodkar - Modifications to pull system generated Notifications (B-107734)
-- 03/16/2023 --04/10/2023 - CIDM-6888 -- Query fine tuning
-- 07-28-2023 - CIDM-7179 - Isread flag changes - Veera
-- 08/01/2023 -- Performance fix (CIDM-7179)
-- 01/10/2024 -- Manasa/Palani Performance tuning (CIDM-8284)
-- 09/13/2024 -- Yogeshvar CIDM-9413 - Add filters for notifications by Source, Startdate, Enddate
-- 21/08/2024 -- Query tuning (CIDM-8332) -> Improvement from 0.180ms - 0.163ms
-- 02/07/2026 - CIDM-11090 -> Filter for last 1 month only for Performance improvement
------------------------------------------------------------------------
DECLARE 
v_userID character varying;
v_liPageNumber      INT;                                                          
v_liPageSize       INT;      
v_startDate date;
v_endDate date;
v_source character varying;                                                   
v_pageSize  INT; 
v_pageNumber INT;
v_pageOffset int;

BEGIN

v_userID := searchObj ->> 'userid';
v_liPageNumber := searchObj ->> 'pagenumber';
v_liPageSize := searchObj ->> 'pagesize';
v_startDate := searchObj ->> 'startdate';
v_endDate := searchObj ->> 'enddate';
v_source := searchObj ->> 'source';
 
v_pageNumber := v_liPageNumber-1;
v_pageOffset = v_pageNumber * v_liPageSize;    

RETURN QUERY 

select count(1) over(), 
	un.usernotificationid, 
	un.objecttype,
	coalesce(nullif(upfrom.fullname, ''), 'CJAMS') as fromname,
	upto.fullname as toname,
	coalesce(nullif(upfrom.email, ''), unmap.fromsecurityusersid) as fromemail,
	upto.email as tomail,
	un.usernotificationtypekey, 
	un.url,
	un.subject, 
	un.priorityleveltypekey, 
	un.body, 
	un.hasattachments, 
	un.source,
	un.entityid,
	un.updatedby, 
	un.insertedon as updatedon, 
	un.insertedby,
	un.insertedon, 
	un.teammemberid, 
	un.attachmentlocation, 
	coalesce(un.objectcasenumber,
		(select case_id::varchar from tb_service_log 
			where service_log_id = (tspa.service_log_id)::int)) as servicecasenumber,
	unmap.tosecurityusersid, 
	unmap.isreplied, 
	unmap.isforwarded, 
	unmap.iscarboncopy, 
	un.isread,
	unmap.effectivedate, 
	unmap.expirationdate,
	CASE WHEN Length (un.objectid)  > 30 THEN un.objectid 
	ELSE (select servicecaseid::varchar from servicecase 
			where servicecasenumber = (select case_id::varchar from tb_service_log 
						where service_log_id = (tspa.service_log_id)::int)) END as intakeserviceid
from usernotification un 
	LEFT JOIN tb_service_purchase_authorization tspa ON to_char_int(tspa.authorization_id) = un.objectid
	inner join usernotificationmap unmap on un.usernotificationid = unmap.usernotificationid and unmap.tosecurityusersid is not null
	left join referencevalues rv on rv.value_text = un.source and rv.referencetypeid = 500503 -- sources reftypeid
	--left join userprofile upfrom on upfrom.securityusersid= COALESCE(unmap.fromsecurityusersid, un.insertedby)
	left join userprofile upfrom on upfrom.securityusersid= (unmap.fromsecurityusersid)
		and upfrom.securityusersid is not null 
	inner join userprofile upto on upto.securityusersid = unmap.tosecurityusersid 
		where un.securityusersid = v_userID
		and un.insertedon::date >= current_date - interval '1 months'
		and un.activeflag=1 and un.teamtypekey = 'CW'
		and COALESCE(un.isexternalentity,false)= isextentity 
		and (v_source is null or v_source = un.source)
		and (v_startDate is null or un.insertedon::date >= v_startDate)
		and (v_endDate is null or un.insertedon::date <= v_endDate)
		AND (un.isexternalentity is null or un.isexternalentity = isextentity)
order by un.updatedon desc, un.usernotificationid
LIMIT v_liPageSize OFFSET v_pageOffset;

END;

$function$
;
