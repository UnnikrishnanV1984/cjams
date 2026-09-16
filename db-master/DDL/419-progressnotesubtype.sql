INSERT INTO cjams.progressnotesubtype
(progressnotesubtypeid, progressnotetypeid, activeflag, description, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", old_id, progressnotesubtypekey)
VALUES(gen_random_uuid(), NULL, 1, 'Detention Center', 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, 'DC');

INSERT INTO cjams.progressnotetypeconfig
(progressnotetypeconfigid, progressnotetypekey, progressnotesubtypekey, teamtypekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, old_id)
VALUES(gen_random_uuid(), 'Detention Center', 'DC', 'CW', 1, 'admin', now(), 'admin', now(), now(), '');

