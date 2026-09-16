
update cjams.routing 
set activeflag = 0, updatedon = now()
where routingid in ('158ab24b-711a-4a93-ba37-489f1fcc94e4',
'469f9be5-5663-4538-80be-46db98d288d7',
'6c292b73-0c8c-4df2-8a4c-6e8f498eebc8',
'4b484532-6d1f-4d29-aa98-9959b1878fb0',
'15afec76-b1b6-47ad-8c58-030cf9333e0f',
'5fbbe3e8-7c02-439b-842f-3ea433dd68ff',
'5c77dffe-1989-4d77-839a-bbdfd4c12603');

