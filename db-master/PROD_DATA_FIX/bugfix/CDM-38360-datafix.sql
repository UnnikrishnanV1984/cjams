/* 
    Issue Description: CDM-38360
   Category/ Module  : Missing Relationship
   Root cause: Please update the relationship
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

update guardianship set primaryrelationshipkey = 'PRNTLGPRNT', updatedby ='CDM-38360', updatedon = now () 
where gapid = 'd79990b5-cce4-40aa-8ff3-6c9641b731d3';

update gapeligibilityinfo set primaryguardianisrelative = 'YES', primaryguardianrelationship = 'Paternal GrandParent',
primaryguardianrelationshipid = '1001', updatedby ='CDM-38360', updatedon = now ()
where client_id = '3815839' and activeflag =1;
