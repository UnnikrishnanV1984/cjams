update routing set routingstatustypeid = 4, updatedby = 'CDM-8020', updatedon = now()
where routingid in ('47c50797-af7e-4d0a-a4cc-7b5d0b6fe046', '971bbd8a-c690-4853-92ff-ad0203baa3e5');

update servicecase set activeflag = 0, updatedby = 'CDM-8020', updatedon = now()
where servicecaseid = '2525a0fc-a43a-4061-831e-b7b1826bc3df';