Drop function if exists sp_ive_alerts_notification_info();

CREATE OR REPLACE FUNCTION cjams.sp_ive_alerts_notification_info()
 RETURNS TABLE(client_id bigint, client_name varchar, removal_id bigint, redet_start_dt Date, redet_end_dt Date, review_period varchar, program_type varchar,  county varchar,
               assigned_specialist varchar,assigned_supervisor varchar, caseid varchar, casenumber varchar, due_date Date, due_status int)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- Manasa Kasula - 07/02/2025 - CIDM-10626: Ive alert notification implementation 
------------------------------------------------------------------------------------------------
DECLARE 
BEGIN	
CREATE TEMP TABLE IF NOT EXISTS
Temp_ive_alerts_info ( 
      client_id bigint, --Client ID
      client_name varchar, --Client Name
      removal_id bigint, --Removal Id
      redet_start_dt Date,--Review period start date
      redet_end_dt Date,--Review period end date/18 BDAY / Notification date/ 
      review_period varchar, --Period Name
      program_type varchar,--GAP,Fostercare,Adoption
      county varchar,--Client County
      assigned_specialist varchar,--Assigned IVE Specialist
      assigned_supervisor varchar,--Assigned IVE Supervisor
      caseid varchar, -- Service/adoption case id,
      casenumber varchar -- Service/adoption case number,
      -- due_date Date,-- Due Date (add 30 days to notification date)
      -- due_status varchar--Due status ( Number Remaining days or over due days)
	);

--Foster Care Court Removal
Insert into Temp_ive_alerts_info(client_id,client_name, removal_id,redet_start_dt,redet_end_dt,review_period, program_type,county,assigned_specialist,assigned_supervisor,caseid,casenumber)
select distinct pr.cjamspid,concat(pr.firstname,' ', pr.lastname) as client_name,iscr.removalid ,
(case when tce.start_dt > (date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 Year')::date
then tce.start_dt else (date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 Year')::date end) as redet_start_dt,
(date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 day')::date,
concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))) as reviewperiod, 'fostercare',
(select c.countyname from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      inner join caseassignment ca on ca.objectid = sc.servicecaseid and ca.enddate is null and ca.activeflag = 1
      join county c on c.countyid = ca.toldssid and c.activeflag =1
where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
 order by ca.insertedon desc limit 1) ::character varying as childjurisdiction,
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.tosecurityusersid
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
),
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.fromsecurityusersid
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
),
(select sc.servicecaseid from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
order by sc.insertedon desc limit 1) ::character varying as servicecaseid,
(select sc.servicecasenumber from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
order by sc.insertedon desc limit 1) ::character varying as servicecasenumber
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('JD')
where btrim(tce.eligibility_type_cd) = '2931' AND tce.delete_sw = 'N' and tce.start_dt::date <= (CURRENT_DATE - INTERVAL '1 year')::date
AND (tce.end_dt IS null or tce.end_dt::date >= now()::date) and (iscr.exitdate is null or iscr.exitdate::date >= now()::date)
and (date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL))::date = now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' and 
((tep.sqnm_sw = 'I' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt))) and tep.approvalstatus is not null)));

