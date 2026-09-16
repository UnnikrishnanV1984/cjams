
--CDM-641 link to old servicecase

UPDATE intakeservicerequestactor set servicecaseid = NULL, updatedon = now(), updatedby = 'CDM-641'
WHERE servicecaseid = 'd57cf897-f758-42bf-80ff-64ad9b70e418' AND intakenumber = 'I202000460555';

UPDATE actor SET servicecaseid = NULL, updatedon = now(), updatedby = 'CDM-641' 
WHERE servicecaseid = 'd57cf897-f758-42bf-80ff-64ad9b70e418' AND intakenumber = 'I202000460555';

UPDATE personrole SET servicecaseid = NULL, updatedby = 'CDM-641', updatedon = now() 
WHERE servicecaseid = 'd57cf897-f758-42bf-80ff-64ad9b70e418' AND intakenumber = 'I202000460555' ;

SELECT * FROM createservicecase('b7893ff4-f914-43a0-9f70-8750abf2c645', '216e453a-5fe4-4d69-a951-f984b5e719f7', 
0, '82b1c827-bc1b-456e-a933-7a21a10aeb1e', '', 'intake'); 