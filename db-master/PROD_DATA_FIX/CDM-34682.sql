/*
   Issue Description: CDM-34682
   Category/ Module  : 
   Root cause:  user want to  Close the Case 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update IntakeServiceRequest set updatedby='CDM-34682',updatedon=now(),
 intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8' where intakeserviceid='17aa423a-7e78-496b-ba0a-f920e6412d44';

INSERT INTO cjams.intakeservicerequestdispositioncode 
    ( intakeservicerequestdispositioncodeid,intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", 
    statusdate, description, expirationdate, effectivedate, activeflag, 
    intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason,
    lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id,
    closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, 
    approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey,
    entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey,
    denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, 
    forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid)
    VALUES('e1c9f6b6-e211-409c-a85f-3a87d249d2f1', '17aa423a-7e78-496b-ba0a-f920e6412d44','527e483b-5108-4906-b2bb-6fdbc317f03e',
    '2023-10-05 14:00:06.455','27e483b-5108-4906-b2bb-6fdbc317f03e', now(), NULL,
    now(), NULL, NULL, now(), 1, 
    '7995cecb-062d-406c-8ea9-b1da4b1877d8', 'd90db0d3-f665-49db-b3ad-0edb468bc02d', NULL, NULL,
    NULL, NULL, now(), 'Supervisor Stacie Parker reviewed AR 231021063659 and approved for case closure on 10/05/2023. CJAMS would not allow worker Ashaley Arnold to submit the case in CJAMS to supervisor Stacie Parker for official closure so ticket S20230278054329 (CJAMS Request CJAMS-47064) was opened in order for the case to be closed from the backend of CJAMS.', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
   

INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid,
fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, 
insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, 
servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'INDR', '527e483b-5108-4906-b2bb-6fdbc317f03e', '6c466761-0c81-42bf-9384-8b086d4ea34c', '38cdcc5e-4997-4b19-ab41-2ba349d39bb8'::uuid, 
'CWSP', 'CWCW', 'e1c9f6b6-e211-409c-a85f-3a87d249d2f1', 16, 1, '527e483b-5108-4906-b2bb-6fdbc317f03e', '2023-10-05 15:00:06.455',
'CDM-34682', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '221020240058', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);