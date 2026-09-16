/*
Issue: CJAMS-63838 need to add addendum to contact note on closed case
Category/Module: Contact Notes
Root cause: Case 251023135962 has already been closed need to add below langauage to the contact id 15527102
            SW did not assess Josiah Christy during this period as he does not live in the home of Mona West, but instead lives with his father Justice Black.
Fix provided: Data fix needed to add addendum notes to the closed case 251023135962 for contact id 15527102
Data/Code fix ticket#: CJAMS-63838
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Case is already closed and data fix is needed.
*/

INSERT INTO cjams.progressnotedetail
(progressnotedetailid, progressnoteid, description, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", old_id, isaddendum, fk_user_id, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'b33ec473-cbc6-4f1b-9d8e-f490be041357'::uuid, '<p>SW did not assess Josiah Christy during this period as he does not live in the home of Mona West, but instead lives with his father Justice Black.<p>', 1, '2025-12-02 10:30:00.000', NULL, 'c078eed8-fab6-490d-b099-47f9b968a5dc', now(), 'CJAMS-63838', now(), NULL, NULL, 1, NULL, NULL, NULL);
