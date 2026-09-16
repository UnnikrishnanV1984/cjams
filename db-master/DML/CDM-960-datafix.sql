update intakeservicerequest
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby='Datafix user', updatedon = now()
where servicerequestnumber in ('CW2475471','CW2815467','CW2816109') and activeflag = 1;
 
DELETE from cjams.intakeservicerequestdispositioncode
where intakeserviceid in ('ec6d7f7c-21ed-4ad5-8c50-6775b25c286c' , 'f4701fd6-9d28-4f64-81fc-79f80fa77ff1' , '9d777a4c-49f7-4c86-b548-7e328d6cb2ae')
and intakeserreqstatustypeid ='642f18b0-ef6e-4d4b-9871-acc0734f3f5a'
and servicerequesttypeconfigiddispostionid  = '87b0728a-2614-4a98-980c-20dc96b6d193';

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate,
 description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid,
 dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, 
 servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, 
 additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey,
 requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, 
 clientmergeid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'ec6d7f7c-21ed-4ad5-8c50-6775b25c286c', 'Datafix user', now(), 'Datafix user', now(), null, now(), 
	   null, null, now(), 1, '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', '87b0728a-2614-4a98-980c-20dc96b6d193', 
	   null, '', null, null, now(), 'Closing Case as per CDM-960 request', '', '', '',
	   null, '', null, '', '',
	   '', null, null, null, null, null, '', '', 
	   '', '', '', '', null, null, null, 
	   null, '', null);
	   
INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate,
 description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid,
 dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, 
 servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, 
 additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey,
 requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, 
 clientmergeid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'f4701fd6-9d28-4f64-81fc-79f80fa77ff1', 'Datafix user', now(), 'Datafix user', now(), null, now(), 
	   null, null, now(), 1, '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', '87b0728a-2614-4a98-980c-20dc96b6d193', 
	   null, '', null, null, now(), 'Closing Case as per CDM-960 request', '', '', '',
	   null, '', null, '', '',
	   '', null, null, null, null, null, '', '', 
	   '', '', '', '', null, null, null, 
	   null, '', null);
	   
INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate,
 description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid,
 dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, 
 servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, 
 additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey,
 requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, 
 clientmergeid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '9d777a4c-49f7-4c86-b548-7e328d6cb2ae', 'Datafix user', now(), 'Datafix user', now(), null, now(), 
	   null, null, now(), 1, '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', '87b0728a-2614-4a98-980c-20dc96b6d193', 
	   null, '', null, null, now(), 'Closing Case as per CDM-960 request', '', '', '',
	   null, '', null, '', '',
	   '', null, null, null, null, null, '', '', 
	   '', '', '', '', null, null, null, 
	   null, '', null);
	   
	   	   
update caseassignment
set enddate = now(), updatedon = now(), updatedby = 'Datafix user CDM-960'
where objectid in ('ec6d7f7c-21ed-4ad5-8c50-6775b25c286c','f4701fd6-9d28-4f64-81fc-79f80fa77ff1','9d777a4c-49f7-4c86-b548-7e328d6cb2ae') 
and activeflag=1 and enddate is null;