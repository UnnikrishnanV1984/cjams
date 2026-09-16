/*
Issue Description3290046:The CPS worker selected the wrong client Michael Duplicate- 204006097, instead of the child -4258270 that is in OHP. There needs to a program assignment with correct client in CJAMS. Since this is considered to be an Out of Home Maltreatment. I need the CPS history added to the correct client 
Root cause: User request deactive unnecessary record,activare required record into intake because of user can able to create they do not access to delete that record.
Fix provided: Data fix was done by Updated actor with related table.
Data/Code fix ticket#:CJAMS-60682
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
delete from actor where updatedby = 'CJAMS-60682';
delete from actorrelationship where updatedby = 'CJAMS-60682';
delete from actorrelationship where updatedby = 'CJAMS-60682';
delete  from personrole where updatedby = 'CJAMS-60682';
*/

--replace the incorrect client with the correct one in the contacts 
update intakeservicerequestactor
set personid ='6ef46165-67ae-44de-b105-7a750710a7c9',updatedby = 'CJAMS-60682', updatedon = now(),actorid ='0705d9aa-4589-4aa1-8163-e5d59a4082b3'
where intakeservicerequestactorid = '227f85d8-4342-4006-a3b1-c18f240827ba' and activeflag=1;


--delete the wrong client(CJAMS ID: 204006097) from the  case.
update actor
set activeflag = 0, updatedby = 'CJAMS-60682',updatedon = now()
where actorid = '3b37817d-cc4a-4f49-9e29-aeb3456c9546' and activeflag =1;

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-60682',updatedon = now()
where intakeservicerequestactorid in ('40ab8da5-5d0a-4a15-9ea9-2565e133d52a')and activeflag=1;

update actorrelationship
set activeflag = 0, updatedby = 'CJAMS-60682',updatedon = now()
where actorrelationshipid in ('21ab7790-877c-45e8-8dae-759871abe86f',
'bdbaa7a4-c3be-46a2-bdf4-9628fbe498e1',
'6508c459-e63f-4899-a10c-eef94edf2ba9',
'000c5c73-16dd-4615-87c7-5c3ff3cfd337',
'16bba2f2-4a30-481f-8670-1a19c59d007b',
'117f3e05-36b3-42d9-ae87-0af278aa3646') and activeflag=1;

update personrole
set activeflag = 0, updatedby = 'CJAMS-60682',updatedon = now()
where personroleid  = 'f4994482-8035-4547-ae9c-389a5b2c6de7' and activeflag =1;

--delete the wrong client(CJAMS ID: 204006097) from the intake 
update actor
set activeflag = 0, updatedby = 'CJAMS-60682',updatedon = now()
where actorid = '335a55ce-6860-45de-84e6-36d6d35fd590' and activeflag =1;

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-60682',updatedon = now()
where intakeservicerequestactorid in ('91307132-3b77-450b-86eb-c16f73ffdb8c','f5aaee77-9076-43bd-8916-efa55318cd03')and activeflag=1;

update actorrelationship
set activeflag = 0, updatedby = 'CJAMS-60682',updatedon = now()
where actorrelationshipid = '9eb975c7-8edd-4ae6-b3ad-fb26bc0c7333' and activeflag=1;

update personrole
set activeflag = 0, updatedby = 'CJAMS-60682',updatedon = now()
where personid = 'f35beaa2-0055-4dd4-9ec9-e40043d62947' and activeflag =1;

 update personprogramarea 
set activeflag =0,updatedby = 'CJAMS-60682',updatedon = now()
 where personid = 'd08a4cf7-ec18-487c-a81f-6f09a6a1ea29' and activeflag =1;

--Add the correct client(CJAMS ID:4258270) in the intake.
insert into actor
(actorid,activeflag,personid,actortype,insertedby,insertedon,updatedby,updatedon,intakeserviceid,intakenumber)
values
(gen_random_uuid(), '1','6ef46165-67ae-44de-b105-7a750710a7c9','RA', 'CJAMS-60682',now(),'CJAMS-60682',now(),'f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518');

