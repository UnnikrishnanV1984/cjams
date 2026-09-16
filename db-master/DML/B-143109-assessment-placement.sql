

delete from cjams.assessmenttemplatecategoryfiltermap where assessmenttemplateid = 'c4f65492-c7ec-40d2-8e1d-3c3e2c3e26ff';
delete from cjams.assessmenttemplate where assessmenttemplateid = 'c4f65492-c7ec-40d2-8e1d-3c3e2c3e26ff';

INSERT INTO cjams.assessmenttemplate
(assessmenttemplateid, "name", description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate,  "timestamp", helptext, 
datamappingenabled, enableassessmentscore,external_templateid, isvisible,  notifywhencomplete, isrequired)
VALUES
('c4f65492-c7ec-40d2-8e1d-3c3e2c3e26ff', 'placementreqestform', 'desc', 1.00, 'PLACEMENT REQUEST FORM - ATTACHMENT A', 'Center', 'instructions', 1, 
'B-143109', now(), 'B-143109', now(), now(), decode('20','hex'), 'helptext', 
true, true, '606b4bd8a4bf68001a52a9e7', true, false, false);

INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid,activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate, "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES(gen_random_uuid(), 'c4f65492-c7ec-40d2-8e1d-3c3e2c3e26ff', 1, 
'B-143109', now(), 'B-143109', now(), now(), true, '13be391c-de90-4ab1-bf07-515a431c3e9c'::uuid, '00000000-0000-0000-0000-000000000000'::uuid, '30c89758-0cc4-4b4a-92b6-df57819a178b' ::uuid, 'CW');