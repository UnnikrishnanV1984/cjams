INSERT INTO cjams.progressnotetypeconfig
(progressnotetypekey, progressnotesubtypekey, teamtypekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id)
VALUES
('File Cabinet Client', '', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL, ''),
('File Cabinet Case', '', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL, '');

INSERT INTO cjams.progressnotetype
(progressnotetypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", parentid, progressnoteclassificationtypekey, old_id)
VALUES
('File Cabinet Client', 1, 'File Cabinet Client', 'admin', now(), 'admin', now(), now(), now(), NULL, NULL, 'user', NULL),
('File Cabinet Case', 1, 'File Cabinet Case', 'admin', now(), 'admin', now(), now(), now(), NULL, NULL, 'user', NULL);



