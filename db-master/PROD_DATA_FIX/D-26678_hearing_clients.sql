--D-26678

INSERT INTO cjams.hearingclients (hearingclientid, courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, courtcasenotx, otherclientflag) 
(
SELECT gen_random_uuid(), '72afdd46-9f5d-48e9-92a3-0e635a01172f', 'D-26678', now(), insertedby, insertedon, 1, personid, courtcasenotx, otherclientflag
FROM cjams.hearingclients where courthearingid = '6fc6a9ad-b19a-4fe5-9a5e-0536f9a7e408');


INSERT INTO cjams.hearingclients (hearingclientid, courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, courtcasenotx, otherclientflag) 
(
SELECT gen_random_uuid(), 'edc9e45a-a4f1-478f-bcb0-21f0bf102f02', 'D-26678', now(), insertedby, insertedon, 1, personid, courtcasenotx, otherclientflag
FROM cjams.hearingclients where courthearingid = 'be96c7fc-4b7b-436e-abf8-fa405bf3483d');



--D-26559
update documentproperties set insertedby ='7119301a-98ab-45f5-9a7d-e6317b8529fb', 
updatedby = '7119301a-98ab-45f5-9a7d-e6317b8529fb' where ecmsdocumentid = '5e56d63646e0fb00c226558b'