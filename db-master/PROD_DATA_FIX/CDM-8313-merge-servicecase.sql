update actor set servicecaseid = '9504384f-4095-44fa-925a-73caf3ab1a32', updatedby = 'CDM-8313', updatedon = now()
where servicecaseid = '1e5b5bfd-086c-4b09-822e-0a55334b2500';
update intakeservicerequestactor set servicecaseid = '9504384f-4095-44fa-925a-73caf3ab1a32', updatedby = 'CDM-8313', updatedon = now()
where servicecaseid = '1e5b5bfd-086c-4b09-822e-0a55334b2500';
update personrole set servicecaseid = '9504384f-4095-44fa-925a-73caf3ab1a32', updatedby = 'CDM-8313', updatedon = now()
where servicecaseid = '1e5b5bfd-086c-4b09-822e-0a55334b2500';
update progressnote set servicecaseid = '9504384f-4095-44fa-925a-73caf3ab1a32', updatedby = 'CDM-8313', updatedon = now()
where servicecaseid = '1e5b5bfd-086c-4b09-822e-0a55334b2500';
update Intakeservreqchildremoval set servicecaseid = '9504384f-4095-44fa-925a-73caf3ab1a32', updatedby = 'CDM-8313', updatedon = now()
where servicecaseid = '1e5b5bfd-086c-4b09-822e-0a55334b2500';
update placement set servicecaseid = '9504384f-4095-44fa-925a-73caf3ab1a32', updatedby = 'CDM-8313', updatedon = now()
where servicecaseid = '1e5b5bfd-086c-4b09-822e-0a55334b2500';
update permanencyplan set servicecaseid = '9504384f-4095-44fa-925a-73caf3ab1a32', updatedby = 'CDM-8313', updatedon = now()
where servicecaseid = '1e5b5bfd-086c-4b09-822e-0a55334b2500';
update tb_Service_log set case_id = 3208474, update_user_id = 'CDM-8313', update_ts = now()
where case_id = 3278469;
update snapshothist set objectid = '9504384f-4095-44fa-925a-73caf3ab1a32', updatedby = 'CDM-8313', updatedon = now()
where objectid = '1e5b5bfd-086c-4b09-822e-0a55334b2500';
update servicecase set activeflag = 0, updatedby = 'CDM-8313', updatedon = now()
where servicecaseid = '1e5b5bfd-086c-4b09-822e-0a55334b2500';
update progressnote set entitytypeid = '9504384f-4095-44fa-925a-73caf3ab1a32', updatedby = 'CDM-8313', updatedon = now()
where servicecaseid = '9504384f-4095-44fa-925a-73caf3ab1a32' or entitytypeid in ('643a1396-b037-40be-b611-67ee2b91a1c7', '1e5b5bfd-086c-4b09-822e-0a55334b2500');