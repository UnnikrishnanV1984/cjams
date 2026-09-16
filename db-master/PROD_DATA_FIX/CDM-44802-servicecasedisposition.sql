update servicecasedisposition 
set updatedon = now(), updatedby = 'CDM-44802', activeflag = 1
where servicecaseid = '3e03991a-a693-4262-8e9d-02349d28e7cd'
and servicecasedispositionid  in (
'a9c29289-2c77-4ea7-9284-198a86621d81',
'4cf5a475-e35a-49a7-a2b3-b3e8940e3263',
'52c35984-232f-49c1-81b8-aaa23c9a0f1e',
'624e284d-f642-453b-8e83-00c29e08d43f'
) and activeflag = 0;