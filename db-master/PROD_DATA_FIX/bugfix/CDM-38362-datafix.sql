/* 
    Issue Description: CDM-38362
   Category/ Module  : Missing Relationship
   Root cause:  Relative showing as No
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

update gapeligibilityinfo set primaryguardianisrelative = 'YES', primaryguardianrelationshipid = '1001',
updatedby ='CDM-38362', updatedon = now ()
where client_id ='3991664' and activeflag =1;
