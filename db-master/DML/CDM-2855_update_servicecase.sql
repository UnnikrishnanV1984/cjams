update cjams.servicecase set statustypekey = 'ASSIGN', updatedby = 'CDM-2855', updatedon = now() where servicecasenumber in (2020022002240,2020024002660,2020022002243,3271750,2020023102450,2020022402320);
						 
update cjams.routing set activeflag = 0, updatedby = 'CDM-2855', updatedon = now() where activeflag =1  
AND routingstatustypeid in (2 ) AND  eventcode = 'SRVC' and tosecurityusersid = 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94' and servicerequestnumber in (2020022002240,2020024002660,2020022002243,3271750,2020023102450,2020022402320);