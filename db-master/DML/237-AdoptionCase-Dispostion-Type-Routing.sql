delete from servicerequesttypeconfigdispositioncode where servicerequesttypeconfigid='503693c5-d544-452f-b531-5138a7a266cc';

delete from servicerequesttypeconfig where servicerequesttypeconfigid='503693c5-d544-452f-b531-5138a7a266cc';

delete from servicerequestsubtype where intakeservreqtypeid='cc4561c8-2fc5-4e3b-8876-4803517d9fc0';

delete from intakeservicerequesttype where intakeservreqtypekey='adoptioncase';

delete from referencevalues where ref_key='ACDR' and referencetypeid=46;

delete from routingconfig where eventcode='ACDR';



INSERT INTO intakeservicerequesttype
(intakeservreqtypeid, intakeservreqtypekey, description, insertedby, insertedon, updatedby, updatedon, archiveon, archiveby, "timestamp", workloadweight, investigatable, activeflag, old_id, sequencenumber)
VALUES('cc4561c8-2fc5-4e3b-8876-4803517d9fc0', 'adoptioncase', 'Adoption Case', 'admin', now(), 'admin', now(), NULL, NULL, NULL, 0, true, 1, NULL, NULL);



INSERT INTO servicerequestsubtype
(servicerequestsubtypeid, intakeservreqtypeid, classkey, description, insertedby, insertedon, updatedby, updatedon, "timestamp", workloadweight, investigatable, activeflag, isvisible, old_id)
VALUES('1aa590f2-dfbd-46f2-9895-e0c99214895f', 'cc4561c8-2fc5-4e3b-8876-4803517d9fc0', 'Default', 'Default', 'admin', now(), 'admin', now(), NULL, 0, true, 1, true, NULL);


INSERT INTO servicerequesttypeconfig
(servicerequesttypeconfigid, intakeservreqtypeid, servicerequestsubtypeid, activeflag, intakeservicerequestplantypekey, workload, internalfile, duedateoffset, limitedrouting, intakeserreqstatustypeid, focusroletype, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, category, displaydatype, displaydasubtype, focusentitytype, isreviewrequired, old_id)
VALUES('503693c5-d544-452f-b531-5138a7a266cc', 'cc4561c8-2fc5-4e3b-8876-4803517d9fc0', '00000000-0000-0000-0000-000000000000', 1, 'INV', 0, NULL, 365, NULL, NULL, NULL, 'admin', now(), 'admin', now(), now(), NULL, 'Intake', NULL, NULL, NULL, true, NULL);


INSERT INTO servicerequesttypeconfigdispositioncode
(servicerequesttypeconfigiddispostionid, servicerequesttypeconfigid, dispositioncode, description, intakeserreqstatustypeid, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", isallowappeal, appealdurationdays, recommendationtype, old_id, roletypekey)
VALUES('c8350bf2-beb6-4a4b-b2f7-5e8d7a5de4fa', '503693c5-d544-452f-b531-5138a7a266cc', 'Closed', 'Close Case', '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, false, NULL, 'Final', NULL, NULL);


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ACDR', 46, 'Adoptioncase Disposiotion Review', 'Adoptioncase Disposiotion Review', NULL, 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);



INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('bd4d97cc-428e-4445-a71b-e761e036c957', 'ACDR', 'CWSP', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'CWCW', NULL, NULL, NULL, NULL);

INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('3d520da6-d157-45ba-beb3-6f3c82e578de', 'ACDR', 'CWSP', 1, 'admin', now(), NULL, now(), now(), NULL, NULL, 'CWSP', NULL, NULL, NULL, NULL);
