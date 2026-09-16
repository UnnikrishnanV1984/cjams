-- select * from sp_ive_alerts_mytasks_info('1dcf4151-cfa3-461e-80be-b99dbb7a0b06', 'IVESV', '{"3254e9ef-08da-4cd7-8aa1-083896ed9bec", "f5214cb2-953e-41a9-a4ad-71341501e2ad"}', null, null, null,20,1,'county','asc');
Drop function if exists sp_ive_alerts_mytasks_info(v_loggedusersid varchar, v_loggeduserrole varchar, v_county varchar[] , v_client_id bigint, v_program_type varchar, v_assigned_specialist varchar, v_pagelimit int, v_pageno int);

Drop function if exists sp_ive_alerts_mytasks_info(v_loggedusersid varchar, v_loggeduserrole varchar, v_county varchar[] , v_client_id bigint, v_program_type varchar, v_assigned_specialist varchar, v_pagelimit int, v_pageno int, v_sortcol varchar, v_sortorder varchar);

DROP FUNCTION IF EXISTS sp_ive_alerts_mytasks_info(character varying,character varying,character varying[],bigint,character varying,character varying,integer,integer,character varying,character varying,character varying);

CREATE OR REPLACE FUNCTION cjams.sp_ive_alerts_mytasks_info(v_loggedusersid character varying, v_loggeduserrole character varying, v_county character varying[], v_client_id bigint, v_program_type character varying, v_assigned_specialist character varying, v_pagelimit integer, v_pageno integer, v_sortcol character varying, v_sortorder character varying, eligiblestatus character varying DEFAULT NULL::character varying)
 RETURNS TABLE(countdata bigint, clientid bigint, client_name text, client_dob date, removal_id bigint, redet_start_dt date, redet_end_dt date, review_period character varying, program_type character varying, countyname character varying, assigned_specialist_name character varying, assigned_supervisor_name character varying, caseid uuid, casenumber character varying, gapagreementid uuid, adoptionbreakthelinkid uuid, placementid uuid, due_date date, due_status integer)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- Manasa Kasula - 07/02/2025 - CIDM-10626: Ive alert notification implementation 
-- 08/14 - CIDM-10626 - Issue fix related Removal exit date
-- 08/26 - CIDM-10626 - Issue fix related Removal exit date
-- CIDM-10835 - Veera - IVE Dashboard refinement - 01/12/2026
-- CIDM-11090 - Yogeshvar - IVE Performance Enhancements- 02/07/2026
-- CIDM-11158 - Veera - IVE Dashboard Pagination issue fix - 02/26/2026
-- CIDM-11158 - Varun/Vineet - Store Proc Refinement and optimization - 03/17/2026
-- CDM-44783 - Vinesh - Completed Task is showing on the Dashboard - 05/05/2026
-- CIDM-11293 - Surya Arigela - To Show auto approved record under My Task - 05/28/2026
------------------------------------------------------------------------------------------------
DECLARE 
      v_pageoffset int;
      v_notificationstartdate date;
BEGIN 
      v_pageoffset = (v_pageno - 1) * v_pagelimit;
      
      SELECT settingvalue INTO v_notificationstartdate FROM settings WHERE settingname = 'ivealertsnotificationdate' AND activeflag = 1;

IF (v_sortcol = 'review_period') THEN v_sortcol = 'reviewperiod'; END IF;

RETURN QUERY 
WITH jurisdiction as (select * from (SELECT ca.objectid,c.countyname, c.countyid,ca.insertedon,
row_number () over ( partition by ca.objectid order by ca.insertedon DESC) rn
 FROM caseassignment ca JOIN county c ON c.countyid = ca.toldssid 
WHERE ca.enddate IS NULL AND ca.activeflag = 1 AND c.activeflag = 1 ORDER BY insertedon DESC) where rn=1),  

