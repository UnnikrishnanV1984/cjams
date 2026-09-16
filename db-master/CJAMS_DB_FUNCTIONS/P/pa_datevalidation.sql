-- FUNCTION: cjams.pa_datevalidation(timestamp without time zone, timestamp without time zone, integer)

DROP FUNCTION IF EXISTS cjams.pa_datevalidation(timestamp without time zone, timestamp without time zone, integer);

CREATE OR REPLACE FUNCTION cjams.pa_datevalidation(
	v_stdt timestamp without time zone,
	v_endt timestamp without time zone,
	v_service_log_id integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
/*
-- 04/24/2024- Manasa Kasula - CDM-38562 - Fix to skip the check if purchase auth exists for both rejected status (62) and return status (850)
-- 02/10/2025- CDM-44102 - fix to fetch the active record
*/

begin 
return (
select 
(select count(1) from tb_service_purchase_authorization join routing on objectid in (authorization_id:: character varying) and routingstatustypeid not in (62,850)
	where service_log_id = v_service_log_id and routing.activeflag=1 and eventcode in ('PCAUTH','PCAUTHR') and (v_stdt::DATE,v_endt::DATE ) OVERLAPS (start_dt::DATE, end_dt::DATE)
=false
and delete_sw = 'N'
and start_dt != v_stdt::DATE and start_dt != v_endt::DATE 
and end_dt != v_stdt ::DATE and end_dt != v_endt ::DATE
)
= 
(select count(1) from tb_service_purchase_authorization join routing on objectid in (authorization_id:: character varying)  and routingstatustypeid not in (62,850)
 where service_log_id  = v_service_log_id and routing.activeflag=1  and eventcode in ('PCAUTH','PCAUTHR')
 and delete_sw = 'N'
 )
)
;
end ;
$BODY$;

