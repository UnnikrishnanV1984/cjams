-- CDM-8961 - Remove the pending approval record that got created accidentally

update routing set activeflag =0, updatedby = 'CDM-8961', updatedon = now() where routingid = '78d634f0-2dfa-4a0e-81c0-a81f16b938f5' and eventcode = 'SCCR' and activeflag =1 and routingstatustypeid =15;
