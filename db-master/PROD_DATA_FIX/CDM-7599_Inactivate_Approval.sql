-- CDM-7599 fix - Remove Service plan review reocrod for the case 2020028703530 

update routing set activeflag = 0, updatedby = 'CDM-7599', updatedon = now() where routingid = 'd5110ecc-16a6-4ef5-9f91-2eaf836103bd' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'SPLAN';