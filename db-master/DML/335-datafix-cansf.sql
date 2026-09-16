update submissioncollection 
set datavalue = '04720769-9e44-4c99-9863-25b815c403c4'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'ALIYAH  KIMBLE';

update submissioncollection 
set datavalue = '18eca1a9-9f66-4a40-b0a2-a7c832f530d1'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'DONZANAE  MONROE';

update submissioncollection 
set datavalue = 'a1ed37f3-11c2-429d-b724-283f97df1da3'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'NICHOLAS D DUFFEY';

update submissioncollection 
set datavalue = 'f3b1cfaf-c733-4b88-8155-d81bdcab9aa2'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'MIRACLE  BROWN';

update submissioncollection 
set datavalue = '67cdf154-2828-413f-9657-7d1086537448'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'KHALIS  DAVIS';

update submissioncollection 
set datavalue = '3bd9862f-859c-419e-9445-0e610c05ba1a'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'AMEERAH  ROUZEE';

update submissioncollection 
set datavalue = '85d0c500-a6b1-4fad-8808-2cfc86794479'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'CRAIG DARRYL DALTON';

update submissioncollection 
set datavalue = '24a1355c-5f17-4770-a9f9-0eca202fd28b'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'AVOKIA  SELLMAN';

update submissioncollection 
set datavalue = 'daf76775-e1e2-4020-9324-f25ba03b4370'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'RAYMOND ARMAND REPASS';

update submissioncollection 
set datavalue = '3f901ef5-a863-43ee-ab53-0ed3baa19695'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'PATRICK B JOHNSON';

update submissioncollection 
set datavalue = '44b25ed0-9294-423f-a5ae-8e39ec0bbeca'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'TRYNT D NUICE';

update submissioncollection 
set datavalue = 'b9422d9b-75d2-4de1-ab7c-8f4471998eee'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'ADELYN B NUICE';

update submissioncollection 
set datavalue = '11e9262d-c054-4364-ad7f-c9650293a8f9'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'GAGE MICHAEL WOLFE';

update submissioncollection 
set datavalue = 'cfad8e49-18aa-4e18-8489-f3802d1e34fc'
where  datakey = 'childname' and insertedby != 'migration user' and activeflag = 1 
and datavalue = 'KIARA  WOLFE';






UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"cfad8e49-18aa-4e18-8489-f3802d1e34fc"')
WHERE assessmentid = '8c302082-d7be-4212-87f5-8cbfeacf2ecc';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"3bd9862f-859c-419e-9445-0e610c05ba1a"')
WHERE assessmentid = '3aaf4517-689f-4219-8606-8a83252dec47';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"44b25ed0-9294-423f-a5ae-8e39ec0bbeca"')
WHERE assessmentid = '5d219987-d8c2-45f0-8ee6-98477d35bab4';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"04720769-9e44-4c99-9863-25b815c403c4"')
WHERE assessmentid = 'b9d0841c-28b7-4202-ba01-57b55496c6b2';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"24a1355c-5f17-4770-a9f9-0eca202fd28b"')
WHERE assessmentid = '35dbac68-5d5c-412f-afb1-f25045efacb6';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"daf76775-e1e2-4020-9324-f25ba03b4370"')
WHERE assessmentid = 'ba6bc0b4-e6e9-420f-aa54-db44a71730d7';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"11e9262d-c054-4364-ad7f-c9650293a8f9"')
WHERE assessmentid = '9d23959a-355e-46f1-8a13-78a6722e27e5';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"18eca1a9-9f66-4a40-b0a2-a7c832f530d1"')
WHERE assessmentid = '017b4daa-ea9b-4910-b09a-0a56079778f1';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"85d0c500-a6b1-4fad-8808-2cfc86794479"')
WHERE assessmentid = 'aff0f832-9548-43f7-87b6-90fb37706991';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{faceLifeForm,childname}','"b9422d9b-75d2-4de1-ab7c-8f4471998eee"')
WHERE assessmentid = '38728319-7e6e-4ba5-9978-babc3070c2db';

