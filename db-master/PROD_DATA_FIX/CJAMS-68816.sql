/*
============================================================================================
Issue          : Provider Involved Maltreatment / SDM - Maltreatment Type
Category/Module : SDM (Maltreatment Type) + Maltreatment Allegation (Case & Intake)
Ticket #        : CJAMS-68816

Root cause      : User did not select "Provider Involved Maltreatment = Yes" nor the
                  "Family-based foster home" setting / provider details in SDM.

Fix provided    : Data fix to,
                    - set Provider Involved Maltreatment = Yes
                    - check "Family-based foster home" (isfcplacementsetting)
                    - set provider = The Arc Baltimore Treatment and Specialized FC (5000384)
                    - check "Alleged maltreatment linked to a child's residence while they were
                      removed (in Foster Care)" (linkschidresid)
                  applied at BOTH Intake level and Case level.

Provider details:
    Provider Id    : 5000384
    Provider Name  : The Arc Baltimore Treatment and Specialized FC
    Provider Phone : 4102965087

Is Code fix Required? : No  (user data entry error - one time correction for this referral)
Regression Impacts    : N/A

NOTE: An empty "Provider Id / Provider Name / Address" block may render on the case-level SDM
      screen. This is an existing frontend behavior (it appears when isfcplacementsetting=true
      and the child has placement records but no placement is linked via providerdetails); it is
      NOT caused by this data fix and is not resolvable via SDM data. Out of scope for this fix.
============================================================================================
*/




-- ==========================================================================================
-- 1. INTAKE LEVEL - SDM base record 
--    Provider Involved = Yes (ismaltreatment), Family-based foster home (isfcplacementsetting),
--    in-Foster-Care link (linkschidresid).
-- ==========================================================================================
UPDATE cjams.intakeservicerequestsdm
SET    ismaltreatment       = true,
       isfcplacementsetting = true,
       linkschidresid       = true,
       updatedby            = 'CJAMS-68816',
       updatedon            = now()
WHERE  intakeserviceid = 'fff3e4a6-2382-4052-ba29-fc7c596495f6'
AND    activeflag = 1;


-- ------------------------------------------------------------------------------------------
-- 1a. Provider NAME row (maltreatmenttype = 'PR') in intakeservrequestsdmmaltreatment.
--     Update the existing active 'PR' row if present; otherwise insert it.
-- ------------------------------------------------------------------------------------------
UPDATE cjams.intakeservrequestsdmmaltreatment
SET    maltreatorsname = 'The Arc Baltimore Treatment and Specialized FC',
       updatedby       = 'CJAMS-68816',
       updatedon       = now()
WHERE  intakeservicerequestsdmid IN (
           SELECT intakeservicerequestsdmid
           FROM   cjams.intakeservicerequestsdm
           WHERE  intakeserviceid = 'fff3e4a6-2382-4052-ba29-fc7c596495f6'
           AND    activeflag = 1)
AND    maltreatmenttype = 'PR'
AND    activeflag = 1;


INSERT INTO cjams.intakeservrequestsdmmaltreatment
       (intakeservicerequestsdmid, maltreatmenttype, maltreatorsname,
        activeflag, insertedby, updatedby, insertedon, updatedon, effectivedate)
SELECT sdm.intakeservicerequestsdmid, 'PR', 'The Arc Baltimore Treatment and Specialized FC',
       1, 'CJAMS-68816', 'CJAMS-68816', now(), now(), now()
FROM   cjams.intakeservicerequestsdm sdm
WHERE  sdm.intakeserviceid = 'fff3e4a6-2382-4052-ba29-fc7c596495f6'
AND    sdm.activeflag = 1
AND    NOT EXISTS (
           SELECT 1 FROM cjams.intakeservrequestsdmmaltreatment m
           WHERE  m.intakeservicerequestsdmid = sdm.intakeservicerequestsdmid
           AND    m.maltreatmenttype = 'PR'
           AND    m.activeflag = 1);


