update intakeservicerequest
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby='Datafix user', updatedon = now()
where servicerequestnumber = 'CW2838203' and activeflag = 1;
 
update servicerequesttypeconfigdispositioncode
set activeflag = 1
where servicerequesttypeconfigiddispostionid = '87b0728a-2614-4a98-980c-20dc96b6d193';
 

DELETE from cjams.intakeservicerequestdispositioncode
where intakeserviceid = '6be10fd1-e468-418a-8670-fbf1cc94fe14' 
and intakeserreqstatustypeid ='642f18b0-ef6e-4d4b-9871-acc0734f3f5a'
and servicerequesttypeconfigiddispostionid  in ('87b0728a-2614-4a98-980c-20dc96b6d193','9ce452bc-0a21-41e4-a2c5-1c690217901a');

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate,
 description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid,
 dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, 
 servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, 
 additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey,
 requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, 
 clientmergeid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '6be10fd1-e468-418a-8670-fbf1cc94fe14', 'Datafix user', now(), 'Datafix user', now(), null, '2015-07-14 00:00:00', 
	   null, null, now(), 1, '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', '87b0728a-2614-4a98-980c-20dc96b6d193', 
	   null, '', null, null, now(), 'Closing Case as per CDM-731 request', '', '', '',
	   null, '', null, '', '',
	   '', null, null, null, null, null, '', '', 
	   '', '', '', '', null, null, null, 
	   null, '', null);