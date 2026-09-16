-- CDM-31866 - Data fix
/*
-- Issue Description:
-- Category/ Module: Intake/Investigation (Expungement)
-- Fix Provided: Datafix has been promoted to expunge the CPS-IR # CW2184997
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



  
-- 221030017162 
--2022-07-09T19:00
--2022-08-29T12:30
--2023-01-25T14:00
      UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid in ('32b6a177-d219-4b26-8852-4834d1bf3ad2',
'6ac6e1e5-f71a-4eda-a3d2-96d695eea05d',
'e5dd9b92-0e8c-4f41-97fc-0feceb70c737') and activeflag = '1';
  
  
  
  
  
--  3273982
--  2022-12-28T14:45
--2023-02-03T10:00
      UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid in ('901cde36-ba56-4aef-acbc-f9bc79dab504',
'b6c9b164-cfda-4abe-9d76-09d1f9558500') and activeflag = '1';
  
  
  
  
  -- 231030104886 
  -- "2023-04-27T12:30"
      UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid = '3089f747-cc46-40ac-9da7-a6f57a49f059' and activeflag = '1';
  
  
  
    
  -- "2023-05-19T15:30" 231030117492
    UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid = '92366cc0-612e-453b-8468-4f1a17faf812' and activeflag = '1';
  
  
  
  
  
--  
--  3164586 
--2022-08-22T14:41
--2022-10-27T13:09
--2023-02-24T10:15
      UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid in (
'283477a3-8808-41f4-a946-2c3ea03817fe',
'dde21b85-81a1-403b-9b85-d779ed9d738b',
'0b350088-db73-4c44-969b-02dfa7f69cac')
	and activeflag = '1';  
  
  
  
  
  
  
  
--  
--3303488   
--2022-03-14T15:30
--2022-08-09T12:00
--2022-12-06T09:30
    UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid in ('07788ddf-7571-4ec2-8ae1-622e7d4ad2c4',
'797896c3-2dd8-4fbf-8436-bda5d9cc3e82',
'3747d721-8530-40d2-a4c8-0b1a73721a59')
	and activeflag = '1';  
  
  
  

--  202105606221
--2022-11-03T16:00
--2023-02-02T10:00
    UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid in ('f25321c6-3083-4f55-bc96-0fc399a44aed',
    '4503a792-05b8-44cb-86f8-27f9aed3f315')
	and activeflag = '1';
  

  
  -- "2021-03-12T14:20" 3154902
    UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid = '18d8d406-bf1b-44a3-9207-bc86183368fb' and activeflag = '1';
  
  
  
  
  -- 3252190 
--  2022-06-16T12:00
--2022-08-02T14:30
--2023-02-21T12:00
    UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid in ('b4d3a9b2-1322-4a5e-816d-7b15b3adc6ec',
'd148a56a-4b93-4dca-9122-880bc59f3b5d',
'210de03e-a490-4b0c-bfbf-eb818f83fb6b')
	and activeflag = '1';
  
  
-- 3259541
--    2022-06-15T09:45
--2022-10-26T10:45
--2022-11-22T12:30
  UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid in ('6ff64994-f6e0-45d2-93e6-e78cbb1a322b',
'9b4a00d6-2af7-427a-938b-45a97d7b928f',
'6a9647c5-5360-4dc8-84e3-36df38343378')
	and activeflag = '1';
  
  
  
  
  
  -- 3252629
  UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid = '07f25c8b-1971-4126-abcd-133251686a0f' and activeflag = '1';
  
  
  -- 231030060225 , "2023-02-09T12:54"
  UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid = 'fd3dc1a9-f6f1-48bd-a836-e982e474a36a' and activeflag = '1';
  
  -- 221030014673  
  -- "2023-02-21T12:30"
    UPDATE assessment set 
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
	where assessmentid = '954cfca2-42de-4f7e-97ae-2f30e142ffbd' and activeflag = '1';
  
  

