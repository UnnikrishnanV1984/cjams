INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate,
 description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid,
 dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey,
 servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey,
 additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey,
 requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag,
 clientmergeid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '37094ffa-a20a-4ccc-b2a5-44ef7a158d56', 'Datafix user', now(), 'Datafix user', now(), null, '2015-06-29 00:00:00',
  null, null, now(), 1, '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', '039256cb-5ffa-4c90-8d3a-c77160707a3b',
  null, '', null, null, now(), 'Closing Case as per CDM-729 request', '', '', '',
  null, '', null, '', '',
  '', null, null, null, null, null, '', '',
  '', '', '', '', null, null, null,
  null, '', null);