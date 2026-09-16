/* Update the immunization key as null for the non CRISP vaccine records in the personimmunization table. */
update personimmunizationconfig 
set immunizationkey = null
where immunizationkey is not null;

delete from personimmunizationconfig where immunizationkey is not null;

/* Insert vaccines into personimmunizationconfig that are valid for CRISP integration with immunization key not null. */
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Corona Virus Disease - 19', '(COVID-19)', 'CV19', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Diptheria & tetanus', 'Diptheria & tetanus', 'DT', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Diptheria, tetanus &  acelluar pertussis', '(DTaP: <7yrs)', 'DTAP', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Diptheria, tetanus, pertussis', 'Diptheria, tetanus, pertussis', 'DTP', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Ebola', 'Ebola', 'EB', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Haemophilus influenzae type b', '(Hib)', 'HIB', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('HBIg', 'HBIg', 'HBIG', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Hepatitis A', '(HepA)', 'HEPA', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Hepatitis B', '(HepB)', 'HEPB', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Human papillomavirus', '(HPV)', 'HPV', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Inactivated poliovirus', '(IPV: <18 yrs)', 'POL', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Influenza', '(IIV) or (LAIV)', 'FLU', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Influenza live attenuated', '(LAIV)', 'FLU-L', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Influenza recombinant', '(RIV)', 'FLU-R', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Measles, mumps, rubella', '(MMR)', 'MMR', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Measles Virus Vaccine', 'Measles Virus Vaccine', 'MEA', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Meningococcal', '(MenACWY-D: ≥9 mos; MenACWY-CRM: ≥2 mos)', 'MENG', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Meningococcal A, C, W, Y', '(MenACWY)', 'MENG-ACWY', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Meningococcal B', '(MenB)', 'MENG-B', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Mumps Virus Vaccine', 'Mumps Virus Vaccine', 'MUM', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Novel Influenza', 'Novel Influenza', 'N-FLU', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Pneumococcal conjugate', '(PCV13)', 'PNCN', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Pneumococcal polysaccharide', '(PPSV23)', 'PNPL', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Rabies', 'Rabies', 'RAB', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('RIg', 'RIg', 'RIG', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Rotavirus', '(RV) RV1 (2-dose series, now(), now()); RV5 (3-dose series)', 'ROTA', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('RSV', 'RSV', 'RSV', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('RSV-IgIM', 'RSV-IgIM', 'RSV-IGIM', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('RSV-IgIV', 'RSV-IgIV', 'RSV-IGIV', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Rubella Virus Vaccine', 'Rubella Virus Vaccine', 'RUB', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Tetanus', 'Tetanus', 'TT', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Tetanus, diphtheria, & acellular pertussis', '(Tdap: ≥7 yrs)', 'TDAP', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Tetanus, diphtheria, pertussis', '(Tdap or Td)', 'TDP', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Tetanus IG', 'Tetanus IG', 'TT-IG', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Varicella', '(VAR)', 'VAR', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('VZIg', 'VZIg', 'VZIG', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('VZIG (IND)', 'VZIG (IND)', 'VZIG-IND', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Zoster live', '(ZVL)', 'ZOS-L', 'CIDM-8809', 'CIDM-8809', now(), now());
INSERT INTO cjams.personimmunizationconfig (value_text, description, immunizationkey, insertedby, updatedby, insertedon, updatedon) VALUES ('Zoster recombinant', '(RZV) (preferred)', 'ZOS-R', 'CIDM-8809', 'CIDM-8809', now(), now());