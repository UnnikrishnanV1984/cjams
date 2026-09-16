--D-23455 Bug/Issue/Defect 3195312 SAFE-C OHP Provider Address displays incorrectly in the SAFE-C OHP.  The correct address is 1605 Cromwell Bridge Road (Line 1) and nothing should display in Line 2.  The city is Baltimore, the state is MD and the zip is 21234

UPDATE assessment

SET updatedby = 'CIDM-4724',
updatedon = now(),
submissiondata = (SELECT replace(replace(submissiondata::character varying,'1605',''),'Cromwell Bridge','1605 Cromwell Bridge')::json FROM assessment WHERE assessmentid='1e2117bc-e645-4040-a0e2-23dd05ce308b')
WHERE assessmentid='1e2117bc-e645-4040-a0e2-23dd05ce308b';

UPDATE assessmentsubmission
SET datavalue = '1605 Cromwell Bridge RD'
WHERE datakey='addressline1' and assessmentid='1e2117bc-e645-4040-a0e2-23dd05ce308b';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='1e2117bc-e645-4040-a0e2-23dd05ce308b';

UPDATE assessmentsubmission
SET datavalue = '1337 Nautical Circle'
WHERE datakey='addressline1' and assessmentid='7b5c74ed-908c-44d2-93d7-321577c3fd36';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='7b5c74ed-908c-44d2-93d7-321577c3fd36';

UPDATE assessmentsubmission
SET datavalue = '1337 Nautical Circle'
WHERE datakey='addressline1' and assessmentid='e66220e3-a7fd-4b9b-b7a9-f1e75efed9e4';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='e66220e3-a7fd-4b9b-b7a9-f1e75efed9e4';

UPDATE assessmentsubmission
SET datavalue = '10822 Downsville Pike'
WHERE datakey='addressline1' and assessmentid='86499dae-0c1b-44bf-902f-78f677fbab40';

UPDATE assessmentsubmission
SET datavalue = 'Apartment 21'
WHERE datakey='addressline2' and assessmentid='86499dae-0c1b-44bf-902f-78f677fbab40';

UPDATE assessmentsubmission
SET datavalue = '21740'
WHERE datakey='zipcode' and assessmentid='86499dae-0c1b-44bf-902f-78f677fbab40';

UPDATE assessmentsubmission
SET datavalue = '1605 Cromwell Bridge RD'
WHERE datakey='addressline1' and assessmentid='24af1fb7-1c60-4f31-b264-8f4df6b17244';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='24af1fb7-1c60-4f31-b264-8f4df6b17244';

UPDATE assessmentsubmission
SET datavalue = '1605 Cromwell Bridge RD'
WHERE datakey='addressline1' and assessmentid='62a85fee-d46a-415d-bc22-5433ef71f495';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='62a85fee-d46a-415d-bc22-5433ef71f495';

UPDATE assessmentsubmission
SET datavalue = '1605 Cromwell Bridge RD'
WHERE datakey='addressline1' and assessmentid='9a1b5f1f-838e-434c-b58c-46b2dd81fefe';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='9a1b5f1f-838e-434c-b58c-46b2dd81fefe';

UPDATE assessmentsubmission
SET datavalue = '1605 Cromwell Bridge RD'
WHERE datakey='addressline1' and assessmentid='100e2520-b295-4d9e-9a19-a96744036151';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='100e2520-b295-4d9e-9a19-a96744036151';

UPDATE assessmentsubmission
SET datavalue = '1605 Cromwell Bridge RD'
WHERE datakey='addressline1' and assessmentid='0efbe037-86eb-40b9-9bf9-b80ffe3a8f7a';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='0efbe037-86eb-40b9-9bf9-b80ffe3a8f7a';

UPDATE assessmentsubmission
SET datavalue = '1605 Cromwell Bridge RD'
WHERE datakey='addressline1' and assessmentid='3d688b6c-369a-449a-8a2b-58b44bb62452';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='3d688b6c-369a-449a-8a2b-58b44bb62452';

UPDATE assessmentsubmission
SET datavalue = '1605 Cromwell Bridge RD'
WHERE datakey='addressline1' and assessmentid='a5738bd4-4c4e-47de-a236-2baf53387e07';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='a5738bd4-4c4e-47de-a236-2baf53387e07';

UPDATE assessmentsubmission
SET datavalue = '13310 B Brook Lane Drive'
WHERE datakey='addressline1' and assessmentid='ab315cce-d82d-4568-8bd2-5f51cfddcde2';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='ab315cce-d82d-4568-8bd2-5f51cfddcde2';

UPDATE assessmentsubmission
SET datavalue = '13310 B Brook Lane Drive'
WHERE datakey='addressline1' and assessmentid='50057a29-6599-41ec-81d1-940c8965b917';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='50057a29-6599-41ec-81d1-940c8965b917';

UPDATE assessmentsubmission
SET datavalue = '13310 B Brook Lane Drive'
WHERE datakey='addressline1' and assessmentid='21e38547-8a95-44fb-80e5-957f051590dc';

UPDATE assessmentsubmission
SET datavalue = ''
WHERE datakey='addressline2' and assessmentid='21e38547-8a95-44fb-80e5-957f051590dc';
