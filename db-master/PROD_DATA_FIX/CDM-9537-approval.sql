
update cjams.routing
set activeflag = 0, updatedon = now()
where routingid in ('548dc837-3b28-49aa-b364-937e11f5053a',
'bd30ced3-157e-4632-9d80-1af057988f15',
'ef8a4015-228e-4cf0-a323-d69059b12272', 
'dd2cab2d-0e27-4389-a7b8-df3135027d0b');