AllAlerts AS 
(
--1 & 2
    select * from (select DISTINCT pr.cjamspid,concat(pr.firstname,' ', pr.lastname) as client_name,iscr.removalid ,
		(case when tce.end_dt IS null then
			(case when tce.start_dt > (date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 Year')::date
			then tce.start_dt else (date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) -
			DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 Year')::date end
			)  
		else
			(case when tce.start_dt > (date_trunc ('month', tce.start_dt ) + ((f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date)) * '1 year'::INTERVAL))::date
			then tce.start_dt else (date_trunc ('month', tce.start_dt ) + ((f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date)) * '1 year'::INTERVAL))::date end
			)
		end ) as redet_start_dt,
		
		(case when tce.end_dt IS null and tfcj.date_agency_lost_legal_responsibility is null then
			LEAST(date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 day')::date
		else
			LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)
		end ) as redet_end_dt,
		
		(case when tce.end_dt IS null then
			concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)))
		else
			concat ('R',(f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date))+1)
		end ) as reviewperiod,
		
		'FOSTER CARE' type,jur.countyname AS childjurisdiction,jur.countyid::character varying AS childjurisdictionid,
		rt.to_fullname AS tosecurityusersid,rt.from_fullname AS fromsecurityusersid,
		rt.to_id AS assigned_specialist_id,rt.from_id AS assigned_supervisor_id,
		null,pr.dob,sc.servicecaseid as caseid,sc.servicecasenumber as casenumber,
		row_number () over ( partition by pr.cjamspid,sc.servicecaseid order by pl.alternateid desc)  as rownum,
		null as gapagreementid,null as adoptionbreakthelinkid,pl.placementid as placementid
	from tb_client_eligibility tce
	join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 and tce.eligibility_type_cd = '2931' AND tce.delete_sw = 'N'
	join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('JD')
	INNER JOIN placement pl on ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid))
	INNER JOIN servicecase sc ON (sc.servicecaseid = iscr.servicecaseid or sc.servicecaseid = pl.servicecaseid) AND sc.activeflag = 1
	left join tb_foster_care_judicial tfcj on tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id and tfcj.period_type =  concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)))
	LEFT JOIN  jurisdiction jur on jur.objectid = sc.servicecaseid
	LEFT JOIN LATERAL (SELECT up_to.fullname AS to_fullname,up_from.fullname AS from_fullname,r.tosecurityusersid AS to_id,r.fromsecurityusersid AS from_id
						from routing r
						join placement plt1 on r.objectid = plt1.placementid:: character varying
						JOIN userprofile up_to ON up_to.securityusersid = r.tosecurityusersid
						JOIN userprofile up_from ON up_from.securityusersid = r.fromsecurityusersid
						where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid = 70
						and r.toroleid in ('IVESP','IVEEA')
						and plt1.activeflag=1
						and (plt1.startdatetime >= iscr.removaldate  
						or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
						and  pr.personid = plt1.personid order by r.insertedon desc limit 1) rt ON TRUE
	
	where (
			(tce.start_dt::date <= (CURRENT_DATE - INTERVAL '1 year')::date
			AND (tce.end_dt IS null or tce.end_dt::date > now()) and (iscr.exitdate is null or iscr.exitdate::date > now())
			and LEAST((date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 day')::date,tfcj.date_agency_lost_legal_responsibility)::date >= v_notificationstartdate
			and LEAST((date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 day')::date,tfcj.date_agency_lost_legal_responsibility)::date <= now()::date
			and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and ((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))) and tep.approvalstatus is not null)))
			and not exists (select 1 from tb_foster_care_judicial tfcj where tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id  and tfcj.period_type !=  concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))) and tfcj.date_agency_lost_legal_responsibility is not null))
		or 
			(tce.start_dt::date <= (CURRENT_DATE)::date
			AND (tce.end_dt::date > (date_trunc ('month', tce.start_dt ) + ((f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date)) * '1 year'::INTERVAL))::date)
			and (iscr.exitdate::date > (date_trunc ('month', tce.start_dt ) + ((f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date)) * '1 year'::INTERVAL))::date )
			and LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)::date >= v_notificationstartdate
			and LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)::date <= now()::date
			and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and ((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = concat ('R',(f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date))+1) and tep.approvalstatus is not null)))
			and not exists (select 1 from tb_foster_care_judicial tfcj where tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id and tfcj.period_type !=  concat ('R',(f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date))+1) and tfcj.date_agency_lost_legal_responsibility is not null))
			 )
	) a where rownum=1
	UNION all
	--3 & 4 & 5
	select * from (select DISTINCT pr.cjamspid,concat(pr.firstname,' ', pr.lastname) as client_name,iscr.removalid ,
			CASE
            -- Query 3 Logic
            WHEN tce.start_dt::date > (CURRENT_DATE - INTERVAL '1 year')::date THEN
                tce.start_dt
            -- Query 1 Logic
            WHEN (iscr.exitdate is null or iscr.exitdate::date > now()) THEN
                (case when (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) = 1 then (tce.start_dt + ('181 day'::INTERVAL)) else (date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 Year')::date end)
            -- Query 2 Logic
            ELSE
                (case when (f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date)) <= 1 then (tce.start_dt + ('181 day'::INTERVAL)) else (date_trunc ('month', tce.start_dt ) + ((f_age(date_trunc('month', tce.start_dt)::date,iscr.exitdate::date)) * '1 year'::INTERVAL))::date end)
        END as redet_start_dt,

        -- Dynamically calculate redet_end_dt
        CASE WHEN tce.start_dt::date > (CURRENT_DATE - INTERVAL '1 year')::date THEN
                LEAST((tce.start_dt + ('180 day'::INTERVAL))::date, tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)
            WHEN (iscr.exitdate is null or iscr.exitdate::date > now()) THEN
                LEAST((date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 day')::date, tfcj.date_agency_lost_legal_responsibility)
            ELSE
                LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)
        END as redet_end_dt,

        -- Dynamically calculate reviewperiod
        CASE WHEN tce.start_dt::date > (CURRENT_DATE - INTERVAL '1 year')::date THEN
                'R1'
            WHEN (iscr.exitdate is null or iscr.exitdate::date > now()) then 
            	concat('R', (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) + 1)
            ELSE
                concat('R', (f_age(date_trunc('month', tce.start_dt)::date, iscr.exitdate::date)) + 1)
        END as reviewperiod,
		'FOSTER CARE' type,jur.countyname AS childjurisdiction,jur.countyid::character varying AS childjurisdictionid,
		rt.to_fullname AS tosecurityusersid,rt.from_fullname AS fromsecurityusersid,
		rt.to_id AS assigned_specialist_id,rt.from_id AS assigned_supervisor_id,
		null, pr.dob, sc.servicecaseid, sc.servicecasenumber,row_number () over ( partition by pr.cjamspid,sc.servicecaseid order by pl.alternateid desc)  as rownum, null as gapagreementid, null as adoptionbreakthelinkid, pl.placementid as placementid
	from tb_client_eligibility tce
	join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 and tce.eligibility_type_cd = '2931' AND tce.delete_sw = 'N'
	join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('TLV', 'CDVP','EHA')
	INNER JOIN placement pl on (( pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or
	(pl.placementtypekey = 'LA' and pl.personid = iscr.personid ))
	INNER JOIN servicecase sc ON (sc.servicecaseid = iscr.servicecaseid or sc.servicecaseid = pl.servicecaseid) AND sc.activeflag = 1
	left join tb_foster_care_judicial tfcj on tfcj.client_id = tce.client_id and tfcj.removal_id = tce.removal_id and tfcj.period_type =  concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))+ 1)
	LEFT JOIN  jurisdiction jur on jur.objectid = sc.servicecaseid
	LEFT JOIN LATERAL (SELECT up_to.fullname AS to_fullname,up_from.fullname AS from_fullname,r.tosecurityusersid AS to_id,r.fromsecurityusersid AS from_id
											from routing r
											   join placement plt1 on r.objectid = plt1.placementid:: character varying
											JOIN userprofile up_to ON up_to.securityusersid = r.tosecurityusersid
											JOIN userprofile up_from ON up_from.securityusersid = r.fromsecurityusersid
												   where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid = 70 and r.toroleid in ('IVESP','IVEEA')
												   and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
												   and pr.personid = plt1.personid order by r.insertedon desc limit 1) rt ON TRUE
	where 	(
				(tce.start_dt::date <= (CURRENT_DATE - INTERVAL '1 year')::date
					 AND (tce.end_dt IS null or tce.end_dt::date > now())
					 AND (iscr.exitdate is null or iscr.exitdate::date > now())
					 AND LEAST((date_trunc('month', tce.start_dt) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL))::date, tfcj.date_agency_lost_legal_responsibility) >= v_notificationstartdate
					 AND LEAST((date_trunc('month', tce.start_dt) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL))::date, tfcj.date_agency_lost_legal_responsibility) <= now()::date
					 AND NOT EXISTS (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and ((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = concat('R', (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) + 1) and tep.approvalstatus is not null)))
					 AND NOT EXISTS (select 1 from tb_foster_care_judicial tfcj_sub where tfcj_sub.client_id = tce.client_id and tfcj_sub.removal_id = tce.removal_id and tfcj_sub.period_type != concat('R', (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) + 1) and tfcj_sub.date_agency_lost_legal_responsibility is not null)
				 )
	        OR 
				 (tce.start_dt::date <= CURRENT_DATE
					 AND (tce.end_dt::date > (case when (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) = 1 then (tce.start_dt + ('181 day'::INTERVAL)) else (date_trunc('month', tce.start_dt) + ((f_age(date_trunc('month', tce.start_dt)::date, iscr.exitdate::date)) * '1 year'::INTERVAL))::date end))
					 AND (iscr.exitdate::date > (case when (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) = 1 then (tce.start_dt + ('181 day'::INTERVAL)) else (date_trunc('month', tce.start_dt) + ((f_age(date_trunc('month', tce.start_dt)::date, iscr.exitdate::date)) * '1 year'::INTERVAL))::date end))
					 AND LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)::date >= v_notificationstartdate
					 AND LEAST(tfcj.date_agency_lost_legal_responsibility, iscr.exitdate)::date <= now()::date
					 AND NOT EXISTS (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and ((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = concat('R', (f_age(date_trunc('month', tce.start_dt)::date, iscr.exitdate::date)) + 1) and tep.approvalstatus is not null)))
					 AND NOT EXISTS (select 1 from tb_foster_care_judicial tfcj_sub where tfcj_sub.client_id = tce.client_id and tfcj_sub.removal_id = tce.removal_id and tfcj_sub.period_type != concat('R', (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) + 2) and tfcj_sub.date_agency_lost_legal_responsibility is not null)
				 )
	        OR 
				 (tce.start_dt::date <= (CURRENT_DATE - INTERVAL '180 day')::date
					 AND tce.start_dt::date > (CURRENT_DATE - INTERVAL '1 year')::date
					 AND (tce.end_dt IS null or tce.end_dt::date > tce.start_dt)
					 AND (iscr.exitdate is null or iscr.exitdate::date > tce.start_dt)
					 AND LEAST((tce.start_dt + ('180 day'::INTERVAL))::date, tfcj.date_agency_lost_legal_responsibility, iscr.exitdate) >= v_notificationstartdate
					 AND LEAST((tce.start_dt + ('180 day'::INTERVAL))::date, tfcj.date_agency_lost_legal_responsibility, iscr.exitdate) <= now()::date
					 AND NOT EXISTS (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and ((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = 'R1' and tep.approvalstatus is not null)))
				 )
	    )
	) a where rownum=1

	union all
	--6
	select * from (select DISTINCT pr.cjamspid,concat(pr.firstname,' ',pr.lastname) as client_name,iscr.removalid, 
		(pr.dob) + interval  '18 Year' as "18thbday",
		(date_trunc('month', pr.dob) + interval  '18 Year' + INTERVAL '1 month' - INTERVAL '1 day')::date as "18thbdaymonth",
		'18BDAY' reviewperiod,'FOSTER CARE' type,jur.countyname AS childjurisdiction,
		jur.countyid::character varying AS childjurisdictionid,
		rt.to_fullname AS tosecurityusersid,rt.from_fullname AS fromsecurityusersid,rt.to_id AS assigned_specialist_id,rt.from_id AS assigned_supervisor_id,
		null, pr.dob, sc.servicecaseid, sc.servicecasenumber,row_number () over ( partition by pr.cjamspid,sc.servicecaseid order by pl.alternateid desc)  as rownum, 
		null as gapagreementid, null as adoptionbreakthelinkid, pl.placementid as placementid
	from tb_client_eligibility tce
	join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 and tce.eligibility_type_cd = '2931' AND tce.delete_sw = 'N' 
	join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('JD','TLV', 'CDVP','EHA')
	INNER JOIN placement pl on (( pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or
	(pl.placementtypekey = 'LA' and pl.personid = iscr.personid ))
	INNER JOIN servicecase sc ON (sc.servicecaseid = iscr.servicecaseid or sc.servicecaseid = pl.servicecaseid) AND sc.activeflag = 1
	LEFT JOIN  jurisdiction jur on jur.objectid = sc.servicecaseid
	LEFT JOIN LATERAL (SELECT up_to.fullname AS to_fullname,up_from.fullname AS from_fullname,r.tosecurityusersid AS to_id,r.fromsecurityusersid AS from_id
							from routing r 
						    join placement plt1 on r.objectid = plt1.placementid:: character varying 
							JOIN userprofile up_to ON up_to.securityusersid = r.tosecurityusersid
							JOIN userprofile up_from ON up_from.securityusersid = r.fromsecurityusersid
						        where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid = 70 and r.toroleid in ('IVESP','IVEEA')
						        and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
						        and pr.personid = plt1.personid order by r.insertedon desc limit 1) rt ON TRUE
									
	where tce.start_dt::date <= (CURRENT_DATE - INTERVAL '1 year')::date
	AND (tce.end_dt IS null or tce.end_dt::date >= now()::date) and (iscr.exitdate is null or iscr.exitdate::date >= now()::date)
	and (pr.dob + interval '18 Year')::date >= v_notificationstartdate
	and (pr.dob + interval '18 Year')::date <= now()::date
	and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and 
	((tep.sqnm_sw = 'I' and tep.delete_sw = 'N' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = '18BDAY' and tep.approvalstatus is not null)))
	) a where rownum=1 
	union all
	--7
	select distinct pr.cjamspid,concat(pr.firstname,' ',pr.lastname) as client_name,tce.guardian_subsidy_id as removal_id, 
				(pr.dob) + interval  '18 Year' as "18thbday",
				(date_trunc('month', pr.dob) + interval  '18 Year' + INTERVAL '1 month' - INTERVAL '1 day')::date as "18thbdaymonth",
				'18BDAY' reviewperiod,'GAP' type,jur.countyname AS childjurisdiction,jur.countyid::character varying AS childjurisdictionid,
				rt.to_fullname AS tosecurityusersid,rt.from_fullname AS fromsecurityusersid,rt.to_id AS assigned_specialist_id,rt.from_id AS assigned_supervisor_id,
				null, pr.dob, sc.servicecaseid, sc.servicecasenumber, 0 as rownum, ga.gapagreementid::text,
				null as adoptionbreakthelinkid, null::uuid as placementid
	from tb_client_eligibility tce
	join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1  and (tce.eligibility_type_cd = '2935') AND tce.delete_sw = 'N'
	INNER JOIN guardianship g on g.alternateid = tce.guardian_subsidy_id
	INNER JOIN gapagreement ga on ga.gapid = g.gapid AND ga.activeflag = 1
	inner join servicecase sc on sc.servicecaseid = g.servicecaseid and sc.activeflag = 1
	--inner join tb_eligibility_period tep on tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N'--and tep.sqnm_sw = 'I' 
	LEFT JOIN  jurisdiction jur on jur.objectid = sc.servicecaseid
	LEFT JOIN LATERAL (SELECT up_to.fullname AS to_fullname,up_from.fullname AS from_fullname,r.tosecurityusersid AS to_id,r.fromsecurityusersid AS from_id
								from routing r 
								JOIN userprofile up_to ON up_to.securityusersid = r.tosecurityusersid
								JOIN userprofile up_from ON up_from.securityusersid = r.fromsecurityusersid 
							        where r.activeflag=1 AND r.eventcode='GAAR' AND r.routingstatustypeid = 73 
							        and r.toroleid in ('IVESP','IVEEA')
							        and r.objectid = ga.gapagreementid::character varying order by r.insertedon desc limit 1) rt ON TRUE
											
	where 
	 (pr.dob + interval  '18 Year')::date >= v_notificationstartdate
	and (pr.dob + interval  '18 Year')::date <= now()::date
	and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and 
	(tep.sqnm_sw = 'R' and tep.approvalstatus is not null) and tep.approvalid not in ('AUTO_APPROVAL'))
	
	union all
	--8
	select distinct pr.cjamspid,concat(pr.firstname,' ',pr.lastname) as client_name,iscr.removalid, 
		(pr.dob) + interval  '18 Year' as "18thbday",(date_trunc('month', pr.dob) + interval  '18 Year' + INTERVAL '1 month' - INTERVAL '1 day')::date as "18thbdaymonth",
		'18BDAY' reviewperiod,'ADOPTION' type, jur.countyname AS childjurisdiction,jur.countyid::character varying AS childjurisdictionid,
		rt.to_fullname AS tosecurityusersid,rt.from_fullname AS fromsecurityusersid,rt.to_id AS assigned_specialist_id,rt.from_id AS assigned_supervisor_id,
		null, pr.dob, ac.adoptioncaseid, ac.adoptioncasenumber, 0 as rownum, null as gapagreementid, adbl.adoptionbreakthelinkid::text as adoptionbreakthelinkid, null::uuid as placementid
	from tb_client_eligibility tce
	join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 and (tce.eligibility_type_cd = '2934') AND tce.delete_sw = 'N'
	INNER JOIN adoptioncase ac on ac.adoptioncasenumber::bigint = tce.case_id and ac.activeflag = 1 and (ac.enddate is null or ac.enddate::date >= now()::date)
	--INNER JOIN tb_eligibility_period tep on tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N'--and tep.sqnm_sw = 'I' 
	LEFT JOIN adoptionplanning apl on apl.alternateid = tce.adoption_id and apl.activeflag = 1
	LEFT JOIN adoptionbreakthelink adbl on apl.adoptionplanningid = adbl.adoptionplanningid and adbl.activeflag = 1
	LEFT JOIN intakeservreqchildremoval iscr on iscr.intakeservicerequestactorid = apl.intakeservicerequestactorid and (iscr.removalexitreason is null or (trim(iscr.removalexitreason)::varchar in ('','ADNRE', 'ADRE', 'AF', 'ADPFIN', 'ADPL', 'CADOFIN', 'PSAP', 'ADPDIS', 'ADP','OTHER'))) and iscr.activeflag = 1
	LEFT JOIN  jurisdiction jur on jur.objectid = ac.adoptioncaseid
	LEFT JOIN LATERAL (SELECT up_to.fullname AS to_fullname,up_from.fullname AS from_fullname,r.tosecurityusersid AS to_id,r.fromsecurityusersid AS from_id
									from routing r 
									JOIN userprofile up_to ON up_to.securityusersid = r.tosecurityusersid
									JOIN userprofile up_from ON up_from.securityusersid = r.fromsecurityusersid 
								        where r.activeflag=1 AND r.eventcode='ABLR' AND r.routingstatustypeid = 67 
								        and r.toroleid in ('IVESP','IVEEA')
								        and r.objectid =adbl.adoptionbreakthelinkid::character varying order by r.insertedon desc limit 1) rt ON TRUE
												
	where 
	(pr.dob + interval  '18 Year')::date >= v_notificationstartdate
	and (pr.dob + interval  '18 Year')::date <= now()::date
	and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and (tep.delete_sw = 'N' or tep.create_ts::DATE >= v_notificationstartdate) and 
	(tep.sqnm_sw = 'R' and tep.approvalstatus is not null) and tep.approvalid not in ('AUTO_APPROVAL'))
)
SELECT count(1) OVER() AS total_count, A.cjamspid, A.client_name, A.dob::date, A.removalid, A.redet_start_dt::date, A.redet_end_dt::date, A.reviewperiod::varchar, 
		A.type::varchar, A.childjurisdiction, A.tosecurityusersid, A.fromsecurityusersid, A.caseid, A.casenumber,
       A.gapagreementid::uuid, A.adoptionbreakthelinkid::uuid, A.placementid::uuid, 
	   (A.redet_end_dt + interval '30 day')::date as due_date, ((A.redet_end_dt + interval '30 day')::date- CURRENT_DATE) as due_status
