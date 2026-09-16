CREATE OR REPLACE FUNCTION cjams.updateservicecasedispositionrouting(v_servicecaseid character varying, v_intakeserreqstatustypekey character varying, v_dispositioncode character varying, v_userid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 09/26/2023 Chandra/Palani - Query Tuning (CIDM-7993)
------------------------------------------------------------------------------------------------------------
declare

v_servicecasedisposition character varying;

begin
    update Servicecasedisposition set activeflag=0, updatedby = v_userid, updatedon = now() where servicecaseid=v_servicecaseid::uuid and intakeserreqstatustypekey=v_intakeserreqstatustypekey and dispositioncode = v_dispositioncode and activeflag = 1
and (select count(1) >0 from routing where objectid = servicecasedispositionid::varchar and activeflag = 1 and eventcode = 'SCDR' and routingstatustypeid = 15) returning servicecasedispositionid into v_servicecasedisposition;

    update routing set activeflag=0, updatedby = v_userid, updatedon = now() where objectid =v_servicecasedisposition and activeflag = 1 and eventcode = 'SCDR' and routingstatustypeid = 15 ;

    return 'success';

end
$function$
;