UPDATE intakeservreqchildremoval icr
SET personid = (SELECT ia.personid FROM intakeservicerequestactor ia WHERE ia.intakeservicerequestactorid = icr.intakeservicerequestactorid)
WHERE icr.personid IS NULL AND icr.old_id IS NULL;

-- Prod data has 7 such cases
-- SELECT count(*) over(),insertedon,old_id,intakeservicerequestactorid,
-- personid,
-- (SELECT ia.personid FROM intakeservicerequestactor ia WHERE ia.intakeservicerequestactorid = icr.intakeservicerequestactorid),* 
-- FROM intakeservreqchildremoval icr
-- WHERE personid IS NULL AND old_id IS NULL ORDER BY insertedon DESC;
-- count	insertedon	old_id	intakeservicerequestactorid	personid	personid	intakeservreqchildremovalid
-- 7	2019-12-27 13:48:39	[NULL]	c8161c69-f99c-49f8-ae38-bab48739a9ab	[NULL]	e6804f0a-ca69-4a37-8e1c-dbe13b0a9b00	d20f9a27-2812-447e-a8af-367b7b110665
-- 7	2019-12-12 10:56:59	[NULL]	f6a5da03-dea2-4cf8-a97b-c778ff0a1def	[NULL]	18c743bb-ef5f-4e07-a436-f9470082bf59	124ecb3b-fecc-4fc9-a588-a0d713eaa74d
-- 7	2019-11-21 10:11:31	[NULL]	8cf5bd90-8cb7-47ef-9c61-6a660a9564c4	[NULL]	1c9bb026-db5a-4150-88b3-b84ddceb9935	8f02de47-0a3a-4aa5-81d8-4b25b98eb1c0
-- 7	2019-11-06 16:07:55	[NULL]	0b8ef109-667f-4c44-a25b-294b5cf0d785	[NULL]	66ee4a3d-2b3b-4a5b-afae-c248b3e20cac	4f6735c9-7513-4827-a810-bbfae23a2a21
-- 7	2019-11-06 16:03:46	[NULL]	739cb07f-8096-4ab9-95b6-3b66da5c944b	[NULL]	aa0c6ad4-330c-49fd-b28d-291ef8884363	4eda69aa-0cd6-4bc0-a8fa-c73c3c3d1578
-- 7	2019-11-06 15:45:16	[NULL]	d0e184b0-3722-45d1-a98e-a845ded1b73d	[NULL]	70b94c07-cb76-4c6d-9bca-0e9f633fcb17	cf6c52d3-9ecb-4755-831d-dbb99dc672bc
-- 7	2019-11-04 09:18:23	[NULL]	e84ca5f5-72ba-441d-a14d-8025c4115ec9	[NULL]	7f9c3df9-2c3c-4ab3-9f50-5f60b0591e09	cf20a1f4-c0d4-4808-98a4-9a18a3bd6448