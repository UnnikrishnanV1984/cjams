-- CDM-7860 - In CW pending approval for assessment need to update active flag

update routing set activeflag = 0, updatedby = 'CDM-7860', updatedon = now() where routingid = '3f9754f4-10f7-4112-a66e-a35cc1a1f757' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'ASST';