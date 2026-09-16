INSERT INTO cjams.progressnotetype
( progressnotetypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", parentid, progressnoteclassificationtypekey, old_id)
VALUES('Public Facility', 1, 'Public Facility', 'admin', now(), 'admin', now(), now(), now, NULL, NULL, 'user', NULL);

INSERT INTO cjams.progressnotetypeconfig
(progressnotetypekey, progressnotesubtypekey, teamtypekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id)
VALUES('Public Facility', '', 'CW', 1, 'admin', now(), 'admin', now() , now() , NULL, '');