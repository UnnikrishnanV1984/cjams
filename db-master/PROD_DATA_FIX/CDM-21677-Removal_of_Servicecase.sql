/*
   Issue Description: CDM-21677
   Category/ Module  : Removal of Service case from User tree
   Root cause:Please remove case from my tree, It's accidentally created
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update servicecase set activeflag = 0 , updatedby = 'CDM-21677', updatedon = now() where servicecaseid  = 'db0f9453-e38f-45e3-a731-4f1c69dbfd0a' and activeflag  = 1;
update servicecaserequest  set activeflag = 0, updatedby = 'CDM-21677', updatedon = now() where servicecaseid  = 'db0f9453-e38f-45e3-a731-4f1c69dbfd0a' and activeflag  = 1;
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-21677', updatedon = now() where servicecaseid  = 'db0f9453-e38f-45e3-a731-4f1c69dbfd0a' and activeflag  = 1;
update routing set activeflag = 0, updatedby = 'CDM-21677', updatedon = now() where objectid = 'db0f9453-e38f-45e3-a731-4f1c69dbfd0a' and activeflag  = 1;