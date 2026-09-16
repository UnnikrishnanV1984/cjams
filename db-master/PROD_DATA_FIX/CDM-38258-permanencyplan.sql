UPDATE cjams.permanencyplan
SET updatedon=now(), updatedby='CDM-38258', activeflag=0
WHERE permanencyplanid='c10edb0a-dfb9-4ee9-a9ce-326e6529e888'::uuid;

UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-38258', updatedon=now()
WHERE routingid='ba2e26a8-a002-4f3f-a8e3-56a7dadf163e'::uuid and objectid='c10edb0a-dfb9-4ee9-a9ce-326e6529e888';

