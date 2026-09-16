-- CDM-7634 - Removing adoption breakthelink record as there are duplicates for one objectid

update routing set activeflag = 0, updatedby = 'CDM-7634', updatedon = now() where routingid = '1d5908dd-9a9a-4afc-ac2e-d24c1378c747' and activeflag =1 and routingstatustypeid = 15 and eventcode = 'ABLR';
update adoptionbreakthelink set activeflag = 0, updatedby = 'CDM-7634', updatedon = now() where adoptionbreakthelinkid = 'cd723069-b16a-4c78-892d-9b33913a1e7f' and activeflag =1;
