/*
Issue Description: Need data fix to retrive the records for moveperson_history on 05/16/2025.
Root cause: error happened during the Friday 05/16 prod datafix deployment, and In the Production env, some records was missing from moveperson_history table
Fix provided: Data fix has been done to update the data in moveperson_history table.
Data/Code fix ticket#: CIDM-10514
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Deployment issue and correction is needed to retive records as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--routingid: faf5e285-3e59-4b1a-8226-0b112d15ba40
--routingid: b5b340bf-6755-4149-bd57-faaf6480526b
INSERT INTO cjams.moveperson_history
(movepersonhistoryid, insertedby, insertedon, updatedby, updatedon, fromuserid, touserid, objectid, endvalue, status, activeflag, casetype, actiondescription, objecttype, "comments")
VALUES(gen_random_uuid(), '5b2d3202-0504-46b4-9e6b-9f3722cd01ab', '2025-05-16 11:20:38.667', '5b2d3202-0504-46b4-9e6b-9f3722cd01ab', '2025-05-16 11:24:55.345', '5b2d3202-0504-46b4-9e6b-9f3722cd01ab', '5b2bcf41-0610-4b6c-b62e-250d714750b5', 'e02208e3-21cb-4a87-ba4b-580624d74635', '[{"enddate":null,"objectid":"9071145e-08bb-434d-9f2c-0162a86f7c26","personid":"1e212781-82f6-4804-83c8-8bcbdae8fdec","endreason":null,"startdate":"2025-05-05T00:00:00","updatedby":"5b2bcf41-0610-4b6c-b62e-250d714750b5","casenumber":"251023050064","programkey":"CPS","endreasonkey":null,"clientmergeid":null,"datavalidflag":null,"objecttypekey":"servicerequest","subprogramkey":"IR","ifpsatriskflag":null,"personprogramid":"220fb650-09a4-48af-9c2b-55fa42824992","datatransferflag":"A","subprogram":"Investigative Response","programname":"CPS"}]'::jsonb, 'Approved', 1, 'CPS', 'Moved from Active to Inactive screen', 'actor', NULL);

--routingid: d1a51c88-0a47-4870-9ab9-3576f1c691a2
--routingid: 2447e5c2-38f9-4081-a634-3240e7243d69
INSERT INTO cjams.moveperson_history
(movepersonhistoryid, insertedby, insertedon, updatedby, updatedon, fromuserid, touserid, objectid, endvalue, status, activeflag, casetype, actiondescription, objecttype, "comments")
VALUES(gen_random_uuid(), '3957db54-d60d-4376-9f3d-248b42fafa98', '2025-05-16 11:20:38.667', '3957db54-d60d-4376-9f3d-248b42fafa98', '2025-05-16 09:32:54.269', '3957db54-d60d-4376-9f3d-248b42fafa98', '5e46d48e-82ff-45dc-9b4d-e68edb67cafc', 'fdf24541-4bb6-46a7-9446-fa79964e37da', '[{"enddate":"2025-05-16T16:56:41.649","objectid":"eba4cbec-cebc-46d2-a153-7edad5d3241b","personid":"e3097cce-5d81-4369-a5ba-f6067143a36d","startdate":"2025-05-16T00:00:00","updatedby":"5e46d48e-82ff-45dc-9b4d-e68edb67cafc","casenumber":"251023020404","programkey":"CPS","endreasonkey":null,"endreason":null,"subprogram":"Investigative Response","clientmergeid":null,"datavalidflag":null,"objecttypekey":"servicerequest","subprogramkey":"IR","ifpsatriskflag":0,"personprogramid":"fd2c5d4f-448b-4245-82d2-16e3f5e27834","datatransferflag":"U","programname":"CPS"}]'::jsonb, 'Approved', 1, 'CPS', 'Moved from Inactive to Active screen', 'actor', NULL);

--routingid: ad0a29fa-19a9-4ccf-b72b-516ca392664f
--routingid: 73d69271-6a3e-4ade-b583-800239d0ff69
INSERT INTO cjams.moveperson_history
(movepersonhistoryid, insertedby, insertedon, updatedby, updatedon, fromuserid, touserid, objectid, endvalue, status, activeflag, casetype, actiondescription, objecttype, "comments")
VALUES(gen_random_uuid(), '3957db54-d60d-4376-9f3d-248b42fafa98', '2025-05-16 11:20:38.667', '3957db54-d60d-4376-9f3d-248b42fafa98', '2025-05-16 09:33:01.902', '3957db54-d60d-4376-9f3d-248b42fafa98', '5e46d48e-82ff-45dc-9b4d-e68edb67cafc', 'e4540301-8e74-456a-8bba-b000e791210f', '[{"enddate":"2025-05-16T16:56:39.293","objectid":"eba4cbec-cebc-46d2-a153-7edad5d3241b","personid":"9679a892-8c11-4a1c-b606-7c2b7c790381","startdate":"2025-05-16T00:00:00","updatedby":"5e46d48e-82ff-45dc-9b4d-e68edb67cafc","casenumber":"251023020404","programkey":"CPS","endreasonkey":null,"endreason":null,"subprogram":"Investigative Response","clientmergeid":null,"datavalidflag":null,"objecttypekey":"servicerequest","subprogramkey":"IR","ifpsatriskflag":0,"personprogramid":"2653dcb8-df7d-4627-838d-39946326b162","datatransferflag":"U","programname":"CPS"}]'::jsonb, 'Approved', 1, 'CPS', 'Moved from Inactive to Active screen', 'actor', NULL);

--routingid: 18ac66c2-6b7f-416f-bb27-e66ed6153043
INSERT INTO cjams.moveperson_history
(movepersonhistoryid, insertedby, insertedon, updatedby, updatedon, fromuserid, touserid, objectid, endvalue, status, activeflag, casetype, actiondescription, objecttype, "comments")
VALUES(gen_random_uuid(), 'e406d0c2-71b3-4e65-b70f-1958cd3d3afd', '2025-05-16 11:20:38.667', 'e406d0c2-71b3-4e65-b70f-1958cd3d3afd', '2025-05-16 15:59:03.940', 'e406d0c2-71b3-4e65-b70f-1958cd3d3afd', '35e42a69-a74e-466e-9d1c-39d234acd8c9', '3bcd5c92-7fdc-4993-9a3e-ca924b030e93', '[{"enddate":null,"objectid":"c43b5cab-161c-4ddd-bcf8-d2039347aceb","personid":"ca7df6d1-78fe-4e45-a25d-65a6029cf7d9","endreason":null,"startdate":"2025-04-25T00:00:00","updatedby":"47dc653d-9089-4b47-b40e-0168ef6c2321","casenumber":"251023043969","programkey":"CPS","endreasonkey":null,"clientmergeid":null,"datavalidflag":null,"objecttypekey":"servicerequest","subprogramkey":"IR","ifpsatriskflag":null,"personprogramid":"251ee1c4-8301-4fbd-965a-a497c15aaf56","datatransferflag":"A","subprogram":"Investigative Response","programname":"CPS"}]'::jsonb, 'Review', 1, 'CPS', 'Moved from Active to Inactive screen', 'actor', NULL);


UPDATE cjams.actor
SET householdswitch='PRRV',
updatedby='CIDM-10514',
updatedon=now()
WHERE actorid='3bcd5c92-7fdc-4993-9a3e-ca924b030e93'::uuid and householdswitch is null;

UPDATE cjams.actor
SET householdswitch='PRAP',
updatedby='CIDM-10514',
updatedon=now()
WHERE actorid='fdf24541-4bb6-46a7-9446-fa79964e37da'::uuid and householdswitch is null;

UPDATE cjams.actor
SET householdswitch='PRAP',
updatedby='CIDM-10514',
updatedon=now()
WHERE actorid='e4540301-8e74-456a-8bba-b000e791210f'::uuid and householdswitch is null;

UPDATE cjams.actor
SET householdswitch='PRAP',
updatedby='CIDM-10514',
updatedon=now()
WHERE actorid='e02208e3-21cb-4a87-ba4b-580624d74635'::uuid and householdswitch is null;
