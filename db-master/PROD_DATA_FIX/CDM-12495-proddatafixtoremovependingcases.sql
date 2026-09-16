update routing set activeflag = 0, updatedby = 'CDM-12495', updatedon = now() where routingid in (
'f3453d66-fcfc-43c1-8921-7f97284f65a1',
'1a5b4823-3ac2-4159-b025-1d1da4119201',
'41cb2fee-3def-47d3-94dc-d37dfc539194',
'901d871b-f62b-45d8-ba29-dae522b3aea3',
'd846aec1-41e8-48e0-bc9b-446aae2999cc'
) and activeflag = 1;