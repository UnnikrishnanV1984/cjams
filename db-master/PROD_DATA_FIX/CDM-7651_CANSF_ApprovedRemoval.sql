-- CDM-7651 - Remove the approved CANS-F record

update routing set activeflag = 0, updatedby = 'CDM-7651', updatedon = now() where routingid = '2ae5da9e-728a-47ba-8a71-242fd797bab5' and activeflag = 1 and routingstatustypeid =4;