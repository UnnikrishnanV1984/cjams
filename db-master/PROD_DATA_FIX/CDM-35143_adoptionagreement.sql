/*
   Issue Description: CDM-35143
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptionagreement set activeflag = 0, updatedby = 'CDM-35143', updatedon = now()
where adoptionagreementid in ('93c328af-4587-4f42-865b-bd75a372da0f') and activeflag = 1;
	