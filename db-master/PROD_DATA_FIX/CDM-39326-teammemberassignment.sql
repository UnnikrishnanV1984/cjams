/*
   Issue Description: CDM-39326
   Category/ Module : Multicounty setup
   Root cause: 
   Fix Provided: Did data fix to do multicounty setup 

*/
UPDATE cjams.teammemberassignment
SET teammemberid='b2919def-cfb9-4ca1-aa0d-3cd7ad10cd7f', updatedby='CDM-39326', updatedon=now()
WHERE teammemberassignmentid='76c5b0ed-eb54-40d7-b706-03892c5ef6e1' and securityusersid='8b7692be-2fbc-49fd-9dce-78666f986886';
UPDATE cjams.teammemberassignment
SET teammemberid='70b8c1a2-ad45-4d63-8a1e-77e478170690', updatedby='CDM-39326', updatedon=now()
WHERE teammemberassignmentid='43b121d1-e4da-4def-b97c-ab25219e4b89' and securityusersid='8b7692be-2fbc-49fd-9dce-78666f986886';
UPDATE cjams.teammemberassignment
SET teammemberid='66739501-1615-4e14-9713-44ce7aad9f20', updatedby='CDM-39326', updatedon=now()
WHERE teammemberassignmentid='05b4efa1-3adc-4641-a608-b8d1dc028cab' and securityusersid='8b7692be-2fbc-49fd-9dce-78666f986886';
update teammember
set teamid = '1bf3e463-8c28-44cc-840f-8c5e43a6dd7b', updatedby= 'CDM-39326', updatedon = now(), supervisorid = '82b1c827-bc1b-456e-a933-7a21a10aeb1e'
where teammemberid = 'c0f61019-f430-4b33-aec0-b55e0f897bd4';