-- CDM-8924 - Add disposition records for service cases and disposition cases

-- Disposition records for service cases

INSERT INTO servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('c0ffd84b-205b-4cb5-ad74-c81f986d79b5', '2019-12-17 12:12:43', 'Open', 'Inprogress','Case Accepted', now(), 1, '82b1c827-bc1b-456e-a933-7a21a10aeb1e',now(),'82b1c827-bc1b-456e-a933-7a21a10aeb1e',now());

INSERT INTO servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('7e763030-c162-4ffb-9550-35ebab90cde0', '2019-12-17 12:12:43', 'Open', 'Inprogress','Case Accepted', now(), 1, '82b1c827-bc1b-456e-a933-7a21a10aeb1e',now(),'82b1c827-bc1b-456e-a933-7a21a10aeb1e',now());

INSERT INTO servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('2346d580-6d20-4af6-8d69-26e22c24dc9b', '2019-12-17 12:12:43', 'Open', 'Inprogress','Case Accepted', now(), 1, '82b1c827-bc1b-456e-a933-7a21a10aeb1e',now(),'82b1c827-bc1b-456e-a933-7a21a10aeb1e',now());

INSERT INTO servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('b7685c4c-ed81-43ab-90eb-6297fbc93ba3', '2019-12-17 12:12:43', 'Open', 'Inprogress','Case Accepted', now(), 1, '82b1c827-bc1b-456e-a933-7a21a10aeb1e',now(),'82b1c827-bc1b-456e-a933-7a21a10aeb1e',now());

INSERT INTO servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('746b77fe-9f36-4d44-9740-9c444d6c3e35', '2019-12-17 12:12:43', 'Open', 'Inprogress','Case Accepted', now(), 1, '82b1c827-bc1b-456e-a933-7a21a10aeb1e',now(),'82b1c827-bc1b-456e-a933-7a21a10aeb1e',now());

-- Disposition records for adoption cases

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('57b91ad2-1885-4e90-9d21-2c3456f1d647', '2021-02-04 19:03:30', 'Open', 'Inprogress','Case Accepted', '2021-02-04 19:03:30', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('9c765d8f-530f-47a6-ae94-a16a4ce809e4', '2021-02-05 05:00:00', 'Open', 'Inprogress','Case Accepted', '2021-02-05 05:00:00', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('2c3d3a4d-1f67-4139-9d1b-998e04d54f01', '2021-02-05 05:00:00', 'Open', 'Inprogress','Case Accepted', '2021-02-05 05:00:00', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('16b3be70-9ed2-4205-94e1-647de89de9a3', '2021-01-20 05:00:00', 'Open', 'Inprogress','Case Accepted', '2021-01-20 05:00:00', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('e22ea8c9-35a4-422d-af7e-75ec468bd3c1', '2021-02-04 21:45:17', 'Open', 'Inprogress','Case Accepted', '2021-02-04 21:45:17', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('fdd0be50-927b-4b69-bb45-53fbdf1799ea', '2021-02-03 16:55:59', 'Open', 'Inprogress','Case Accepted', '2021-02-03 16:55:59', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('3bea693e-8073-4b7e-af65-704a2f563ef6', '2021-02-04 21:36:21', 'Open', 'Inprogress','Case Accepted', '2021-02-04 21:36:21', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('d01f30c0-4e91-4226-ae50-0ce9418e9d8e', '2021-02-04 17:40:49', 'Open', 'Inprogress','Case Accepted', '2021-02-04 17:40:49', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('8c289657-d78e-41d2-abf6-c5b91e00b405', '2020-03-04 05:00:00', 'Open', 'Inprogress','Case Accepted', '2020-03-04 05:00:00', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('ae97f7cf-8795-4d37-a3a7-ffdd15fbcb00', '2020-12-18 05:00:00', 'Open', 'Inprogress','Case Accepted', '2020-12-18 05:00:00', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('2a3eb481-daf3-4a45-831d-79f709eaaa05', '2021-01-26 05:00:00', 'Open', 'Inprogress','Case Accepted', '2021-01-26 05:00:00', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('80b86af3-6045-47ae-b4fc-9cdfa28a6b23', '2021-01-29 05:00:00', 'Open', 'Inprogress','Case Accepted', '2021-01-29 05:00:00', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('0d22711d-4b33-424f-8faa-676e47ba4340', '2021-02-04 18:25:21', 'Open', 'Inprogress','Case Accepted', '2021-02-04 18:25:21', 1, 'CDM-8924',now(),'CDM-8924',now());

INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('e7f834f5-10bc-4f4d-aa77-06634c5deb18', '2020-12-18 05:00:00', 'Open', 'Inprogress','Case Accepted', '2020-12-18 05:00:00', 1, 'CDM-8924',now(),'CDM-8924',now());