-- ------------------------------------------------------------------------------------------
-- 1b. intakesnapshot JSON (drives the read-only / display of the intake screen)
-- ------------------------------------------------------------------------------------------
UPDATE cjams.intakesnapshot
SET    jsondata = jsonb_set(
                    jsonb_set(
                      jsonb_set(
                        jsonb_set(
                          jsonb_set(jsondata::jsonb, '{sdm,maltreatment}',          '"yes"'::jsonb, true),
                          '{sdm,isfcplacementsetting}', '"true"'::jsonb, true),
                        '{sdm,linkschidresid}',        '"true"'::jsonb, true),
                      '{sdm,provider}',
                      '[{"providerid":5000384,"providername":"The Arc Baltimore Treatment and Specialized FC","providerphone":"4102965087"}]'::jsonb, true),
                    '{sdm,selectedproviderdetails}',
                    '{"providerid":5000384,"providername":"The Arc Baltimore Treatment and Specialized FC","providerphone":"4102965087"}'::jsonb, true),
       updatedby = 'CJAMS-68816',
       updatedon = now()
WHERE  intakenumber = 'I261014111947'
AND    activeflag = 1;


-- ------------------------------------------------------------------------------------------
-- 1c. intakedastaging JSON 
-- ------------------------------------------------------------------------------------------
UPDATE cjams.intakedastaging
SET    jsondata = jsonb_set(
                    jsonb_set(
                      jsonb_set(
                        jsonb_set(
                          jsonb_set(jsondata::jsonb, '{sdm,maltreatment}',          '"yes"'::jsonb, true),
                          '{sdm,isfcplacementsetting}', '"true"'::jsonb, true),
                        '{sdm,linkschidresid}',        '"true"'::jsonb, true),
                      '{sdm,provider}',
                      '[{"providerid":5000384,"providername":"The Arc Baltimore Treatment and Specialized FC","providerphone":"4102965087"}]'::jsonb, true),
                    '{sdm,selectedproviderdetails}',
                    '{"providerid":5000384,"providername":"The Arc Baltimore Treatment and Specialized FC","providerphone":"4102965087"}'::jsonb, true),
       updatedby = 'CJAMS-68816',
       updatedon = now()
WHERE  intakenumber = 'I261014111947'
AND    activeflag = 1;


-- ==========================================================================================
-- 2. CASE LEVEL - Maltreatment Allegation (image 3)
--    Provider Involved = Yes + provider details + Family-based foster home (FCPS).
-- ==========================================================================================

-- 2a. Provider Involved = Yes on all active allegations for this investigation
UPDATE cjams.investigationallegation ia
SET    isproviderinvolved = 1,
       updatedby = 'CJAMS-68816',
       updatedon = now()
FROM   cjams.investigation inv
WHERE  inv.investigationid = ia.investigationid
AND    inv.intakeserviceid = 'fff3e4a6-2382-4052-ba29-fc7c596495f6'
AND    inv.activeflag = 1
AND    ia.activeflag = 1;


-- 2b. Provider details on the investigation maltreatment record
UPDATE cjams.investigationmaltreatment im
SET    providerid          = '5000384',
       providername        = 'The Arc Baltimore Treatment and Specialized FC',
       providerphonenumber = '4102965087',
       updatedby = 'CJAMS-68816',
       updatedon = now()
FROM   cjams.investigation inv
WHERE  inv.investigationid = im.investigationid
AND    inv.intakeserviceid = 'fff3e4a6-2382-4052-ba29-fc7c596495f6'
AND    inv.activeflag = 1
AND    im.activeflag = 1;


-- 2c. Provider maltreatment setting = Family-based foster home (FCPS) for each active allegation.
--     Insert only where an active FCPS row does not already exist.
INSERT INTO cjams.allegationprovidermaltreatment
       (allegationprovidermaltreatmentid, investigationallegationid, providermaltreatmenttypekey,
        activeflag, insertedby, updatedby, effectivedate, insertedon, updatedon, old_id)
SELECT gen_random_uuid(), ia.investigationallegationid, 'FCPS',
       1, 'CJAMS-68816', 'CJAMS-68816', now(), now(), now(), NULL
FROM   cjams.investigationallegation ia
JOIN   cjams.investigation inv ON inv.investigationid = ia.investigationid
WHERE  inv.intakeserviceid = 'fff3e4a6-2382-4052-ba29-fc7c596495f6'
AND    inv.activeflag = 1
AND    ia.activeflag = 1
AND    NOT EXISTS (
           SELECT 1 FROM cjams.allegationprovidermaltreatment apm
           WHERE  apm.investigationallegationid = ia.investigationallegationid
           AND    apm.providermaltreatmenttypekey = 'FCPS'
           AND    apm.activeflag = 1);
