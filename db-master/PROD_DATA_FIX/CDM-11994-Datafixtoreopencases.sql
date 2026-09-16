/*
-- Issue Description: 
   Datafix to re-open the Service Case 

   Case ID: 3117532,3207836, 3281334
statustypekey, dispositioncode, enddate, servicecaseid, servicecase   
ASSGN	Closed	2017-03-02 00:00:00	4db9dc36-6c62-4601-bbdc-f3d6834adb20	3207836
ASSGN	Closed	2007-06-29 00:00:00	e0f35997-9d75-42dd-a9e7-5236728e40fc	3117532
ASSGN	Closed	2018-02-22 00:00:00	b32c8ad7-9789-4f0e-81d7-8e7e03a3da6a	3281334   
   
*/



-- 3207836
INSERT INTO cjams.servicecasedisposition
( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('4db9dc36-6c62-4601-bbdc-f3d6834adb20', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
'CDM-11994', now(), 'CDM-11994', now(), NULL, null, NULL, null);

-- 3117532
INSERT INTO cjams.servicecasedisposition
( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('e0f35997-9d75-42dd-a9e7-5236728e40fc', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
'CDM-11994', now(), 'CDM-11994', now(), NULL, null, NULL, null);

-- 3281334
INSERT INTO cjams.servicecasedisposition
( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('b32c8ad7-9789-4f0e-81d7-8e7e03a3da6a', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
'CDM-11994', now(), 'CDM-11994', now(), NULL, null, NULL, null);

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-11994',updatedon = now() WHERE servicecaseid in (
'4db9dc36-6c62-4601-bbdc-f3d6834adb20',
'e0f35997-9d75-42dd-a9e7-5236728e40fc',
'b32c8ad7-9789-4f0e-81d7-8e7e03a3da6a'
) and activeflag = 1;