--CIDM-9564-UPDATE-LAP-STORY

delete from cjams.assessmenttemplatecategoryfiltermap where assessmenttemplateid = '0e17ebd8-57dc-41bc-b51f-ac95103b9542';
delete from cjams.assessmenttemplate where assessmenttemplateid = '0e17ebd8-57dc-41bc-b51f-ac95103b9542';


INSERT INTO cjams.assessmenttemplate
(assessmenttemplateid, "name", description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate,  "timestamp", helptext, 
datamappingenabled, enableassessmentscore,external_templateid, isvisible,  notifywhencomplete, isrequired)
VALUES
('0e17ebd8-57dc-41bc-b51f-ac95103b9542', 'lapassessmentform', 'desc', 1.00, 'LAP (Lethality Assessment Program)', 'Center', 'instructions', 1, 
'CIDM-9564', now(), 'CIDM-9564', now(), now(), decode('20','hex'), 'helptext', 
true, true, '606b4bd8a4bf68001a52a8e9', true, false, false);


INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid,activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate, "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES(gen_random_uuid(), '0e17ebd8-57dc-41bc-b51f-ac95103b9542', 1, 
'CIDM-9564', now(), 'CIDM-9564', now(), now(), true, '13be391c-de90-4ab1-bf07-515a431c3e9c'::uuid, '00000000-0000-0000-0000-000000000000'::uuid, '30c89758-0cc4-4b4a-92b6-df57819a178b' ::uuid, 'CW');


INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid,activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate, "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES(gen_random_uuid(), '0e17ebd8-57dc-41bc-b51f-ac95103b9542', 1, 
'CIDM-9564', now(), 'CIDM-9564', now(), now(), true, '00000000-0000-0000-0000-000000000000'::uuid, '00000000-0000-0000-0000-000000000000'::uuid, '2a999e91-c11f-4da0-8e46-ae934cd59ea2' ::uuid, 'CW');