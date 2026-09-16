
delete from cjams."role" where openamrole in (
'CJAMS_CW_PSYCH_PHARMACIST','CJAMS_CW_PSYCH_PSYCHIARIST','CJAMS_CW_PSYCH_COORDINATOR')
and roletypekey in ('CWPSYPHARM','CWPSYPSYCH','CWPSYCOORD');

INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES((select max(id)+1 from cjams."role"), 'CJAMS_CW_PSYCH_PHARMACIST', 'PSYCHOTROPIC PHARMACIST REVIEW', NULL, NULL, 1, 'CIDM-9541', 'CIDM-9541', now(), now(), 'CWPSYPHARM', NULL, 'CJAMS_CW_PSYCH_PHARMACIST');

INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES((select max(id)+1 from cjams."role"), 'CJAMS_CW_PSYCH_PSYCHIARIST', 'PSYCHOTROPIC PSYCHIARIST REVIEW', NULL, NULL, 1, 'CIDM-9541', 'CIDM-9541', now(), now(), 'CWPSYPSYCH', NULL, 'CJAMS_CW_PSYCH_PSYCHIARIST');

INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES((select max(id)+1 from cjams."role"), 'CJAMS_CW_PSYCH_COORDINATOR', 'PSYCHOTROPIC COORDINATOR REVIEW', NULL, NULL, 1, 'CIDM-9541', 'CIDM-9541', now(), now(), 'CWPSYCOORD', NULL, 'CJAMS_CW_PSYCH_COORDINATOR');


delete from cjams.teammemberroletype where roletypekey in ('CWPSYPHARM','CWPSYPSYCH','CWPSYCOORD');

