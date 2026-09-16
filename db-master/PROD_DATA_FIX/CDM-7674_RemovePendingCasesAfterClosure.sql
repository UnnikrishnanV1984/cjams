-- CDM-7674 - Remove pending cases from approval inbox after case is closed

update routing set activeflag = 0, updatedby = 'CDM-7674', updatedon = now() where routingid = '9da485a6-6cd9-49a4-8cd4-7cecc722f5b7' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'SCDR';
update routing set activeflag = 0, updatedby = 'CDM-7674', updatedon = now() where routingid = '4ee2c79c-0121-4e51-88fe-60cf87d57d2a' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'SCDR';
