/* 
    Issue Description: CDM-40458
    Category/ Module: GAP / Title IV-E
    Root cause: If the relationship is not identified while doing the GAP guardianship permanency plan,
                then it is not populating in the Title IV-E elegibility and is returning error from Corticon rules
    Fix Provided: Data fix to populate primary guardian relationship details in GAP as well as IV-E eligibility info
    Pull request# for code fix: N/A
    Reason why no related code fix: User story is being developed to make this field as mandatory to pervent such scenario
*/

UPDATE cjams.guardianship
SET primaryrelationshipkey='NORELTVE',
updatedby = 'CDM-40458', updatedon = now() 
WHERE servicecaseid = 'a943e5e7-f00b-4aac-9f6b-d29001d0b0a3' AND 
gapid='6b646e19-c06e-495c-9526-e9ffd00a5307';

UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationship='Non-Relative',
primaryguardianisrelative='NO', primaryguardianrelationshipid='1015',
updatedby = 'CDM-40458', updatedon = now()
WHERE gapeligibilityinfoid='49ba9fb2-1093-4569-a62b-050e1f24f9df'
AND  client_id = 4414148;