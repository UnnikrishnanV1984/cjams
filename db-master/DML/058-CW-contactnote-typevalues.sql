DELETE FROM cjams.progressnotereasontype WHERE progressnotereasontypekey='PCVLMI';


INSERT INTO cjams.progressnotereasontype
(progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('PCV', 1, ' Parent Child Visit', '2018-10-10 19:51:51.114', NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.progressnotesubtype 
(progressnotetypeid,activeflag,description,insertedby,insertedon,updatedby,updatedon,effectivedate,expirationdate,old_id,progressnotesubtypekey)
 VALUES 
(NULL,1,'Incident Location','admin',now(),'admin',now(),now(),NULL,NULL,'INCLOC'),
(NULL,1,'Child Residence','admin',now(),'admin',now(),now(),NULL,NULL,'CHRES'),
(NULL,1,'Parent Residence','admin',now(),'admin',now(),now(),NULL,NULL,'PARES');


INSERT INTO cjams.progressnotetypeconfig
(progressnotetypekey, progressnotesubtypekey, teamtypekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id)
VALUES
('', 'INCLOC', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL, ''),
('', 'CHRES', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL, ''),
('', 'PARES', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL, '');