-- CDM-9412 - Remove service case and change the status of intake from approved to review

update servicecase set activeflag =0, updatedby = 'CDM-9412', updatedon = now() where servicecasenumber = 2021026075272 and activeflag =1;

update intakeservicerequest set intakeserreqstatustypeid = '0fb08074-540f-47a6-87ed-1622288996d1', updatedby = 'CDM-9412', updatedon = now() where intakeserviceid = 'bb8ad577-e9af-4689-b681-8872abdafc9c' and activeflag =1;
update routing set activeflag = 0, updatedby = 'CDM-9412', updatedon = now() where routingid = '02c0638f-ede7-4fa6-98b9-a0bf62d23976' and eventcode = 'INTR' and routingstatustypeid =2 and activeflag = 1;
