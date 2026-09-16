


delete from cjams.referencevalues where referencetypeid = 1000;
delete from cjams.referencetype where referencetypeid = 1000;


INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(1000, 'attachmenttypes', 'attachmenttypes', 1, 'CIDM-6863',  now(), 'CIDM-6863',  now(), NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('prot', 1000, 'Protection', 'Protection', 'CW', 1, 1, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL)on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cpsba', 1000, 'CPS Background/Adam Walsh Background Clearance Request', 'CPS Background/Adam Walsh Background Clearance Request', 'CW', 1, 1, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('staon', 1000, 'State’s Attorney Final Report Notification', 'State’s Attorney Final Report Notification', 'CW', 1, 1, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('lawon', 1000, 'Law Enforcement Notification', 'Law Enforcement Notification', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('inter', 1000, 'Intended Action Letter', 'Intended Action Letter', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('apprk', 1000, 'Appeal Paperwork', 'Appeal Paperwork', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('safan', 1000, 'Safety Plan', 'Safety Plan', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('recide', 1000, 'Receipt of Parent’s Guide', 'Receipt of Parent’s Guide', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('repect', 1000, 'Report of Suspected Child Abuse/Neglect (Form 180)', 'Report of Suspected Child Abuse/Neglect (Form 180)', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('planre', 1000, 'Plan of Safe Care', 'Plan of Safe Care', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cpsces', 1000, 'CPS Intake Clearances', 'CPS Intake Clearances', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('notorm', 1000, 'Notification of Substance Exposed Newborn Form', 'Notification of Substance Exposed Newborn Form', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('arner', 1000, 'AR Notification of Closing Letter', 'AR Notification of Closing Letter', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('irner', 1000, 'IR Notification of Closing Letter', 'IR Notification of Closing Letter', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'prot', NULL)on conflict do nothing;


















INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('medts', 1000, 'Medical/Dental Documents', 'Medical/Dental Documents', 'CW', 1, 1, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL)on conflict do nothing;





INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('annam', 1000, 'Annual Exam/EPSDT Exam', 'Annual Exam/EPSDT Exam', 'CW', 1, 1, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('denam', 1000, 'Dental Exam', 'Dental Exam', 'CW', 1, 1, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('visam', 1000, 'Vision Exam', 'Vision Exam', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('iniam', 1000, 'Initial Medical Exam', 'Initial Medical Exam', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('comxam', 1000, 'Comprehensive Exam', 'Comprehensive Exam', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('speam', 1000, 'Specialist Exam', 'Specialist Exam', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('folxam', 1000, 'Follow-up Medical Exam', 'Follow-up Medical Exam', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('behrds', 1000, 'Behavioral Health Records', 'Behavioral Health Records', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('hosary', 1000, 'Hospital Discharge Summary', 'Hospital Discharge Summary', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('heaort', 1000, 'Health Passport', 'Health Passport', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('heaorm', 1000, 'Health Care Services Authorization Form', 'Health Care Services Authorization Form', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('otherds', 1000, 'Other Medical Records', 'Other Medical Records', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'medts', NULL)on conflict do nothing;








INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('consent', 1000, 'Consents', 'Consents', 'CW', 1, 3, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('contion', 1000, 'Consent for Release of Information', 'Consent for Release of Information', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'consent', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('psyent', 1000, 'Psychotropic Medication Informed Consent', 'Psychotropic Medication Informed Consent', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'consent', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othtry', 1000, 'Other Consent', 'Other Consent', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'consent', NULL) on conflict do nothing;








INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('Court', 1000, 'Court', 'Court', 'CW', 1, 4, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('sheon', 1000, 'Shelter Petition', 'Shelter Petition', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('sheder', 1000, 'Shelter Care Order', 'Shelter Care Order', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cinaon', 1000, 'CINA Petition', 'CINA Petition', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('adjder', 1000, 'Adjudication / Disposition Court Order', 'Adjudication / Disposition Court Order', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('perder', 1000, 'Permanency Planning Review Hearing Court Order', 'Permanency Planning Review Hearing Court Order', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('tprtion', 1000, 'TPR Petition', 'TPR Petition', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('tprder', 1000, 'TPR Court Order', 'TPR Court Order', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ottry', 1000, 'Other Court Order or Document', 'Other Court Order or Document', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('noting', 1000, 'Notification of Court Hearing', 'Notification of Court Hearing', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('perorr', 1000, 'Permanency Planning Hearing Court Order', 'Permanency Planning Hearing Court Order', 'CW', 1, null, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Court', NULL) on conflict do nothing;










INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('assnts', 1000, 'Assessments', 'Assessments', 'CW', 1, 5, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('subent', 1000, 'Substance Use Assessment', 'Substance Use Assessment', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'assnts', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('homeent', 1000, 'Home Health Assessment', 'Home Health Assessment', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'assnts', NULL) on conflict do nothing;







INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('edution', 1000, 'Education', 'Education', 'CW', 1, 6, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('bestorm', 1000, 'Best Interest Determination Form', 'Best Interest Determination Form', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'edution', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('enrion', 1000, 'Enrollment Documentation', 'Enrollment Documentation', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'edution', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('repard', 1000, 'Report Card', 'Report Card', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'edution', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('iep', 1000, 'IEP', 'IEP', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'edution', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('504plan', 1000, '504 Plan', '504 Plan', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'edution', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('eduort', 1000, 'Education Progress Report', 'Education Progress Report', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'edution', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('poston', 1000, 'Post-Secondary Documentation', 'Post-Secondary Documentation', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'edution', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('Other1', 1000, 'Other', 'Other', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'edution', NULL) on conflict do nothing;





INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('titiv', 1000, 'Title IV-E', 'Title IV-E', 'CW', 1, 7, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ivents', 1000, 'IV-E Supporting Documents', 'IV-E Supporting Documents', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'titiv', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ivetion', 1000, 'IV-E Initial Eligibility Documentation', 'IV-E Initial Eligibility Documentation', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'titiv', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('iverede', 1000, 'IV-E Redetermination', 'IV-E Redetermination', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'titiv', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ivement', 1000, 'IV-E Applicable Child Assessment', 'IV-E Applicable Child Assessment', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'titiv', NULL) on conflict do nothing;










INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('childon', 1000, 'Child Personal Information', 'Child Personal Information', 'CW', 1, 8, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('socard', 1000, 'Social Security Card', 'Social Security Card', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('birate', 1000, 'Birth Certificate', 'Birth Certificate', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('curoto', 1000, 'Current Child Photo', 'Current Child Photo', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('socary', 1000, 'Social Summary', 'Social Summary', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('socest', 1000, 'Social Security (Federal Form SS-5)/Birth Certificate Replacement Request', 'Social Security (Federal Form SS-5)/Birth Certificate Replacement Request', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('not224', 1000, 'Notification to Child’s Counsel for Title II and Title XVI Benefits (DHR/SSA 224)', 'Notification to Child’s Counsel for Title II and Title XVI Benefits (DHR/SSA 224)', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('reqyee', 1000, 'Request to be Selected as Representative Payee (SSA 11-BK)', 'Request to be Selected as Representative Payee (SSA 11-BK)', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cons827', 1000, 'Consent to Release Information (SSA 827)', 'Consent to Release Information (SSA 827)', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('appo96', 1000, 'Appointment of Representative Form (SSA 1696)', 'Appointment of Representative Form (SSA 1696)', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('rep234', 1000, 'Representative Payee Report (SSA 6234)', 'Representative Payee Report (SSA 6234)', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('rep623', 1000, 'Representative Payee Report of Benefits & Dedicated Account (SSA 6233)', 'Representative Payee Report of Benefits & Dedicated Account (SSA 6233)', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('refram', 1000, 'Referral for Disability Benefits Advocacy Program', 'Referral for Disability Benefits Advocacy Program', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('Other2', 1000, 'Other', 'Other', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'childon', NULL) on conflict do nothing;









INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('Other', 1000, 'Other', 'Other', 'CW', 1, 9, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('birary', 1000, 'Birth Match Summary', 'Birth Match Summary', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Other', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('purice', 1000, 'Purchase Authorization/ Invoice', 'Purchase Authorization/ Invoice', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Other', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('tralan', 1000, 'Transportation Plan', 'Transportation Plan', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Other', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('other4', 1000, 'Other', 'Other', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, 'Other', NULL) on conflict do nothing;







INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('1080es', 1000, '1080 Notification Series', '1080 Notification Series', 'CW', 1, 10, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, NULL, NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('chiity', 1000, 'Child Fatality', 'Child Fatality', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, '1080es', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('serury', 1000, 'Serious Physical Injury', 'Serious Physical Injury', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, '1080es', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('criopt', 1000, 'Critical Incident Report', 'Critical Incident Report', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, '1080es', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('runway', 1000, 'Runaway', 'Runaway', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, '1080es', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('pubecy', 1000, 'Public Health Emergency', 'Public Health Emergency', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, '1080es', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cfspi', 1000, 'CF/SPI/CI Notification Email', 'CF/SPI/CI Notification Email', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, '1080es', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('raptes', 1000, 'Rapid Response Review Team Minutes', 'Rapid Response Review Team Minutes', 'CW', 1, NULL, 'CIDM-6863', now(), 'CIDM-6863', now(), NULL, '1080es', NULL) on conflict do nothing;



