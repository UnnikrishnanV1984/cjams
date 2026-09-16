-- CDM-232 pathway change 2020069016641

UPDATE routing SET activeflag = 0, updatedby = 'CDM-232', updatedon = now() WHERE 
activeflag = 1 AND routingstatustypeid = 15 AND routingid = 'ecb99e87-5b3e-49e3-981f-51ad87361d0a';
