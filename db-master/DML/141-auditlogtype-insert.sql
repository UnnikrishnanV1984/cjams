update auditlogtype set logtype='Profile' where logtypekey='NY009';

delete from  auditlogtype where logtypekey in ('NY010','NY011');

INSERT INTO auditlogtype
( logtypekey, logtype, modulename, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES( 'NY010', 'Ethnicity', 'Hispanic or Latino Ethnicity is modified',  now(), NULL, 'admin', 'admin',  now(),  now(), NULL);
INSERT INTO auditlogtype
( logtypekey, logtype, modulename, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES( 'NY011', 'Profile', 'Demo info is modified for in-active client.',  now(), NULL, 'admin', 'admin',  now(),  now(), NULL);
