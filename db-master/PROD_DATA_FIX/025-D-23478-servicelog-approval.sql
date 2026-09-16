update routing set activeflag=0 where objectid=1730944 and routingid='4d855c9f-421a-4709-ad06-bcf6182f81fb' and routingstatustypeid=40;
update routing set activeflag=0 where objectid=729706 and routingid in ('d210e35b-9378-41af-8bd1-1e56d5aaeb5d','b4a87b40-554e-4138-a0fa-823e763d90df',
'0ab9617f-53e3-4065-9f06-7adfe4dc2e6b');
update routing set activeflag=1 where objectid=729706 and routingid in ('d26bccc0-1a65-4a60-b39d-cbc801519f51');
delete from routing where routingid in ('7b741b41-293c-4d9b-9c41-aa438858882c',
'37746d7f-2a00-495c-9f3f-379370f4649d',
'21104afa-1edf-45d3-a7a8-a8941a415d86',
'1ca4d3ec-715b-4a22-9f00-11d684a84d3d','d210e35b-9378-41af-8bd1-1e56d5aaeb5d','b4a87b40-554e-4138-a0fa-823e763d90df');