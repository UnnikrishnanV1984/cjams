update intakeservicerequest
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby='Datafix as per CDM-1418', updatedon = now()
where servicerequestnumber in ('CW2943530','CW2951854') and activeflag = 1;

DELETE from cjams.intakeservicerequestdispositioncode
where intakeserviceid in ('1bcbce88-023c-43a4-adcc-0c1f2dd72e8e','eb7b17b1-ec42-4d4e-b970-ba55fa248513')
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
VALUES(gen_random_uuid(), '1bcbce88-023c-43a4-adcc-0c1f2dd72e8e', 'Datafix user as per CDM-1418', now(), 'Datafix user as per CDM-1418', now(), null, now(), 
	   null, null, now(), 1, '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', '87b0728a-2614-4a98-980c-20dc96b6d193', 
	   null, '', null, null, now(), 'Closing Case as per CDM-1418 request', '', '', '',
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
VALUES(gen_random_uuid(), 'eb7b17b1-ec42-4d4e-b970-ba55fa248513', 'Datafix user as per CDM-1418', now(), 'Datafix user as per CDM-1418', now(), null, now(), 
	   null, null, now(), 1, '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', '87b0728a-2614-4a98-980c-20dc96b6d193', 
	   null, '', null, null, now(), 'Closing Case as per CDM-1418 request', '', '', '',
	   null, '', null, '', '',
	   '', null, null, null, null, null, '', '', 
	   '', '', '', '', null, null, null, 
	   null, '', null);
	   	   
update Caseassignment
set enddate = now(), updatedon = now(), updatedby = 'Datafix as per CDM-1418'
where objectid in ('1bcbce88-023c-43a4-adcc-0c1f2dd72e8e','eb7b17b1-ec42-4d4e-b970-ba55fa248513') and enddate is null and activeflag=1;
	   
	   