insert into intakeservicerequestactor
(intakeservicerequestactorid,activeflag,actorid,personid,intakeservicerequestpersontypekey,insertedby,insertedon,updatedby,updatedon,intakeserviceid,intakenumber)
values
(gen_random_uuid(), '1','0705d9aa-4589-4aa1-8163-e5d59a4082b3','6ef46165-67ae-44de-b105-7a750710a7c9','CHILD',  'CJAMS-60682',now(),'CJAMS-60682',now(), 'f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518'),
(gen_random_uuid(), '1','0705d9aa-4589-4aa1-8163-e5d59a4082b3','6ef46165-67ae-44de-b105-7a750710a7c9','AV',      'CJAMS-60682',now(),'CJAMS-60682',now(),'f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518');


insert into actorrelationship
(actorrelationshipid,activeflag,intakeservicerequestactorid,relationshiptypekey,person1id,intakeserviceid,intakenumber,updatedby,updatedon,insertedby,insertedon)
values
(gen_random_uuid(),'1','4dbeb8cf-f9c7-44a6-8126-3f043d676626','BGCHLD',     '6ef46165-67ae-44de-b105-7a750710a7c9','f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518','CJAMS-60682',now(),'CJAMS-60682',now()),
(gen_random_uuid(),'1','4dbeb8cf-f9c7-44a6-8126-3f043d676626','BIOBR',      '6ef46165-67ae-44de-b105-7a750710a7c9','f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518','CJAMS-60682',now(),'CJAMS-60682',now()),
(gen_random_uuid(),'1','4dbeb8cf-f9c7-44a6-8126-3f043d676626','BGCHLD',     '6ef46165-67ae-44de-b105-7a750710a7c9','f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518','CJAMS-60682',now(),'CJAMS-60682',now()),
(gen_random_uuid(),'1','4dbeb8cf-f9c7-44a6-8126-3f043d676626','MATNLNPW',   '6ef46165-67ae-44de-b105-7a750710a7c9','f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518','CJAMS-60682',now(),'CJAMS-60682',now()),
(gen_random_uuid(),'1','4dbeb8cf-f9c7-44a6-8126-3f043d676626','MATNLNPW',   '6ef46165-67ae-44de-b105-7a750710a7c9','f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518','CJAMS-60682',now(),'CJAMS-60682',now()),
(gen_random_uuid(),'1','4dbeb8cf-f9c7-44a6-8126-3f043d676626','PRNTLGCHLD', '6ef46165-67ae-44de-b105-7a750710a7c9','f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518','CJAMS-60682',now(),'CJAMS-60682',now());


insert into personrole
(personroleid,activeflag,personid,insertedby,insertedon,updatedby,updatedon,intakeserviceid,intakenumber)
values
(gen_random_uuid(),'1','6ef46165-67ae-44de-b105-7a750710a7c9','CJAMS-60682',now(),'CJAMS-60682',now(),'f120e7a4-597d-4d2d-ad93-e341f4908ca9','I251013302518');


--replace the incorrect client with the correct one in the  safe-c assessment.
update assessment
SET submissiondata = (
    SELECT jsonb_set(
        submissiondata::jsonb,
        '{childdatagrid}',
        to_jsonb((
            SELECT jsonb_agg(
                CASE
                    WHEN elem ->> 'clientid' = '204006097' THEN
                        jsonb_build_object(
                            'age', '7 Yrs',
                            'clientid', '4258270',
                            'childname', ' MICHAEL S FOLEY III'
                        )
                    ELSE
                        elem
                END
            )
            FROM jsonb_array_elements(submissiondata::jsonb -> 'childdatagrid') elem
        ))
    )
),
updatedby = 'CJAMS-60682',
updatedon = now()
WHERE assessmentid = 'c05771a3-92e9-4938-9e75-b7be47021143'
  AND activeflag = 1;

-- replace the incorrect client with the correct one in the contacts .
 UPDATE progressnote
SET focusperson = jsonb_set(
    jsonb_set(
        focusperson::jsonb,
        '{focuspersonjson,0,intakeservicerequestactorid}',
        '"afad6542-3a05-44a5-87d4-bc5e37255e7d"'
    ),
    '{focuspersonjson,0,participantid}',
    '"afad6542-3a05-44a5-87d4-bc5e37255e7d"'
),
updatedby = 'CJAMS-60682',
updatedon = now()
WHERE focusperson::jsonb -> 'focuspersonjson' -> 0 ->> 'participantid' = '227f85d8-4342-4006-a3b1-c18f240827ba'
  AND activeflag = 1 and intakeserviceid = 'f120e7a4-597d-4d2d-ad93-e341f4908ca9'
      AND entitytypeid = 'f120e7a4-597d-4d2d-ad93-e341f4908ca9';
      
      

