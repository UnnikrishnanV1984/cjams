/*
  Issue Description:  CDM-35720
   Category/ Module  : Case Closure
   Root cause: User requested to close the case
    Fix Provided: Did data fix to close the case 
   
*/


INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, etl_userid, etl_load_date, adultassignedsecurityid)
VALUES('4493dc11-47ff-434e-8935-4df99858f7a1', '722fc507-9360-4737-b9da-0a5894928f09', '38d79277-40be-4c69-941c-598d2e5e462b', '2023-12-01 11:01:31.858', 'CDM-35720', '2023-12-01 11:01:31.858', NULL, '2023-12-01 11:01:31.858', '', NULL, '2023-12-01 11:01:31.858', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', '02a89a40-85bf-47d0-adc6-6e4f0bea9465', NULL, NULL, NULL, NULL, '2023-12-01 11:01:31.000', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('6623f6eb-981e-478d-ba87-5eea1a2ff252', 'INDR', '38d79277-40be-4c69-941c-598d2e5e462b', '0f23d988-4f96-4fdf-99ef-dab6c952c32a', 'c1c244cf-89ee-4d3b-8ae1-00909a262da5', 'CWSP', 'CWCW', '4493dc11-47ff-434e-8935-4df99858f7a1', 16, 1, '9d425628-e466-4839-a395-68b2c2ec320c', '2023-12-01 12:20:08.376', 'CDM-35720', '2023-12-01 12:20:08.376', true, 'Disposition Approved', NULL, 'Disposition Approved', '231021184947', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby='CDM-35720', updatedon=now()
WHERE intakeserviceid='722fc507-9360-4737-b9da-0a5894928f09';

  UPDATE cjams.caseassignment
SET updatedby='CDM-35720', updatedon=now(), enddate='2023-12-01 12:20:00'
WHERE caseassignmentid='28a97bc5-d622-4473-8b3a-1a84cedea2ee' ;

INSERT INTO cjams.legislative
(legislativeid, intakeserviceid, isapprovedsafec, activeflag, updatedby, updatedon, insertedby, insertedon, isinitialfacetoface, isapprovedmfira, isapprovecansf, isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, isreasonnotprovided, isdataentrynotes, islateinitialcontact)
VALUES('44f1a2db-239e-4017-b2f3-3ef7917bdc45', '722fc507-9360-4737-b9da-0a5894928f09', true, 1, 'CDM-35720', '2023-12-12 11:19:47.486', '38d79277-40be-4c69-941c-598d2e5e462b', '2022-12-01 08:10:49.000', NULL, true, true, NULL, true, NULL, '', NULL, '', '', true);
