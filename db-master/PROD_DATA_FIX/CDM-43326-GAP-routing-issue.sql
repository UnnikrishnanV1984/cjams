/*
Issue Description: 3190154:Unable to approve Guardianship subsidy for Jordan Hardesty in case 3190154 so guardianship family has not received their subsidy payment for November 2024 and will not be able to receive ongoing until approval is completed
Category/Module: GAP
Root cause: 3190154:Unable to approve Guardianship subsidy for Jordan Hardesty in case 3190154 as the routing record is missing in the database and the requested user is currently deactive.
            TDB, at this point of time looks like some intermittent issue, we will monitor if this happens again. 
Fix provided: Data fix has been done to insert the GAP agreement record in the routing table.
Data/Code fix ticket#: CDM-43326
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The routing record is missing in the DB.TDB, at this point of time looks like some intermittent issue, we will monitor if this happens again. 
Backup before update/ delete:Query:
*/


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'GARR', 'ac0b65b9-b299-4727-b3d8-b834a38bdbc8', 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', '381f1793-744c-4c4f-a409-809a260dcc45', 'CWCW', 'CWSP', 'c79cdce4-0db0-4f56-b3d1-5bd290f18241', 15, 1, 'ac0b65b9-b299-4727-b3d8-b834a38bdbc8', '2024-06-04 09:57:08', 'a05600b9-15f8-4f11-8602-0a9135968f21', '2024-06-04 09:57:08', true, 'Guardianship Agreement Submitted for review', NULL, 'Guardianship Agreement Submitted for review', '3190154', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
