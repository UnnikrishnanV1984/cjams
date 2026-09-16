/*
   Issue Description: CDM-31933
   Category/ Module  :Relationship Tab 
   Root cause: Self is showing up in relationship
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

UPDATE cjams.actorrelationship
SET updatedby='CDM-31933', updatedon=now(), activeflag=0
WHERE actorrelationshipid='bd149f1e-9d79-480d-bff5-4cecbf40ae03' AND relationshiptypekey='SELF';
