-- CDM-6331 Approval from Inbox to be cleared.

 update routing set activeflag = 0, updatedby = 'CDM-6331', updatedon = now() where routingid = 'c6038f54-854d-46fd-8e3f-62a7935fffd6' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'GAAP';