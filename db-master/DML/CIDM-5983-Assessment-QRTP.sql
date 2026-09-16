
delete from cjams.assessmenttemplatecategoryfiltermap where assessmenttemplateid = '1d51c065-7733-4ff9-8a9b-7667019c86ca';
delete from cjams.assessmenttemplate where assessmenttemplateid = '1d51c065-7733-4ff9-8a9b-7667019c86ca';

INSERT INTO cjams.assessmenttemplate
(assessmenttemplateid, "name", description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate,  "timestamp", helptext, 
datamappingenabled, enableassessmentscore,external_templateid, isvisible,  notifywhencomplete, isrequired)
VALUES
('1d51c065-7733-4ff9-8a9b-7667019c86ca', 'placementreqestformpartb', 'desc', 1.00, 'QUALIFIED INDIVIDUAL (QI) ASSESSMENT - ATTACHMENT B', 'Center', 'instructions', 1, 
'CIDM-5983', now(), 'CIDM-5983', now(), now(), decode('20','hex'), 'helptext', 
true, true, '606b4bd8a4bf68001a52a9e8', true, false, false);

INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid,activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate, "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES(gen_random_uuid(), '1d51c065-7733-4ff9-8a9b-7667019c86ca', 1, 
'CIDM-5983', now(), 'CIDM-5983', now(), now(), true, '13be391c-de90-4ab1-bf07-515a431c3e9c'::uuid, '00000000-0000-0000-0000-000000000000'::uuid, '30c89758-0cc4-4b4a-92b6-df57819a178b' ::uuid, 'CW');