update routing set activeflag=0 where objectid in (5861) and eventcode = 'FINALDIS'
and routingid in ('9fb6309f-b9da-4c67-8f29-2e7e8351b597','8dee4a3d-2145-4897-9efe-cc5dd245e296','181234a2-b8de-48ef-9511-b06709c6972a');
	
update routing set remarks='Approved' where objectid in (5861) and eventcode = 'FINALDIS'
and routingid in ('110029cd-563b-48c8-89aa-9090d90ca6fd');	
	
update routing set activeflag=0 where objectid in (5882) and eventcode = 'FINALDIS'
and routingid in ('e594f98d-efdc-4e0f-9d6f-7a6319f9d8d6','592c9c0e-6f83-4986-9f3d-6c76ba746478','f67cbf20-7a39-497a-a30a-5d67219106e7');
	
update routing set remarks='Approved' where objectid in (5882) and eventcode = 'FINALDIS'
and routingid in ('a40cade3-e0d7-43f8-97c2-25503a196ef7');