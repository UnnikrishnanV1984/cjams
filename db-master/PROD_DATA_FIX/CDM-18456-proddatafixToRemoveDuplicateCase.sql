
/*
   Issue Description: CDM-18456
   Category/ Module  : Removing the duplicated Service case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update servicecase set activeflag = 0, updatedby = 'CDM-18456', updatedon = now() where servicecaseid = '6a837d1f-c50f-4ec9-af44-eebe014ab606' and activeflag = 1;
update routing set activeflag = 0, updatedby = 'CDM-18456', updatedon = now() where routingid = '5104ea3c-8c2d-4b7d-a128-64655b027206';
--2021036078872
update routing set activeflag = 0, updatedby = 'CDM-18456', updatedon = now() where routingid = '240653bc-2606-4d83-9fc6-12dc4765e9a1';
