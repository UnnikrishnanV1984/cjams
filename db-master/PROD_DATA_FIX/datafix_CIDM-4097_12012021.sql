-- CIDM-4097 CJAMS - E&E Outbound batch failure due to the duplicate person records for the same cjamspid

-- Datafix to update CJAMS - E&E Out Bound Batch Number 169 as processed successfully
-- Blank batch generated on 11/26
 
select batchnumber, successful_sw, runstatus, updatedby, updatedon
     from cjams.interfacesruntimeslog
where runid = 4160
     and interfaceid = 'ENE_OUTBOUND' ;

update cjams.interfacesruntimeslog
set successful_sw = 'Y',
      updatedby = 'CIDM-4097',
      updatedon = now()
where runid = 4160
      and interfaceid = 'ENE_OUTBOUND' ;


Insert into cjams.interfacesruntimeslog
( interfaceid, currentruntimestamp, previousruntimestamp, batchnumber, runstatus,
insertedon, insertedby, updatedon, updatedby, activeflag, successful_sw
)
values
( 'ENE_INBOUND', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,'169','Y',
current_timestamp,'CIDM-4097',current_timestamp,'CIDM-4097', 1 ,'Y'
) ;

-- After 
select interfaceid, batchnumber, successful_sw, runstatus, updatedby, updatedon
      from cjams.interfacesruntimeslog
where interfaceid like 'ENE%'
      and btrim(batchnumber) = '169';