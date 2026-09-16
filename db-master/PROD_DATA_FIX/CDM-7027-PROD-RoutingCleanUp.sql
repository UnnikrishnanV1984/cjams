update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-7027'
where routingid in ('54c27240-b451-4d1d-b9b6-822b83cd8c00', '51c64d37-4dc2-4176-b77d-f28f37794cce');