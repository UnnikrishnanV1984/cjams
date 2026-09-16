-- CDM-7674 - Remove pending cases from approval inbox after case is closed

update routing set activeflag = 0, updatedby = 'CDM-7674', updatedon = now() where routingid = 'f2ba4686-7b25-43ad-a2ed-5e9700b01deb' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'SCDR';
update routing set activeflag = 0, updatedby = 'CDM-7674', updatedon = now() where routingid = '6a19cd41-4c1f-4ae2-a68c-8a22edc94f80' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'SCDR';
