
-- fix for reopen.
update intakeservicerequestdispositioncode set updatedby = 'CDM-22447', updatedon = now()
where intakeservicerequestdispositioncodeid = '1d52c402-6a9d-4e69-80ea-dee5488e09e0';

update routing set activeflag = 1, updatedby = 'CDM-22447', updatedon = now() 
where objectid = '1d52c402-6a9d-4e69-80ea-dee5488e09e0';