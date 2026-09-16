-- CDM-7967 - Update activeflag for approved case

update routing set activeflag =0, updatedby = 'CDM-7967', updatedon = now() where routingid = '982e2a38-e524-4299-90ad-4fc41cd375ab' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'CPLAN2';
