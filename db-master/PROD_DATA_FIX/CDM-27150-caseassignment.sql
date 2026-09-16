/*
   Issue Description: CDM-27150
   Category/ Module  : INtake
   Root cause: user requested  to 
     1. Select the service type as In Home Service and Service to Family and Children.
     2. Create a service case and connect to the referral.
     3. Assign the service case to Tracy Donaghue (tracy.donaghue@maryland.gov)
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- Create a servicecase
select * from cjams.createservicecase('0d661895-d594-464f-9b2f-d9be55c04605', null, 1, 'ca0e23df-c05e-4f45-8815-a3abfd8b0e18', 'intake', '');

--case assignment for that service case
INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno,
fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, 
tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid,
responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype,
fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype)
VALUES(gen_random_uuid(), gen_random_uuid(), NULL, 'ca0e23df-c05e-4f45-8815-a3abfd8b0e18', NULL, NULL, '2e986755-60ff-467d-922b-1f2e1438b9d6'
, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ca0e23df-c05e-4f45-8815-a3abfd8b0e18', 
'CDM-27150', '2022-12-06 16:33:09.426', 'now()', 'servicecase',
(select servicecaseid from servicecase
where servicecaseid = (
select servicecaseid 
from intakeservicerequest where intakenumber = 'I221010342983'
)),
 'family', 1, '2022-12-06 16:33:09.426', NULL, 'cb7d5453-fd10-4439-8581-81e2be53c34c',
'cb7d5453-fd10-4439-8581-81e2be53c34c', '', NULL, 'cd1940bd-e41d-4d9f-8f73-936fdf05a2cf', 'cd1940bd-e41d-4d9f-8f73-936fdf05a2cf', 
'W', NULL, '2022-12-06 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--updating supervisor decision to SCREEN IN
UPDATE intakesnapshot
SET
updatedby = 'CDM-27150', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Scrnin"'))))
WHERE intakenumber = 'I221010342983' AND activeflag=1; 


---INHOME-SERVICE NEEDS TO BE CHECKED
update intakedastaging
set updatedby = 'CDM-27150', updatedon = now(), jsondata = replace(jsondata::text,
'"intakeservice": [{"intakesubservice": [{"activeflag": 1, "intakeservid": "34ed3645-252d-4b1f-8b40-c3387087fed4", "typedescription": "Voluntary Placement", "intakeservsubtypeid": "4e2cb2f6-004d-4bbb-95e4-d56e360d2547", "intakeservsubtypekey": "VP"}]}]',
'"intakeservice":[{"description":"In Home Services","intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","intakesubservice":[{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Services to Family and Children","intakeservsubtypeid":"03b7c2e7-09b1-4d0b-9d29-a12f53379fe2","intakeservsubtypekey":"FPS"}],"intakeservsubtype":[{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Request of Other Agency","intakeservsubtypeid":"022cb37c-bd74-4dc4-8014-d6d9a2889364","intakeservsubtypekey":"ROA"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Services to Family and Children","intakeservsubtypeid":"03b7c2e7-09b1-4d0b-9d29-a12f53379fe2","intakeservsubtypekey":"FPS"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Kinship Navigator","intakeservsubtypeid":"0b932ef3-d4eb-44ea-9035-0fef6e7331ca","intakeservsubtypekey":"SGP"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Interagency Family Preservation Services","intakeservsubtypeid":"269ea9f0-55ad-4fa6-95e6-0c1b646cd5f0","intakeservsubtypekey":"IFPS"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Voluntary Placement","intakeservsubtypeid":"4e2cb2f6-004d-4bbb-95e4-d56e360d2547","intakeservsubtypekey":"VP"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Independent Living After Care Services","intakeservsubtypeid":"5e6358b3-e242-45aa-a16b-d28ad836ba08","intakeservsubtypekey":"ILAC"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Consolidated Services","intakeservsubtypeid":"cb3dc65e-4c48-4b65-8059-53ae4321f6bc","intakeservsubtypekey":"COS"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Request to file a CINA petition","intakeservsubtypeid":"ce037f63-18a6-4990-80bb-c8a9631d0739","intakeservsubtypekey":"RFCP"}],"intakeservtypekey":"IHS"}]')::json
 where intakenumber = 'I221010342983' and activeflag = 1;


 update intakesnapshot
set updatedby = 'CDM-27150', updatedon = now(), jsondata = replace(jsondata::text,
'"intakeservice": [{"intakesubservice": [{"activeflag": 1, "intakeservid": "34ed3645-252d-4b1f-8b40-c3387087fed4", "typedescription": "Voluntary Placement", "intakeservsubtypeid": "4e2cb2f6-004d-4bbb-95e4-d56e360d2547", "intakeservsubtypekey": "VP"}]}]',
'"intakeservice":[{"description":"In Home Services","intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","intakesubservice":[{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Services to Family and Children","intakeservsubtypeid":"03b7c2e7-09b1-4d0b-9d29-a12f53379fe2","intakeservsubtypekey":"FPS"}],"intakeservsubtype":[{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Request of Other Agency","intakeservsubtypeid":"022cb37c-bd74-4dc4-8014-d6d9a2889364","intakeservsubtypekey":"ROA"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Services to Family and Children","intakeservsubtypeid":"03b7c2e7-09b1-4d0b-9d29-a12f53379fe2","intakeservsubtypekey":"FPS"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Kinship Navigator","intakeservsubtypeid":"0b932ef3-d4eb-44ea-9035-0fef6e7331ca","intakeservsubtypekey":"SGP"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Interagency Family Preservation Services","intakeservsubtypeid":"269ea9f0-55ad-4fa6-95e6-0c1b646cd5f0","intakeservsubtypekey":"IFPS"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Voluntary Placement","intakeservsubtypeid":"4e2cb2f6-004d-4bbb-95e4-d56e360d2547","intakeservsubtypekey":"VP"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Independent Living After Care Services","intakeservsubtypeid":"5e6358b3-e242-45aa-a16b-d28ad836ba08","intakeservsubtypekey":"ILAC"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Consolidated Services","intakeservsubtypeid":"cb3dc65e-4c48-4b65-8059-53ae4321f6bc","intakeservsubtypekey":"COS"},{"activeflag":1,"intakeservid":"34ed3645-252d-4b1f-8b40-c3387087fed4","typedescription":"Request to file a CINA petition","intakeservsubtypeid":"ce037f63-18a6-4990-80bb-c8a9631d0739","intakeservsubtypekey":"RFCP"}],"intakeservtypekey":"IHS"}]')::json
 where intakenumber = 'I221010342983' and activeflag = 1;








