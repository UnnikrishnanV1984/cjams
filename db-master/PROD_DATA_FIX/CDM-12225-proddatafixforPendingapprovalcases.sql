update routing set activeflag = 0, updatedby = 'CDM-12225', updatedon = now() where routingid in ('00c23af0-0b2d-4e3b-b6d5-a819127111dd',
'f81acce5-991c-411f-9bb4-55243a140c6a') and activeflag = 1;