/*
   Issue Description: CDM-33850
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptionagreement set activeflag = 0, updatedby = 'CDM-33850', updatedon = now()
where adoptionagreementid in ('40d477b2-77ee-4747-8972-88dd815bc7d5','c68529ca-e165-4d5d-b3c3-696198b618a3') and activeflag = 1;
	