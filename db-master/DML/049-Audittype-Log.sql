INSERT INTO cjams.auditlogtype
( logtypekey, logtype, modulename, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('PNOTE', 'PNOTE', 'PROGRESSNOTE', '2018-06-06 12:15:38.888', NULL, 'admin', 'admin', 
'2018-06-06 12:15:38.888', '2018-06-06 12:15:38.888', NULL);
INSERT INTO cjams.progressnotetype
(progressnotetypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", parentid, progressnoteclassificationtypekey, old_id)
VALUES( 'Weekly Visits', 1, 'Weekly Visits', '', '2019-05-11 08:28:46.477', NULL, NULL, '2019-05-11 08:28:46.477', NULL, NULL, NULL, 'user', NULL);

INSERT INTO cjams.progressnotetypeconfig
(progressnotetypekey, progressnotesubtypekey, teamtypekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id)
VALUES( 'Weekly Visits', '', 'CW', 1, 'admin', '2019-03-20 17:58:41.598', 'admin', '2019-03-20 17:58:41.598', '2019-03-20 17:58:41.598', NULL, '');
