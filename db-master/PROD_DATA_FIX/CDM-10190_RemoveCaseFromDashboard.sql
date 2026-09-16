-- CDM-10190 - Case came to supervisor approval dashboard by mistake

update routing set activeflag =0, updatedby = 'CDM-10190', updatedon = now() where routingid = '7b1c124f-976f-47c4-aaff-5094d0f76619' and routingstatustypeid = 15 and activeflag = 1;