--Foster Care VPA removal more than 1 year 
Insert into Temp_ive_alerts_info(client_id,client_name, removal_id,redet_start_dt,redet_end_dt,review_period, program_type,county,assigned_specialist,assigned_supervisor,caseid,casenumber)
select distinct pr.cjamspid,concat(pr.firstname,' ', pr.lastname) as client_name,iscr.removalid ,
(case when (DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) = 1 then (tce.start_dt + ('181 day'::INTERVAL)) else
(date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 Year')::date end) as redet_start_dt, 
(date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL) - interval '1 day')::date,
concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) + 1) as reviewperiod, 'fostercare',
(select c.countyname from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      inner join caseassignment ca on ca.objectid = sc.servicecaseid and ca.enddate is null and ca.activeflag = 1
      join county c on c.countyid = ca.toldssid and c.activeflag =1
where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
 order by ca.insertedon desc limit 1) ::character varying as childjurisdiction,
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.tosecurityusersid
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
),
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.fromsecurityusersid
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
),
(select sc.servicecaseid from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
order by sc.insertedon desc limit 1) ::character varying as servicecaseid,
(select sc.servicecasenumber from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
order by sc.insertedon desc limit 1) ::character varying as servicecasenumber
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('TLV', 'CDVP','EHA')
where btrim(tce.eligibility_type_cd) = '2931' AND tce.delete_sw = 'N' and tce.start_dt::date <= (CURRENT_DATE - INTERVAL '1 year')::date
AND (tce.end_dt IS null or tce.end_dt::date >= now()::date) and (iscr.exitdate is null or iscr.exitdate::date >= now()::date)
and (date_trunc ('month', tce.start_dt ) + ((DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) * '1 year'::INTERVAL))::date = now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' and 
((tep.sqnm_sw = 'I' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = concat ('R',(DATE_PART('YEAR', now()) - DATE_PART('YEAR', tce.start_dt)) + 1) and tep.approvalstatus is not null)));

--Foster Care Court Removal and VPA removal for 18th bday
Insert into Temp_ive_alerts_info(client_id,client_name, removal_id,redet_start_dt,redet_end_dt,review_period,program_type,county,assigned_specialist,assigned_supervisor,caseid,casenumber)
select distinct pr.cjamspid,concat(pr.firstname,' ',pr.lastname) as client_name,iscr.removalid, (pr.dob) + interval  '18 Year' as "18thbday",
(date_trunc('month', pr.dob) + interval  '18 Year' + INTERVAL '1 month' - INTERVAL '1 day')::date as "18thbdaymonth",
'18BDAY','fostercare',
(select c.countyname from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      inner join caseassignment ca on ca.objectid = sc.servicecaseid and ca.enddate is null and ca.activeflag = 1
      join county c on c.countyid = ca.toldssid and c.activeflag =1
where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
order by ca.insertedon desc limit 1) ::character varying as childjurisdiction,
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.tosecurityusersid
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
),
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.fromsecurityusersid
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
),
(select sc.servicecaseid from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
order by sc.insertedon desc limit 1) ::character varying as servicecaseid,
(select sc.servicecasenumber from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
order by sc.insertedon desc limit 1) ::character varying as servicecasenumber
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('JD','TLV', 'CDVP','EHA')
where btrim(tce.eligibility_type_cd) = '2931' AND tce.delete_sw = 'N' and tce.start_dt::date <= (CURRENT_DATE - INTERVAL '1 year')::date
AND (tce.end_dt IS null or tce.end_dt::date >= now()::date) and (iscr.exitdate is null or iscr.exitdate::date >= now()::date)
and (pr.dob + interval  '18 Year')::date = now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' and 
((tep.sqnm_sw = 'I' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = '18BDAY' and tep.approvalstatus is not null)));

