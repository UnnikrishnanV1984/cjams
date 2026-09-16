update personprogramarea
set enddate = '2021-02-08 16:05:00.000000', updatedon = now(), updatedby = 'CDM-12580'
where objectid =  'c984f59f-6711-4fd7-96c9-b1fc3e420969';

delete from cjams.intakeservicerequestdispositioncode where intakeserviceid = 'c984f59f-6711-4fd7-96c9-b1fc3e420969' and intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a';

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, etl_userid, etl_load_date, adultassignedsecurityid)
VALUES(gen_random_uuid(), 'c984f59f-6711-4fd7-96c9-b1fc3e420969', '18549a79-2a1f-4ab4-bab5-e0f5b40158bd', now(), 'CDM-12580',now(), NULL, '2021-02-08 16:05:00.000000', NULL, '2020-11-11 21:00:00', '2020-11-11 21:00:00', 1, '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', '402b1a1e-18fb-447c-821f-d571d8050c62', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);




delete from routing where objectid = 'cfe89570-c7ca-4d60-8786-920225248ec1' and routingstatustypeid = 16 and eventcode = 'INDR';
INSERT INTO routing(
						eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid,objectid , routingstatustypeid,
						insertedby,  updatedby , servicerequestnumber,objecttypekey,routeddescription)

		VALUES('INDR','18549a79-2a1f-4ab4-bab5-e0f5b40158bd','59fc02a7-d0a6-4efe-9989-83d6d2a8ad55','79b67c84-50b6-4521-8fc8-5d1fa6e41a3c',
		   'CWSP','CWCW',(select distinct intakeservicerequestdispositioncodeid  from cjams.intakeservicerequestdispositioncode 
where intakeserviceid = 'c984f59f-6711-4fd7-96c9-b1fc3e420969' and intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a'
and activeflag=1 limit 1) ,16,
		   '18549a79-2a1f-4ab4-bab5-e0f5b40158bd','CDM-12820','20200342060356','Disposition','Case Close Approved');
		   
delete from routing where objectid = 'cfe89570-c7ca-4d60-8786-920225248ec1' and routingstatustypeid = 15 and eventcode = 'INDR';
INSERT INTO routing(
						eventcode, activeflag, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid,objectid , routingstatustypeid,
						insertedby,  updatedby , servicerequestnumber,objecttypekey,routeddescription)

		VALUES('INDR', '0' ,'59fc02a7-d0a6-4efe-9989-83d6d2a8ad55', '18549a79-2a1f-4ab4-bab5-e0f5b40158bd','79b67c84-50b6-4521-8fc8-5d1fa6e41a3c',
		  'CWCW', 'CWSP',(select distinct intakeservicerequestdispositioncodeid  from cjams.intakeservicerequestdispositioncode 
where intakeserviceid = 'c984f59f-6711-4fd7-96c9-b1fc3e420969' and intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a'
and activeflag=1 limit 1),15,
		   '59fc02a7-d0a6-4efe-9989-83d6d2a8ad55','CDM-12820','20200342060356','Disposition','Case Close Review');   
		   
update intakeservicerequest
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a'
where intakeserviceid = 'c984f59f-6711-4fd7-96c9-b1fc3e420969';  


