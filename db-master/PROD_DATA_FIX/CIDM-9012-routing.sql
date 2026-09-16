/*
  Issue Description: CIDM-9012
   Category/ Module: Purchase Auth
   Root cause: Routing record is not deactivated on approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE cjams.routing
SET activeflag=0, updatedby='CIDM-9012', updatedon=now()
WHERE eventcode in ('PCAUTH','PCAUTHR') and activeflag= 1 and routingstatustypeid != 43 
and objectid in (select r.objectid from routing r where r.routingstatustypeid = 43 
and r.activeflag = 1 and r.eventcode in ('PCAUTH','PCAUTHR')
and (select count(*) from routing r1 where r1.routingstatustypeid != 43 
    and r1.activeflag = 1 and r1.objectid = r.objectid and r1.eventcode in ('PCAUTH','PCAUTHR'))> 0
and (select count(*) from tb_service_purchase_authorization pa, tb_service_log sl
    where pa.service_log_id = sl.service_log_id and pa.delete_sw = 'N' and sl.delete_sw = 'N' 
    and pa.authorization_id = r.objectid::bigint )> 0   
and (select count(*) from tb_payment_header ph where ph.delete_sw = 'N' and ph.authorization_id = r.objectid::bigint)> 0)
