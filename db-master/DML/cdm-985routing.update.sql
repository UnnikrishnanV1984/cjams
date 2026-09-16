update cjams.routing set activeflag = 0 where routingid='6ad6106d-67c9-4fc8-96f4-cc1cb5d686b9' AND eventcode = 'INDR';

insert into routing(eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,activeflag,insertedby,insertedon,servicerequestnumber)
select 'INDR',tosecurityusersid,fromsecurityusersid,teamid,toroleid,fromroleid,objectid,16,activeflag,'CDM-985',now(),'20200115017878'
from routing where routingid='6ad6106d-67c9-4fc8-96f4-cc1cb5d686b9';