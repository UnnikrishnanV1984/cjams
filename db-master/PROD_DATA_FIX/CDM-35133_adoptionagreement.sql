/*
   Issue Description: CDM-35133
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptionagreement set activeflag = 0, updatedby = 'CDM-35133', updatedon = now()
where adoptionagreementid in ('75024062-a8b1-45ef-9301-66f5267718c1', 'ec5230a8-7d02-4b3a-a671-29c281ab1131') and activeflag = 1;
	