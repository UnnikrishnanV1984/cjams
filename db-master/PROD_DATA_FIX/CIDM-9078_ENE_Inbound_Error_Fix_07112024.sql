-- CIDM-9078 - 07/10 EnE Inbound job failure
/*
E&E inbound file was having one old additional batch number.
E&E Inbound batch error: (E&E) Warning: BATCH NO IS NOT VALID ON E&E INBOUND FILE


select successful_sw, runstatus, batchnumber, interfaceid, updatedby, updatedon 
from cjams.interfacesruntimeslog
where runid = 73104 ;

N	P	783	ENE_OUTBOUND	cjams_batch_user	2024-07-11 05:01:33.272
*/

update cjams.interfacesruntimeslog 
set successful_sw = 'P', 
	updatedby = 'CIDM-9078', 	
	updatedon = now() 
where runid = 73104 ;

