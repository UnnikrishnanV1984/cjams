/*
   Issue Description: CDM-38357
   Category/ Module  : Prod data fix for updating Guardian Relation ship
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update guardianship set primaryrelationshipkey = 'PRNTLGPRNT',secondaryrelationshipkey = 'PRNTLGPRNT', updatedby = 'CDM-38357', updatedon =  now()
where gapid = '18f38fba-5a99-48c1-bf0a-8f8ca8530b22';


update gapeligibilityinfo set primaryguardianrelationship = 'Paternal Grandparent',primaryguardianrelationshipid = '1001',
secondguardianrelationship = 'Paternal Grandparent',secondguardianrelationshipid = '1001', updatedby = 'CDM-38357', updatedon =  now()
where client_id = '200567453' and activeflag = 1;