INSERT INTO cjams.teammemberroletype
(roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES( 'CWPSYPHARM', 1, 'PSYCHOTROPIC PHARMACIST REVIEW', 'CW', true, 'CIDM-9541', now(), 'CIDM-9541', now(), now(), NULL, NULL, false, NULL, NULL);

INSERT INTO cjams.teammemberroletype
(roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES( 'CWPSYPSYCH', 1, 'PSYCHOTROPIC PSYCHIARIST REVIEW', 'CW', true, 'CIDM-9541', now(), 'CIDM-9541', now(), now(), NULL, NULL, false, NULL, NULL);

INSERT INTO cjams.teammemberroletype
(roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES( 'CWPSYCOORD', 1, 'PSYCHOTROPIC COORDINATOR REVIEW', 'CW', true, 'CIDM-9541', now(), 'CIDM-9541', now(), now(), NULL, NULL, false, NULL, NULL);


-- adding the team

delete from cjams.team t 
where teamname = 'BHIPP'
and countyid ='11dc65f0-b116-45a9-a07a-8fbe171f0c9d'
;
INSERT INTO cjams.team
(activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(1, 'BHIPP', 'BHIPP_Psych_1', 'CW', 'BHIPP_Psych_1', '01:00:00', '04:00:00', '71066c32-2942-4474-91be-55e9207ce4ed'::uuid, 'admin', now(), 'admin', now(), now(), NULL, NULL, 0, NULL, NULL, '11dc65f0-b116-45a9-a07a-8fbe171f0c9d', NULL);
-- 10/18/2023 prasanna sai kommineni -- CIDM-9541 B-206485 : CW-Psychotropic Medications - Secondary Review


delete from cjams.referencevalues where referencetypeid = 46 and ref_key='PSY';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PSY', 46, 'Psychotropic Secondary Review', 'Psychotropic Secondary Review', 'CW', 1, NULL, 'CIDM-9541', now(), 'admin', NOW(), NULL, NULL, NULL);


DELETE FROM cjams.routingstatustype
WHERE sequencenumber = 900 and activeflag =1;

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, 
expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(900, 'caseworker_to_reviewcoordinator', 1, 'Awaiting Assignment', now(),
NULL, NULL, 'CIDM-9541', NULL, now(), null, NULL);

DELETE FROM cjams.routingstatustype
WHERE sequencenumber = 901 and activeflag =1;

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, 
expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(901, 'reviewcoordinator_to_pharmacist', 1, 'Pending Pharmacist Review', now(),
NULL, NULL, 'CIDM-9541', NULL, now(), null, NULL);

DELETE FROM cjams.routingstatustype
WHERE sequencenumber = 902 and activeflag =1;

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, 
expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(902, 'return_to_reviewcoordinator', 1, 'Awaiting Assignment', now(),
NULL, NULL, 'CIDM-9541', NULL, now(), null, NULL);


DELETE FROM cjams.routingstatustype
WHERE sequencenumber = 903 and activeflag =1;

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, 
expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(903, 'reviewcoordinator_to_psychiatrist', 1, 'Pending CAP Review', now(),
NULL, NULL, 'CIDM-9541', NULL, now(), null, NULL);


DELETE FROM cjams.routingstatustype
WHERE sequencenumber = 904 and activeflag =1;

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, 
expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(904, 'psychotropic_return', 1, 'Returned to Worker', now(),
NULL, NULL, 'CIDM-9541', NULL, now(), null, NULL);


DELETE FROM cjams.routingstatustype
WHERE sequencenumber = 905 and activeflag =1;

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, 
expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(905, 'psychotropic_reject', 1, 'Rejected', now(),
NULL, NULL, 'CIDM-9541', NULL, now(), null, NULL);


DELETE FROM cjams.routingstatustype
WHERE sequencenumber = 906 and activeflag =1;

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, 
expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(906, 'psychotropic_incomplete', 1, 'Information Incomplete', now(),
NULL, NULL, 'CIDM-9541', NULL, now(), null, NULL);

DELETE FROM cjams.routingstatustype
WHERE sequencenumber = 907 and activeflag =1;

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, 
expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(907, 'peer_to_peer', 1, 'Pending Peer To Peer Review', now(),
NULL, NULL, 'CIDM-9541', NULL, now(), null, NULL);

--FOR method of delivery
delete from cjams.referencetype where referencetypeid = 500600;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500600,'methodofdelivery', 'methodofdelivery', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);


delete from cjams.referencevalues where referencetypeid = 500600;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IMI', 500600, 'Intramuscular (IM) injection (into a muscle)', 'Intramuscular (IM) injection (into a muscle)', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('ITS', 500600, 'Intrathecal Therapy (within the spinal canal)', 'Intrathecal Therapy (within the spinal canal)', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('IIV', 500600, 'Intravenous (IV) (into a vein)', 'Intravenous (IV) (into a vein)', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OBY', 500600, 'Oral (by mouth)', 'Oral (by mouth)', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('REC', 500600, 'Rectal', 'Rectal', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('SIN', 500600, 'Subcutaneous (SC) injection (under the skin)', 'Subcutaneous (SC) injection (under the skin)', 'CW', 1, 6, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);


-- FOR prescribed duration
delete from cjams.referencetype where referencetypeid = 500601;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500601,'prescribedduration', 'prescribedduration', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);


delete from cjams.referencevalues where referencetypeid = 500601;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NON', 500601, 'None', 'None', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OTH', 500601, 'Other (specify)', 'Other (specify)', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('UNK', 500601, 'Unknown', 'Unknown', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('XDY', 500601, 'X Days (specify)', 'X Days (specify)', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('XWE', 500601, 'X Weeks (specify)', 'X Weeks (specify)', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);

-- FOR prescriber degree

delete from cjams.referencetype where referencetypeid = 500602;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500602,'prescriberdegree', 'prescriberdegree', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);


delete from cjams.referencevalues where referencetypeid = 500602;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MD', 500602, 'MD', 'MD', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('DO', 500602, 'DO', 'DO', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('NP', 500602, 'NP', 'NP', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('RN', 500602, 'RN', 'RN', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('PA', 500602, 'PA', 'PA', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OTH', 500602, 'Other', 'Other', 'CW', 1, 6, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);


--FOR Prescriber Field of Specialty 

delete from cjams.referencetype where referencetypeid = 500603;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500603,'prescriberspecialty', 'prescriberspecialty', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);


delete from cjams.referencevalues where referencetypeid = 500603;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FMP', 500603, 'Family Medicine/Family Practice', 'Family Medicine/Family Practice', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('PED', 500603, 'Pediatrics', 'Pediatrics', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('INM', 500603, 'Internal Medicine', 'Internal Medicine', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('EMM', 500603, 'Emergency Medicine', 'Emergency Medicine', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('PSY', 500603, 'Psychiatry', 'Psychiatry', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('BEH', 500603, 'Behavioral Health', 'Behavioral Health', 'CW', 1, 6, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OTH', 500603, 'Other', 'Other', 'CW', 1, 7, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('AAN', 500603, 'N/A', 'N/A', 'CW', 1, 8, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);


---Setting where medication prescribed

delete from cjams.referencetype where referencetypeid = 500604;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500604,'settingmedicationprescribed', 'settingmedicationprescribed', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);


delete from cjams.referencevalues where referencetypeid = 500604;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OPT', 500604, 'Outpatient treatment', 'Outpatient treatment', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('IOP', 500604, 'Intensive Outpatient Program', 'Intensive Outpatient Program', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('EMD', 500604, 'Emergency Department', 'Emergency Department', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('DTP', 500604, 'Day Treatment Program', 'Day Treatment Program', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('IHP', 500604, 'Inpatient Hospitalization program', 'Inpatient Hospitalization program', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);


--FOR diagnosis

delete from cjams.referencetype where referencetypeid = 500605;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500605,'diagnosis', 'diagnosis', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);


