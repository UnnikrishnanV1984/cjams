/*
Issue: CIDM-11026 Closure
Category/Module: Case closure
Root cause: Case Closure for case# 251023248680 
            Requested Date: 01/23/2026, 08:49 AM
            Approved By: Alicia Snoots  
            Approved On: 01/27/2026, 08:49 AM
            BA will create a seperate code fix ticket for this issue.
Fix provided:  Data fix has been done to close the case 251023248680
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: TBD
Code fix ticket#: N/A
Reason why no related code fix: User requested for data fix 
*/

update intakeservicerequest
set  exitdate = '01/27/2026 08:49:00',
     intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a',
     updatedon = now(),
     updatedby = 'CIDM-11026'
where  intakeserviceid = 'd459f575-7087-425f-abc6-0d4d2347ca28'
and activeflag =1;

update personprogramarea
set enddate = '01/27/2026 08:49:00',
    updatedon = now(),
    updatedby = 'CIDM-11026'
where objectid = 'd459f575-7087-425f-abc6-0d4d2347ca28' 
and enddate is null 
and activeflag = 1;

update caseassignment
set enddate = '01/27/2026 08:49:00',
    updatedon = now(),
    updatedby = 'CIDM-11026'
where objectid = 'd459f575-7087-425f-abc6-0d4d2347ca28' 
and enddate is null 
and activeflag = 1;

update routing
set activeflag =0,
    updatedby = 'CIDM-11026',
    updatedon = now()
where routingid = 'fbf37912-8b1e-4b96-85a0-9477b4b05558'
and activeflag =1;    

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INDR', '6af7a326-0572-4e9c-9d19-e15e2949c5fe', '677e7c24-f5e6-4e46-9e57-681ae0336664', 'f2f7d045-6caa-4363-ad9d-139c7ac11f0d'::uuid, 'CWSP', 'CWCW', 'ca217874-c87c-411a-a681-825c8c3ba25d', 16, 1, 'CIDM-11026', '2026-01-27 08:49:00.000', 'CIDM-11026', 'now()', true, '', NULL, 'Disposition Approved', '251023248680', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--Updating intakeservicerequestdispositioncode to close the case
update intakeservicerequestdispositioncode
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', 
updatedby = 'CIDM-11026', 
updatedon = now()
where intakeservicerequestdispositioncodeid = 'ca217874-c87c-411a-a681-825c8c3ba25d' and activeflag = 1;