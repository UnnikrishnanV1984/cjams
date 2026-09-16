
update routing r
set  activeflag = 0
where 
r.eventcode = 'SPLAN' 
and r.routingstatustypeid = 15
and r.activeflag=1
and r.insertedon::time <= (select insertedon from routing where eventcode = 'SPLAN' and routingstatustypeid=17 and activeflag=1 and objectid= r.objectid)::time
and r.objectid in (select objectid from routing where eventcode = 'SPLAN' and routingstatustypeid=17 and activeflag=1)
