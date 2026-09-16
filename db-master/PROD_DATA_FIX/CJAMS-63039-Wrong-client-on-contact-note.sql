/*
   Issue Description:251023120864:Leon Myron Sutton SR. CJAMS PID#: 204212260 was added to the case and used as the ICC and parent. However, It was learned that Leon Myron Sutton Jr CJAMS PID#:204246312 is the ICC and parent.
    Sutton Sr is deceased. Can you do a fix where you change Contact ID: 15324940 and Contact ID: 15408987 to remove Leon Sr and add Leon Jr. 
   Category/ Module  : service log
   Root cause: User Erro/User Request, correct the contact id's 15404694 and 15324940 from Leon Myron Sutton Senior to  Leon Myron Sutto4n Junior.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
--adding date of death (5/10/2024) for Leon Myron Sutton Sr.

update person
set dateofdeath = '2024-05-10 00:00:00',
    updatedby = 'CJAMS-63039',
    updatedon = now()
where personid = '5a22cb67-bd4a-46ae-a314-696f57ef326b'
and activeflag = 1;


update contactparticipant 
set intakeservicerequestactorid = '43dbcf5e-30dd-48fe-b3e6-ff47234d12e3',--b9d3c307-5c2a-402f-80d3-c15d13abbb14
	updatedby = 'CJAMS-63039',
	updatedon = now()
where progressnoteid in ('5de9b6d7-b3f0-45e6-8275-2ecfb4df1eae','4dcc5c91-7ab3-480a-acd7-3ecd8e1d27d7')
	and activeflag =1
	and contactparticipantid in ('2bf5bfdd-ef75-4bdd-9aa7-d246ee1a77a5','9aed25ed-ae4c-45bd-84c6-f5088c4e1ab1');

-- replace the incorrect client with the correct one in the contacts.
--select focusperson ,witsid ,* from progressnote p where witsid in ('15324940','15404694');

UPDATE progressnote
SET focusperson = jsonb_set(
    jsonb_set(
        focusperson::jsonb,
        '{focuspersonjson,0,intakeservicerequestactorid}',
        '"43dbcf5e-30dd-48fe-b3e6-ff47234d12e3"'
    ),
    '{focuspersonjson,0,participantid}',
    '"43dbcf5e-30dd-48fe-b3e6-ff47234d12e3"'
),
updatedby = 'CJAMS-63039',
updatedon = now()
WHERE progressnoteid = '5de9b6d7-b3f0-45e6-8275-2ecfb4df1eae'
	AND activeflag = 1
	and focusperson::jsonb -> 'focuspersonjson' -> 0 ->> 'participantid' = '2d3bf2e4-f5f8-4f14-a91c-e21a5ab5fd92'
   and intakeserviceid = '03265ced-084c-4c32-a9d0-f5e576890e39';
  
  
UPDATE progressnote
SET focusperson = jsonb_set(
    jsonb_set(
        focusperson::jsonb,
        '{focuspersonjson,0,intakeservicerequestactorid}',
        '"43dbcf5e-30dd-48fe-b3e6-ff47234d12e3"'
    ),
    '{focuspersonjson,0,participantid}',
    '"43dbcf5e-30dd-48fe-b3e6-ff47234d12e3"'
),
updatedby = 'CJAMS-63039',
updatedon = now()
WHERE progressnoteid = '4dcc5c91-7ab3-480a-acd7-3ecd8e1d27d7'
	AND activeflag = 1
	and focusperson::jsonb -> 'focuspersonjson' -> 0 ->> 'participantid' = '2d3bf2e4-f5f8-4f14-a91c-e21a5ab5fd92'
   and intakeserviceid = '03265ced-084c-4c32-a9d0-f5e576890e39';