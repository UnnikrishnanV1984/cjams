/*
Issue Description: I251013308979:Service case # 251030525645The case was screened in as a SEN case, however the hospital called back to report that this is NOT a SEN baby. 
There will be NO CWS response and a case should not have been opened. This should be deleted.
Category/Module: Error
Root cause: User Error/Request
Fix provided: DB queries to update the SEN flag, remove service case add said additional data to the intake narrative
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

-- remove sen flag
/*
select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	substanceexposednewborntimetamp, substanceclasses, othersubstances, senstatusflag, updatedby, updatedon 
from person
where cjamspid = 204166277
	and activeflag = 1;
*/

update person
set substanceexposednewbornflag = NULL,  -- 1
	substanceexposednewbornsourcetypekey = NULL, -- '2954'
	substanceexposednewbornsourceid = NULL, -- 'I251013308979'
	substanceexposednewborntimetamp = NULL, -- '2025-06-18 14:40:42'
	substanceclasses = NULL, -- '["["BBS"]"]'
--	othersubstances = NULL, -- NULL
	senstatusflag = NULL, -- 1
	updatedby = 'CJAMS-60276', 
	updatedon = now()
where personid = '2e986449-c69f-485a-977e-43765b82d2cb'
	and activeflag = 1;

-- screening out the intake
/*
select * from dispositioncode where dispositioncode = 'Accepted'
select jsondata,* from intakesnapshot
WHERE intakenumber = 'I251013308979' AND activeflag=1;
*/

UPDATE intakesnapshot
set updatedby = 'CJAMS-60276',
	updatedon = now(),
	jsondata = jsonb_set(jsondata, '{DAType}',
		jsonb_set(jsondata->'DAType', '{DATypeDetail}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
		jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))
		)
WHERE intakenumber = 'I251013308979' AND activeflag=1;

/*
select jsondata,* from intakedastaging
WHERE intakenumber = 'I251013308979' AND activeflag=1;
*/

UPDATE intakedastaging
SET status = 'Closed',
    updatedby = 'CJAMS-60276',
    updatedon = now(),
    jsondata = jsonb_set(
        jsonb_set(
            jsondata, '{DAType,DATypeDetail,0}',
            jsonb_set(
                jsonb_set(
                    jsondata->'DAType'->'DATypeDetail'->0,
                    '{supDisposition}', '"ScreenOUT"'::jsonb
                ),
                '{supStatus}', '"Approved"'::jsonb
            )
        ),
        '{disposition,0}',
        jsonb_set(
            jsonb_set(
                jsondata->'disposition'->0,
                '{supDisposition}', '"ScreenOUT"'::jsonb
            ),
            '{supStatus}', '"Approved"'::jsonb
        )
    )
WHERE intakenumber = 'I251013308979' 
AND activeflag = 1;

/*
select supervisordecision,updatedby,fromsecurityusersid,tosecurityusersid,* from routing where objectid = 'I251013308979' and activeflag =1;
select * from userprofile where securityusersid = 'fc251376-8745-4381-a750-6a617c748678'
--from: 9c424094-8dc4-4015-9a32-3a7020615f11 --kim

select * from routing where routingid = 'f05d81ae-5b6c-47b3-a275-d15dd878507c'
*/
update routing set routingstatustypeid =8,
	supervisordecision = 'ScreenOUT'
where objectid='I251013308979' and activeflag=1;

/*
select intakeservicerequestclassid,* from intakeservicerequest where servicerequestnumber = '251030525645'; --isID:c5d50540-44b1-44b1-8ef1-d7ff33f6abe5
select activeflag,routingstatustypeid,routingid,supervisordecision,* from routing where objectid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5' and activeflag = 1;
*/
--select * from servicecase where servicecasenumber = '251030525645'; --ROH

-- routingid: c5d50540-44b1-44b1-8ef1-d7ff33f6abe5
--select * from routing where objectid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5';

update routing
set activeflag = 0, updatedby = 'CJAMS-60276', updatedon = now() 
where objectid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5' and activeflag = 1;


--remove the case

/*
 * not the CPS Case
--remove the case
update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-60124', updatedon = now() 
where intakeserviceid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5';
*/

update servicecase set activeflag =0, updatedby = 'CJAMS-60276', updatedon = now() 
where servicecaseid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5' and activeflag=1;

update servicecasedisposition set activeflag = 0, updatedby = 'CJAMS-60276', updatedon = now() 
where servicecaseid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5' and activeflag=1;

/*
select * from personprogramarea where objectid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5' and activeflag = 1;
*/
/*UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CJAMS-60276'
WHERE objectid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5' and activeflag = 1;*/

update caseassignment
set activeflag = 0, updatedby = 'CJAMS-60276', updatedon = now() 
where objectid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5' and activeflag = 1;


