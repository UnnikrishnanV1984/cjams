


delete from referencevalues where ref_key='CACCTRANS';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey)
VALUES('CACCTRANS', 46, 'Child Transation Error Correction', 'Child Transation Error Correction', 'FNS', 1, 1, 'Admin', '2019-01-02 19:12:40.434', NULL, '2019-01-02 19:12:40.434', NULL, NULL);

delete from routingstatustype  where sequencenumber = 81;
INSERT INTO routingstatustype (sequencenumber,routingstatustypekey,activeflag,typedescription,effectivedate,expirationdate,"timestamp",insertedby,updatedby,insertedon,updatedon,old_id) VALUES 
(81,'CACCERROR',1,'Child Transation Error Correction','2018-12-28 17:16:15.740',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

delete from routingstatustype  where sequencenumber = 82;
INSERT INTO routingstatustype (sequencenumber,routingstatustypekey,activeflag,typedescription,effectivedate,expirationdate,"timestamp",insertedby,updatedby,insertedon,updatedon,old_id) VALUES 
(82,'CACCERRORAPRV',1,'Child Transation Error Correction Approval','2018-12-28 17:16:15.740',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

delete from routingstatustype  where sequencenumber = 83;
INSERT INTO routingstatustype (sequencenumber,routingstatustypekey,activeflag,typedescription,effectivedate,expirationdate,"timestamp",insertedby,updatedby,insertedon,updatedon,old_id) VALUES 
(83,'CACCERRORREJ',1,'Child Transation Error Correction Rejection','2018-12-28 17:16:15.740',NULL,NULL,NULL,NULL,NULL,NULL,NULL);


delete from routingconfig where eventcode='CACCTRANS';
INSERT INTO routingconfig
( eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id)
VALUES( 'CACCTRANS','FNSFS' , 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'FNSFN', NULL);



update roletype set shortname= 'FW' where roletypecode in ('FW');
update roletype set shortname= 'FS' where roletypecode in ('FS');
update roletype set shortname= 'DF' where roletypecode in ('DF');

update role set "name" = 'FW' where roletypekey in ('FNSFW');
update role set "name" = 'FS' where roletypekey in ('FNSFS');
update role set "name" = 'DF' where roletypekey in ('FNSDF');

update routingconfig set principaltype = 'USER' where eventcode ='PCAUTH'; 

delete from routingconfig where routingconfigid in ('da0e3ca3-8314-4b37-ae0c-892b8bf4d55f','ace18e67-5591-4800-ac13-4b4a732e141f','946965b1-542a-4dae-9dd4-95c07a517b76','b267a6bb-1c4d-4f0c-a3e3-f33823bbb5f5');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('946965b1-542a-4dae-9dd4-95c07a517b76', 'PCAUTH', 'FNSFW', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'CWSP', NULL, NULL,'ROLE');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('b267a6bb-1c4d-4f0c-a3e3-f33823bbb5f5', 'PCAUTH', 'FNSFW', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'FNSDF', NULL, NULL,'ROLE');

INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('da0e3ca3-8314-4b37-ae0c-892b8bf4d55f', 'PCAUTH', 'FNSFS', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'FNSFW', NULL, NULL,'ROLE');

INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('ace18e67-5591-4800-ac13-4b4a732e141f', 'PCAUTHR', 'FNSFS', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'FNSFW', NULL, NULL,'ROLE');


delete from routingconfig where eventcode ='PCAUTHR';
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('fb6545d1-0a14-46ca-98c0-a2a2a88606f6', 'PCAUTHR', 'FNSFW', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'CWSP', NULL, NULL,'ROLE');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('55669a5b-ee0a-4d4c-899b-00c744663209', 'PCAUTHR', 'FNSFW', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'FNSDF', NULL, NULL,'ROLE');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('24671121-c1b5-486d-8fe6-8cc1d45200ad', 'PCAUTHR', 'CWSP', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'CWCW', NULL, null,'ROLE');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('9ff807d5-79b8-41a3-8260-03c981ecb00d', 'PCAUTHR', 'FNSFS', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'CWSP', NULL, NULL,'ROLE');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('585bf731-de79-45b2-b060-b39db8f29cc0', 'PCAUTHR', 'FNSFS', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'FNSDF', NULL, NULL,'ROLE');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('b23cbcce-d13e-4599-973c-97be692d43da', 'PCAUTHR', 'FNSDF', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'CWSP', NULL, NULL,'ROLE');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('334c68c2-8666-4def-8fa8-1530308c3a17', 'PCAUTHR', 'FNSFS', 1, 'admin', '2019-03-08 18:09:20.213', 'admin', '2019-03-08 18:09:20.213', '2019-03-08 18:09:20.213', NULL, NULL, 'FNSFS', NULL, NULL,'ROLE');

