-- 247a8b26-cdee-4ce8-b36e-b37e49fd0103
update intakeservicerequest set intakeserreqstatustypeid ='642f18b0-ef6e-4d4b-9871-acc0734f3f5a',updatedby = 'CDM-13836',updatedon = now() where 
intakeserviceid = '0073846b-5322-4db6-a337-a70a2f059ff5';


INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments)
VALUES('d3f84e5d-a3d0-4205-a69a-fc0950ead94b'::uuid,'0073846b-5322-4db6-a337-a70a2f059ff5'::uuid, 'df0a92fb-d901-4c7f-a5ae-048fc1c1397a', '2021-05-21 09:47:48.420', 'CDM-13836', NOW(), NULL, '2021-05-21 09:47:48.420', '', NULL, '2021-05-21 09:47:48.420', 1, '642f18b0-ef6e-4d4b-9871-acc0734f3f5a'::uuid, 'd69ef21e-dce1-4cd4-bda3-76255fc92db3'::uuid, NULL, NULL, NULL, NULL, NULL, 'This case was called into the Department on 5/14/21. The family lives outside of jurisdiction in Baltimore Co. TA Biggs spoke with Screening Admin Holly Naff in Baltimore Co and was informed that the case would not be accepted there. TA Biggs was advised to screen out the case or close.', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('INDR','df0a92fb-d901-4c7f-a5ae-048fc1c1397a','df0a92fb-d901-4c7f-a5ae-048fc1c1397a', NULL, NULL, NULL, 'd3f84e5d-a3d0-4205-a69a-fc0950ead94b' , 16, 1, 'CDM-13836', '2021-05-21 00:00:00', 'CDM-13836', '2021-05-21 00:00:00', false, 'Disposition Approved', NULL, 'Disposition Approved', 20200203025354, 'servicerequest', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


update caseassignment set enddate = '2021-05-21 09:47:50',updatedby = 'CDM-13683',updatedon = now() where caseassignmentid = '5e3d6e5a-4d8b-4939-98fd-6eb75c927464'
