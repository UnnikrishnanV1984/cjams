update tb_slpa_snapshot
set funding_name = 'Jennafer Armbrester' , payment_name ='Dawn Dent'
where authorization_id  in (1733220,1733225,1733229,1733231,1733224,1733226,1733228,1733230);

update routing
set tosecurityusersid = '5102afd8-319f-45ad-9743-071e95686a05', updatedon = now(), updatedby = 'Datafix user as per CDM-1144'
where objectid in (1733220,1733225,1733229,1733231,1733224,1733226,1733228,1733230) and routingstatustypeid = 44;

update routing
set tosecurityusersid = 'b9241dd6-438f-4014-a21a-fe85eb21b6ff', fromsecurityusersid = '5102afd8-319f-45ad-9743-071e95686a05', updatedon = now(), updatedby = 'Datafix user as per CDM-1144'
where objectid in (1733220,1733225,1733229,1733231,1733224,1733226,1733228,1733230) and routingstatustypeid = 43;

