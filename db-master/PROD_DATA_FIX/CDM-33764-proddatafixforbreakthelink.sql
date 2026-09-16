/*
   Issue Description: CDM-33764
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


	update adoptionagreement set activeflag = 0, updatedby = 'CDM-33764', updatedon = now()
	where adoptionagreementid in ('1d88d1c6-c4ef-4eac-8191-c9a238794a98','f0c965c7-9f53-4832-8590-5a521a2b83e8') and activeflag = 1;
	