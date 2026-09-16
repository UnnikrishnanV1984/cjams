/*
Issue Description: CIDM-10763 CJAMS PID not captured in Quicksight Report for LAP Assessment
Category/Module: LAP Assessment
Root cause: Data fix has been done to include cjamspid in reporting submission data as the part of bulk data fix as the part of CIDM-10763.
            There is one client added before this data fix went to prod and also there are two new clients who is having prefix in their names which need a manual data fix.
Fix provided: Data fix has been done to include cjamspid in reporting submission data as the part of bulk data fix.              
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a known issue and we are handling it with this data fix.
*/

--Travon Henderson  objectid:472b42b7-2658-45bf-a076-dbf726f9cdb5
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(204025766), true),
    updatedby = 'CIDM-10763',
    updatedon = now()
WHERE assessmentid = '68aafead-abe9-4003-8967-c78f96c6165f';

--John David Mansberger Jr.  objectid:3ac94502-428d-4436-9e37-56e8f9d40cca
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(204093619), true),
    updatedby = 'CIDM-10763',
    updatedon = now()
WHERE assessmentid = '17236990-010e-4eb7-a495-f52bcfb1c170';

--McKinley Ray Quarles Jr.    objectid:dba43337-cc3a-4fc2-923b-3aca74e24c1e
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(200873375), true),
    updatedby = 'CIDM-10763',
    updatedon = now()
WHERE assessmentid = 'ecc2eb0c-2218-49ef-9074-8376220bc747';
                     



