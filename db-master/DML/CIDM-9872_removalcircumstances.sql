DELETE FROM cjams.referencetype where referencetypeid = 1200;

DELETE FROM referencevalues WHERE referencetypeid = 1200;




INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(1200, 'removalcircumstances', 'removalcircumstances', 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('abandonment', 1200, 'Abandonment', 'Abandonment', 'CW', 1, 1, 'CIDM-8848', now(), 'CIDM-8848', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('caretakeralcoholuse', 1200, 'Caretaker’s Alcohol Use', 'Caretaker’s Alcohol Use', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('caretakerdruguse', 1200, 'Caretaker’s Drug Use', 'Caretaker’s Drug Use', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('caretakersignificantimpairment', 1200, 'Caretaker’s Significant Impairment-Cognitive', 'Caretaker’s Significant Impairment-Cognitive', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('caretakerignificantimpphysical', 1200, 'Caretaker’s Significant Impairment-Physical/Emotional', 'Caretaker’s Significant Impairment-Physical/Emotional', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('childalcoholuse', 1200, 'Child Alcohol Use', 'Child Alcohol Use', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('childbehaviorproblem', 1200, 'Child Behavior Problem', 'Child Behavior Problem', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('childdruguse', 1200, 'Child Drug Use', 'Child Drug Use', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('childrequestedplacement', 1200, 'Child Requested Placement', 'Child Requested Placement', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('deathofcaretaker', 1200, 'Death of Caretaker', 'Death of Caretaker', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('diagnosedcondition', 1200, 'Diagnosed Condition', 'Diagnosed Condition', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('domesticviolence', 1200, 'Domestic Violence', 'Domestic Violence', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('failuretoreturn', 1200, 'Failure to Return', 'Failure to Return', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('familyconflict', 1200, 'Family Conflict Related to Child’s Sexual Orientation, Gender Identity, or Gender Expression', 'Family Conflict Related to Child’s Sexual Orientation, Gender Identity, or Gender Expression', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('homelessness', 1200, 'Homelessness', 'Homelessness', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;







INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('inadequateaccesstomhs', 1200, 'Inadequate Access to Mental Health Services', 'Inadequate Access to Mental Health Services', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('inadequateaccesstomedicalservices', 1200, 'Inadequate Access to Medical Services', 'Inadequate Access to Medical Services', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('inadequatehousing', 1200, 'Inadequate Housing', 'Inadequate Housing', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('incarcerationofcaretaker', 1200, 'Incarceration of Caretaker', 'Incarceration of Caretaker', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('medicalneglect', 1200, 'Medical Neglect', 'Medical Neglect', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('neglect', 1200, 'Neglect', 'Neglect', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('parentalimmigration', 1200, 'Parental Immigration Detainment or Deportation', 'Parental Immigration Detainment or Deportation', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('physicalabuse', 1200, 'Physical Abuse', 'Physical Abuse', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('prenatalalcoholexposure', 1200, 'Prenatal Alcohol Exposure', 'Prenatal Alcohol Exposure', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('prenataldrugexposure', 1200, 'Prenatal Drug Exposure', 'Prenatal Drug Exposure', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('psychologicalemotionalabuse', 1200, 'Psychological or Emotional Abuse', 'Psychological or Emotional Abuse', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('publicagencytitleive', 1200, 'Public Agency Title IV-E Agreement', 'Public Agency Title IV-E Agreement', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('runawaynotes', 1200, 'Runaway', 'Runaway', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('sexualabuse', 1200, 'Sexual Abuse', 'Sexual Abuse', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('sextrafficking', 1200, 'Sex Trafficking', 'Sex Trafficking', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('tribaltitleive', 1200, 'Tribal Title IV-E Agreement', 'Tribal Title IV-E Agreement', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('voluntaryrelinquishment', 1200, 'Voluntary Relinquishment for Adoption', 'Voluntary Relinquishment for Adoption', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('whereaboutsunknown', 1200, 'Whereabouts Unknown', 'Whereabouts Unknown', 'CW', 1, 1, 'CIDM-9872', now(), 'CIDM-9872', now(), NULL, NULL, NULL)on conflict do nothing;





