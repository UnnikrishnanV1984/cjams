/*
Issue Description: CJAMS-60414 We have an adjustment payment id # 4602468 that does not have the option to be approved by a supervisor to be interfaced. We need this to interface
Category/Module: Ancillary Payments Adjustment 
Root cause: The Ancillary Payment Adjustment was created and submitted by terri.eck@maryland.gov .
            This user has CW case worker role as primary role due to which routing record is not getting inserted and shown for approval in superivsor approval dashboard.
            Code fix might be needed to allow the routing insertion if the user belongs to FNS FINANCE WORKER group. 
Fix provided: Data fix has been done to insert the routing record into evelyn.allende@maryland.gov dashboard
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: TBD
Reason why no related code fix: N/A
*/

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'ANPAYADJ', '29bfa90d-4299-47a0-ad96-51a2496a9b4a', 'ac06fa1f-a4d7-4b61-9dd9-ee5942773229', 'dd6448e0-25df-4695-a5d0-4dbda4ef6f3c', 'CWCW', 'FNSFS', '4602468', 51, 1, 'CJAMS-60414', now(), 'CJAMS-60414', now(), true, 'Forwarded to Payment Approval', NULL, 'Purchase Adjustment Forwarded to Payment Approval', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
