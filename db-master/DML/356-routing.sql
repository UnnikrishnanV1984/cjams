update cjams.routing
set activeflag = 0, updatedon = now(), updatedby = 'D-26763'
where routingid in ('9ea89c8d-55ab-4fb4-a151-2db76ba13386',
'26d54542-85e5-477e-84d2-c4d807b6f18e',
'bd95eda0-3757-43c2-b35a-21f115197c4f',
'36bb87b9-fef1-41a8-9e89-bd12a2c9b71f');

