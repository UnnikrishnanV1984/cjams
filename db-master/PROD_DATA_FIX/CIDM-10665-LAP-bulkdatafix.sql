/*
Issue Description: CIDM-10665 CJAMS PID not captured in Quicksight Report for LAP Assessment
Category/Module: LAP Assessment
Root cause: We are not capturing the LAP assessment cjamspid and we need a bulk data fix to include cjamspid for the existing records. 
Fix provided: Data fix has been done to include cjamspid in reporting submission data as the part of bulk data fix.
              There are 15 clients with suffix and prefix appended and we are doing a manual insertion for those users as the query will not work for those.
Data/Code fix ticket#:CIDM-10665
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10665
Reason why no related code fix: N/A
*/

WITH lap_clients AS (
    SELECT DISTINCT 
        pr.personid, pr.cjamspid, pr.firstname, pr.lastname, pr.middlename, pr.dob::date,
        sc.servicecasenumber AS casenumber, 
        ac.servicecaseid AS caseid, 
        'servicecase' AS casetype
    FROM actor ac
    JOIN intakeservicerequestactor isa ON ac.actorid = isa.actorid
    JOIN person pr ON isa.personid = pr.personid
    JOIN servicecase sc ON ac.servicecaseid = sc.servicecaseid
    WHERE ac.servicecaseid IN (
          SELECT sc.servicecaseid  
          FROM assessment a
          JOIN servicecase sc ON sc.servicecaseid = a.objectid 
          WHERE a.assessmenttemplateid = '0e17ebd8-57dc-41bc-b51f-ac95103b9542')
    
    UNION ALL

    SELECT DISTINCT 
        pr.personid, pr.cjamspid, pr.firstname, pr.lastname, pr.middlename, pr.dob::date,
        isr.servicerequestnumber AS casenumber, 
        ac.intakeserviceid AS caseid, 
        'cpscase' AS casetype
    FROM actor ac
    JOIN intakeservicerequestactor isa ON ac.actorid = isa.actorid
    JOIN person pr ON isa.personid = pr.personid
    JOIN intakeservicerequest isr ON ac.intakeserviceid = isr.intakeserviceid
    WHERE  ac.intakeserviceid IN (
          SELECT isr.intakeserviceid  
          FROM assessment a
          JOIN intakeservicerequest isr ON isr.intakeserviceid = a.objectid 
          WHERE a.assessmenttemplateid = '0e17ebd8-57dc-41bc-b51f-ac95103b9542' 
          AND isr.teamtypekey <> 'AS'
      )
)

UPDATE assessment a
SET submissiondata = jsonb_set(a.submissiondata, '{cjamspid}', to_jsonb(l.cjamspid), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
FROM lap_clients l
WHERE a.assessmenttemplateid = '0e17ebd8-57dc-41bc-b51f-ac95103b9542'
  AND (a.submissiondata #>> '{caseNumber}') = l.casenumber
  AND (a.submissiondata #>> '{dob}')::date = l.dob
  AND LOWER(TRIM(a.submissiondata #>> '{victiminfo}')) = LOWER(TRIM(CONCAT_WS(' ',
        NULLIF(TRIM(l.firstname), ''),
        NULLIF(TRIM(l.middlename), ''),
        NULLIF(TRIM(l.lastname), '')
  )));

--- Bulk Data fix to manually update the cjamspid for users who are having suffix/Prefix in their names

---TYREKA MARIE WALKER  Cjamspid: 1495976

UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(1495976), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid in ('08304fa8-bf2b-47fe-9a10-548383b4afd7','ac433d06-3054-4cda-941c-1c9df5ce3748');

--MARIE DENIS cjamspid:1489490

UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(1489490), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = '55ce811e-fd6b-4daa-ae32-b00591db462b';

--	EMMANUEL PIERRE PIERRE Sr. CJAMSPID:4322686  

UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(4322686), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = '8761a510-5a33-4030-9a3d-4fb661d288dd';

 --  Mr. RONALD MCCULLOUGH II cjasmpid:1901531
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(1901531), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = '3ba1bd9f-90c4-4e8e-8afb-5f29e9cd27d4';

--Teri Mersing cjamspid:204073932
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(204073932), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = 'f6aa7d46-ba4b-4fa1-ac57-51967e298721';

--Mia Lynn Gonzalez  cjamspid:203642346
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(203642346), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = 'fc786e6e-d73e-49f8-8fe9-e25c1552044e';

--DAVID VEST Sr. cjamspid:4113203
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(4113203), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = '32901038-f5a7-4127-a7cb-a4b3b2c22c83';


---	Peyton Bryant (Bransby)	204172805

UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(204172805), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = 'e0c37b80-36b4-4c4a-b20e-9c0f9142cff8';

----Shaunte M Mcmath	241030296763	e2d9f6ab-fb10-49f3-b933-dbc199eae65c	d557492a-bae8-4edd-a9af-38302fd68591 (This person is not availble in the case and we have other user with same cjamspid 204098732)
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(204098732), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = 'd557492a-bae8-4edd-a9af-38302fd68591';


--- CHARDA L DUTREE Cjampid: 1634024
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(1634024), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = '4ea1bbfa-e61b-4e6e-a895-a7596482120d';

-- naomi manges cjamspid: 204109902
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(204109902), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = '2771ae7f-1d03-46df-8230-ede1e54acb7f';


---Ms. TINESHA C BETTS cjamspid:1754880
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(1754880), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = '38780c53-d6b4-4113-a1b2-539513615bc5';

--- Mrs. Alecia West-Willburn  cjamspid:200175386
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(200175386), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = 'c533d6c4-2668-43c5-921c-d8caafb54573';

--- Alexis Hunt cjamspid:204172243
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{cjamspid}', to_jsonb(204172243), true),
    updatedby = 'CIDM-10665',
    updatedon = now()
WHERE assessmentid = '45886ad7-c3fa-4ac2-8769-f90913a88234';