

delete from auditlog where logtypekey in ('CM003','CM006','WL016');
delete from auditlogtype where logtypekey in ('CM003','CM006','WL016');




INSERT INTO auditlogtype
(logtypeid, logtypekey, logtype, modulename, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('2adc073b-74bc-4227-98e2-d9e19ce614c0', 'WL016', 'Contact Summary Report Generated', 'Contact Summary Report Generated', '2019-07-09 12:29:03.486', NULL, 'admin', 'admin', '2019-07-09 12:29:03.486', '2019-07-09 12:29:03.486', NULL);


INSERT INTO cjams.auditlogtype
(logtypeid, logtypekey, logtype, modulename, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(gen_random_uuid(), 'CM003', 'Safety plan', 'Safety plan completed and approved', now(), null, 'admin', 'admin', now(), now(), '');


INSERT INTO cjams.auditlogtype
(logtypeid, logtypekey, logtype, modulename, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(gen_random_uuid(), 'CM006', 'Risk Assesment', 'Risk Assesment has been completed and approved', now(), null, 'admin', 'admin', now(), now(), '');

