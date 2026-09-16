/*
   Issue Description: CDM-38359 Paternal Grandma needs to be updated to Ava Walker 
   Category/ Module  : Prod data fix for updating Ava Walker Guardian Relationship to Paternal Grandma
   Root cause: user requeseted to Update the primary gaurdian relationship of Ava Walker as Paternal Grandma
   Fix Provided : Data fix has been promoted to update the GAP provider relationship in permanency plan 
*/


update guardianship set primaryrelationshipkey = 'PRNTLGPRNT', updatedby = 'CDM-38359', updatedon =  now()
where gapid = '8f2f72d8-518b-4ea6-ae57-da014536a228';


update gapeligibilityinfo set primaryguardianrelationship = 'Paternal Grandparent',primaryguardianrelationshipid = '1001', primaryguardianisrelative = 'YES', updatedby = 'CDM-38359', updatedon =  now()
where client_id = '4392760' and activeflag = 1;