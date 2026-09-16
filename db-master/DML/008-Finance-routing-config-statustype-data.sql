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

delete from routingconfig where eventcode='CACCTRANS';
INSERT INTO routingconfig
( eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id)
VALUES( 'CACCTRANS','FNSFS' , 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'FNSFW', NULL);
