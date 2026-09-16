--------------------------------------------------------------------------------------------------
-- 04/25/2024 prasanna sai kommineni - CIDM-10420 Quick Youth Indicators for Trafficking (QYIT)

-----------------------------------------------------------------------------------------------------

delete from cjams.assessmenttemplatecategoryfiltermap where assessmenttemplateid='c0d60a15-b3ac-4063-a56c-4a2083fc76ce' ;

delete from cjams.assessmenttemplateroleconfig where assessmenttemplateid='c0d60a15-b3ac-4063-a56c-4a2083fc76ce' 
and assessmenttemplateroleconfigid='01bb065c-cf33-4936-aabf-fde9c533f20f';

delete from cjams.assessment_history where assessmenttemplateid='c0d60a15-b3ac-4063-a56c-4a2083fc76ce';

delete from assessmentcomments 
where assessmentid in 
(select assessmentid from cjams.assessment 
where assessmenttemplateid='c0d60a15-b3ac-4063-a56c-4a2083fc76ce');

delete from cjams.assessment where assessmenttemplateid='c0d60a15-b3ac-4063-a56c-4a2083fc76ce';


delete from cjams.assessmenttemplate where assessmenttemplateid='c0d60a15-b3ac-4063-a56c-4a2083fc76ce';

INSERT INTO cjams.assessmenttemplate
(assessmenttemplateid, "name", description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", helptext, datamappingenabled, enableassessmentscore, scoringname, calculationmethod, assessmentscoresetupid, external_templateid, isvisible, duedays, ismandatory, targetroletypekey, notifywhencomplete, isrequired)
VALUES('c0d60a15-b3ac-4063-a56c-4a2083fc76ce', 'qyit', 'desc', 1.00, 'Quick Youth Indicators for Trafficking (QYIT)', 'Center', 'instructions', 1, 'CIDM-10420', now(), 'CIDM-10420', now(), now(), NULL, NULL, decode('20','hex'), 'helptext', true, true, NULL, NULL, NULL, '2b4f455a-b4c5-4f41-9353-685e7850f2ef', true, NULL, NULL, NULL, false, false);
                   

INSERT INTO cjams.assessmenttemplateroleconfig
(assessmenttemplateroleconfigid, assessmenttemplateid, teamtypekey, roletypecode, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('01bb065c-cf33-4936-aabf-fde9c533f20f', 'c0d60a15-b3ac-4063-a56c-4a2083fc76ce', 'CW', 'CW', 1, 'CIDM-10420', now(), 'CIDM-10420', now(), now(), NULL);


INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('315efdd7-6b35-4cbd-98bb-061bd2972079', 'c0d60a15-b3ac-4063-a56c-4a2083fc76ce', NULL, 1, 'CIDM-10420', now(), 'CIDM-10420', now(), now(), NULL, ' ', decode('20','hex'), true, '13be391c-de90-4ab1-bf07-515a431c3e9c', '00000000-0000-0000-0000-000000000000', '30c89758-0cc4-4b4a-92b6-df57819a178b', 'CW');


INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid,activeflag, 
insertedby, insertedon, updatedby, updatedon, effectivedate, "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES(gen_random_uuid(), 'c0d60a15-b3ac-4063-a56c-4a2083fc76ce', 1, 
'CIDM-10420', now(), 'CIDM-10420', now(), now(), true, '00000000-0000-0000-0000-000000000000'::uuid, '00000000-0000-0000-0000-000000000000'::uuid, '2a999e91-c11f-4da0-8e46-ae934cd59ea2' ::uuid, 'CW');
             




