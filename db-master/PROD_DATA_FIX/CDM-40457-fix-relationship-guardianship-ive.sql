/* 
    Issue Description: CDM-40457
    Category/ Module: GAP / Title IV-E
    Root cause: If the relationship is not identified while doing the GAP guardianship permanency plan,
                then it is not populating in the Title IV-E elegibility and is returning error from Corticon rules
    Fix Provided: Data fix to populate primary guardian relationship details in GAP as well as IV-E eligibility info
    Pull request# for code fix: N/A
    Reason why no related code fix: User story is being developed to make this field as mandatory to pervent such scenario
*/

UPDATE cjams.guardianship
SET primaryrelationshipkey='NORELTVE',
updatedby = 'CDM-40457', updatedon = now() 
WHERE servicecaseid = '69430133-de50-4155-a306-08b764cccc13'
AND gapid = 'af06de8a-f9ea-43ac-abee-1fe2561b112e';

UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationship='Non-Relative',
primaryguardianisrelative='NO', primaryguardianrelationshipid='1015',
updatedby = 'CDM-40457', updatedon = now()
WHERE gapeligibilityinfoid='58755cb5-eecf-4fba-a8df-b79141d6d148'
AND client_id = 3918275 AND activeflag = 1;