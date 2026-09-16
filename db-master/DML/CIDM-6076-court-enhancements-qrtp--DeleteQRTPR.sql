-- QA Wants QRTPR to be deleted as this is a duplicate value for QRTPRH QRTP Review Hearing

--INSERT INTO cjams.hearingtype
--(hearingtypeid, hearingtypekey, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
--VALUES('4682d9f9-6d0f-4ad5-93e3-f374242de94a', 'QRTPR', 'QRTP Review', 1, '2019-05-30 22:33:02.189', '2019-05-30 22:33:02.189804-04', '2019-05-30 22:33:02.189804-04', '2019-05-30 22:33:02.189', '2019-05-30 22:33:02.189', NULL, 'CW');


DELETE FROM cjams.hearingtype
WHERE hearingtypekey='QRTPR';