-- CDM-22976 - Remove the case assessment request from to be assigned

update routing set activeflag=0, updatedby='CDM-22976', updatedon = now() 
where routingid='3f8f293e-3266-4f4d-ac4b-405e9bf4edc3';
