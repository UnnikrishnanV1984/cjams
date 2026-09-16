DROP FUNCTION if exists cjams.getrohsenuntimelycriteria(uuid,uuid,uuid,uuid);
DROP FUNCTION if exists cjams.getrohsenuntimelycriteria(uuid,uuid,uuid,uuid,character varying);
CREATE OR REPLACE FUNCTION cjams.getrohsenuntimelycriteria(v_servicecaseid uuid, v_progressnoteid uuid DEFAULT NULL::uuid, v_safecassessmentid uuid DEFAULT NULL::uuid, v_mfiraassessmentid uuid DEFAULT NULL::uuid, v_objecttype character varying DEFAULT null::varchar) 
	RETURNS TABLE(servicecaseid uuid, personid uuid, startdate timestamp without time zone, f2fcontactuntimelydone boolean, safecuntimelydone boolean, mfirauntimelydone boolean, f2fcontactuntimelydonereason character varying, 
	otherf2fcomments text, safecuntimelydonereason character varying,othersafeccomments text, mfirauntimelydonereason character varying, othermfiracomments text, cjamspid bigint, clientname character varying, progressnoteid uuid,
	safecassessmentid uuid,mfiraassessmentid uuid)
	LANGUAGE plpgsql 
AS $function$ 
-------------------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Manasa Kasula
-- Date Created : 01/06/2026
-- SEN- Untimely Completion Reason (CIDM-10984 - B-207269)

-- Argument(s): 1) IN v_servicecaseid - Servicecaseid ID

-- Revision(s)
-- 01/06/2026 Manasa Kasula - SEN- Untimely Completion Reason (CIDM-10984)
-------------------------------------------------------------------------------------------------------------

BEGIN
	RETURN  query    
	select 
		rsuc.servicecaseid,
		rsuc.personid,
		rsuc.startdate,
		rsuc.f2fcontactuntimelydone,
		rsuc.safecuntimelydone,
		rsuc.mfirauntimelydone,
		rsuc.f2fcontactuntimelydonereason,
		rsuc.otherf2fcomments,
		rsuc.safecuntimelydonereason,
		rsuc.othersafeccomments,
		rsuc.mfirauntimelydonereason,
		rsuc.othermfiracomments, 
		p.cjamspid,
		concat(p.firstname, ' ', p.lastname)::varchar as clientname,
		rsuc.progressnoteid,
		rsuc.safecassessmentid,
		rsuc.mfiraassessmentid
	from cjams.rohsenuntimelycompletionreasons rsuc
	inner join cjams.person p on p.personid = rsuc.personid and p.activeflag = 1 and p.substanceexposednewbornflag = 1 
	where rsuc.servicecaseid = v_servicecaseid and rsuc.activeflag = 1
	and (select count(1) > 0 from cjams.rohsenuntimelycompletionreasons rsuc1 where rsuc1.servicecaseid = v_servicecaseid and 
		(case when v_progressnoteid is not null then (rsuc1.progressnoteid = v_progressnoteid and rsuc1.f2fcontactuntimelydone = true and rsuc1.f2fcontactuntimelydonereason is null) else true end)
		and (case when v_safecassessmentid is not null then (rsuc1.safecassessmentid = v_safecassessmentid and rsuc1.safecuntimelydone = true and rsuc1.safecuntimelydonereason is null) else true end) 
		and (case when v_mfiraassessmentid is not null then (rsuc1.mfiraassessmentid = v_mfiraassessmentid and rsuc1.mfirauntimelydone = true and rsuc1.mfirauntimelydonereason is null) else true end)
		and (case when v_objecttype = 'overduereasonpopup' then (rsuc1.f2fcontactuntimelydone = true or rsuc1.safecuntimelydone = true or rsuc1.mfirauntimelydone = true) else true end)
		and rsuc1.activeflag = 1 );
END;

$function$
;
