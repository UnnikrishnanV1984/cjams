-- CDM-7863 - Remove pending cases from pending inbox after case is approved

update routing set activeflag = 0, updatedby = 'CDM-7863', updatedon = now() where routingid = 'd002b1fa-2875-4b36-a26b-af07ba0098f0' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'SPLAN';
