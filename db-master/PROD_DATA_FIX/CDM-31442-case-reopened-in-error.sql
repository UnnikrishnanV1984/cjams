/*
  Issue Description:  CDM-31442
   Category/ Module  : Case Closure
   Root cause: User requested to close the case reopened in error
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/
INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, etl_userid, etl_load_date, adultassignedsecurityid)
VALUES(gen_random_uuid(), 'f654e93c-5b2f-4fc6-a49a-23a594f37546', '7f95d559-f472-4a11-adab-ae3b513c828a', '2023-03-09 08:58:57.000', 'CDM-31442', now(), NULL, '2023-03-09 12:20:08.376', NULL, NULL, '2023-03-09 08:58:57.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 'd90db0d3-f665-49db-b3ad-0edb468bc02d', NULL, NULL, NULL, NULL, '2023-03-09 13:58:55.836', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

select routingintake from routingintake(gen_random_uuid()::character varying ,
     'f654e93c-5b2f-4fc6-a49a-23a594f37546' ::character varying,
    'INDR',15,'Disposition approved','f654e93c-5b2f-4fc6-a49a-23a594f37546' ::character varying,true,false,false,
   'Disposition approved','Disposition approved','ece748ab-a53a-49e0-b57f-46f8c7bc2bd9'::character varying,'',0)  ;
   
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(), 'INVT', 'ce5b8c8a-64f7-4a9b-b4eb-f05a7dfe0934', '7f95d559-f472-4a11-adab-ae3b513c828a', 'f200d197-841f-4699-8942-ef085d25f027', 'CWSP', 'CWCW', 'f654e93c-5b2f-4fc6-a49a-23a594f37546', 4, 1, 'CDM-31442', now(), '7f95d559-f472-4a11-adab-ae3b513c828a', '2023-03-09 08:58:55.665', false, NULL, NULL, NULL, '221020276970', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


update intakeservicerequest set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8' where servicerequestnumber = '221020276970';