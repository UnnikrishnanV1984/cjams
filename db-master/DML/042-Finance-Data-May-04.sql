delete from routingconfig where routingconfigid ='217e16a3-c2f6-451b-b038-c5d3c25a5642';
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('217e16a3-c2f6-451b-b038-c5d3c25a5642', 'PCAUTHR', 'FNSFS', 1, 'admin', '2019-03-08 18:09:20.213', 'admin', '2019-03-08 18:09:20.213', '2019-03-08 18:09:20.213', NULL, NULL, 'FNSFN', NULL, NULL, 'ROLE');


update programcategorylink set activeflag =1 where programcategorylinkid in ('3424ba69-1490-49b2-90a8-e855ac3e6ce0','53b46a4d-c270-4649-84db-3e21c0aa3be7');

update roletype set roletypename ='LDSS Director' where roletypecode = 'DF';

update teammemberroletype set description ='LDSS Director' where roletypekey = 'FNSDF';