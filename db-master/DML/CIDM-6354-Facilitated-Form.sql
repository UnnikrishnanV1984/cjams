delete from cjams.assessmenttemplatecategoryfiltermap where assessmenttemplateid = '1ce7d8ae-e13f-4ed3-a074-ea203935a1aa';
delete from cjams.assessmenttemplate where assessmenttemplateid = '1ce7d8ae-e13f-4ed3-a074-ea203935a1aa';

INSERT INTO cjams.assessmenttemplate
(assessmenttemplateid, "name", description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate,  "timestamp", helptext, 
datamappingenabled, enableassessmentscore,external_templateid, isvisible,  notifywhencomplete, isrequired)
VALUES
('1ce7d8ae-e13f-4ed3-a074-ea203935a1aa', 'facilitatedmeetingreferralform', 'desc', 1.00, 'FACILITATED MEETING REFERRAL FORM', 'Center', 'instructions', 1, 
'CIDM-6354', now(), 'CIDM-6354', now(), now(), decode('20','hex'), 'helptext', 
true, true, '606b4bd8a4bf68001a52a9e9', true, false, false);

INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid,activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate, "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES(gen_random_uuid(), '1ce7d8ae-e13f-4ed3-a074-ea203935a1aa', 1, 
'CIDM-6354', now(), 'CIDM-6354', now(), now(), true, '13be391c-de90-4ab1-bf07-515a431c3e9c'::uuid, '00000000-0000-0000-0000-000000000000'::uuid, '30c89758-0cc4-4b4a-92b6-df57819a178b' ::uuid, 'CW');