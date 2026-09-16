update routing set activeflag = 0, updatedby = 'CDM-8619', updatedon = now() where routingid in ('2881a3ba-3ce2-441c-8555-8d80d768fd15','010ff03a-1eb8-440e-bcfd-20b1f422830e');

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, updatedby, insertedon, updatedon, isreviewrequest, servicerequestnumber)
select eventcode, tosecurityusersid, fromsecurityusersid, teamid, toroleid, toroleid, objectid, 16, 1, tosecurityusersid, 'CDM-8957', now(), now(), isreviewrequest, servicerequestnumber
from routing where routingid = '2881a3ba-3ce2-441c-8555-8d80d768fd15';