FROM AllAlerts A
WHERE (v_client_id IS NULL OR A.cjamspid = v_client_id)
  AND (v_program_type IS NULL OR A.type = v_program_type)
  AND (v_county IS NULL OR cardinality(v_county) = 0 OR A.childjurisdictionid = ANY (v_county))
  AND ((v_assigned_specialist IS NOT NULL AND A.assigned_specialist_id = v_assigned_specialist)
        OR
        (v_assigned_specialist IS NULL AND v_loggeduserrole = 'IVESP' AND A.assigned_specialist_id = v_loggedusersid)
        OR
        (v_assigned_specialist IS NULL AND v_loggeduserrole <> 'IVESP' AND (A.assigned_supervisor_id = v_loggedusersid OR A.assigned_specialist_id IS NULL)))  
  AND (eligiblestatus IS NULL
        OR (eligiblestatus = 'overdue' AND (A.redet_end_dt + INTERVAL '30 day')::date <= CURRENT_DATE )
        OR (eligiblestatus = 'underdue' AND (A.redet_end_dt + INTERVAL '30 day')::date > CURRENT_DATE)) 
ORDER BY 
    CASE WHEN v_sortorder = 'asc' THEN
        CASE v_sortcol
            WHEN 'redet_start_dt' THEN A.redet_start_dt::varchar
            WHEN 'redet_end_dt' THEN A.redet_end_dt::varchar
            WHEN 'due_date' THEN (A.redet_end_dt + interval '30 day')::varchar
            WHEN 'countyname' THEN A.childjurisdiction
            WHEN 'reviewperiod' THEN A.reviewperiod
            WHEN 'assigned_specialist_name' THEN A.tosecurityusersid
        END
    END ASC NULLS LAST,
    CASE WHEN v_sortorder = 'desc' THEN
        CASE v_sortcol
            WHEN 'redet_start_dt' THEN A.redet_start_dt::varchar
            WHEN 'redet_end_dt' THEN A.redet_end_dt::varchar
            WHEN 'due_date' THEN (A.redet_end_dt + interval '30 day')::varchar
            WHEN 'countyname' THEN A.childjurisdiction
            WHEN 'assigned_specialist_name' THEN A.tosecurityusersid
        END
    END DESC NULLS LAST
LIMIT v_pagelimit OFFSET v_pageoffset;

END $function$
;