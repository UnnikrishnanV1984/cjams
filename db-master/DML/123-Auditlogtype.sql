delete from auditlogtype where logtypekey in ('IN035','NY005','NY006','NY015','NY009','NY016','NY017','WL015','WL019') and logtype in ('Education','Contact');

Insert INTO cjams.auditlogtype
(logtypekey, logtype, modulename, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id) values
('IN035', 'Education', 'Education modified', now() , NULL, 'admin', 'admin', now(), now(), NULL),
('NY005', 'Education', 'Education level is modified', now() , NULL, 'admin', 'admin', now(), now(), NULL),
('NY006', 'Education', 'Special Education is modified', now() , NULL, 'admin', 'admin', now(), now(), NULL),
('NY015', 'Education', 'Education info modified for in-active client.', now() , NULL, 'admin', 'admin', now(), now(), NULL),
('NY009', 'Contact', 'Race is modified', now() , NULL, 'admin', 'admin', now(), now(), NULL),
('NY016', 'Contact', 'Contact information is modified', now() , NULL, 'admin', 'admin', now(), now(), NULL),
('NY017', 'Contact', 'Address information is modified', now() , NULL, 'admin', 'admin', now(), now(), NULL),
('WL015', 'Contact', 'Contact viewed by worker', now() , NULL, 'admin', 'admin', now(), now(), NULL),
('WL019', 'Contact', 'Contact edited by worker', now() , NULL, 'admin', 'admin', now(), now(), NULL);