-- Updating Narrative
--select jsondata,* from intakedastaging where intakenumber = 'I251013308979' and activeflag=1;
--Updating jsondata in intakedastaging
update intakedastaging
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><br></p><p>6/24/2025: Information provided on 6/18/2025, after the initial intake, resulted in a change to the screening decision. On 6/18/2025, hospital Social Worker Michelle Taylor reported that a CWS response is not necessary because the SENS report was done in error by the reporting source (SW Maria Cole). <br> She said that Ms. Cole misunderstood the information. Ms. Taylor reported the substance that resulted in a positive drug result has been verified to be a prescription administered to mom during her pregnancy. Ms. Taylor confirmed that mother has been sober for a year.</p>')
	),
	updatedby = 'CJAMS-60276', updatedon = now()
where intakenumber = 'I251013308979' and activeflag = 1;

--Updating jsondata in intakedastatus

update intakedastatus
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><br></p><p>6/24/2025: Information provided on 6/18/2025, after the initial intake, resulted in a change to the screening decision. On 6/18/2025, hospital Social Worker Michelle Taylor reported that a CWS response is not necessary because the SENS report was done in error by the reporting source (SW Maria Cole).<br> She said that Ms. Cole misunderstood the information. Ms. Taylor reported the substance that resulted in a positive drug result has been verified to be a prescription administered to mom during her pregnancy. Ms. Taylor confirmed that mother has been sober for a year.</p>')
	),
	updatedby = 'CJAMS-60276', updatedon = now()
where intakenumber = 'I251013308979' and activeflag = 1;

--Updating jsondata in intakesnapshot
update intakesnapshot
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><br></p><p>6/24/2025: Information provided on 6/18/2025, after the initial intake, resulted in a change to the screening decision. On 6/18/2025, hospital Social Worker Michelle Taylor reported that a CWS response is not necessary because the SENS report was done in error by the reporting source (SW Maria Cole). <br>She said that Ms. Cole misunderstood the information. Ms. Taylor reported the substance that resulted in a positive drug result has been verified to be a prescription administered to mom during her pregnancy. Ms. Taylor confirmed that mother has been sober for a year.</p>')
	),
	updatedby = 'CJAMS-60276', updatedon = now()
where intakenumber = 'I251013308979' and activeflag = 1;

-- actor, intakeservicerequestactor, personrole, actorrelationship, personprogramarea and personroletype table for service case # 251030525645 ?
--select * from actor where servicecaseid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5';
update actor
set activeflag = 0,
	updatedby = 'CJAMS-60276',
	updatedon = now()
where actorid in (
'4d935210-ddd8-4c34-a11b-3a25a810f1e2',
'6e67b7c2-e7b7-4205-bf38-9d4d2bcc5b0e',
'ae5aa351-fd1c-406c-8747-85d0346fb4c0'
) and servicecaseid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5'
and activeflag = 1;

--select * from personrole where servicecaseid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5'

update personrole
set activeflag = 0,
	updatedby = 'CJAMS-60276',
	updatedon = now()
where personroleid in (
'440c94d5-86b0-4e39-a567-dd0a2f816782',
'ed7d1ea4-7d8d-41f4-97bf-0b6e09314ca2',
'f37d9c23-46e7-4e5b-885a-7a8a829a3949'
) and servicecaseid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5'
and activeflag = 1;

--select * from actorrelationship where servicecaseid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5'

update actorrelationship
set activeflag = 0,
	updatedby = 'CJAMS-60276',
	updatedon = now()
where actorrelationshipid in (
'0af3b6a9-e055-4298-98a7-a1aa5d5641a4',
'ff29d420-8068-4189-9f51-43a6b0247a7e',
'92150147-1b7d-4eac-811e-68f37016ee28',
'c35e8d59-3855-471f-ac5f-d1b3363fff93',
'37543e2b-ccb6-41da-a033-8c8eae38c0e0',
'0ce034aa-27d2-44d1-b307-aa4b71135b86'
) and servicecaseid = 'c5d50540-44b1-44b1-8ef1-d7ff33f6abe5'
and activeflag = 1;

--No program area for this case
-- personroletype 

/*
select * from personroletype where personroleid in (
'440c94d5-86b0-4e39-a567-dd0a2f816782',
'ed7d1ea4-7d8d-41f4-97bf-0b6e09314ca2',
'f37d9c23-46e7-4e5b-885a-7a8a829a3949'
) 
and activeflag = 1;
*/

update personroletype
set activeflag = 0,
	updatedby = 'CJAMS-60276',
	updatedon = now()
where personroleid in (
'440c94d5-86b0-4e39-a567-dd0a2f816782',
'ed7d1ea4-7d8d-41f4-97bf-0b6e09314ca2',
'f37d9c23-46e7-4e5b-885a-7a8a829a3949'
) and activeflag = 1;