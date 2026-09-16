/*
   Issue Description: CDM-33817
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptionagreement set activeflag = 0, updatedby = 'CDM-33817', updatedon = now()
where adoptionagreementid in ('e3cc9a5e-77e8-4a36-b60f-acec2eb9b357') and activeflag = 1;
	