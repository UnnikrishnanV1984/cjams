
/* 
   Issue Description: CDM-40436
   Category/ Module  : GAP
   Root cause: User Request
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
    
*/
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationship='Maternal Grandparent',
primaryguardianisrelative = 'YES',
secondaryguardianisrelative = 'YES',
primaryguardianrelationshipid = 1001,
secondguardianrelationship = 'Maternal Grandparent',
updatedby = 'CDM-40436', updatedon = now()
WHERE gapeligibilityinfoid='f8b47364-1cb5-43f7-b77a-c06823cc08e5'::uuid
and activeflag = 1;