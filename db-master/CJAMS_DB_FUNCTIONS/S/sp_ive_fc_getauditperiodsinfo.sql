Drop function if exists sp_ive_fc_getauditperiodsinfo(bigint, bigint);

CREATE OR REPLACE FUNCTION cjams.sp_ive_fc_getauditperiodsinfo( al_client_id bigint, al_removal_id bigint) 
RETURNS TABLE( period character varying, period_start_dt date, period_end_dt date, forstercareeligibilitystatus character varying,inserttedon timestamp without time zone, transactionid int, period_fostercarecomponents json, approvalstatus character varying, approvalid uuid, remarks character varying, fromsecurityusersid uuid, period_fostercareevents json, period_messages json, progressnoteid uuid, ivenarrativesection character varying) 
LANGUAGE plpgsql AS $function$ 
--------------------------------------------------------------------------------------------------------------------------
-- CDM-25639 - Vijaya Laxmi - Display history eligibility records which are active : tb_eligibility_period.delete_sw = 'N'
--  Reverting this change to display all history records
--------------------------------------------------------------------------------------------------------------------------

begin return query
select
  tep.sqnm_sw,
  tep.start_dt::date,
  tep.end_dt::date,
  (SELECT tpv.value_tx FROM tb_picklist_values tpv 
		WHERE tpv.picklist_type_id = 262 AND trim(tpv.picklist_value_cd) = trim(tep.status_cd)),
  tep.create_ts,
  tep.eligibility_period_id,
  (
    select json_agg(d)
    from (
    select (select tpv.value_tx from tb_picklist_values tpv where tpv.picklist_type_id = 315 AND trim(tpv.picklist_value_cd) = trim(tics.component_type_cd)) as component_name,
    (select tpv.value_tx from tb_picklist_values tpv where tpv.picklist_type_id = 262 AND trim(tpv.picklist_value_cd) = trim(tics.ive_event_status_cd)) as component_status_cd
    from tb_ive_component_status tics where tics.event_id = tep.eligibility_period_id order by 1
    ) d
  ) as fostercarecomponentdetails,
  tep.approvalstatus,
  tep.approvalid :: uuid,
  (select case when tep.approvalid is not null then (select r.remarks::varchar from routing r where r.objectid = tep.approvalid::varchar and r.activeflag = 1 and r.eventcode = 'PLTR') else null end),
  (select case when tep.approvalid is not null then (select r.fromsecurityusersid:: uuid as requestedfrom from routing r where r.objectid = tep.approvalid::varchar and r.activeflag = 1 and r.eventcode = 'PLTR') else null end),
  (
      select json_agg(d)
      from (
      select notes_tx, event_start_dt,event_end_dt, (select tpv.value_tx from tb_picklist_values tpv where tpv.picklist_type_id = 263 AND trim(tpv.picklist_value_cd) = trim(tafc.reason_cd)) as reason_cd, event_dt,
      (select tpv.value_tx from tb_picklist_values tpv where tpv.picklist_type_id = 262 AND trim(tpv.picklist_value_cd) = trim(tafc.resulting_status_cd)) as resulting_status_cd
      from tb_eligibility_events tafc where tafc.eligibility_period_id = tep.eligibility_period_id
      ) d
  ) as fostercareeventsdetails,
  (
      select json_agg(d)
      from (
      select * from fcauditperiodmessages tapm where tapm.auditperiodid = tep.eligibility_period_id
      ) d
  ) as messages,
  tep.progressnoteid :: uuid,
  tep.ivenarrativesection
from
  tb_client_eligibility tce join tb_eligibility_period tep on tep.eligibility_id = tce.eligibility_id
where
  tce.client_id :: bigint = al_client_id
  and tce.removal_id :: bigint = al_removal_id
  --and tep.delete_sw = 'N'
ORDER BY
  tep.sqnm_sw desc,
  tep.create_ts desc;
end;
$function$;