--Foster Care VPA removal 1st redet due date
Insert into Temp_ive_alerts_info(client_id,client_name, removal_id,redet_start_dt,redet_end_dt,review_period,program_type,county,assigned_specialist,assigned_supervisor,caseid,casenumber)
select distinct pr.cjamspid,concat(pr.firstname,' ',pr.lastname) as client_name,iscr.removalid,tce.start_dt,(tce.start_dt + ('180 day'::INTERVAL))::date, 
'R1','fostercare',
(select c.countyname from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      inner join caseassignment ca on ca.objectid = sc.servicecaseid and ca.enddate is null and ca.activeflag = 1
      join county c on c.countyid = ca.toldssid and c.activeflag =1
where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
 order by ca.insertedon desc limit 1) ::character varying as childjurisdiction,
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.tosecurityusersid
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
),
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.fromsecurityusersid
      join placement plt1 on pr.personid = plt1.personid
      where r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = '70' and r.toroleid in ('IVESP','IVEEA')
      and plt1.activeflag=1 and (plt1.startdatetime >= iscr.removaldate  or (plt1.enddatetime is null and plt1.startdatetime <= iscr.removaldate))
      and r.objectid :: character varying = plt1.placementid:: character varying order by r.insertedon desc limit 1
),
(select sc.servicecaseid from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
order by sc.insertedon desc limit 1) ::character varying as servicecaseid,
(select sc.servicecasenumber from placement pl
      inner JOIN servicecase sc on (iscr.servicecaseid = sc.servicecaseid or pl.servicecaseid = sc.servicecaseid) and sc.activeflag = 1
      where ((pl.intakeservreqchildremovalid = iscr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = iscr.personid )) and pl.activeflag = 1
order by sc.insertedon desc limit 1) ::character varying as servicecasenumber
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
join intakeservreqchildremoval iscr on iscr.removalid = tce.removal_id and iscr.activeflag = 1 and iscr.removaltypekey in ('TLV', 'CDVP','EHA')
where btrim(tce.eligibility_type_cd) = '2931' AND tce.delete_sw = 'N' and tce.start_dt::date <= (CURRENT_DATE - INTERVAL '180 day')::date 
and tce.start_dt::date > (CURRENT_DATE - INTERVAL '1 year')::date AND (tce.end_dt IS null or tce.end_dt::date >= now()::date) and 
(iscr.exitdate is null or iscr.exitdate::date >= now()::date) and (tce.start_dt + ('181 day'::INTERVAL))::date = now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' and 
((tep.sqnm_sw = 'I' and trim(tep.status_cd) = '2914') or (tep.sqnm_sw = 'R1' and tep.approvalstatus is not null)));

-- GAP Redetermination
Insert into Temp_ive_alerts_info(client_id,client_name, removal_id,redet_start_dt,redet_end_dt,review_period,program_type,county,assigned_specialist,assigned_supervisor,caseid,casenumber)
select distinct pr.cjamspid,concat(pr.firstname,' ',pr.lastname) as client_name,tce.guardian_subsidy_id as removal_id, (pr.dob) + interval  '18 Year' as "18thbday",
(date_trunc('month', pr.dob) + interval  '18 Year' + INTERVAL '1 month' - INTERVAL '1 day')::date as "18thbdaymonth",
'18BDAY','Gap',
(select c.countyname from caseassignment ca 
      join county c on c.countyid = ca.toldssid and c.activeflag =1
where  ca.objectid = sc.servicecaseid and lower(ca.responsibilitytypekey) = 'family' and ca.activeflag = 1
order by ca.insertedon desc limit 1) ::character varying as childjurisdiction,
(select up.securityusersid::varchar from routing r 
      join userprofile up on up.securityusersid = r.tosecurityusersid
      where r.activeflag=1 AND r.eventcode='GAAR' AND r.routingstatustypeid::text = '73' and r.toroleid in ('IVESP','IVEEA')
      and r.objectid :: character varying = ga.gapagreementid :: character varying order by r.insertedon desc limit 1),
(select up.securityusersid::varchar from routing r 
      join userprofile up on up.securityusersid = r.fromsecurityusersid
      where r.activeflag=1 AND r.eventcode='GAAR' AND r.routingstatustypeid::text = '73' and r.toroleid in ('IVESP','IVEEA')
      and r.objectid :: character varying = ga.gapagreementid :: character varying order by r.insertedon desc limit 1),
