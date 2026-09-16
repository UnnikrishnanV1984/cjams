-- CJAMS CW - E&E Interface Run Time Log master data script
-- To update last success batch number as 69999

INSERT INTO cjams.interfacesruntimeslog
(	runid, interfaceid, currentruntimestamp, previousruntimestamp, batchnumber, 
	runstatus, insertedon, insertedby, updatedon, updatedby, activeflag, old_id, successful_sw
)
values
(	nextval('interfacesruntimeslog_runid_seq'::regclass), 
	'ENE_INBOUND', now(), now(), 69999, 'Y', now(), 'eneadmin', now(), 'eneadmin', 1, NULL, 'Y'
);
