delete from cjams.hearingtype where hearingtypekey='QRTPR';
INSERT INTO cjams.hearingtype
(hearingtypekey, description, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('QRTPR', 'QRTP Review', 1, now(), now(), now(), now(), now(), NULL, 'CW');
