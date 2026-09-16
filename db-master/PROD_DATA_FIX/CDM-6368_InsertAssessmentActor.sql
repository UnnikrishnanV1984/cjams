-- CDM-6368 - Added child in the case to the safe-c assessment

INSERT INTO cjams.assessmentactor
(assessmentid, intakeservicerequestactorid, issafe, activeflag, insertedby, updatedby, effectivedate, insertedon, updatedon, old_id, etl_userid, etl_load_date)
VALUES('bdb878e7-af3b-443c-b47f-78db28628387', 'bc91da7f-14be-43b8-aa83-c0e0ddae2a13', NULL, 1, 'CDM-6368', 
'CDM-6368', now(),now(), now(), NULL, NULL, NULL);