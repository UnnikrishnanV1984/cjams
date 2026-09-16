/*
 Issue Description: CIDM-10248
-- Category/ Module: Permanancy Plan
-- Root cause: One of the actorrelationship information was entered as big sister due to a data error
-- Fix Provided: Datafix has been promoted to fix this issue.
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/

UPDATE
    actorrelationship
SET
    relationshiptypekey = 'BIOBR',
    updatedon = NOW(),
    updatedby = 'CIDM-10248'
WHERE
    person1id = 'a81d1fd7-e0e2-4b76-8135-5efa6b2d9c3c'
    AND person2id = '488483e4-1706-4295-9c3e-885d23c76692'
    AND actorrelationshipid = '6d5c7a71-6e94-45db-997b-233ffbf08bb2';