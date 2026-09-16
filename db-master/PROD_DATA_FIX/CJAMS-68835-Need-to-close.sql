/*
   Issue Description: CJAMS-68835 
   Category/ Module  :Assignments
   Root cause:  End date assignment for the mentioned case
      Please carry out below data fix 
            Assignments tab - Update the End Date as 07/09/2026
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update caseassignment 
set enddate = '2026-07-06 00:31:12.963', updatedby = 'CJAMS-68835', updatedon = now()
where caseassignmentid = 'f9779d22-344b-4bb2-92ad-feb870a7de99' and activeflag = 1 and enddate is null;

update adoptioncase 
set statustypekey = 'Closed', updatedby =  'CJAMS-68835', updatedon = now() 
where adoptioncaseid = 'c233a589-2dc0-4e2a-b107-dcc1f53d2b69' and activeflag = 1;


INSERT INTO cjams.adoptioncasedisposition
(adoptioncasedispositionid, adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'c233a589-2dc0-4e2a-b107-dcc1f53d2b69', '2026-07-06 00:31:12.963', 'Closed', 'Closed',  'Case is closed with ticket CJAMS-68835', '2026-07-06 00:31:12.963', 1, '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', now() , 'CJAMS-68835', now() , null, null, null, null);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'ACDR', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', 'ab5963bc-43fe-4567-8487-62195fa3936b', 'a4bf63ee-9314-458b-95d9-0c7095db11a4', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68835',now(), 'CJAMS-68835', now(), true, 'case is closed with ticket CJAMS-68835', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68835'), '3215376', 'Adoptioncase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'ACDR', 'ab5963bc-43fe-4567-8487-62195fa3936b', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb','a4bf63ee-9314-458b-95d9-0c7095db11a4', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68835'), 16, 1, 'CJAMS-68835', now(), 'CJAMS-68835', now(), true, 'APPROVED', NULL, 'APPROVED', '3215376', 'Adoptioncase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);