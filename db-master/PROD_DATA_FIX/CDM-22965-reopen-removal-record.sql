/*
-- CDM-22965- 

-- Issue Description: 
 Unable to reopen the removal record
  
-- Customer Email ID: jonathan.albright@maryland.gov

-- Root cause: Data fix to reopen the removal record
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservreqchildremoval  set activeflag = 0,
updatedby = 'CDM-22965', updatedon = now() where intakeservreqchildremovalid  in ('6a513c23-bb2f-4b1f-a9d5-9b80f123fe4c','634685e8-a5ce-4d0d-b1c7-2608454a0ae7') and activeflag = 1;

-- 2021-09-30 13:00:00.000, OTHER
update intakeservreqchildremoval  set exitdate  = null,removalexitreason = NULL,
updatedby = 'CDM-22965', updatedon = now() where intakeservreqchildremovalid  in ('b2219777-d359-432c-8644-f4b59c620611','8e061790-79cd-467f-9c37-10d07e52f428');


update personprogramarea  set activeflag = 0, updatedon = now(), updatedby = 'CDM-22965' where personprogramid  in ('cb04d671-006e-472b-9b4f-49a9a389f6e5', '70087adb-bace-4e98-8aac-1956840b37c3');

-- 2021-09-30
update personprogramarea  set enddate  = null, updatedon = now(), updatedby = 'CDM-22965' where personprogramid  in ('f9434240-e645-42da-98ed-21700a44fc52', '8ae5d844-60cf-4ff8-80a5-32ef112c86be');

-- 634685e8-a5ce-4d0d-b1c7-2608454a0ae7
update placement set intakeservreqchildremovalid = '8e061790-79cd-467f-9c37-10d07e52f428', updatedby = 'CDM-22965', updatedon =  now()
where placementid = '6ada8631-df02-46ed-ae0b-732db9219a68';