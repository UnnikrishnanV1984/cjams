/* Deactivating Existing records substance classification records CIDM-10982 -
*/
UPDATE cjams.referencevalues
set activeflag = 2
WHERE activeflag = 1 and referencetypeid = '55';


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('OPID', 55, 'Opioids', 'Opioids', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), NULL, null, NULL, '557e0e14-5ba5-4610-bf7f-5c1efe3dc4e8'::uuid) on conflict do nothing;


DELETE FROM referencevalues
WHERE referencetypeid = 55 and parentkey = 'OPID' and activeflag = 1;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HRS1', 55, 'Heroin/Schedule I', 'Heroin/Schedule I', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MTS2', 55, 'Methadone/Schedule II', 'Methadone/Schedule II', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BSS2', 55, 'Buprenorphine, Suboxone/Schedule II', 'Buprenorphine, Suboxone/Schedule II', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HDS2', 55, 'Hydromorphone,Dilaudid/Schedule II', 'Hydromorphone,Dilaudid/Schedule II', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MRS2', 55, 'Morphine/Schedule II', 'Morphine/Schedule II', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FTS2', 55, 'Fentanyl/Schedule II', 'Fentanyl/Schedule II', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HYS2', 55, 'Hydrocodone/Schedule II', 'Hydrocodone/Schedule II', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OPS2', 55, 'Oxycodone,OxyContin,Percocet/Schedule II', 'Oxycodone,OxyContin,Percocet/Schedule II', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CDS2', 55, 'Codeine/Schedule II', 'Codeine/Schedule II', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MDS2', 55, 'Meperidine,Demerol/Schedule II', 'Meperidine,Demerol/Schedule II', NULL, 1, 26, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'OPID', null);



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('STML', 55, 'Stimulants', 'Stimulants', NULL, 1, 27, 'CIDM-10982', now(), 'CIDM-10982', now(), NULL, null, NULL, 'e96f1dab-8040-4289-bc8b-2a51c921a481'::uuid) on conflict do nothing;


DELETE FROM referencevalues
WHERE referencetypeid = 55 and parentkey = 'STML' and activeflag = 1;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('COS2', 55, 'Cocaine/Schedule II', 'Cocaine/Schedule II', NULL, 1, 27, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'STML', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MES2', 55, 'Methamphetamine/Schedule II', 'Methamphetamine/Schedule II', NULL, 1, 27, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'STML', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MPS2', 55, 'Methylphenidate (Ritalin)/Schedule II', 'Methylphenidate (Ritalin)/Schedule II', NULL, 1, 27, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'STML', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('AMS2', 55, 'Amphetamine/Schedule II', 'Amphetamine/Schedule II', NULL, 1, 28, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'STML', null, '6335b937-f54f-4693-80d5-ea0c0f58de4f'::uuid) on conflict do nothing;

DELETE FROM referencevalues
WHERE referencetypeid = 55 and parentkey = 'AMS2' and activeflag = 1;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ADDE', 55, 'Adderall', 'Adderall', NULL, 1, 28, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'AMS2', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VYVA', 55, 'Vyvanse', 'Vyvanse', NULL, 1, 28, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'AMS2', null);




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('DEPR', 55, 'Depressants', 'Depressants', NULL, 1, 29, 'CIDM-10982', now(), 'CIDM-10982', now(), null, null, null, '4a164ece-9ab3-4053-bb65-dc2249607ba5'::uuid) on conflict do nothing;

DELETE FROM referencevalues
WHERE referencetypeid = 55 and parentkey = 'DEPR' and activeflag = 1;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('BZS4', 55, 'Benzodiazepine/Schedule IV', 'Benzodiazepine/Schedule IV', NULL, 1, 29, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'DEPR', null, '6c6c3ebe-ca29-4d23-89e5-bf97bdaa657c'::uuid) on conflict do nothing;


DELETE FROM referencevalues
WHERE referencetypeid = 55 and parentkey = 'BZS4' and activeflag = 1;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VALI', 55, 'Valium', 'Valium', NULL, 1, 29, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'BZS4', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('XANA', 55, 'Xanax', 'Xanax', NULL, 1, 29, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'BZS4', null);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('BARB', 55, 'Barbiturates', 'Barbiturates', NULL, 1, 29, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'DEPR', null, '6c6c3ebe-ca29-4d23-89e5-bf97bdaa657c'::uuid) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('ALCH', 55, 'Alcohol', 'Alcohol', NULL, 1, 29, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'DEPR', null, '6c6c3ebe-ca29-4d23-89e5-bf97bdaa657c'::uuid) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('HAOC', 55, 'Hallucinogens and Other Compounds', 'Hallucinogens and Other Compounds', NULL, 1, 30, 'CIDM-10982', now(), 'CIDM-10982', now(), null, null, null, '15ae4f6f-fd42-4e1f-a0f2-4176b00709f4'::uuid) on conflict do nothing;

DELETE FROM referencevalues
WHERE referencetypeid = 55 and parentkey = 'HAOC' and activeflag = 1;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MAS1', 55, 'Marijuana/Schedule I', 'Marijuana/Schedule I', NULL, 1, 30, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'HAOC', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ASIE', 55, 'Amphetamine/Schedule I- Ecstasy', 'Amphetamine/Schedule I- Ecstasy', NULL, 1, 30, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'HAOC', null);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LSD1', 55, 'LSD/Schedule I', 'LSD/Schedule I', NULL, 1, 30, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'HAOC', null);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PCS2', 55, 'Phencyclidine (PCP)/Schedule II', 'Phencyclidine (PCP)/Schedule II', NULL, 1, 30, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'HAOC', null);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('KES3', 55, 'Ketamine/Schedule III', 'Ketamine/Schedule III', NULL, 1, 30, 'CIDM-10982', now(), 'CIDM-10982', now(), null, 'HAOC', null);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('OTDS', 55, 'Other Drug/Substance', 'Other Drug/Substance', NULL, 1, 30, 'CIDM-10982', now(), 'CIDM-10982', now(), null, null, null, '749c179b-9d18-4a85-8a3d-b92912b9b04e'::uuid) on conflict do nothing;



