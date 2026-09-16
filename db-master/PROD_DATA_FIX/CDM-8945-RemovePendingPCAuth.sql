-- CDM-8945 - Remove pending approval record for PCAuth

update routing set activeflag = 0, updatedby = 'CDM-8945', updatedon = now() where routingid = '17d97f30-40cd-458f-9fd3-f78314d27b67' and activeflag = 1 and routingstatustypeid = 39;