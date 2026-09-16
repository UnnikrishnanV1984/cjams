-- CIDM-6985 - CJAMS - E&E Outbound batch file was blank on 04/06/2023
/*
-- Issue Description: 
	CJAMS - E&E Outbound batch file was blank on 04/06/2023

-- Category/ Module: Interface 
-- Root cause: The wrong (old processed) batch number CJAMS received on the 04/05 inbound file from E&E.
-- Fix Provided: Datafix has been promoted to update Interface runtime log data, so 04/07/2023 - 6 pm batch will generate the same batch # 465 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update last processed CJAMS - E&E Outboud Bound Batch Number as 464
-- Delete batch # 465 from  Interface runtime log
 
select batchnumber, successful_sw, runstatus, updatedby, updatedon
     from cjams.interfacesruntimeslog
where runid = 18724
     and interfaceid = 'ENE_OUTBOUND' ;
	 
delete from cjams.interfacesruntimeslog
where runid = 18724
     and interfaceid = 'ENE_OUTBOUND' ;


/*
-- To Revert if needed
INSERT INTO cjams.interfacesruntimeslog
	(	runid, interfaceid, currentruntimestamp, previousruntimestamp, batchnumber, runstatus, 
		insertedon, insertedby, updatedon, updatedby, activeflag, old_id, successful_sw
	)
VALUES
	(	18724, 'ENE_OUTBOUND', '2023-04-06 20:02:52.003', '2023-04-06 20:02:52.003', 465, 'P', 
		'2023-04-06 20:05:53.769', 'cjams_batch_user', '2023-04-06 20:05:53.769', 'cjams_batch_user', 1, NULL, 'Y'
	);
*/	
