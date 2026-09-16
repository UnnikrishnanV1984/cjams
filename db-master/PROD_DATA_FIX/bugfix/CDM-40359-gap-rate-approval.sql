/* 
   Issue Description: CDM-40359
   Category/ Module  : Subsidy Benefits
   Root cause: The GAP Subsidy Rate successfully approved by supervisor but the status is not changed to Approved . This seems to be incorrect data issue and approval status key is not getting updated.
   Fix Provided : Data fix has been provided to update the approvalstatuskey in gapraterevision table. 
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

--Gap agreement rate not showing as approved due to data issue

update gapratesrevision
set approvalstatustypekey = '3047',
    updatedby = 'CDM-40359',
    updatedon = now(),
    approvaldate = '2024-05-30 00:00:00'
where gaprateid = '72470a1f-085b-4466-ab7b-ea14f48b4726'
and activeflag =1;    

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('72470a1f-085b-4466-ab7b-ea14f48b4726', 'GARR', '3ca8e63d-f885-445b-aab9-24456e91ad4a', 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9', 'b50f2419-42ba-4ab6-84ab-5172917d2d77', 'CWSP', 'CWCW', '72470a1f-085b-4466-ab7b-ea14f48b4726', 16, 1, '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2024-07-24 16:27:26.785', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2023-06-07 16:27:26.785', true, '', NULL, 'Guardianship Rate Approved ', '3286319', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
