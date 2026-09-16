DROP FUNCTION IF EXISTS cjams.getiveapprovallist(character varying, character varying, bigint, bigint, character varying, character varying, character varying);
DROP FUNCTION IF EXISTS cjams.getiveapprovallist(character varying, character varying, bigint, bigint, character varying, character varying, character varying, character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.getiveapprovallist(userid character varying, v_roleid character varying, pagenumber bigint, pagesize bigint, v_clientId character varying, approvalstatus character varying, programtype character varying, requestedtouser character varying, requestedfromuser character varying)
RETURNS TABLE(countdata bigint, requestedfrom text, requestedon timestamp without time zone, requestedto text, placement_type text, client_id bigint, removal_id bigint, approval_status character varying, client_name character varying, sqnm_sw character varying, approvedby character varying, approvedon timestamp without time zone)
 LANGUAGE plpgsql
AS $function$ 
-------------------------------------------------
-- CDM-27610 - ACA Approval Dashboard issue fix
-- CIDM-6805 - Query Optimization - Veera  Nadimpalli 04-06
-- CIDM-9958 - To get Guardian subsidy ID
-- cIDM-10835 - Query Optimization
-------------------------------------------------
DECLARE
	v_pageoffset int;
	v_pagenumber int;
	v_approval_status varchar;
DECLARE 
	totalcount integer;
BEGIN
    v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;
	v_approval_status := approvalstatus;
 
raise notice 'test %',v_roleid;
RETURN QUERY 
select count(1) over(), * from 
	(select concat(up.firstname , ' ' , up.lastname) as requestedfrom, r.insertedon ,
			concat(up2.firstname,' ', up2.lastname) as requestedto,
			(case when r.routingstatustypeid::text  in ('68' , '77', '80') then 'Adoption'  when r.routingstatustypeid::text in ('71', '72', '78') then 'Fostercare' when r.routingstatustypeid::text  in ('74' , '75', '79') then 'Gap' end) as placement_type,
			tce.client_id::bigint as client_id,
			(case when r.routingstatustypeid::text  in ('68' , '77', '80') then (select tga.removalid from tb_ive_adoption_audit tga where tga.eligibility_period_id = tfa.eligibility_period_id)  
			when r.routingstatustypeid::text in ('71', '72', '78') then tce.removal_id 
			when r.routingstatustypeid::text  in ('74' , '75', '79') then tce.guardian_subsidy_id end)::bigint as removal_id,
			tfaa.approvalstatus::varchar,
			concat(pr.firstname,' ', pr.lastname)::varchar as client_name,
            tfa.sqnm_sw::varchar as sqnm_sw,
            (case when tfa.approvedby is not null then tfa.approvedby else (select concat(up2.firstname , ' ' , up2.lastname) :: character varying ) end),
            (case when tfa.approvedon is not null then tfa.approvedon else r.updatedon end)
	FROM routing r
	inner join tb_eligibility_period tfa on tfa.approvalid::character varying = r.objectid
	inner join tb_client_eligibility tce on tce.eligibility_id = tfa.eligibility_id and tce.delete_sw = 'N'
	inner join tb_eligibility_period tfaa on tfaa.delete_sw = 'N' and tfaa.approvalid = r.objectid
	inner join person pr on pr.cjamspid = tce.client_id
	inner join userprofile up on up.securityusersid = r.fromsecurityusersid
	inner join userprofile up2 on up2.securityusersid = r.tosecurityusersid
	WHERE (r.toroleid=v_roleid or r.fromroleid=v_roleid or r.toroleid = 'IVESP')  AND r.activeflag=1 and r.eventcode in ('PLTR', 'ABLR', 'GAAR') and r.fromroleid in ('IVESP','IVEEA') and r.routingstatustypeid::text in ('68','71','74','72','75','77','78','79','80')
	and (CASE WHEN v_clientId IS NOT NULL THEN  tce.client_id::character varying = v_clientId ELSE TRUE END)
		AND (CASE WHEN programtype = 'Adoption' THEN r.routingstatustypeid in (68,77,80) WHEN programtype = 'Fostercare' THEN r.routingstatustypeid in (71,72,78) WHEN programtype = 'Gap' THEN r.routingstatustypeid in (74,75,79) ELSE TRUE END)
		AND (CASE WHEN v_approval_status IS NOT NULL THEN  tfaa.approvalstatus::character varying = v_approval_status ELSE TRUE END)
		AND (CASE WHEN requestedtouser IS NOT NULL THEN  concat(up2.firstname,' ', up2.lastname)::character varying = requestedtouser ELSE TRUE END)
		AND (CASE WHEN requestedfromuser IS NOT NULL THEN  concat(up.firstname , ' ' , up.lastname)::character varying = requestedfromuser ELSE TRUE END)
	union  
	select concat(up.firstname , ' ' , up.lastname) as requestedfrom, r.insertedon ,
			concat(up2.firstname,' ', up2.lastname) as requestedto,
			'Adoption' as placement_type,
			tadp.cjamspid as client_id,
			tadp.removalid as removal_id,
			tadp.approvalstatus as approval_status,
			concat(pr.firstname,' ', pr.lastname)::varchar as client_name,
            'A',
			concat(up2.firstname , ' ' , up2.lastname),
            tadp.updatedon
	FROM routing r
	inner join tb_ive_adoption_audit tadp on  tadp.approvalid::character varying = r.objectid and tadp.category = 'A'
	inner join person pr on pr.cjamspid = tadp.cjamspid
	inner join userprofile up on up.securityusersid = r.fromsecurityusersid
	inner join userprofile up2 on up2.securityusersid = r.tosecurityusersid
	WHERE (r.toroleid=v_roleid or r.fromroleid=v_roleid)  AND r.activeflag=1 and r.eventcode in ('ABLR') --and r.fromroleid = 'IVESP'
	and r.routingstatustypeid::text in ('68','77', '80')
	and (CASE WHEN v_clientId IS NOT NULL THEN  tadp.cjamspid::character varying = v_clientId ELSE TRUE END)
		AND (CASE WHEN programtype IS NOT NULL THEN  'Adoption'::character varying = programtype ELSE TRUE END)
		AND (CASE WHEN v_approval_status IS NOT NULL THEN  tadp.approvalstatus::character varying = v_approval_status ELSE TRUE END)
        AND (CASE WHEN requestedtouser IS NOT NULL THEN  concat(up2.firstname , ' ' , up2.lastname)::character varying = requestedtouser ELSE TRUE END)
		AND (CASE WHEN requestedfromuser IS NOT NULL THEN  concat(up.firstname , ' ' , up.lastname)::character varying = requestedfromuser ELSE TRUE END)
    ) as t
 order by t.insertedon desc LIMIT pagesize OFFSET v_pageoffset;


END;

$function$
;
