/*
  Issue Description:CDM-43896 Duplicate family assignment issue 
  Category/ Module : Case Assignments
  Root cause:  B-202849 story changes had data fix which introduced duplicate family assignments for the reopen cases.
  Fix Provided: Data fix has been promoted to Remove dupliacte family assignment
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/
-- 202008601092,2020017401540,3179974,3205070,3301207,3303826,3281226,3171550,221030018757,2020033004425
update caseassignment
set activeflag = 0, updatedon = now(), updatedby = 'CDM-43896'
where caseassignmentid in ('c171b12d-445a-4cc8-8299-09de8900b0df',
'b5396e35-52b0-4f8b-8cfa-6bcb5ddcb569',
'6e81fa23-e742-4fe1-9153-139225482b84','cfae1745-d8eb-436d-8022-e7a6742562f6',
'2a515e60-a7ed-4563-9ebd-15b88044b2d8',
'6e722883-490b-486e-aad2-0eb4c766efc3',
'35cadb8c-2bce-4bf3-90b3-21ea6f901d85','84058f30-360c-41d8-8844-a0201d90022f','c2734faa-472b-4607-aea6-0aba4ce66924',
'55633201-5b7a-4f59-8196-a81aac099be0','c73fbb5b-143e-431d-ad2b-4f895597132e',
'f04629bb-e33e-47fe-a466-b5bc7390c71a',
'01e690a3-8ae3-4207-bb4a-1fafbd5beb3b',
'51d5e533-c428-4e8a-a50c-f7232213839f') and activeflag = 1;


update caseassignment
set fromteamid = '62f4f141-d1fe-4d68-8f88-60db503863c6',toteamid = '62f4f141-d1fe-4d68-8f88-60db503863c6',
fromldssid= '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b',toldssid = '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 
updatedon = now(), updatedby = 'CDM-43896'
where caseassignmentid in ('209824d1-7f6c-41ac-b576-611d873a4c9a') and activeflag = 1;