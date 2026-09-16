
/*
   Issue Description: CDM-38355
   Category/ Module  : Prod data fix for updating Guardian Relation ship
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update guardianship set primaryrelationshipkey = 'PRNTLGPRNT', updatedby = 'CDM-38355', updatedon =  now()
where gapid = '4a9d8681-26d6-40d9-9fd6-0662be35091a';


update gapeligibilityinfo set primaryguardianrelationship = 'Paternal Grandparent',primaryguardianrelationshipid = '1001', updatedby = 'CDM-38355', updatedon =  now()
where client_id = '4206697' and activeflag = 1;