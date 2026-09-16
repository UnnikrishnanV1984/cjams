/*
 * CIDM-8438 - Approved intakes shows as drafts in report
 * Description - As per RE866R report, the attached list of intakes are showing as in 'Draft' or 'Review' statuses.
 * While looking into the application, many are already approved by the supervisor but some information are missing.
 * https://docs.google.com/spreadsheets/d/1yGePzkycNBPm7ch-ftwZr7sRacKLm2rR/edit#gid=1480495526
 * 
 */

--No Submission History
DELETE FROM cjams.routing WHERE insertedby = '42e2b86d-e58d-494a-9a13-175ba7a54e50' and objectid = 'I202000683665'; 
INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('INTR', 'd3952938-0fc1-4032-b129-07ae6236c00a', '42e2b86d-e58d-494a-9a13-175ba7a54e50', '1925cd78-850b-419e-b25b-c21a5a91440f'::uuid, 'CWSP', 'CWCW', 'I202000683665', 2, 1, '42e2b86d-e58d-494a-9a13-175ba7a54e50', '2024-02-27 11:25:35.322', '42e2b86d-e58d-494a-9a13-175ba7a54e50', '2024-02-27 11:25:35.322', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--Supervisor Decision shows as Screen Out but Submission history is in review
update routing set routingstatustypeid = 8 where objectid='I202000694088';
UPDATE intakedastaging
SET status = 'Closed', 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000694088' AND activeflag=1;

--Intake Recommendation is missing
update routing set routingstatustypeid = 1 where objectid='I202000206340';
UPDATE intakedastaging
SET 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{dispositioncode}', '"Scrnin"'))))
WHERE intakenumber = 'I202000206340' AND activeflag=1;

--Intake Recommendation is missing
update routing set routingstatustypeid = 1 where objectid='I202100247314';
UPDATE intakedastaging
SET 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{dispositioncode}', '"Scrnin"'))))
WHERE intakenumber = 'I202100247314' AND activeflag=1;

--Intake Recommendation is missing
update routing set routingstatustypeid = 1 where objectid='I202100232484';
UPDATE intakedastaging
SET 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{dispositioncode}', '"Scrnin"'))))
WHERE intakenumber = 'I202100232484' AND activeflag=1;

--Intake Recommendation is missing
update routing set routingstatustypeid = 1 where objectid='I202100418998';
UPDATE intakedastaging
SET 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{dispositioncode}', '"Scrnin"'))))
WHERE intakenumber = 'I202100418998' AND activeflag=1;

--Intake Recommendation is missing
update routing set routingstatustypeid = 1 where objectid='I202100541956';
UPDATE intakedastaging
SET 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{dispositioncode}', '"Scrnin"'))))
WHERE intakenumber = 'I202100541956' AND activeflag=1;

--Intake Recommendation is available and Supervisor decision is available but Submission history is showing as Review 
update routing set routingstatustypeid = 8 where objectid='I202000562690';
UPDATE intakedastaging
SET status = 'Closed', 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000562690' AND activeflag=1;

--Intake Recommendation is missing
select * from intakedastaging where intakenumber in ('I231010950957') AND activeflag=1;
update routing set routingstatustypeid = 1 where objectid in ('I231010950957');
UPDATE intakedastaging
SET 
jsondata = jsonb_set(jsondata, '{DAType}','{
    "DATypeDetail": [
      {
        "caseID": "",
        "DAStatus": "Review",
        "DaTypeKey": "247a8b26-cdee-4ce8-b36e-b37e49fd0103",
        "intakeAction": "",
        "issubtypekey": true,
        "DADisposition": "Scrnin",
        "serviceTypeID": "",
        "dispositioncode": "Scrnin",
        "ServiceRequestNumber": "I231010950957",
        "intakeserreqstatustypekey": "Review",
        "supMultipleDispositionDropdown": [],
        "intakeMultipleDispositionDropdown": [
          {
            "text": "Screen In",
            "value": "Scrnin"
          },
          {
            "text": "Screen Out",
            "value": "ScreenOUT"
          }
        ]
      }
    ]
  }')
WHERE intakenumber in ('I231010950957') AND activeflag=1;

--Supervisor Decision shows as Screen Out but Submission history is in Routed to Servicecase
update routing set routingstatustypeid = 8 where objectid='I221010239296';
UPDATE intakedastaging
SET status = 'Closed', 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010239296' AND activeflag=1;

