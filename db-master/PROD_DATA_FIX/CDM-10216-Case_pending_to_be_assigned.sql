
update servicecase set activeflag = 1, updatedby = 'CDM-10216', updatedon = now() where servicecaseid = '4e77b496-0e84-46eb-b3dc-0a9b40c34647';

update servicecase set activeflag = 1, updatedby = 'CDM-10216', updatedon = now() where servicecaseid = 'b0242204-0b9f-44e3-8c2c-bd8867fe5df7';

update routing set activeflag = 0, updatedby = 'CDM-10216', updatedon = now() where routingid in ('94acf254-efac-4804-86fa-2d36616cbc96', 'f7c87dd0-bd2f-45b3-b608-865048e24eb8');
