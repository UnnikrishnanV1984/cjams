-- CJAMS CW - E&E Interface Run Time Log master data script
-- To update last success batch number as 49999

INSERT INTO cjams.interfacesruntimeslog
(	runid, interfaceid, currentruntimestamp, previousruntimestamp, batchnumber, 
	runstatus, insertedon, insertedby, updatedon, updatedby, activeflag, old_id, successful_sw
)
values
(	nextval('interfacesruntimeslog_runid_seq'::regclass), 
	'ENE_INBOUND', now(), now(), 49999, 'Y', now(), 'eneadmin', now(), 'eneadmin', 1, NULL, 'Y'
);


-- To update last success batch number as 0
INSERT INTO cjams.interfacesruntimeslog
(	runid, interfaceid, currentruntimestamp, previousruntimestamp, batchnumber, 
	runstatus, insertedon, insertedby, updatedon, updatedby, activeflag, old_id, successful_sw
)
values
(	nextval('interfacesruntimeslog_runid_seq'::regclass), 
	'ENE_OUTBOUND', now(), now(), 0, 'Y', now(), 'eneadmin', now(), 'eneadmin', 1, NULL, 'Y'
);


-- Data to load for 1st run
INSERT INTO cjams.eneoutboundtrigger
(	eneoutboundtriggerid, fk_id, transactionon, transactiontypekey, batchrunon, 
	statusflag, activeflag, batchnumber, datavalidflag, old_id, etl_userid, etl_load_date
)
(	SELECT caresoutboundtriggerid, fk_id, transactionon, transactiontypekey, batchrunon, 
		statusflag, activeflag, batchnumber, datavalidflag, old_id, etl_userid, etl_load_date
	FROM cjams.caresoutboundtrigger
	where statusflag = 'N'	
		and activeflag = 1
	order by transactionon asc
)
	

