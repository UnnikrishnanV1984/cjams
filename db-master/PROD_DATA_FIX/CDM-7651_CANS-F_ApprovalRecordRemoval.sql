-- CDM-7651 - Remove approved Cans-f record from pending approval

update routing set activeflag = 0, updatedby = 'CDM-7651', updatedon = now() where routingid = '6d2192a1-dc70-41f1-b739-010282b94146' and activeflag = 1 and routingstatustypeid =15;