delete from cjams.referencevalues where referencetypeid = 500605;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('AOC', 500605, 'Anxiety', 'Anxiety', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OCR', 500605, 'Obsessive-Compulsive and Related Disorders', 'Obsessive-Compulsive and Related Disorders', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('TSR', 500605, 'Trauma and Stressor-Related Disorders', 'Trauma and Stressor-Related Disorders', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('DDR', 500605, 'Depressive Disorder', 'Depressive Disorder', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('DYS', 500605, 'Dysthymia', 'Dysthymia', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('MDN', 500605, 'Mood Disorder NOS', 'Mood Disorder NOS', 'CW', 1, 6, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('BDR', 500605, 'Bipolar Disorder', 'Bipolar Disorder', 'CW', 1, 7, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('ASD', 500605, 'Autism Spectrum Disorder', 'Autism Spectrum Disorder', 'CW', 1, 8, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('ADH', 500605, 'ADHD', 'ADHD', 'CW', 1, 9, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('DIC', 500605, 'Disruptive Impulse-Control and Conduct Disorders', 'Disruptive Impulse-Control and Conduct Disorders', 'CW', 1, 10, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('SRD', 500605, 'Substance-Related Disorders', 'Substance-Related Disorders', 'CW', 1, 11, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('SSO', 500605, 'Schizophrenia Spectrum and Other Psychotic Disorders', 'Schizophrenia Spectrum and Other Psychotic Disorders', 'CW', 1, 12, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('PDR', 500605, 'Psychotic Disorder', 'Psychotic Disorder', 'CW', 1, 13, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('FED', 500605, 'Feeding and Eating Disorders', 'Feeding and Eating Disorders', 'CW', 1, 14, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('SLD', 500605, 'Specific Learning Disorder', 'Specific Learning Disorder', 'CW', 1, 15, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('MDO', 500605, 'Motor Disorders', 'Motor Disorders', 'CW', 1, 16, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('COD', 500605, 'Comorbid Development', 'Comorbid Development', 'CW', 1, 17, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('COM', 500605, 'Comorbid Medical', 'Comorbid Medical', 'CW', 1, 18, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('CDR', 500605, 'Communication disorders', 'Communication disorders', 'CW', 1, 19, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('IDA', 500605, 'Intellectual disability', 'Intellectual disability', 'CW', 1, 20, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OTH', 500605, 'Other', 'Other', 'CW', 1, 21, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);



--Currently receiving psychosocial interventions" with drop down  if yes
delete from cjams.referencetype where referencetypeid = 500606;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500606,'additionalpsychosocialinterventions', 'additionalpsychosocialinterventions', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);


