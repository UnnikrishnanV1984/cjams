/*
   Issue Description: CDM-38356
   Category/ Module  : Prod data fix for updating Guardian Relation ship
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update guardianship set primaryrelationshipkey = 'MATRNLGPRNT', updatedby = 'CDM-38356', updatedon =  now()
where gapid = '9d1ce4f0-0a16-4e92-8bfe-81839fdf218c';



update gapeligibilityinfo set primaryguardianrelationship = 'Maternal Grandparent',primaryguardianrelationshipid = '1001', updatedby = 'CDM-38356', updatedon =  now()
where client_id = '4496264' and activeflag = 1;
