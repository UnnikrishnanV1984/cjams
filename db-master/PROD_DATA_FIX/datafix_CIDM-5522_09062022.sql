-- CIDM-5522 Batch failed : 09/05/2022
/*
09/05/2022 was a State Holiday and so the CJAMS - E&E Outbound Batch file (Batch # 322) went as an empty file 
(there was no data to interface). In such a scenario we are not receiving success status back.

Data fix needed to update CJAMS - E&E Outbound Batch Number 322 as a Success. 
Then only CJAMS will send the new Outbound Batch out.
*/

-- Datafix to update CJAMS - E&E Out Bound Batch Number 322 as processed successfully
-- Blank batch generated on 09/05/2022 (Holiday)
 
select batchnumber, successful_sw, runstatus, updatedby, updatedon
     from cjams.interfacesruntimeslog
where runid = 5780
     and interfaceid = 'ENE_OUTBOUND' ;

update cjams.interfacesruntimeslog
set successful_sw = 'Y',
      updatedby = 'CIDM-5522',
      updatedon = now()
where runid = 5780
      and interfaceid = 'ENE_OUTBOUND' ;


Insert into cjams.interfacesruntimeslog
	(	interfaceid, currentruntimestamp, previousruntimestamp, batchnumber, runstatus,
		insertedon, insertedby, updatedon, updatedby, activeflag, successful_sw
	)
values
	(	'ENE_INBOUND', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,'322','Y',
		current_timestamp,'CIDM-5522',current_timestamp,'CIDM-5522', 1 ,'Y'
	) ;

-- After 
select interfaceid, batchnumber, successful_sw, runstatus, updatedby, updatedon
      from cjams.interfacesruntimeslog
where interfaceid like 'ENE%'
      and btrim(batchnumber) = '322';
