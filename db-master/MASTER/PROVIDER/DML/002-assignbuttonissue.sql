update teammemberroletype set teamtypekey='PVPROV' where roletypekey  in ('LDSSDD',
'LDSSSP',
'LDSSRW',
'LDSSHSW',
'LDSSRT');

delete from routingconfig where routingconfigid in ('998716d8-aec4-4562-bfef-1c486156a1d9','0741de91-b0e6-4bca-8632-55bfb3ea2508');
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('998716d8-aec4-4562-bfef-1c486156a1d9', 'PRASS', 'LDSSSP', 1, 'admin', '2019-05-29 17:28:49.478', NULL, '2019-05-29 17:28:49.478', '2019-05-29 17:28:49.478', NULL, NULL, 'LDSSRW', NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('0741de91-b0e6-4bca-8632-55bfb3ea2508', 'PRASS', 'LDSSSP', 1, 'admin', '2019-05-29 17:28:49.478', NULL, '2019-05-29 17:28:49.478', '2019-05-29 17:28:49.478', NULL, NULL, 'LDSSHSW', NULL, NULL, NULL);


delete from referencevalues where referencetypeid=46 and ref_key='PRASS';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey)
VALUES('PRASS', 46, 'Assigning Inquiry to Supervisor', 'Assigning Inquiry to Supervisor', 'LDSS', 1, 1, 'Admin', now(), NULL, now(), NULL, NULL);

delete from routingstatustype where sequencenumber=84 and routingstatustypekey='PRASSA';
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(84, 'PRASSA', 1, 'Provider Inquiry Accepted', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

delete from routingconfig where routingconfigid in ('f2ae784b-fe3c-4057-ad91-f0934e9b68a8','fd161523-cc8f-4a9a-bbf2-44ecbf71edd1');
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('f2ae784b-fe3c-4057-ad91-f0934e9b68a8', 'PRRWHW', 'LDSSHSW', 1, 'admin', '2019-05-29 18:30:43.013', NULL, '2019-05-29 18:30:43.013', '2019-05-29 18:30:43.013', NULL, NULL, 'LDSSSP', NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('fd161523-cc8f-4a9a-bbf2-44ecbf71edd1', 'PRRWHW', 'LDSSRW', 1, 'admin', '2019-05-29 18:30:55.359', NULL, '2019-05-29 18:30:55.359', '2019-05-29 18:30:55.359', NULL, NULL, 'LDSSSP', NULL, NULL, NULL);


delete from referencevalues where referencetypeid=46 and ref_key='PRRWHW';
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PRRWHW', 46, 'Assign Inquiry to worker', 'Assign Inquiry to worker', 'LDSS', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);


delete from routingconfig where routingconfigid in ('3e213488-517f-48ca-a218-41f206e1238c','28207f61-3d90-4911-9045-ed0c4d3b768c');
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('3e213488-517f-48ca-a218-41f206e1238c', 'PRWS', 'LDSSHSW', 1, 'admin', '2019-05-31 17:32:41.484', NULL, '2019-05-31 17:32:41.484', '2019-05-31 17:32:41.484', NULL, NULL, 'LDSSSP', NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('28207f61-3d90-4911-9045-ed0c4d3b768c', 'PRWS', 'LDSSSP', 1, 'admin', '2019-05-31 17:32:43.116', NULL, '2019-05-31 17:32:43.116', '2019-05-31 17:32:43.116', NULL, NULL, 'LDSSHSW', NULL, NULL, NULL);

alter table tb_provider_applicant_services drop column if exists applicant_service_id;
alter table tb_provider_applicant_services add column if not exists applicant_service_id uuid;
ALTER TABLE tb_provider_applicant_services ALTER COLUMN applicant_service_id SET DEFAULT gen_random_uuid();
update roletype set roletypename='Resource Worker' where roletypeid='d4ef2998-5f10-477a-a1e2-b48d11ead1d8';
update roletype set roletypename='Home Study Worker' where roletypeid='33052091-95ed-4a70-b3fa-4ada61165a0b';

delete from routingstatustype where sequencenumber=87;
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(87, 'PRRHSWA', 1, 'Restricted home', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);