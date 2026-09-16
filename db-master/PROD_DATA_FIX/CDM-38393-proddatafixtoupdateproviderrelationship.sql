/*
   Issue Description: CDM-38393
   Category/ Module  : Prod data fix for updating Guardian Relation ship
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update guardianship set primaryrelationshipkey = 'FOSPARNT', updatedby = 'CDM-38393', updatedon =  now()
where gapid = 'a6ff5f9f-730c-4f62-8916-013887aacd92';


update gapeligibilityinfo set primaryguardianisrelative = 'NO', childjurisdiction='Baltimore City',primaryguardianrelationshipid = 1001, primaryguardianrelationship = 'Foster-Parent', updatedby ='CDM-38393', updatedon = now ()
where client_id ='3587884' and activeflag =1;

