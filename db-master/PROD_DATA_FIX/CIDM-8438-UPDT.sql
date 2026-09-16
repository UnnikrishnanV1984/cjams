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

UPDATE intakesnapshot 
SET updatedby = 'CIDM-8438', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber in ('I202000683665', 'I202100217791') AND activeflag=1;
UPDATE intakedastaging 
SET updatedby = 'CIDM-8438', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber in ('I202000683665', 'I202100217791') AND activeflag=1;

--Intake Recommendation is missing
update routing set routingstatustypeid = 1 where objectid='I202000206340';
UPDATE intakedastaging
SET 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{dispositioncode}', '"Scrnin"'))))
WHERE intakenumber in ('I202000206340','I202100541956') AND activeflag=1;

UPDATE cjams.routing
SET eventcode='INTR', tosecurityusersid='5611119d-16d8-4a4e-b045-5ab9734e01ba', activeflag=1 
WHERE routingid='d698b4e7-b517-4b1f-a656-88e9e6a1c6f2' and objectid = 'I202000206340';

UPDATE cjams.routing
SET eventcode='INTR', activeflag=1 
WHERE routingid='a4e30d4e-83e8-457c-9881-523e7e2a25f3' and objectid = 'I202100541956';

--Intake Recommendation is missing
--select * from v_userprofile where email = 'carmen.phelps@maryland.gov';
UPDATE cjams.routing
SET eventcode='INTR', activeflag=1, routingstatustypeid = 1 
WHERE routingid='43db2122-2644-4432-9bc1-4d685409b6bd' and objectid = 'I202000172656';
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
        "ServiceRequestNumber": "I202000172656",
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
WHERE intakenumber in ('I202000172656') AND activeflag=1;


