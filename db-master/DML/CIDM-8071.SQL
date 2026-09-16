delete from cjams.referencetype where referencetypeid = 500120;
INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500120,'targetedsymptoms', 'targetedsymptoms', 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL);

delete from cjams.referencevalues where referencetypeid = 500120;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IRR', 500120, 'Irritability', 'Irritability', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('AGG', 500120, 'Aggression', 'Aggression', 'CW', 1, 2, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('IMP', 500120, 'Impulsivity', 'Impulsivity', 'CW', 1, 3, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('SLD', 500120, 'Sleep Disturbance', 'Sleep Disturbance', 'CW', 1, 4, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('HAL', 500120, 'Hallucinations', 'Hallucinations', 'CW', 1, 5, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('DEL', 500120, 'Delusion', 'Delusion', 'CW', 1, 6, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('DEP', 500120, 'Depression', 'Depression', 'CW', 1, 7, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('HYP', 500120, 'Hyperactivity', 'Hyperactivity', 'CW', 1, 8, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('ANX', 500120, 'Anxiety', 'Anxiety', 'CW', 1, 9, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('MAN', 500120, 'Manic Episode', 'Manic Episode', 'CW', 1, 10, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('SIB', 500120, 'Self-Injurious Behavior', 'Self-Injurious Behavior', 'CW', 1, 11, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('MOI', 500120, 'Mood Instability', 'Mood Instability', 'CW', 1, 12, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('OTH', 500120, 'Other', 'Other', 'CW', 1, 13, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL);

delete from cjams.referencetype where referencetypeid = 500121;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500121,'informedconsent', 'informedconsent', 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL);

delete from cjams.referencevalues where referencetypeid = 500121;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LDP', 500121, 'LDSS provided informed consent', 'LDSS provided informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('LDD', 500121, 'LDSS denied informed consent', 'LDSS denied informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('CPI', 500121, 'Court provided informed consent', 'Court provided informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('BPP', 500121, 'Biological parent provided informed consent', 'Biological parent provided informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('BPD', 500121, 'Biological parent denied informed consent', 'Biological parent denied informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('YAU', 500121, 'Youth assented - ages 16 and under', 'Youth assented - ages 16 and under', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('YRS', 500121, 'Youth refused to sign - ages 16 and under', 'Youth refused to sign - ages 16 and under', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('YPC', 500121, 'Youth provided consent - 16 and older', 'Youth provided consent - 16 and older', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('YRC', 500121, 'Youth refused to consent - 16 and older', 'Youth refused to consent - 16 and older', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL);

update cjams.referencevalues set displayorder=null, updatedby='CIDM-8071',updatedon=now()
 where referencetypeid=500120;

--for document
delete from cjams.referencevalues where referencetypeid = 1000 and ref_key='infocon';

