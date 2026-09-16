/* 
    Issue Description: CDM-38358
   Category/ Module  : Missing Relationship
   Root cause: Need to update the relationship 'Maternal Aunt' for the below primary guardian in service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/


update guardianship set primaryrelationshipkey = 'MTNLAT', updatedby ='CDM-38358', updatedon = now () 
where gapid = 'd5870b79-56f6-4907-80ea-e0f9fa0e2a74';

select primaryguardianisrelative,primaryguardianrelationship
from gapeligibilityinfo where client_id = '4178483' and activeflag =1;

update gapeligibilityinfo set primaryguardianisrelative = 'YES', primaryguardianrelationship = 'maternal aunt',
primaryguardianrelationshipid = '1001',updatedby = 'CDM-38358', updatedon = now()
where client_id = '4178483' and activeflag =1;
