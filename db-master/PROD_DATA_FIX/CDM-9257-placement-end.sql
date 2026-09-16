INSERT INTO cjams.placementrevision
		( placementid, transactiondate, entrydate, entrytime, exitdate, 
		exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, 
		approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag,
		voidreasontypekey,voidremarks,enddate,endtime,exittypekey,remarks,isvoided,voiddate
		,requestedby,requesteddate,approvedby,approveddate)
		VALUES('64aeaff6-de11-48df-a974-8694c5dc08c7',now(), '2020-01-29 00:00:00':: date, '2020-01-29 00:00:00', '2020-08-18 00:00:00':: date
		, '2020-08-18 00:00:00', '', 'REUNIF', 'Permanently leaving care - reunification with care', '3281', now()::date, 1, now(),'CDM-9257', now(),  'CDM-9257', 1,
		'' , '', ('2020-08-18 00:00:00' :: date) , '2020-08-18 00:00:00' , 
		'PLCC' , '', null,null, '', now(), 'CDM-9257', now());

update placement set exittypekey = 'PLCC', exitreasontypekey = 'REUNIF', enddatetime = '2020-08-18 00:00:00', updatedon = now(), updatedby = 'CDM-9254' where placementid = '64aeaff6-de11-48df-a974-8694c5dc08c7';