sc.servicecaseid,sc.servicecasenumber
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
INNER JOIN guardianship g on g.alternateid = tce.guardian_subsidy_id
INNER JOIN gapagreement ga on ga.gapid = g.gapid AND ga.activeflag = 1
inner join servicecase sc on sc.servicecaseid = g.servicecaseid and sc.activeflag = 1
inner join tb_eligibility_period tep on tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N'--and tep.sqnm_sw = 'I' 
where btrim(tce.eligibility_type_cd) = '2935' AND tce.delete_sw = 'N'
and (pr.dob + interval  '18 Year')::date = now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' and 
(tep.sqnm_sw = 'R' and tep.approvalstatus is not null));

--Adoption Redetermination
Insert into Temp_ive_alerts_info(client_id,client_name, removal_id,redet_start_dt,redet_end_dt,review_period,program_type,county,assigned_specialist,assigned_supervisor,caseid,casenumber)
select distinct pr.cjamspid,concat(pr.firstname,' ',pr.lastname) as client_name,iscr.removalid, (pr.dob) + interval  '18 Year' as "18thbday",
(date_trunc('month', pr.dob) + interval  '18 Year' + INTERVAL '1 month' - INTERVAL '1 day')::date as "18thbdaymonth",
'18BDAY','Adoption',
(select c.countyname from caseassignment ca 
      join county c on c.countyid = ca.toldssid and c.activeflag =1
where ca.objectid = ac.adoptioncaseid and ca.enddate is null and ca.activeflag = 1
 order by ca.insertedon desc limit 1) ::character varying as childjurisdiction,
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.tosecurityusersid
      where r.activeflag=1 AND r.eventcode='ABLR' and r.toroleid in ('IVESP','IVEEA') AND 
      r.routingstatustypeid::text = '67' and r.objectid :: character varying = adbl.adoptionbreakthelinkid :: character varying order by r.insertedon desc limit 1),
(select up.securityusersid::varchar from routing r join userprofile up on up.securityusersid = r.fromsecurityusersid
      where r.activeflag=1 AND r.eventcode='ABLR' and r.toroleid in ('IVESP','IVEEA') AND 
      r.routingstatustypeid::text = '67' and r.objectid :: character varying = adbl.adoptionbreakthelinkid :: character varying order by r.insertedon desc limit 1),
ac.adoptioncaseid,ac.adoptioncasenumber
from tb_client_eligibility tce
join person pr on pr.cjamspid = tce.client_id and pr.activeflag = 1 
LEFT JOIN adoptionplanning apl on apl.alternateid = tce.adoption_id and apl.activeflag = 1
LEFT JOIN adoptionbreakthelink adbl on apl.adoptionplanningid = adbl.adoptionplanningid and adbl.activeflag = 1
LEFT JOIN intakeservreqchildremoval iscr on iscr.intakeservicerequestactorid = apl.intakeservicerequestactorid and (iscr.removalexitreason is null or (trim(iscr.removalexitreason)::varchar in ('','ADNRE', 'ADRE', 'AF', 'ADPFIN', 'ADPL', 'CADOFIN', 'PSAP', 'ADPDIS', 'ADP','OTHER'))) and iscr.activeflag = 1
INNER JOIN adoptioncase ac on ac.adoptioncasenumber::bigint = tce.case_id and ac.activeflag = 1 and (ac.enddate is null or ac.enddate::date >= now()::date)
inner join tb_eligibility_period tep on tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N'--and tep.sqnm_sw = 'I' 
where btrim(tce.eligibility_type_cd) = '2934' AND tce.delete_sw = 'N'
and (pr.dob + interval  '18 Year')::date = now()::date
and not exists (select 1 from tb_eligibility_period tep where tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' and 
(tep.sqnm_sw = 'R' and tep.approvalstatus is not null));

RETURN QUERY SELECT A.*, (A.redet_end_dt + interval '30 day')::date as due_date, ((A.redet_end_dt + interval '30 day')::date-now()::date) as due_status
               	FROM Temp_ive_alerts_info A
				ORDER BY (A.redet_end_dt + interval '30 day') desc;
              
DROP TABLE Temp_ive_alerts_info;

   END
$function$
;