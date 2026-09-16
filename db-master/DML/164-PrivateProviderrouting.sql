

delete from routingconfig where eventcode='PRVTPR';
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('c25092cd-a73e-4add-aa52-10da92dd587b', 'PRVTPR', 'OLMLA', 1, 'admin', '2019-07-25 16:10:51.728', NULL, '2019-07-25 16:10:51.728', '2019-07-25 16:10:51.728', NULL, NULL, 'PPROSA', NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('4e2da4ec-0c3a-4521-87d0-c7096c389fe9', 'PRVTPR', 'OLMPM', 1, 'admin', '2019-07-25 17:01:28.922', NULL, '2019-07-25 17:01:28.922', '2019-07-25 17:01:28.922', NULL, NULL, 'OLMLA', NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('41bc5719-bdde-48b9-bde6-8ed88f818a47', 'PRVTPR', 'OLMDD', 1, 'admin', '2019-07-25 17:02:12.221', NULL, '2019-07-25 17:02:12.221', '2019-07-25 17:02:12.221', NULL, NULL, 'OLMPM', NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('65ebd90a-b195-44d3-82d9-a622e4ac8d16', 'PRVTPR', 'OLMED', 1, 'admin', '2019-07-25 17:02:45.883', NULL, '2019-07-25 17:02:45.883', '2019-07-25 17:02:45.883', NULL, NULL, 'OLMDD', NULL, NULL, NULL, NULL);

delete from referencevalues where ref_key='PRVTPR' and referencetypeid=46;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey)
VALUES('PRVTPR', 46, 'Private provider routing', 'Private proviver routing', 'OLM', 1, 1, 'Admin', now(), NULL, now(), NULL, NULL);

