INSERT INTO cjams.progressnotetypeconfig
(progressnotetypekey, progressnotesubtypekey, teamtypekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id)
VALUES
('Mail', '', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL, '');

DELETE FROM cjams.progressnotetype WHERE progressnotetypekey='Mail';

INSERT INTO cjams.progressnotetype
(progressnotetypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", parentid, progressnoteclassificationtypekey, old_id)
VALUES('Mail', 1, 'Mail', 'admin', now(), 'admin', now(), now(), now(), NULL, NULL, 'user', NULL);