delete from cjams.referencevalues where referencetypeid = 500606;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ITH', 500606, 'Individual therapy', 'Individual therapy', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('GTE', 500606, 'Group therapy', 'Group therapy', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('FTE', 500606, 'Family therapy', 'Family therapy', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('SBT', 500606, 'School-based therapy', 'School-based therapy', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('ABA', 500606, 'Applied Behavior Analysis', 'Applied Behavior Analysis', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OTH', 500606, 'Other', 'Other', 'CW', 1, 6, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);




-- for targeted symptoms psychotropic

delete from cjams.referencetype where referencetypeid = 500607;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500607,'targetedsymptomspsychotropic', 'targetedsymptomspsychotropic', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);



delete from cjams.referencevalues where referencetypeid = 500607;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('AGG', 500607, 'Aggression', 'Aggression', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('ANX', 500607, 'Anxiety', 'Anxiety', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('ACT', 500607, 'Attention/ concentration', 'Attention/ concentration', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('BPR', 500607, 'Behavior problems', 'Behavior problems', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('COB', 500607, 'Compulsions', 'Compulsions', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('CSI', 500607, 'Cutting/ non-suicidal self-injury', 'Cutting/ non-suicidal self-injury', 'CW', 1, 6, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('DEL', 500607, 'Delusions', 'Delusions', 'CW', 1, 7, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('DEM', 500607, 'Depression', 'Depression', 'CW', 1, 8, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('DIS', 500607, 'Dissociation', 'Dissociation', 'CW', 1, 9, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('HAL', 500607, 'Hallucinations', 'Hallucinations', 'CW', 1, 10, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('HYP', 500607, 'Hyperactivity', 'Hyperactivity', 'CW', 1, 11, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('IMP', 500607, 'Impulsivity', 'Impulsivity', 'CW', 1, 12, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('IRR', 500607, 'Irritability', 'Irritability', 'CW', 1, 13, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('MAE', 500607, 'Manic episode', 'Manic episode', 'CW', 1, 14, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('MID', 500607, 'Mood instability', 'Mood instability', 'CW', 1, 15, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OST', 500607, 'Obsessive thoughts', 'Obsessive thoughts', 'CW', 1, 16, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('SLE', 500607, 'Sleep problems', 'Sleep problems', 'CW', 1, 17, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('STG', 500607, 'Suicidal thoughts/ gestures', 'Suicidal thoughts/ gestures', 'CW', 1, 18, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('SUA', 500607, 'Suicide attempt', 'Suicide attempt', 'CW', 1, 19, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OMV', 500607, 'Tics (motor/ vocal)', 'Tics (motor/ vocal)', 'CW', 1, 20, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('OTH', 500607, 'Other', 'Other', 'CW', 1, 21, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);



delete from cjams.referencevalues where referencetypeid = 1000 and ref_key= 'PSMR';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PSMR', 1000, 'Psychotropic Medication Request', 'Psychotropic Medication Request', 'CW', 1, NULL, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, 'medts', NULL);

--psychotropic review status

delete from cjams.referencetype where referencetypeid = 500608;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500608,'psychotropicreviewstatus', 'psychotropicreviewstatus', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);

delete from cjams.referencevalues where referencetypeid = 500608;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('ALL', 500608, 'all', 'All', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('APR', 500608, 'approved', 'Approved', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('AWA', 500608, 'awaiting_assignment', 'Awaiting Assignment', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('DRF', 500608, 'draft', 'Draft', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('IFI', 500608, 'information_incomplete', 'Information Incomplete', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('PCR', 500608, 'pending_cap_review', 'Pending Cap Review', 'CW', 1, 6, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('PPP', 500608, 'pending_peer_review', 'Pending Peer To Peer Review', 'CW', 1, 7, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('PPR', 500608, 'pending_pharmacist_review', 'Pending Pharmacist Review', 'CW', 1, 8, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('REJ', 500608, 'rejected', 'Rejected', 'CW', 1, 9, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('RTW', 500608, 'return_worker', 'Return To Worker', 'CW', 1, 10, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);


delete from cjams.referencetype where referencetypeid = 500609;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500609,'psychotropicmedicationclassification', 'psychotropicmedicationclassification', 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL);


delete from cjams.referencevalues where referencetypeid = 500609;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AD', 500609, 'Antidepressants', 'Antidepressants', 'CW', 1, 1, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('AAM', 500609, 'Anti-anxiety medications', 'Anti-anxiety medications', 'CW', 1, 2, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('STI', 500609, 'Stimulants', 'Stimulants', 'CW', 1, 5, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('ANT', 500609, 'Antipsychotics', 'Antipsychotics', 'CW', 1, 3, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('MOS', 500609, 'Mood stabilizers', 'Mood stabilizers', 'CW', 1, 4, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL),
('UNK', 500609, 'Non-Stimulant (NS)', 'Non-Stimulant (NS)', 'CW', 1, 6, 'CIDM-9541', now(), 'CIDM-9541', now(), NULL, NULL, NULL);


UPDATE referencevalues 
SET parentkey = 'AD',updatedby ='CIDM-9541' ,updatedon =now()
WHERE referencetypeid = 903 AND value_text IN (
    'Amitriptyline', 'Amoxapine', 'Bupropion', 'Citalopram', 'Desipramine', 
    'Desvenlafaxine', 'Doxepin', 'Duloxetine', 'Escitalopram', 'Esketamine', 
    'Fluoxetine', 'Imipramine', 'Isocarboxazid', 'Levomilnacipran', 'Maprotiline', 
    'Mirtazapine', 'Nortriptyline', 'Paroxetine', 'Phenelzine', 'Selegiline', 
    'Sertraline', 'Tranylcypromine', 'Trazodone', 'Venlafaxine', 
    'Vilazodone', 'Vortioxetine'
);


UPDATE referencevalues 
SET parentkey = 'UNK' ,updatedby ='CIDM-9541' ,updatedon =now()
WHERE referencetypeid = 903 AND value_text IN (
    'Atomoxetine',
'Clonidine',
'Guanfacine'
);

UPDATE referencevalues 
SET parentkey = 'AAM' ,updatedby ='CIDM-9541' ,updatedon =now()
WHERE referencetypeid = 903 AND value_text IN (
    'Alprazolam', 
    'Buspirone', 
    'Chlordiazepoxide', 
    'Clonazepam', 
    'Clorazepate', 
    'Diazepam', 
    'Hydroxyzine', 
    'Lorazepam', 
    'Oxazepam'
);
---Brexpiprazole MISSING
UPDATE referencevalues 
SET parentkey = 'ANT' ,updatedby ='CIDM-9541' ,updatedon =now()
WHERE referencetypeid = 903 AND value_text IN (
    'Rexpiprazole',
    'Aripiprazole',
    'Asenapine',
    'Cariprazine',
    'Chlorpromazine',
    'Clozapine',
    'Fluphenazine',
    'Haloperidol',
    'Iloperidone',
    'Lumateperone',
    'Lurasidone',
    'Olanzapine',
    'Paliperidone',
    'Perphenazine',
    'Quetiapine',
    'Risperidone',
    'Thioridazine',
    'Thiothixene',
    'Trifluoperazine',
    'Ziprasidone'
);


UPDATE referencevalues 
SET parentkey = 'MOS' ,updatedby ='CIDM-9541' ,updatedon =now()
WHERE referencetypeid = 903 AND value_text IN (
    'Carbamazepine',
    'Divalproex/Valproate',
    'Lamotrigine',
    'Lithium',
    'Oxcarbazine',
    'Topiramate'
);


UPDATE referencevalues 
SET parentkey = 'STI' ,updatedby ='CIDM-9541' ,updatedon =now()
WHERE referencetypeid = 903 AND value_text IN (
    'Amphetamine',
    'Dextroamphetamine',
    'Lisdexamfetamine',
    'Methamphetamine',
    'Methylphenidate'
);


update userprofile set alternateemailid='vinod.erakkat@maryland.gov' where email in ('test.psychcoordinator1@maryland.gov','test.psychiarist1@maryland.gov');

update userprofile set alternateemailid='krishnamohan.sankala2@maryland.gov' where email in ('test.pharmacist1@maryland.gov');
