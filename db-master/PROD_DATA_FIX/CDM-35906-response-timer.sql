/*
  Issue Description:  CDM-35906
   Category/ Module  : Case Closure
   Root cause: User requested to close the case
    Fix Provided: Did data fix to close the case 
   
*/
select * from intakeservicerequest where servicerequestnumber ='231021392712';

select activeflag,* from intakeservicerequestdispositioncode where intakeservicerequestdispositioncodeid ='37a0690d-9a11-4698-9ff9-06aa72256462';

SELECT * from gen_random_uuid();

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, etl_userid, etl_load_date, adultassignedsecurityid)
VALUES('37a0690d-9a11-4698-9ff9-06aa72256462', '369612da-43b6-43c0-8210-b2d2cfa8c614', '6af7a326-0572-4e9c-9d19-e15e2949c5fe', '2023-11-28 10:45:20', 'CDM-35906', '2023-11-20 10:45:20', NULL, '2023-11-20 10:45:20', '', NULL, '2023-11-20 10:45:20', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', '02a89a40-85bf-47d0-adc6-6e4f0bea9465', NULL, NULL, NULL, NULL, NULL, 'The investigation is down to one day before closure.', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)ON CONFLICT DO NOTHING;

update intakeservicerequestdispositioncode
set insertedon ='2023-12-28 10:45:20', servicerequesttypeconfigiddispostionid ='d90db0d3-f665-49db-b3ad-0edb468bc02d', reviewcomments ='The investigation is down to one day before closure.'
where intakeservicerequestdispositioncodeid ='37a0690d-9a11-4698-9ff9-06aa72256462' and activeflag =1;

select * from routing where servicerequestnumber ='231021392712';

select objectid,activeflag,* from routing where routingid ='e185dd70-7806-49be-bf4b-351be0b9ebaf';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('f262b93f-72db-466f-ab48-4161bd916955', 'INDR', '24b7331d-f52d-4e13-bb62-ae8bc29dcbbf', '6af7a326-0572-4e9c-9d19-e15e2949c5fe', 'f2f7d045-6caa-4363-ad9d-139c7ac11f0d', 'CWCW', 'CWSP', '37a0690d-9a11-4698-9ff9-06aa72256462', 15, 0, '24b7331d-f52d-4e13-bb62-ae8bc29dcbbf', '2023-12-28 12:45:30', 'CDM-35906', '2023-11-20 10:46:30', true, 'Disposition Approved', NULL, 'Disposition Approved', '231021392712', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('e185dd70-7806-49be-bf4b-351be0b9ebaf', 'INDR', '6af7a326-0572-4e9c-9d19-e15e2949c5fe', '24b7331d-f52d-4e13-bb62-ae8bc29dcbbf', 'f2f7d045-6caa-4363-ad9d-139c7ac11f0d', 'CWSP', 'CWCW', '37a0690d-9a11-4698-9ff9-06aa72256462', 16, 1, '6af7a326-0572-4e9c-9d19-e15e2949c5fe', '2023-12-28 12:45:30', 'CDM-35906', '2023-11-20 10:46:30', true, 'Disposition Approved', NULL, 'Disposition Approved', '231021392712', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)ON CONFLICT DO NOTHING;

update routing 
set insertedon ='2023-12-28 12:45:30'
where objectid ='37a0690d-9a11-4698-9ff9-06aa72256462' and activeflag =1;

select intakeserreqstatustypeid,* from intakeservicerequest where servicerequestnumber ='231021392712';

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby='CDM-35906', updatedon=now()
WHERE intakeserviceid='369612da-43b6-43c0-8210-b2d2cfa8c614';

UPDATE cjams.caseassignment
SET updatedby='CDM-35906', updatedon=now(), enddate='2023-11-20 10:46:30'
WHERE caseassignmentid='9fbce397-b15d-4240-aca3-0dc00ffd2064';

INSERT INTO cjams.legislative
(legislativeid, intakeserviceid, isapprovedsafec, activeflag, updatedby, updatedon, insertedby, insertedon, isinitialfacetoface, isapprovedmfira, isapprovecansf, isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, isreasonnotprovided, isdataentrynotes, islateinitialcontact)
VALUES('5c722766-db78-4d11-b38e-9f79f3a32cd3', '369612da-43b6-43c0-8210-b2d2cfa8c614', NULL, 1, 'CDM-35906', '2023-11-20 10:46:30', '6af7a326-0572-4e9c-9d19-e15e2949c5fe', '2023-12-28 12:45:30', NULL, NULL, NULL, true, true, NULL, '', NULL, '', '', true)ON CONFLICT DO NOTHING;

select * from personprogramarea where objectid ='369612da-43b6-43c0-8210-b2d2cfa8c614';

update personprogramarea
set enddate ='2023-12-28 12:45:30', updatedon =now()
where objectid ='369612da-43b6-43c0-8210-b2d2cfa8c614';