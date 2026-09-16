
DELETE from cjams.intakeservicerequestdispositioncode
where intakeserviceid ='29526a28-88e4-4248-b952-b8ee2ff011d3';


INSERT INTO cjams.intakeservicerequestdispositioncode (intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, 
"timestamp", statusdate, description, expirationdate, effectivedate, activeflag,
intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid,
dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay,
old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, 
servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, 
approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, 
etl_userid, etl_load_date, adultassignedsecurityid)
VALUES('28872543-ec5b-444e-82d7-8b91fd3d61b1', '29526a28-88e4-4248-b952-b8ee2ff011d3', '43c25cfb-be4a-4052-bd08-e9bc318c92f6', now(),'CDM-7359', now(),
null, now()::date, '', null, now(), 0, 
'7995cecb-062d-406c-8ea9-b1da4b1877d8', '87b0728a-2614-4a98-980c-20dc96b6d193', 
null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);

update routing set activeflag=0 where objectid in (select IntakeServiceRequestDispositionCodeid :: character varying from  IntakeServiceRequestDispositionCode where IntakeServiceId= '29526a28-88e4-4248-b952-b8ee2ff011d3') ;

select * from routingintake('28872543-ec5b-444e-82d7-8b91fd3d61b1', '43c25cfb-be4a-4052-bd08-e9bc318c92f6', 'INDR', 16, '', '43c25cfb-be4a-4052-bd08-e9bc318c92f6', true, false, false, '','','CW2955636','',0);
