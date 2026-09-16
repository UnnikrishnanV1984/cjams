INSERT INTO cjams.progressnotesubtype
(progressnotesubtypeid, progressnotetypeid, activeflag, description, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", old_id, progressnotesubtypekey)
VALUES(gen_random_uuid(), NULL, 1, 'Relative''s Residence', 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, 'RR');

INSERT INTO cjams.progressnotetypeconfig
(progressnotetypeconfigid, progressnotetypekey, progressnotesubtypekey, teamtypekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, old_id)
VALUES(gen_random_uuid(), 'Relatives Residence', 'RR', 'CW', 1, 'admin', now(), 'admin', now(), now(), '');
