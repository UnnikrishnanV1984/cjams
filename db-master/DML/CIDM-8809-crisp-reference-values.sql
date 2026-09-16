-- B-192488 CJAMS CW Immunet Interface (CRISP) 
-- Add all the vaccine immunization key in the reference types and values.
DELETE FROM cjams.referencetype where referencetypeid = 500501;

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, updatedby)
VALUES(500501, 'Immunization Key', 'Immunization Key For CRISP', 1, 'CIDM-8809', 'CIDM-8809');

DELETE FROM cjams.referencevalues WHERE referencetypeid = 500501;

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('CV19', 500501, 'Corona Virus Disease - 19', 'Corona Virus Disease - 19' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('DT', 500501, 'Diptheria & tetanus', 'Diptheria & tetanus' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('DTAP', 500501, 'Diptheria, tetanus &  acelluar pertussis', 'Diptheria, tetanus &  acelluar pertussis' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('DTP', 500501, 'Diptheria, tetanus, pertussis', 'Diptheria, tetanus, pertussis' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('EB', 500501, 'Ebola', 'Ebola' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('HIB', 500501, 'Haemophilus influenzae type b', 'Haemophilus influenzae type b' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('HBIG', 500501, 'HBIg', 'HBIg' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('HEPA', 500501, 'Hepatitis A', 'Hepatitis A' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('HEPB', 500501, 'Hepatitis B', 'Hepatitis B' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('HPV', 500501, 'Human papillomavirus', 'Human papillomavirus' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('POL', 500501, 'Inactivated poliovirus', 'Inactivated poliovirus' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('FLU', 500501, 'Influenza', 'Influenza' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('FLU-L', 500501, 'Influenza live attenuated', 'Influenza live attenuated' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('FLU-R', 500501, 'Influenza recombinant', 'Influenza recombinant' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('MEA', 500501, 'Measles Virus Vaccine', 'Measles Virus Vaccine' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('MMR', 500501, 'Measles, mumps, rubella', 'Measles, mumps, rubella' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('MENG', 500501, 'Meningococcal', 'Meningococcal' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('MENG-ACWY', 500501, 'Meningococcal A, C, W, Y', 'Meningococcal A, C, W, Y' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('MENG-B', 500501, 'Meningococcal B', 'Meningococcal B' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('MUM', 500501, 'Mumps Virus Vaccine', 'Mumps Virus Vaccine' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('N-FLU', 500501, 'Novel Influenza', 'Novel Influenza' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('PNCN', 500501, 'Pneumococcal conjugate', 'Pneumococcal conjugate' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('PNPL', 500501, 'Pneumococcal polysaccharide', 'Pneumococcal polysaccharide' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('RAB', 500501, 'Rabies', 'Rabies' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('RIG', 500501, 'RIg', 'RIg' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('ROTA', 500501, 'Rotavirus', 'Rotavirus' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('RSV', 500501, 'RSV', 'RSV' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('RSV-IGIM', 500501, 'RSV-IgIM', 'RSV-IgIM' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('RSV-IGIV', 500501, 'RSV-IgIV', 'RSV-IgIV' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('RUB', 500501, 'Rubella Virus Vaccine', 'Rubella Virus Vaccine' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('TT', 500501, 'Tetanus', 'Tetanus' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('TT-IG', 500501, 'Tetanus IG', 'Tetanus IG' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('TDAP', 500501, 'Tetanus, diphtheria, & acellular pertussis ', 'Tetanus, diphtheria, & acellular pertussis ' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('TDP', 500501, 'Tetanus, diphtheria, pertussis', 'Tetanus, diphtheria, pertussis' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('VAR', 500501, 'Varicella', 'Varicella' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('VZIG', 500501, 'VZIg', 'VZIg' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('VZIG-IND', 500501, 'VZIG (IND)', 'VZIG (IND)' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('ZOS-L', 500501, 'Zoster live', 'Zoster live' , 'CW', 1, 'B-193558', 'B-193558');
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, updatedby) VALUES('ZOS-R', 500501, 'Zoster recombinant', 'Zoster recombinant' , 'CW', 1, 'B-193558', 'B-193558');
