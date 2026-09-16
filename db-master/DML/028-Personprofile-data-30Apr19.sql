DELETE FROM cjams.personimmunizationconfig
WHERE personimmunizationconfigid in ('f67577ce-69b7-47ce-844e-84c827e5a263',
'18bdf953-5e87-48e5-be5a-b42153b5c9e7',
'0481ab6d-92ca-475b-af5b-6114f30d5eec',
'297f5956-293e-4334-80a3-d0b6168121af',
'75790f55-a90f-4dc6-8eb1-d3b729e6e370',
'e11aad92-73d1-4766-bc0f-2a87b2d9d151',
'66491538-4857-4cfc-9aa3-cfc07fc13000',
'1cc33637-c212-49a1-89d7-b7b195ad1d9f',
'2c76f88a-95cc-4b4f-be56-ab765d7b22b6',
'0e26207a-603d-416a-a05e-7cf8a22b96b9',
'edd19642-b3ef-4116-8d26-554b4c5c8c80',
'87f2fd9f-840e-4370-bded-a26fd2144fd8',
'b71f2587-0e11-47c7-8579-376b6abea3cc',
'f27667ea-c668-4d28-b7f0-7572acd11b99',
'9ea9a978-3410-4a7d-bb74-9355f9f71b5e',
'f663393b-eae4-47cc-9943-4b88ab037cea',
'36671dc0-2955-414c-8a3e-8d824fb31948',
'cc5a4359-92e9-4700-890e-31e01bb5c92e',
'0cc32dc6-3010-4342-bfec-2de2d39f8698',
'70b8b69d-cfd6-4389-bf87-c0b441cd1ece',
'554ca5fd-04cd-432b-9e92-003e36f58981',
'bf739d06-a2b7-4a52-bd98-84e83598b12e',
'0c386f81-6de6-4f5c-9908-3d4d65ece8c2',
'932288ea-5766-4dd2-9370-e7ad19f02677',
'78fad5de-d8f4-4781-86ed-7c7ec672dc34',
'30d2e4b4-bc84-4898-be6c-fb80a1cf9707',
'fbb81fae-d8c3-4bec-9e67-0ff6d8b41488',
'df835e5f-f8e8-4739-9174-2c0e05a3eef1',
'8f036309-512b-411a-a6bc-f29c5d1fca58',
'dd0f01a5-0ae8-4a43-a246-3cdedf855cf9',
'e0524de3-a0d4-4f82-b9b3-6ef48e87dd53',
'da507720-99a0-4970-90a9-22a7ced1a0ef',
'db911ded-4d45-4fdb-8562-894352f9a94d',
'e3750838-9a45-4d68-a26e-d2dd1c05a070',
'ab63bff9-d0fd-4cd5-bb25-efba9a7668f7',
'1b33670b-e60d-4cb8-aa0d-d76bb4e74a7f',
'e03d6b7f-4d4d-4cce-922f-a9a51494160c',
'e168a53c-5ace-47e0-baff-b157c932d714',
'e20c74cf-178c-4c5b-91c9-417c02c47fd0',
'55d437f0-d602-4c34-a16c-f5fcdfd5cdcd',
'efaf5eba-06cd-40c6-b955-e1b1491c54e5',
'c68ca9d9-e521-43bc-a240-20fab1fc1fe4',
'e21bb813-daab-457f-a250-f6ccd696e837',
'3b8bda19-3bd8-4ee4-84a0-835a51c7ecaa',
'bc4b2a4d-48a5-44de-b4a2-d31e9288a1cd');


INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('f67577ce-69b7-47ce-844e-84c827e5a263', 'Hepatitis B', 'HepB', '[{"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 2, "comments": ""}, {"date": null, "dose": null, "colspan": 1, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 4, "comments": ""}]', 'BIRTH_TO_15_M', 1, NULL, '2019-04-24 16:25:35.395', 'admin', '2019-04-24 16:25:35.395', '2019-04-24 16:25:35.395', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('18bdf953-5e87-48e5-be5a-b42153b5c9e7', 'Meningococcal', 'MenACWY-D: ≥9 mos; MenACWY-CRM: ≥2 mos', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('0481ab6d-92ca-475b-af5b-6114f30d5eec', 'Tetanus, diphtheria, & acellular pertussis ', 'MMR', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('297f5956-293e-4334-80a3-d0b6168121af', 'Human papillomavirus', 'HPV', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('75790f55-a90f-4dc6-8eb1-d3b729e6e370', 'Meningococcal B', 'MenB', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('e11aad92-73d1-4766-bc0f-2a87b2d9d151', 'Pneumococcal polysaccharide ', 'PPSV23', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('66491538-4857-4cfc-9aa3-cfc07fc13000', 'Diptheria, tetanus &  acelluar pertussis', '(DTaP: <7yrs)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "4th dose", "colspan": 1, "comments": ""}]', 'BIRTH_TO_15_M', 1, NULL, '2019-04-24 16:30:32.912', 'admin', '2019-04-24 16:30:32.912', '2019-04-24 16:30:32.912', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('1cc33637-c212-49a1-89d7-b7b195ad1d9f', 'Inactivated poliovirus', 'IPV: <18 yrs', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 4, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('2c76f88a-95cc-4b4f-be56-ab765d7b22b6', 'Haemophilus influenzae type b', '(Hib)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, NULL, '2019-04-24 17:52:08.783', 'admin', '2019-04-24 17:52:08.783', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('0e26207a-603d-416a-a05e-7cf8a22b96b9', 'Pneumococcal conjugate', '(PCV13)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 1, "comments": ""}, {"date": null, "dose": "4th dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('edd19642-b3ef-4116-8d26-554b4c5c8c80', 'Measles, mumps, rubella', 'MMR', '[{"date": null, "dose": null, "colspan": 6, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('87f2fd9f-840e-4370-bded-a26fd2144fd8', 'Influenza', '(IIV) or (LAIV)', '[{"date": null, "dose": null, "colspan": 4, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 4, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('b71f2587-0e11-47c7-8579-376b6abea3cc', 'Tetanus, diphtheria, & acellular pertussis ', 'Tdap: ≥7 yrs', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('f27667ea-c668-4d28-b7f0-7572acd11b99', 'Human papillomavirus', 'HPV', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('9ea9a978-3410-4a7d-bb74-9355f9f71b5e', 'Meningococcal B', 'MenB', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('f663393b-eae4-47cc-9943-4b88ab037cea', 'Pneumococcal polysaccharide ', 'PPSV23', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('36671dc0-2955-414c-8a3e-8d824fb31948', 'Influenza recombinant', '(RIV)', '[{"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 2, "comments": ""}, {"date": null, "dose": null, "colspan": 1, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 4, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 16:25:35.395', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('cc5a4359-92e9-4700-890e-31e01bb5c92e', 'Influenza live attenuated', '(LAIV)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 16:27:52.881', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('0cc32dc6-3010-4342-bfec-2de2d39f8698', 'Tetanus, diphtheria, pertussis', '(Tdap or Td)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 16:30:32.912', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('70b8b69d-cfd6-4389-bf87-c0b441cd1ece', 'Measles, mumps, rubella', '(MMR)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('554ca5fd-04cd-432b-9e92-003e36f58981', 'Varicella', '(VAR)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('bf739d06-a2b7-4a52-bd98-84e83598b12e', 'Zoster recombinant', '(RZV) (preferred)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('0c386f81-6de6-4f5c-9908-3d4d65ece8c2', 'Zoster live', '(ZVL)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('932288ea-5766-4dd2-9370-e7ad19f02677', 'Human papillomavirus', '(HPV)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('78fad5de-d8f4-4781-86ed-7c7ec672dc34', 'Pneumococcal conjugate', '(PCV13)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('30d2e4b4-bc84-4898-be6c-fb80a1cf9707', 'Pneumococcal polysaccharide', '(PPSV23)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('fbb81fae-d8c3-4bec-9e67-0ff6d8b41488', 'Hepatitis A', '(HepA)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('df835e5f-f8e8-4739-9174-2c0e05a3eef1', 'Hepatitis B', '(HepB)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('8f036309-512b-411a-a6bc-f29c5d1fca58', 'Meningococcal A, C, W, Y', '(MenACWY)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('dd0f01a5-0ae8-4a43-a246-3cdedf855cf9', 'Meningococcal B', '(MenB)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('e0524de3-a0d4-4f82-b9b3-6ef48e87dd53', 'Haemophilus influenzae type b', '(Hib)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "3rd dose", "colspan": 2, "comments": ""}]', 'YEAR_19_TO_YEAR_21', 1, 'admin', '2019-04-27 20:00:54.169', 'admin', '2019-04-27 20:00:54.169', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('da507720-99a0-4970-90a9-22a7ced1a0ef', 'Rotavirus', '(RV) RV1 (2-dose series); RV5 (3-dose series)', '[{"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 4, "comments": ""}]', 'BIRTH_TO_15_M', 1, NULL, '2019-04-24 16:27:52.881', 'admin', '2019-04-24 16:27:52.881', '2019-04-24 16:27:52.881', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('db911ded-4d45-4fdb-8562-894352f9a94d', 'Varicella', 'VAR', '[{"date": null, "dose": null, "colspan": 6, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('e3750838-9a45-4d68-a26e-d2dd1c05a070', 'Hepatitis A', 'HepA', '[{"date": null, "dose": null, "colspan": 6, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 2, "comments": ""}]', 'BIRTH_TO_15_M', 1, 'admin', '2019-04-26 18:14:20.712', 'admin', '2019-04-26 18:14:20.712', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('ab63bff9-d0fd-4cd5-bb25-efba9a7668f7', 'Hepatitis B', 'HepB', '[{"date": null, "dose": "3rd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 8, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 16:25:35.395', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('1b33670b-e60d-4cb8-aa0d-d76bb4e74a7f', 'Rotavirus', '(RV) RV1 (2-dose series); RV5 (3-dose series)', '[{"date": null, "dose": null, "colspan": 9, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 16:27:52.881', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('e03d6b7f-4d4d-4cce-922f-a9a51494160c', 'Diptheria, tetanus &  acelluar pertussis', '(DTaP: <7yrs)', '[{"date": null, "dose": "4th dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 1, "comments": ""}, {"date": null, "dose": "5th dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 6, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 16:30:32.912', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('e168a53c-5ace-47e0-baff-b157c932d714', 'Haernophilus influenzae type b', '(Hib)', '[{"date": null, "dose": null, "colspan": 9, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('e20c74cf-178c-4c5b-91c9-417c02c47fd0', 'Pneumococcal conjugate', 'PCV13', '[{"date": null, "dose": null, "colspan": 9, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('55d437f0-d602-4c34-a16c-f5fcdfd5cdcd', 'Inactivated poliovirus', 'IPV: <18 yrs', '[{"date": null, "dose": "3rd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}, {"date": null, "dose": "5th dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 5, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('efaf5eba-06cd-40c6-b955-e1b1491c54e5', 'Influenza', '(IIV) or (LAIV)', '[{"date": null, "dose": "Annual Vaccination 1 or 2 doses", "colspan": 4, "comments": ""}, {"date": null, "dose": "Annual Vaccination 1 dose only", "colspan": 5, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('c68ca9d9-e521-43bc-a240-20fab1fc1fe4', 'Measles, mumps, rubella', 'MMR', '[{"date": null, "dose": null, "colspan": 3, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 5, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('e21bb813-daab-457f-a250-f6ccd696e837', 'Varicella', 'VAR', '[{"date": null, "dose": null, "colspan": 3, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 5, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('3b8bda19-3bd8-4ee4-84a0-835a51c7ecaa', 'Hepatitis A', 'HepA', '[{"date": null, "dose": "2-dose series", "colspan": 2, "comments": ""}, {"date": null, "dose": null, "colspan": 7, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);
INSERT INTO cjams.personimmunizationconfig
(personimmunizationconfigid, value_text, description, uiconfig, agetype, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
VALUES('bc4b2a4d-48a5-44de-b4a2-d31e9288a1cd', 'Meningococcal', 'MenACWY-D: ≥9 mos; MenACWY-CRM: ≥2 mos', '[{"date": null, "dose": null, "colspan": 4, "comments": ""}, {"date": null, "dose": "1st dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 1, "comments": ""}, {"date": null, "dose": "2nd dose", "colspan": 1, "comments": ""}, {"date": null, "dose": null, "colspan": 2, "comments": ""}]', '18_M_TO_18_Y', 1, 'admin', '2019-04-26 18:14:31.445', 'admin', '2019-04-26 18:14:31.445', '2019-04-24 17:52:08.783', NULL, NULL);

