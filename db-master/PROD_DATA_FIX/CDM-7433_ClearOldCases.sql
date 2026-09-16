--CDM-7433 - Changed activeflag to 0 for already assigned cases.

update routing set activeflag = 0, updatedby = 'CDM-7433', updatedon = now() where routingid = '394d9233-d61b-4f01-a067-2c530b047c81' and activeflag =1 and routingstatustypeid = 9 and eventcode = 'SRVC';
update routing set activeflag = 0, updatedby = 'CDM-7433', updatedon = now() where routingid = '954231bd-1e54-4cc2-898f-94fd726f262c' and activeflag =1 and routingstatustypeid = 9 and eventcode = 'SRVC';
update routing set activeflag = 0, updatedby = 'CDM-7433', updatedon = now() where routingid = '023a71c7-d095-4f18-8104-d6de076d1afe' and activeflag =1 and routingstatustypeid = 9 and eventcode = 'SRVC';