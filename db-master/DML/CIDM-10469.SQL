

delete from cjams.referencetype where referencetypeid=500700;

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(500700, 'Authorized HCDM', 'Authorized HCDM', 1, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL);

delete from cjams.referencetype where referencetypeid=500701;

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(500701, 'Health Care Decision Maker', 'Health Care Decision Maker', 1, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL);

delete from cjams.referencevalues where referencetypeid=500700;

delete from cjams.referencevalues where referencetypeid=500701;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HCDM_PAR', 500700, 'Parent', 'Parent', NULL, 1, 1, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HCDM_LDD', 500700, 'LDSS Director', 'LDSS Director', NULL, 1, 2, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HCDM_LDAD', 500700, 'LDSS Assistant Director', 'LDSS Assistant Director', NULL, 1, 3, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HCDM_LDS', 500700, 'LDSS Designee', 'LDSS Designee', NULL, 1, 4, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HCDM_AUG', 500700, 'Authorized Guardian', 'Authorized Guardian', NULL, 1, 5, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HCDM_YOU', 500700, 'Youth', 'Youth', NULL, 1, 6, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HCDM_OTH', 500700, 'Other', 'Other', NULL, 1, 7, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PAR', 500701, 'Parent(s) or Legal Guardian', 'Parent(s) or Legal Guardian', NULL, 1, 1, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('YOU', 500701, 'Youth', 'Youth', NULL, 1, 2, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LDSS', 500701, 'LDSS', 'LDSS', NULL, 1, 3, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AAAC', 500701, 'Another Adult Authorized by Court', 'Another Adult Authorized by Court', NULL, 1, 4, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('EA', 500701, 'Emergency Authorization', 'Emergency Authorization', NULL, 1, 5, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

delete from cjams.referencevalues where referencetypeid=500120 and value_text in ('Attention/ concentration','Behavior problems','Compulsions','Cutting/ non-suicidal self-injury',
'Dissociation','Obsessive thoughts','Sleep problems','Suicidal thoughts/ gestures','Suicide attempt','Tics (motor/ vocal)');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ACT', 500120, 'Attention/ concentration', 'Attention/ concentration', 'CW', 1, 3, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BPR', 500120, 'Behavior problems', 'Behavior problems', 'CW', 1, 4, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('COB', 500120, 'Compulsions', 'Compulsions', 'CW', 1, 5, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CSI', 500120, 'Cutting/ non-suicidal self-injury', 'Cutting/ non-suicidal self-injury', 'CW', 1, 6, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DIS', 500120, 'Dissociation', 'Dissociation', 'CW', 1, 9, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OST', 500120, 'Obsessive thoughts', 'Obsessive thoughts', 'CW', 1, 16, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SLE', 500120, 'Sleep problems', 'Sleep problems', 'CW', 1, 17, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('STG', 500120, 'Suicidal thoughts/ gestures', 'Suicidal thoughts/ gestures', 'CW', 1, 18, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SUA', 500120, 'Suicide attempt', 'Suicide attempt', 'CW', 1, 19, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OMV', 500120, 'Tics (motor/ vocal)', 'Tics (motor/ vocal)', 'CW', 1, 20, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);


delete from cjams.referencevalues where referencetypeid=339 and value_text in ('Non-Stimulant (NS)');


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UNK', 339, 'Non-Stimulant (NS)', 'Non-Stimulant (NS)', 'CW', 1, 6, 'CIDM-10469', now(), 'CIDM-10469', now(), NULL, NULL, NULL);

delete from cjams.countygoliveconfig where countygoliveconfigid='1fbfccc2-0442-4715-ada0-5219e2d2e41b' ;

INSERT INTO cjams.countygoliveconfig
(countygoliveconfigid, objecttype, statewide, charles, washington, stmarys, annearundel, frederick, garrett, carroll, allegany, princegeorge, montgomery, calvert, baltimorecity, baltimorecounty, caroline, dorchester, kent, queenannes, somerset, wicomico, worcester, cecil, talbot, harford, howard, dhris, insertedon, insertedby, updatedon, updatedby, activeflag)
VALUES('1fbfccc2-0442-4715-ada0-5219e2d2e41b', 'psycotrophic-hcdm', NULL, NULL, null, NULL, null, NULL, NULL, NULL, NULL, NULL, NULL, NULL, null, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NOW(), 'CIDM-10469', NOW(), 'CIDM-10469', 1);


delete from cjams.audittraillukup where audittraillukupid='6dc766f5-d954-4698-b0fe-9c1d3a762ea7' ;

INSERT INTO cjams.audittraillukup
(audittraillukupid, typekey, fieldjson, activeflag, insertedby, insertedon, updatedby, updatedon, historytablename, primarykeyname)
VALUES('6dc766f5-d954-4698-b0fe-9c1d3a762ea7', 'healthcaredecisionmakerinformation', null, 1, 'ADMIN', now(), 'CIDM-5982', now(), 'healthcaredecisionmakerinformation_history', 'healthcaredecisionmakerinformationid');






