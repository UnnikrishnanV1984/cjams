/* 
   Issue Description: Routing record insertion is not happening when we are sending the Ancillary payment adjustment from a finance worker whose primary role is CJAMS Case Worker or Case Supervisor 
   Category/ Module  : Ancillary Payments Adjustments
   Root cause:  Insertion not happening in the routing table when the Finance worker with the primary role as CW case worker or CW supervisor is sending a ancillary payments adjustment for supervisor approval.
                The routing config table only facilitates the source role keys FNSFW and FNSFS to send for approval to the target role keys FNSFS
                Data fix needs to be done to add entries in the routing config tables to facilitate the CWCW and CWSP to send the ancillary payments adjustment for supervisor approval 
   Fix Provided : Data fix has been done to add entries in the routing config tables to facilitate the CWCW and CWSP to send the ancillary payments adjustment for supervisor approval 
   Regression Impacts : Ancillary Payment adjustments approval flow
   Is code fix needed : NO
   Reason why no related code fix: This is a configuration issue and we are adding necessary changes as data entries on the routingconfig files
*/


INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'ANPAYADJ', 'FNSFS', 1, 'CIDM-10633', now(), 'CIDM-10633', now(), now(), NULL, NULL, 'CWCW', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'ANPAYADJ', 'FNSFS', 1, 'CIDM-10633', now(), 'CIDM-10633', now(), now(), NULL, NULL, 'CWSP', NULL, NULL, NULL, NULL);